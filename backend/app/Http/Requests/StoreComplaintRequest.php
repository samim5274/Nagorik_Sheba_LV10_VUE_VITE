<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreComplaintRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
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

            // Visibility (frontend radio থেকে mode পাঠাতে পারো, নইলে is_public/is_anonymous পাঠাও)
            'visibility_mode' => ['nullable', 'in:public,anonymous'],
            'is_public' => ['nullable', 'boolean'],
            'is_anonymous' => ['nullable', 'boolean'],

            // Complainant
            'complainant_name' => ['required', 'string', 'max:120'],
            'complainant_phone' => ['required', 'string', 'max:20'],
            'complainant_email' => ['nullable', 'email', 'max:120'],

            // Files
            'attachment' => ['nullable', 'file', 'mimes:jpg,jpeg,png,pdf,doc,docx', 'max:5120'], // 5MB
            'attachments' => ['nullable', 'array', 'max:10'],
            'attachments.*' => ['file', 'mimes:jpg,jpeg,png,pdf,doc,docx', 'max:5120'],
        ];
    }

    public function messages(): array
    {
        return [
            'attachments.*.mimes' => 'Each attachment must be jpg, jpeg, png, pdf, doc or docx.',
            'attachments.*.max' => 'Each attachment size must be under 5MB.',
        ];
    }
}
