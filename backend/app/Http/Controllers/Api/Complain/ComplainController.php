<?php

namespace App\Http\Controllers\Api\Complain;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Http\UploadedFile;
use App\Http\Requests\StoreComplaintRequest;
use App\Models\Division;
use App\Models\District;
use App\Models\Upazila;
use App\Models\PoliceStation;
use App\Models\Category;
use App\Models\Subcategory;
use App\Models\Complaint;
use App\Models\ComplaintReaction;
use App\Models\ComplaintComments;


class ComplainController extends Controller
{
    public function index(Request $request){
        try{
            $userId = auth('sanctum')->id();
            
            // $query = Complaint::with(['category','subCategory','division','district','upazila','policeStation'])
            //     ->latest('id');

            $query = Complaint::query()
                ->with(['category','subCategory','division','district','upazila','policeStation'])
                ->withCount(['likes', 'dislikes', 'comments'])
                ->with([
                    'reactions' => function ($q) use ($userId) {
                        if ($userId) $q->where('user_id', $userId)->select('id','complaint_id','user_id','type');
                        else $q->whereRaw('1=0'); // guest হলে empty
                    }
                ])
                ->latest('id');

            // Search: complaint_no বা title
            if ($request->filled('complaint_no')) {
                $term = trim($request->complaint_no);

                $query->where(function ($q) use ($term) {
                    $q->where('complaint_no', 'like', "%{$term}%")
                    ->orWhere('title', 'like', "%{$term}%");
                    // ->orWhere('description', 'like', "%{$term}%"); // চাইলে
                });
            }

            // Status filter
            if ($request->filled('status')) {
                $query->where('status', $request->status);
            }

            // paginate (page param auto handle করে)
            $complaints = $query->paginate(15);

            $complaints->getCollection()->transform(function ($c) {
                $c->my_reaction = $c->reactions->first()->type ?? null;
                unset($c->reactions); // response clean
                return $c;
            });

            return response()->json([
                'success' => true,
                'message' => 'Get all complaints.',
                'data' => $complaints
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Complaints can not fetched.',
            ], 500);
        }
    }

    public function show($id){
        try{
            $complaint = Complaint::
                with(['category','subCategory', 'division','district','upazila','policeStation'])->find($id);

            if (!$complaint) {
                return response()->json([
                    'success' => false,
                    'message' => 'Complaint not found.',
                    'data' => null
                ], 404);
            }
            
            return response()->json([
                'success' => true,
                'message' => 'Get specific complaint.',
                'data' => $complaint
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Complaint can not fetched.',
            ], 500);
        }
    }

    public function getDivision(){
        try{
            $division = Division::all();
            return response()->json([
                'success' => true,
                'data' => $division
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Division can not fetched.',
            ], 500);
        }
    }

    public function getDistrict($id){
        try{
            $district = District::where('division_id', $id)->get();
            return response()->json([
                'success' => true,
                'data' => $district,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'District can not fetched.',
            ], 500);
        }
    }

    public function getUpazila($id){
        try{
            $upazila = Upazila::where('district_id', $id)->get();
            return response()->json([
                'success' => true,
                'data' => $upazila,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Upazila can not fetched.',
            ], 500);
        }
    }

    public function getPoliceStations($id){
        try{
            $policeStation = PoliceStation::where('upazila_id', $id)->get();
            return response()->json([
                'success' => true,
                'data' => $policeStation,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'PoliceStation can not fetched.',
            ], 500);
        }
    }

    public function getCategory(){
        try{
            $categories = Category::all();
            return response()->json([
                'success' => true,
                'data' => $categories
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Category can not fetched.',
            ], 500);
        }
    }

    public function getSubcategory($id){
        try{
            $subcategorices = Subcategory::where('category_id', $id)->get();
            return response()->json([
                'success' => true,
                'data' => $subcategorices,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Subcategory can not fetched.',
            ], 500);
        }
    }

