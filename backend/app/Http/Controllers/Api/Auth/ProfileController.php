<?php

namespace App\Http\Controllers\Api\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

use App\Models\User;

class ProfileController extends Controller
{
    public function update(Request $request)
    {
        $user = $request->user();

        $data = $request->validate([
            'name' => ['required','string','max:255'],
            'phone' => ['nullable','string','max:30', Rule::unique('users','phone')->ignore($user->id)],
            'dob' => ['nullable','date'],
            'gender' => ['nullable','in:male,female,other'],
            'blood_group' => ['nullable','string','max:10'],
            'present_address' => ['nullable','string','max:500'],
            'parmanent_address' => ['nullable','string','max:500'],
            'national_id' => ['nullable','string','max:50'],
            'religion' => ['nullable','string','max:50'],
            'photo' => ['nullable','image','max:2048'],
        ]);

        if ($request->hasFile('photo')) {
            // old photo delete
            if ($user->photo && Storage::disk('public')->exists($user->photo)) {
                Storage::disk('public')->delete($user->photo);
            }

            $path = $request->file('photo')->store('users', 'public');
            $data['photo'] = $path;
        }

        // profile completed simple rule
        $data['is_profile_completed'] = !empty(trim($data['name'] ?? $user->name ?? '')) && !empty(trim($data['phone'] ?? $user->phone ?? ''));

        $user->update($data);

        $fresh = $user->fresh();
        $fresh->photo_url = $fresh->photo ? asset('storage/'.$fresh->photo) : null;

        return response()->json([
            'success' => true,
            'data' => $fresh,
        ]);
    }

    public function changePassword(Request $request)
    {
        $user = $request->user();

        $data = $request->validate([
            'current_password' => 'required|string',
            'password' => 'required|string|min:8|confirmed',
        ]);

        if (!Hash::check($data['current_password'], $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Current password is incorrect.',
            ], 422);
        }

        $user->update([
            'password' => Hash::make($data['password']),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Password updated.',
        ]);
    }
}
