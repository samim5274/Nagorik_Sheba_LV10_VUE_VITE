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
        Schema::create('complaint_comment_reactions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('comment_id')->constrained('complaint_comments')->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();

            $table->enum('reaction_type', ['like', 'dislike', 'helpful', 'support', 'resolved'])->default('like');

            $table->ipAddress('reacted_ip')->nullable();
            $table->timestamp('created_at')->useCurrent();

            $table->index(['comment_id', 'reaction_type']);
            $table->unique(['comment_id', 'user_id', 'reaction_type'], 'comment_user_reaction_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('complaint_comment_reactions');
    }
};
