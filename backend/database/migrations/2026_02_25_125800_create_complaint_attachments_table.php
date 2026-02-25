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
        Schema::create('complaint_attachments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('complaint_id')->constrained()->cascadeOnDelete();
            $table->foreignId('uploaded_by')->nullable()->constrained('users')->nullOnDelete();

            // Which part this file belongs to
            $table->string('context_type', 30)->default('complaint'); // complaint/comment/status_log/resolution
            $table->unsignedBigInteger('context_id')->nullable();

            $table->string('original_name');
            $table->string('file_name');
            $table->string('file_path');
            $table->string('file_disk', 30)->default('public');

            $table->string('mime_type', 100);
            $table->string('file_extension', 20)->nullable();
            $table->unsignedBigInteger('file_size');

            $table->string('file_hash', 64)->nullable();

            $table->boolean('is_image')->default(false);
            $table->boolean('is_public')->default(true);
            $table->unsignedInteger('sort_order')->default(0);

            $table->ipAddress('uploaded_ip')->nullable();

            $table->timestamps();
            $table->softDeletes();

            $table->index(['complaint_id', 'context_type', 'context_id']);
            $table->index(['file_hash']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('complaint_attachments');
    }
};
