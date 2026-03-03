<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreComplaintRequest extends FormRequest
{

    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $allowedExt = 'jpg,jpeg,png,pdf,doc,docx,mp4,webm,mov,mkv';

        return [
            // Location
            'division_id' => ['required', 'integer', 'exists:divisions,id'],
            'district_id' => ['required', 'integer', 'exists:districts,id'],
            'upazila_id' => ['required', 'integer', 'exists:upazilas,id'],
            'police_station_id' => ['nullable', 'integer', 'exists:police_stations,id'],
            'ward_no' => ['nullable', 'string', 'max:20'],
            'address_line' => ['nullable', 'string', 'max:255'],
            'landmark' => ['nullable', 'string', 'max:255'],
            'latitude' => ['nullable', 'numeric', 'between:-90,90'],
            'longitude' => ['nullable', 'numeric', 'between:-180,180'],

            // Complaint details
            'category_id' => ['required', 'integer', 'exists:categories,id'],
            'sub_category_id' => ['required', 'integer', 'exists:subcategories,id'],
            'title' => ['required', 'string', 'max:255'],
            'description' => ['required', 'string', 'min:10'],
            'priority' => ['required', 'in:low,medium,high,urgent'],

            // Visibility
            'visibility_mode' => ['nullable', 'in:public,anonymous'],
            'is_public' => ['nullable', 'boolean'],
            'is_anonymous' => ['nullable', 'boolean'],

            // Files (single + multiple)
            'attachment' => ['nullable', 'file', "mimes:$allowedExt", 'max:51200'],
            'attachments' => ['nullable', 'array', 'max:10'],
            'attachments.*' => ['file', "mimes:$allowedExt", 'max:51200'],
        ];
    }

    public function messages(): array
    {
        return [
            'attachment.uploaded' => 'Upload failed. Please try again (file too large or server limit).',
            'attachment.mimes' => 'Allowed: jpg, jpeg, png, pdf, doc, docx, mp4, webm, mov, mkv.',
            'attachment.max' => 'File must be under 50MB.',

            'attachments.*.uploaded' => 'Upload failed. Please try again (file too large or server limit).',
            'attachments.*.mimes' => 'Allowed: jpg, jpeg, png, pdf, doc, docx, mp4, webm, mov, mkv.',
            'attachments.*.max' => 'Each file must be under 50MB.',
        ];
    }
}