    public function store(StoreComplaintRequest $request): JsonResponse {

        DB::beginTransaction();

        try{
            $data = $request->validated();

            // Visibility mapping (frontend radio => visibilityMode / visibility_mode)
            $visibilityMode = $request->input('visibility_mode', $request->input('visibilityMode'));

            if ($visibilityMode === 'anonymous') {
                $data['is_public'] = false;
                $data['is_anonymous'] = true;
            } elseif ($visibilityMode === 'public') {
                $data['is_public'] = true;
                $data['is_anonymous'] = false;
            } else {
                // fallback if directly booleans sent
                $data['is_public'] = (bool) ($data['is_public'] ?? true);
                $data['is_anonymous'] = (bool) ($data['is_anonymous'] ?? false);
            }

            // Complaint no generate
            $data['complaint_no'] = $this->generateComplaintNo();

            // Auth user (if logged in)
            $user = auth('sanctum')->user();
            $data['user_id'] = $user?->id;

            // Complainant
            $data['complainant_name']  = $user?->name;
            $data['complainant_phone'] = $user?->phone;
            $data['complainant_email'] = $user?->email;

            // Default values
            $data['status'] = 'pending';
            $data['source'] = 'web';

            // Meta info
            $data['submitted_ip'] = $request->ip();
            $data['submitted_user_agent'] = $request->userAgent();
            $data['submitted_device'] = $this->detectDevice($request->userAgent());
            $data['submitted_platform'] = $this->detectPlatform($request->userAgent());
            $data['submitted_browser'] = $this->detectBrowser($request->userAgent());

            // Single file (if you use it later)
            // if ($request->hasFile('attachment')) {
            //     $data['attachment'] = $request->file('attachment')->store('complaints/single', 'public');
            // }

            // Multiple attachments
            $storedAttachments = [];

            $files = $request->file('attachments', []);
            if (is_array($files)) {
                foreach ($files as $file) {
                    if (!$file instanceof UploadedFile) continue;

                    if (!$file->isValid()) {
                        throw new \Exception("Upload failed for {$file->getClientOriginalName()}");
                    }

                    $generatedName = (string) Str::uuid() . '.' . $file->getClientOriginalExtension();
                    $path = $file->storeAs('complaints/multiple', $generatedName, 'public');

                    $storedAttachments[] = [
                        'original_name' => $file->getClientOriginalName(),
                        'file_name'     => $generatedName,
                        'mime_type'     => $file->getMimeType(), // server-detected
                        'size'          => $file->getSize(),
                        'path'          => $path,
                    ];
                }
            }

            $data['attachments'] = $storedAttachments ?: null;

            $complaint = Complaint::create($data);

            DB::commit();
            
            return response()->json([
                'message' => 'Complaint submitted successfully.',
                'data' => [
                    'id' => $complaint->id,
                    'complaint_no' => $complaint->complaint_no,
                    'status' => $complaint->status,
                    'title' => $complaint->title,
                    'created_at' => $complaint->created_at,
                ]
            ], 201);
        } catch (\Throwable $e) {
            DB::rollBack();

            \Log::error('Complaint store error', [
                'message' => $e->getMessage(),
                'line' => $e->getLine(),
                'file' => $e->getFile(),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'message' => 'Failed to submit complaint.',
                'error' => config('app.debug') ? $e->getMessage() : 'Server error'
            ], 500);
        }
    }

    private function generateComplaintNo(): string
    {
        // Example: CMP-20260225-AB12CD
        do {
            $number = 'CMP-' . now()->format('Ymd') . '-' . strtoupper(Str::random(6));
        } while (Complaint::where('complaint_no', $number)->exists());

        return $number;
    }

    private function detectDevice(?string $ua): ?string
    {
        if (!$ua) return null;

        $ua = strtolower($ua);

        if (str_contains($ua, 'mobile')) return 'Mobile';
        if (str_contains($ua, 'tablet')) return 'Tablet';
        return 'Desktop';
    }

    private function detectPlatform(?string $ua): ?string
    {
        if (!$ua) return null;

        $ua = strtolower($ua);

        return match (true) {
            str_contains($ua, 'windows') => 'Windows',
            str_contains($ua, 'macintosh') || str_contains($ua, 'mac os') => 'MacOS',
            str_contains($ua, 'linux') => 'Linux',
            str_contains($ua, 'android') => 'Android',
            str_contains($ua, 'iphone') || str_contains($ua, 'ipad') => 'iOS',
            default => 'Unknown',
        };
    }

    private function detectBrowser(?string $ua): ?string
    {
        if (!$ua) return null;

        $ua = strtolower($ua);

        return match (true) {
            str_contains($ua, 'edg') => 'Edge',
            str_contains($ua, 'chrome') && !str_contains($ua, 'edg') => 'Chrome',
            str_contains($ua, 'firefox') => 'Firefox',
            str_contains($ua, 'safari') && !str_contains($ua, 'chrome') => 'Safari',
            str_contains($ua, 'opr') || str_contains($ua, 'opera') => 'Opera',
            default => 'Unknown',
        };
    }

