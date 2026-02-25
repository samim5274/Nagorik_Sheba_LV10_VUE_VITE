<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('complaints', function (Blueprint $table) {
            $table->id();
            // Tracking
            $table->string('complaint_no', 30)->unique();

             // User
            $table->foreignId('user_id')->nullable()->constrained('users')->restrictOnDelete();

            // Category
            $table->foreignId('category_id')->constrained('categories')->restrictOnDelete();
            $table->foreignId('sub_category_id')->constrained('subcategories')->restrictOnDelete();

            // Complaint content
            $table->string('title', 255);
            $table->longText('description');

            // Priority & Status
            $table->enum('priority', ['low', 'medium', 'high', 'urgent'])->default('medium');
            $table->enum('status', [
                'pending',
                'in_review',
                'assigned',
                'in_progress',
                'on_hold',
                'resolved',
                'rejected',
                'closed'
            ])->default('pending');

            // Location
            $table->foreignId('division_id')->constrained()->cascadeOnDelete();
            $table->foreignId('district_id')->constrained()->cascadeOnDelete();
            $table->foreignId('upazila_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('police_station_id')->nullable()->constrained()->restrictOnDelete();

            $table->string('ward_no', 20)->nullable();
            $table->string('address_line')->nullable();
            $table->string('landmark')->nullable();
            $table->decimal('latitude', 10, 7)->nullable();
            $table->decimal('longitude', 10, 7)->nullable();

            // Complainant info
            $table->string('complainant_name', 120);
            $table->string('complainant_phone', 20);
            $table->string('complainant_email')->nullable();

            // Legacy/simple attachment support (optional)
            $table->string('attachment')->nullable();
            $table->json('attachments')->nullable();

            // Admin handling
            $table->foreignId('assigned_to')->nullable()->constrained('users')->restrictOnDelete();
            $table->timestamp('assigned_at')->nullable();

            $table->text('admin_remark')->nullable();
            $table->text('action_taken')->nullable();
            $table->text('rejected_reason')->nullable();

            $table->timestamp('resolved_at')->nullable();
            $table->timestamp('closed_at')->nullable();

            // Visibility / Privacy
            $table->boolean('is_public')->default(true);
            $table->boolean('is_anonymous')->default(false);

            // Submission metadata
            $table->string('source', 20)->default('web'); // web/app/admin/api/kiosk
            $table->ipAddress('submitted_ip')->nullable();
            $table->text('submitted_user_agent')->nullable();
            $table->string('submitted_device')->nullable();
            $table->string('submitted_platform')->nullable();
            $table->string('submitted_browser')->nullable();

            // Flags
            $table->boolean('is_edited')->default(false);
            $table->boolean('is_deleted_by_user')->default(false);
            $table->boolean('is_spam')->default(false);
            $table->boolean('is_duplicate')->default(false);

            $table->timestamps();
            $table->softDeletes();

            // Indexes
            $table->index(['status', 'priority']);
            $table->index(['division_id', 'district_id']);
            $table->index(['assigned_to', 'status']);
            $table->index(['created_at']);
            $table->index(['complainant_phone']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('complaints');
    }
};
