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
        Schema::create('complaint_status_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('complaint_id')->constrained()->cascadeOnDelete();

            $table->string('old_status', 30)->nullable();
            $table->string('new_status', 30);

            $table->foreignId('changed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->text('remark')->nullable();

            $table->ipAddress('changed_ip')->nullable();
            $table->text('changed_user_agent')->nullable();

            $table->timestamp('created_at')->useCurrent();

            $table->index(['complaint_id', 'created_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('complaint_status_logs');
    }
};