    public function myComplain(Request $request){
        try{
            $query = Complaint::with([
                'category',
                'subCategory',
                'division',
                'district',
                'upazila',
                'policeStation',
            ])
            ->where('user_id', auth()->id());

            // complaint_no search
            if ($request->filled('complaint_no')) {
                $q = trim($request->complaint_no);
                $query->where('complaint_no', 'like', "%{$q}%");
            }

            if ($request->filled('status')) {
                $query->where('status', $request->status);
            }
            
            // Alphabetical order ভালো লাগে না। Custom order চাইলে এটা
            // if ($request->input('sort_by') === 'status') {
            //     $dir = strtolower($request->input('sort_dir', 'asc')) === 'desc' ? 'DESC' : 'ASC';

            //     $query->orderByRaw("
            //         FIELD(status,
            //             'pending',
            //             'assigned',
            //             'in_review',
            //             'in_progress',
            //             'on_hold',
            //             'resolved',
            //             'rejected',
            //             'closed'
            //         ) $dir
            //     ");
            // } else {
            //     $query->latest('id');
            // }

            $perPage = (int) $request->input('per_page', 15);
            
            $complaints = $query->latest('id')->paginate($perPage);

            return response()->json([
                'success' => true,
                'message' => 'Get all complaints.',
                'data'    => $complaints,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Complain can not fetched.',
            ], 500);
        }
    }

    public function delete($id){
        try{
            $complaint = Complaint::where('status', 'pending')->where('id', $id)->where('user_id', auth()->id())->first();

            if (!$complaint) {
                return response()->json([
                    'success' => false,
                    'message' => 'Complaint not found.',
                ], 404);
            }

            DB::transaction(function () use ($complaint) {
                // 1) Delete dependent rows first (FK constraint prevent করবে)
                // $complaint->statusLogs()->delete();
                // $complaint->comments()->delete();
                // $complaint->attachmentsList()->delete();
                // $complaint->editLogs()->delete();
                // $complaint->activityLogs()->delete();

                // 2) Now permanent delete (এখানেই model deleting event trigger হবে)
                $complaint->forceDelete();
            });

            return response()->json([
                'success' => true,
                'message' => 'Complaint deleted successfully.',
                'data'    => ['id' => $id],
            ], 200);
        } catch (\Throwable $e) {
            \Log::error('Complaint force delete failed', [
                'id' => $id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Complaint could not be deleted.',
                'error' => config('app.debug') ? $e->getMessage() : null,
            ], 500);
        }
    }

    public function stats(): JsonResponse{
        $userId = auth()->id();

        // today range (server timezone)
        $todayStart = now()->startOfDay();
        $todayEnd   = now()->endOfDay();

        // Status list (ensure same as your frontend)
        $statuses = [
            'pending', 'in_progress', 'resolved', 'rejected',
            'closed', 'assigned', 'in_review', 'on_hold'
        ];

        // One query to get counts by status
        $byStatus = Complaint::query()
            ->where('user_id', $userId)
            ->whereIn('status', $statuses)
            ->select('status', DB::raw('COUNT(*) as total'))
            ->groupBy('status')
            ->pluck('total', 'status'); // returns like ['pending' => 10, ...]

        // Today new complaints
        $todayNew = Complaint::query()
            // ->where('user_id', $userId)
            ->whereBetween('created_at', [$todayStart, $todayEnd])
            ->count();

        // Build response with defaults 0
        $data = [
            'pending'     => (int)($byStatus['pending'] ?? 0),
            'in_progress' => (int)($byStatus['in_progress'] ?? 0),
            'resolved'    => (int)($byStatus['resolved'] ?? 0),
            'rejected'    => (int)($byStatus['rejected'] ?? 0),
            'closed'      => (int)($byStatus['closed'] ?? 0),
            'assigned'    => (int)($byStatus['assigned'] ?? 0),
            'in_review'   => (int)($byStatus['in_review'] ?? 0),
            'on_hold'     => (int)($byStatus['on_hold'] ?? 0),
            'today_new'   => (int)$todayNew,
        ];

        return response()->json([
            'success' => true,
            'data' => $data,
        ]);
    }

    public function getLike($id){
        try{
            $user = auth('sanctum')->user();
            $complaint = Complaint::findOrFail($id);

            if (!$user) {
                return response()->json(['success'=>false,'message'=>'Unauthenticated'], 401);
            }

            $reaction = ComplaintReaction::where('complaint_id', $complaint->id)
            ->where('user_id', $user->id)
            ->first();

            // If already liked => toggle off (remove)
            if ($reaction && $reaction->type === 'like') {
                $reaction->delete();

                return response()->json([
                    'success' => true,
                    'message' => 'Like removed',
                    'data' => $this->reactionCounts($complaint->id, $user->id)
                ]);
            }

            // If disliked আগে থেকে থাকে => switch to like, না থাকলে create like
            ComplaintReaction::updateOrCreate(
                ['complaint_id' => $complaint->id, 'user_id' => $user->id],
                ['type' => 'like']
            );

            return response()->json([
                'success' => true,
                'message' => 'Get liked complain',
                'data' => $this->reactionCounts($complaint->id, $user->id)
            ]);
        } catch (\Throwable $e) {            
            return response()->json([
                'message' => 'Failed to react complaint.',
                'error' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine(),
            ], 500);
        }
    }

