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
        Schema::create('complaint_comments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('complaint_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();

            // Reply support
            $table->foreignId('parent_id')->nullable()->constrained('complaint_comments')->nullOnDelete();

            $table->text('comment');

            $table->boolean('is_admin')->default(false);
            $table->boolean('is_internal')->default(false); // admin note only

            // Edit/Delete state
            $table->boolean('is_edited')->default(false);
            $table->timestamp('edited_at')->nullable();
            $table->foreignId('edited_by')->nullable()->constrained('users')->nullOnDelete();

            $table->boolean('is_deleted')->default(false);
            $table->timestamp('deleted_at')->nullable();
            $table->foreignId('deleted_by')->nullable()->constrained('users')->nullOnDelete();
            $table->string('delete_reason')->nullable();

            // Metadata
            $table->ipAddress('comment_ip')->nullable();
            $table->text('comment_user_agent')->nullable();

            $table->timestamps();

            $table->index(['complaint_id', 'created_at']);
            $table->index(['parent_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('complaint_comments');
    }
};
