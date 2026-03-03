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
        Schema::create('complaint_reactions', function (Blueprint $table) {
            $table->id();

            $table->foreignId('complaint_id')->constrained('complaints')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();

            $table->enum('type', ['like', 'dislike']);
            $table->timestamps();

            // one user -> one reaction per complaint
            $table->unique(['complaint_id', 'user_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('complaint_reactions');
    }
};