    public function getDislike($id)
    {
        $user = auth('sanctum')->user();
        $complaint = Complaint::findOrFail($id);

        $reaction = ComplaintReaction::where('complaint_id', $complaint->id)
            ->where('user_id', $user->id)
            ->first();

        // If already disliked => toggle off
        if ($reaction && $reaction->type === 'dislike') {
            $reaction->delete();

            return response()->json([
                'success' => true,
                'message' => 'Dislike removed',
                'data' => $this->reactionCounts($complaint->id, $user->id)
            ]);
        }

        // switch/create dislike
        ComplaintReaction::updateOrCreate(
            ['complaint_id' => $complaint->id, 'user_id' => $user->id],
            ['type' => 'dislike']
        );

        return response()->json([
            'success' => true,
            'message' => 'Get dis-liked complain',
            'data' => $this->reactionCounts($complaint->id, $user->id)
        ]);
    }

    private function reactionCounts($complaintId, $userId)
    {
        $likes = ComplaintReaction::where('complaint_id', $complaintId)->where('type', 'like')->count();
        $dislikes = ComplaintReaction::where('complaint_id', $complaintId)->where('type', 'dislike')->count();

        $my = ComplaintReaction::where('complaint_id', $complaintId)->where('user_id', $userId)->value('type'); // like/dislike/null

        return [
            'likes' => $likes,
            'dislikes' => $dislikes,
            'my_reaction' => $my,
        ];
    }

    public function storeComment(Request $request){

        DB::beginTransaction();

        try{
            $validator = Validator::make($request->all(), [
                // frontend: complain_id, db: complaint_id
                'complain_id' => ['required', 'integer', 'exists:complaints,id'],
                'comment'     => ['required', 'string', 'min:1', 'max:2000'],

                // reply comment হলে optional
                'parent_id'   => ['nullable', 'integer', 'exists:complaint_comments,id'],
                'is_internal' => ['nullable', 'boolean'],
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors'  => $validator->errors(),
                ], 422);
            }

            $user = $request->user();

            $ua = (string) $request->userAgent();
            $device   = $this->detectDevice($ua);
            $platform = $this->detectPlatform($ua);
            $browser  = $this->detectBrowser($ua);

            $comment = ComplaintComments::create([
                'complaint_id'        => (int) $request->complain_id,
                'user_id'             => $user->id,
                'parent_id'           => $request->parent_id,

                'comment'             => $request->comment,

                'is_admin'            => (bool) ($user->role === 'admin'), // তোমার role system অনুযায়ী বদলাতে পারো
                'is_internal'         => (bool) ($request->boolean('is_internal')),

                'is_edited'           => false,
                'edited_at'           => null,
                'edited_by'           => null,

                'is_deleted'          => false,
                'deleted_at'          => null,
                'deleted_by'          => null,
                'delete_reason'       => null,

                'comment_ip'          => $request->ip(),
                'comment_user_agent' => substr($ua, 0, 255),
            ]);

            DB::commit();

            $comment->load('user:id,name,photo');
            $commentsCount = ComplaintComments::where('complaint_id', $comment->complaint_id)->count();
            return response()->json([
                'success' => true,
                'message' => 'Comment added',
                'data' => [
                    'id' => $comment->id,
                    'complaint_id' => $comment->complaint_id,
                    'comment' => $comment->comment,
                    'created_at' => $comment->created_at,
                    'comments_count' => $commentsCount,
                    'user' => [
                    'id' => $comment->user->id,
                    'name' => $comment->user->name,
                    'photo' => $comment->user->photo,
                    ],
                ]
            ]);

        } catch (\Throwable $e) {
            DB::rollBack();

            \Log::error('Complaint comment store error', [
                'message' => $e->getMessage(),
                'line' => $e->getLine(),
                'file' => $e->getFile(),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to submit complaint comment.',
                'error' => config('app.debug') ? $e->getMessage() : 'Server error'
            ], 500);
        }
    }

    public function showComment($id){
        try{
            $data = ComplaintComments::with(['user:id,name,photo'])
                ->where('complaint_id', $id)
                ->latest('id')
                ->get()
                ->map(function ($c) {
                    return [
                        'id' => $c->id,
                        'complaint_id' => $c->complaint_id,
                        'comment' => $c->comment,
                        'created_at' => $c->created_at,
                        'user' => $c->user ? [
                            'id' => $c->user->id,
                            'name' => $c->user->name,
                            'photo' => $c->user->photo,
                        ] : null,
                    ];
                });


            return response()->json([
                'success' => true,
                'message' => 'Fetched complaint comments.',
                'data' => $data
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetched complaint comment.',
                'error' => config('app.debug') ? $e->getMessage() : 'Server error'
            ], 500);
        }
    }
}
