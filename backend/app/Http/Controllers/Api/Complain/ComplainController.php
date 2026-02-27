<?php

namespace App\Http\Controllers\Api\Complain;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Http\Requests\StoreComplaintRequest;
use App\Models\Division;
use App\Models\District;
use App\Models\Upazila;
use App\Models\PoliceStation;
use App\Models\Category;
use App\Models\Subcategory;
use App\Models\Complaint;


class ComplainController extends Controller
{
    public function index(){
        try{
            $complaints = Complaint::with(['category','subCategory', 'division','district','upazila','policeStation'])
            ->latest('id')->paginate(15);
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
            $data['user_id'] = auth('sanctum')->id() ?? auth()->id();

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

            if ($request->hasFile('attachments')) {
                foreach ($request->file('attachments') as $file) {
                    $generatedName = Str::uuid() . '.' . $file->getClientOriginalExtension();

                    $path = $file->storeAs('complaints/multiple', $generatedName, 'public');

                    $storedAttachments[] = [
                        'original_name' => $file->getClientOriginalName(),
                        'file_name' => $generatedName,
                        'mime_type' => $file->getClientMimeType(),
                        'size' => $file->getSize(),
                        'path' => $path,
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

            $perPage = (int) $request->input('per_page', 20);
            
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
            $complaint = Complaint::where('id', $id)->where('user_id', auth()->id())->first();

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
}
