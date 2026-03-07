<template>
    <div class="min-h-screen bg-white dark:bg-slate-900 transition-colors duration-200">
        <Header
        @open-sidebar="sidebarOpen = true"        
        :isDark="isDark" @toggle-theme="toggleTheme"
        />

        <div class="flex  min-h-[calc(100vh-56px)]">
            <Navbar :open="sidebarOpen" @close="sidebarOpen=false" />
            <Message
                :successMsg="successMsg"
                :errorMsg="errorMsg"
                @update:successMsg="successMsg = $event"
                @update:errorMsg="errorMsg = $event"
            />
            <!-- Content -->
            <div class="flex-1 min-w-0 mx-auto px-4 sm:px-6 lg:px-8 py-5">
                <!-- Top bar (Title + optional actions/search) -->
                <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-xl sm:text-2xl font-bold text-gray-800 dark:text-gray-100 py-4">Public Complains</h1>
                        <p class="text-sm text-gray-700 dark:text-slate-300">Here are the all public compalins</p>
                    </div>
                    <div>
                        <button @click="$router.push('/create')"
                            type="button"
                            class="inline-flex items-center justify-center gap-2 rounded-xl border border-slate-200 bg-white px-5 py-3 text-sm font-semibold text-slate-800 shadow-sm hover:bg-slate-50 active:bg-slate-100 transition dark:border-slate-700 dark:bg-slate-900 dark:text-slate-100 dark:hover:bg-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 dark:focus:ring-offset-slate-900">
                                <span class="text-base leading-none"><i class="fa-solid fa-plus"></i></span>
                                Create New
                        </button>
                    </div>
                </div>

                <div class="xl:col-span-8 dark:border-slate-700 rounded-md p-3 text-white">
                    <div class="w-full overflow-hidden rounded-2xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900 shadow-sm">
                        <!-- Table Header Area -->
                        <div class="flex flex-col gap-3 border-b border-slate-200 dark:border-slate-700 px-4 py-4 sm:flex-row sm:items-center sm:justify-between">
                            <div>
                                <h2 class="text-base font-semibold text-slate-800 dark:text-slate-100">Complaint List</h2>
                                <p class="text-sm text-slate-500 dark:text-slate-400">Manage and monitor all submitted complaints</p>
                            </div>

                            <div class="flex flex-col gap-2 sm:flex-row sm:items-center">
                                <input v-model="searchComplaintNo"
                                    type="text"
                                    placeholder="Search complaint..."
                                    class="w-full sm:w-64 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-sm text-slate-700 dark:text-slate-100 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500"
                                />

                                <select @change="getComplaints(1)" v-model="statusFilter"
                                    class="rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-sm text-slate-700 dark:text-slate-100 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                                    <option value="">All Status</option>
                                    <option value="pending">Pending</option>
                                    <option value="in_review">In Review</option>
                                    <option value="assigned">Assigned</option>
                                    <option value="in_progress">In Progress</option>
                                    <option value="on_hold">On Hold</option>
                                    <option value="resolved">Resolved</option>
                                    <option value="rejected">Rejected</option>
                                    <option value="closed">Closed</option>
                                </select>
                            </div>
                        </div>

                        <!-- Table -->
                        <div class="w-full overflow-x-auto max-h-[900px]">
                            <table class="w-full whitespace-nowrap">
                                <tbody class="divide-y divide-slate-200 dark:divide-slate-700 bg-white dark:bg-slate-900">
                                    <tr
                                        v-for="complaint in complaints"
                                        :key="complaint.id"
                                        class="text-sm text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition">
                                        
                                        <!-- Complaint Info -->
                                        <td class="px-2 sm:px-4 py-3 sm:py-4 align-top">
                                            <div class="group rounded-2xl border border-slate-200 bg-white p-3 sm:p-4 shadow-sm transition hover:shadow-md dark:border-slate-700 dark:bg-slate-900">
                                                <!-- Clickable Content (Details) -->
                                                <div class="space-y-3 cursor-pointer" @click="viewComplaint(complaint)">
                                                    <!-- Title + Badges -->
                                                    <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between sm:gap-3">
                                                        <div class="min-w-0">
                                                            <div class="flex flex-wrap items-center gap-2">
                                                                <h3 class="min-w-0 flex-1 truncate text-[14px] sm:text-[15px] font-semibold text-slate-900 dark:text-slate-100">
                                                                    <span class="group-hover:underline">{{ complaint.title }}</span>
                                                                </h3>

                                                                <span
                                                                v-if="complaint.is_anonymous"
                                                                class="shrink-0 inline-flex items-center rounded-full bg-purple-50 px-2 py-0.5 text-[10px] sm:text-[11px] font-semibold text-purple-700 dark:bg-purple-900/25 dark:text-purple-300">
                                                                    <i class="fa-solid fa-user-secret mr-1 text-[10px]"></i> Anonymous
                                                                </span>
                                                            </div>

                                                            <div class="mt-1 flex flex-wrap items-center gap-2 text-[11px] sm:text-xs text-slate-500 dark:text-slate-400">
                                                                <span class="font-medium text-indigo-600 dark:text-indigo-400">#{{ complaint.complaint_no || 'N/A' }}</span>
                                                                <span class="text-slate-300 dark:text-slate-600">•</span>
                                                                <span class="whitespace-nowrap">{{ formatDate(complaint.created_at) }}</span>
                                                                <span class="text-slate-300 dark:text-slate-600">•</span>
                                                                <span class="whitespace-nowrap">{{ formatTime(complaint.created_at) }}</span>
                                                            </div>
                                                        </div>

                                                        <!-- Right badges (wrap + full width on mobile) -->
                                                        <div class="flex flex-wrap items-center gap-2 sm:justify-end sm:text-right">
                                                            <!-- Priority -->
                                                            <span
                                                                class="inline-flex rounded-full px-2.5 py-1 text-[10px] sm:text-[11px] font-semibold"
                                                                :class="{
                                                                'bg-slate-100 text-slate-700 dark:bg-slate-800 dark:text-slate-200': complaint.priority === 'low',
                                                                'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300': complaint.priority === 'medium',
                                                                'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-300': complaint.priority === 'high',
                                                                'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300': complaint.priority === 'urgent'
                                                                }">
                                                                {{ complaint.priority }}
                                                            </span>

                                                            <!-- Status -->
                                                            <span
                                                                class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 text-[10px] sm:text-[11px] font-semibold capitalize"
                                                                :class="statusBadge(complaint.status)">
                                                                <span class="h-1.5 w-1.5 rounded-full" :class="statusDot(complaint.status)"></span>
                                                                {{ formatStatus(complaint.status) }}
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <!-- Meta chips -->
                                                    <div class="flex flex-wrap items-center gap-1.5">
                                                        <span class="inline-flex items-center rounded-full bg-slate-100 px-2 py-0.5 text-[10px] sm:text-[11px] font-medium text-slate-700 dark:bg-slate-800 dark:text-slate-200">
                                                            <i class="fa-solid fa-layer-group mr-1 text-[10px] opacity-70"></i>
                                                            <span class="truncate max-w-[220px] sm:max-w-none">{{ complaint.category?.name || 'No Category' }}</span>
                                                        </span>

                                                        <span
                                                        v-if="complaint.sub_category"
                                                        class="inline-flex items-center rounded-full bg-blue-50 px-2 py-0.5 text-[10px] sm:text-[11px] font-medium text-blue-700 dark:bg-blue-900/20 dark:text-blue-300">
                                                            <i class="fa-solid fa-tag mr-1 text-[10px] opacity-70"></i>
                                                            <span class="truncate max-w-[220px] sm:max-w-none">{{ complaint.sub_category?.name }}</span>
                                                        </span>
                                                    </div>

                                                    <!-- Location + Address -->
                                                    <div class="grid gap-2 sm:grid-cols-2">
                                                        <div class="flex items-start gap-2 text-[11px] sm:text-xs text-slate-600 dark:text-slate-400">
                                                            <i class="fa-solid fa-location-dot mt-0.5 text-slate-400 dark:text-slate-500"></i>
                                                            <p class="line-clamp-2">
                                                                {{ complaint.division?.name || '-' }},
                                                                {{ complaint.district?.name || '-' }}
                                                                {{ complaint.upazila?.name || '-' }}
                                                                <span v-if="complaint.police_station?.name">, {{ complaint.police_station?.name }}</span>
                                                            </p>
                                                        </div>

                                                        <div class="flex items-start gap-2 text-[11px] sm:text-xs text-slate-600 dark:text-slate-400">
                                                            <i class="fa-solid fa-map-pin mt-0.5 text-slate-400 dark:text-slate-500"></i>
                                                            <p class="line-clamp-2">
                                                                {{ complaint.address_line || 'No address' }}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Divider -->
                                                <div class="my-3 sm:my-4 h-px bg-slate-100 dark:bg-slate-800"></div>

                                                <!-- Actions (stack on mobile) -->
                                                <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between sm:gap-4">
                                                    <div class="flex flex-wrap items-center gap-2">
                                                        <!-- Like -->
                                                        <button type="button" @click.stop="getLike(complaint)"
                                                            :class="[
                                                                'inline-flex items-center gap-2 rounded-xl px-3 py-1.5 text-[13px] sm:text-sm font-semibold transition',
                                                                complaint.my_reaction === 'like'
                                                                ? 'bg-blue-50 text-blue-700 dark:bg-blue-900/20 dark:text-blue-300'
                                                                : 'text-slate-700 hover:bg-slate-100 dark:text-slate-200 dark:hover:bg-slate-800'
                                                            ]">
                                                            <i :class="complaint.my_reaction === 'like' ? 'fa-solid fa-thumbs-up' : 'fa-regular fa-thumbs-up'"></i>
                                                            <span class="rounded-lg bg-white/70 px-2 py-0.5 text-[11px] sm:text-xs font-bold text-slate-700 ring-1 ring-slate-200 dark:bg-slate-900/40 dark:text-slate-200 dark:ring-slate-700">
                                                                {{ formatCount(complaint.likes_count ?? 0) }}
                                                            </span>
                                                        </button>

                                                        <!-- Dislike -->
                                                        <button type="button" @click.stop="getDisLike(complaint)"
                                                            :class="[
                                                                'inline-flex items-center gap-2 rounded-xl px-3 py-1.5 text-[13px] sm:text-sm font-semibold transition',
                                                                complaint.my_reaction === 'dislike'
                                                                ? 'bg-red-50 text-red-700 dark:bg-red-900/20 dark:text-red-300'
                                                                : 'text-slate-700 hover:bg-slate-100 dark:text-slate-200 dark:hover:bg-slate-800'
                                                            ]">
                                                            <i :class="complaint.my_reaction === 'dislike' ? 'fa-solid fa-thumbs-down' : 'fa-regular fa-thumbs-down'"></i>
                                                            <span class="rounded-lg bg-white/70 px-2 py-0.5 text-[11px] sm:text-xs font-bold text-slate-700 ring-1 ring-slate-200 dark:bg-slate-900/40 dark:text-slate-200 dark:ring-slate-700">
                                                                {{ formatCount(complaint.dislikes_count ?? 0) }}
                                                            </span>
                                                        </button>

                                                        <!-- Comments -->
                                                        <button type="button" @click.stop="toggleComments(complaint)" 
                                                        class="inline-flex items-center gap-2 rounded-xl px-3 py-1.5 text-[13px] sm:text-sm font-semibold text-slate-700 transition hover:bg-slate-100 dark:text-slate-200 dark:hover:bg-slate-800">
                                                            <i class="fa-regular fa-comment"></i>
                                                            <span class="rounded-lg bg-white/70 px-2 py-0.5 text-[11px] sm:text-xs font-bold text-slate-700 ring-1 ring-slate-200 dark:bg-slate-900/40 dark:text-slate-200 dark:ring-slate-700">
                                                                {{ formatCount(complaint.comments_count ?? 0) }}
                                                            </span>
                                                            <span class="text-[11px] opacity-70">
                                                                {{ commentsOpen[complaint.id] ? "Hide" : "Show" }}
                                                            </span>
                                                        </button>
                                                    </div>

                                                    <!-- Hint aligns under buttons on mobile -->
                                                    <div class="text-[11px] sm:text-xs text-slate-500 dark:text-slate-400">
                                                        {{
                                                        complaint.my_reaction === 'like'
                                                            ? 'You liked this'
                                                            : complaint.my_reaction === 'dislike'
                                                            ? 'You disliked this'
                                                            : 'Be the first to react'
                                                        }}
                                                    </div>
                                                </div>

                                                <!-- Comments Panel -->
                                                <div v-if="commentsOpen[complaint.id]" class="mt-4 border-t border-slate-200 pt-4 dark:border-slate-700">

                                                    <!-- Loading -->
                                                    <div v-if="commentsLoading[complaint.id]" class="text-sm text-slate-500">
                                                        Loading comments...
                                                    </div>

                                                    <!-- Error -->
                                                    <div v-else-if="commentsError[complaint.id]" class="text-sm text-red-500">
                                                        {{ commentsError[complaint.id] }}
                                                    </div>

                                                    <!-- List -->
                                                    <div v-else class="space-y-3">
                                                        <div
                                                            v-for="c in (commentsByComplaint[complaint.id] || [])"
                                                            :key="c.id"
                                                            class="flex items-start gap-3">
                                                            <!-- Avatar -->
                                                            <img
                                                                class="h-8 w-8 shrink-0 rounded-full object-cover ring-2 ring-slate-200 dark:ring-white/10"
                                                                :src="commentUserAvatar(c.user)"
                                                                alt="avatar"/>

                                                            <!-- Comment Card -->
                                                            <div class="min-w-0 flex-1">
                                                                <div class="rounded-2xl border border-slate-200 bg-white p-3 shadow-sm dark:border-slate-700 dark:bg-slate-900">
                                                                    <!-- Header -->
                                                                    <div class="flex items-start justify-between gap-3">
                                                                        <div class="min-w-0">
                                                                            <p class="truncate text-sm font-semibold text-slate-900 dark:text-slate-100">
                                                                                {{ c.user?.name || "Unknown User" }}
                                                                            </p>
                                                                            <p class="mt-0.5 text-[11px] text-slate-500 dark:text-slate-400">
                                                                                {{ formatDateTime(c.created_at) }}
                                                                            </p>
                                                                        </div>

                                                                        <!-- 3 dots + menu -->
                                                                        <div v-if="canManageComment(c)" class="relative shrink-0" @click.stop>
                                                                            <button type="button" class="inline-flex h-8 w-8 items-center justify-center rounded-lg text-slate-500 hover:bg-slate-100 hover:text-slate-700 dark:text-slate-400 dark:hover:bg-slate-800 dark:hover:text-slate-200 transition" 
                                                                            @click="toggleCommentMenu(complaint.id, c.id)">
                                                                                <i class="fa-solid fa-ellipsis-vertical"></i>
                                                                            </button>

                                                                            <div v-if="isCommentMenuOpen(complaint.id, c.id)"
                                                                            class="absolute right-0 z-30 mt-2 w-36 overflow-hidden rounded-xl border border-slate-200 bg-white shadow-lg dark:border-slate-700 dark:bg-slate-900">
                                                                                <button
                                                                                    type="button"
                                                                                    class="flex w-full items-center gap-2 px-3 py-2 text-sm text-slate-700 hover:bg-slate-50 dark:text-slate-200 dark:hover:bg-slate-800"
                                                                                    @click="startEditComment(complaint.id, c)">
                                                                                    <i class="fa-regular fa-pen-to-square"></i>
                                                                                    Edit
                                                                                </button>

                                                                                <button
                                                                                    type="button"
                                                                                    class="flex w-full items-center gap-2 px-3 py-2 text-sm text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-900/20"
                                                                                    @click="askDeleteComment(complaint.id, c)">
                                                                                    <i class="fa-regular fa-trash-can"></i>
                                                                                    Delete
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Body -->
                                                                    <div v-if="!isEditingComment(complaint.id, c.id)" class="mt-2">
                                                                        <div class="rounded-2xl bg-slate-50 px-3 py-2 text-sm leading-relaxed text-slate-700 dark:bg-slate-800/60 dark:text-slate-200">
                                                                            {{ c.comment }}
                                                                        </div>
                                                                    </div>

                                                                    <!-- Edit mode -->
                                                                    <div v-else class="mt-2 space-y-2">
                                                                        <textarea
                                                                            v-model="editState.text"
                                                                            rows="2"
                                                                            class="w-full resize-none rounded-2xl border border-slate-200 bg-white px-3 py-2 text-sm text-slate-800 outline-none focus:ring-2 focus:ring-blue-500/30 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-100"></textarea>

                                                                        <div class="flex items-center justify-end gap-2">
                                                                            <button type="button" class="rounded-xl border border-slate-200 bg-white px-3 py-1.5 text-sm font-semibold text-slate-700 hover:bg-slate-50 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800" @click="cancelEdit()">
                                                                                Cancel
                                                                            </button>

                                                                            <button type="button" class="rounded-xl bg-blue-600 px-3 py-1.5 text-sm font-semibold text-white hover:opacity-95" @click="saveEditComment(complaint.id)">
                                                                                Save
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Empty -->
                                                        <div
                                                            v-if="!(commentsByComplaint[complaint.id]?.length)"
                                                            class="rounded-2xl border border-dashed border-slate-200 bg-white px-4 py-3 text-sm text-slate-500 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-400">
                                                            No comments yet.
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Comment box (full width on mobile) -->
                                                <div class="mt-4">
                                                    <form @submit.prevent="submitComment" class="space-y-6">
                                                        <div class="flex items-start gap-3">
                                                            <!-- Avatar -->
                                                            <div class="h-9 w-9 sm:h-10 sm:w-10 shrink-0 overflow-hidden rounded-full bg-slate-200 dark:bg-slate-700">
                                                                <div class="grid h-full w-full place-items-center text-[11px] sm:text-xs font-bold text-slate-600 dark:text-slate-200">
                                                                    <img class="h-8 w-8 rounded-full object-cover dark:ring-white/10" :src="avatarUrl" alt="User" />
                                                                </div>
                                                            </div>

                                                            <!-- Input -->
                                                            <div class="flex-1 min-w-0">
                                                                <div class="flex items-center gap-2 rounded-2xl border border-slate-200 bg-white px-3 py-2 shadow-sm transition focus-within:ring-2 focus-within:ring-blue-500/30 dark:border-slate-700 dark:bg-slate-900">
                                                                    <i class="fa-regular fa-face-smile text-slate-400 dark:text-slate-500"></i>

                                                                    <input
                                                                    type="text" v-model="commentText[complaint.id]" @focus="form.complain_id = complaint.id"
                                                                    placeholder="Write a comment..."
                                                                    class="w-full min-w-0 bg-transparent text-[13px] sm:text-sm text-slate-900 placeholder:text-slate-400 outline-none dark:text-slate-100 dark:placeholder:text-slate-500"
                                                                    @click.stop/>

                                                                    <button
                                                                    type="submit" @click.stop
                                                                    class="inline-flex shrink-0 items-center justify-center rounded-xl bg-blue-600 px-3 py-2 text-sm font-semibold text-white transition hover:opacity-95">
                                                                    <i class="fa-solid fa-paper-plane"></i>
                                                                    </button>
                                                                </div>

                                                                <div class="mt-1 flex items-center justify-between text-[10px] sm:text-[11px] text-slate-500 dark:text-slate-400">
                                                                    <span>Press Enter to send</span>
                                                                    <span class="hidden sm:inline">Shift + Enter for new line</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>

                                    <!-- Empty state -->
                                    <tr v-if="!complaints || complaints.length === 0">
                                        <td colspan="7" class="px-4 py-10 text-center text-sm text-slate-500 dark:text-slate-400">
                                            No complaints found.
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- Pegination section -->
                        <div class="flex flex-col gap-2 border-t border-slate-200 px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
                            <p class="text-xs text-slate-500">
                                Showing
                                <span class="font-semibold text-slate-700">{{ fromItem }}</span>
                                –
                                <span class="font-semibold text-slate-700">{{ toItem }}</span>
                                of
                                <span class="font-semibold text-slate-700">{{ total }}</span>
                            </p>

                            <div class="flex flex-wrap items-center justify-end gap-2">
                                <!-- First -->
                                <button
                                    @click="getComplaints(1)"
                                    :disabled="currentPage === 1 || loading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-angles-left"></i>
                                </button>

                                <!-- Prev -->
                                <button
                                    @click="getComplaints(Math.max(1, currentPage - 1))"
                                    :disabled="currentPage === 1 || loading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </button>

                                <!-- Pages -->
                                <button
                                    v-for="page in visiblePages"
                                    :key="String(page)"
                                    :disabled="page === '...' || loading"
                                    @click="page !== '...' && getComplaints(page)"
                                    class="rounded-lg border px-3 py-1.5 text-xs font-semibold"
                                    :class="[
                                        page === '...'
                                        ? 'border-slate-200 bg-white dark:bg-slate-900 text-slate-400 cursor-default'
                                        : currentPage === page
                                            ? 'border-slate-900 bg-slate-900 dark:bg-slate-100 text-white dark:text-slate-900'
                                            : 'border-slate-200 bg-white dark:bg-slate-900 text-slate-700 dark:text-slate-100 hover:bg-slate-50'
                                    ]">
                                    {{ page }}
                                </button>

                                <!-- Next -->
                                <button
                                    @click="getComplaints(Math.min(lastPage, currentPage + 1))"
                                    :disabled="currentPage === lastPage || loading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-angle-right"></i>
                                </button>

                                <!-- Last -->
                                <button
                                    @click="getComplaints(lastPage)"
                                    :disabled="currentPage === lastPage || loading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-angles-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted, onBeforeUnmount, ref, computed, watch, reactive } from "vue";
import { useRouter } from "vue-router";
import api, {makeImg} from "../../services/api";

import Navbar from '../Dashboard/navbar.vue'
import Header from '../Dashboard/header.vue'
import Message from '../Message/message.vue'

const router = useRouter();

const complaints = ref([]);
const loading = ref(false);
const errorMsg = ref("");
const successMsg = ref("");
const defaultAvatar = "/images/avater.png";

// Reusable state reset helper
function resetErrorAndLoading() {
    loading.value = true;
    errorMsg.value = "";
}

// Reusable error handler helper
function handleApiError(err, fallbackMessage, targetRef) {
    console.error(fallbackMessage, err);
    errorMsg.value = err?.response?.data?.message || fallbackMessage;
    if (targetRef) targetRef.value = [];
}



// search
const searchComplaintNo = ref("");
const statusFilter = ref("");
let searchTimer = null;

watch([searchComplaintNo, statusFilter], () => {
    clearTimeout(searchTimer);
    searchTimer = setTimeout(() => {
        getComplaints(1);
    }, 400);
});



// date/time format
function formatDate(date) {
    if (!date) return "N/A";

    return new Date(date).toLocaleDateString("en-BD", {
        year: "numeric",
        month: "short",
        day: "numeric",
    });
}

function formatTime(date) {
    if (!date) return "";

    return new Date(date).toLocaleTimeString("en-BD", {
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
    });
}

// view complaint
function viewComplaint(complaint) {
    if (!complaint?.id) return;
    router.push(`/complaints/${complaint.id}/${complaint.complaint_no ?? ''}`);
}

// paginate section 
const currentPage = ref(1);
const lastPage = ref(1);
const total = ref(0);
const perPage = ref(20);
const fromItem = ref(0);
const toItem = ref(0);

const visiblePages = computed(() => {
    const pages = [];
    const last = lastPage.value;
    const cur = currentPage.value;

    if (last <= 5) {
        for (let i = 1; i <= last; i++) pages.push(i);
        return pages;
    }

    pages.push(1);

    if (cur > 3) pages.push("...");

    const start = Math.max(2, cur - 1);
    const end = Math.min(last - 1, cur + 1);

    for (let i = start; i <= end; i++) {
        pages.push(i);
    }

    if (cur < last - 2) pages.push("...");

    pages.push(last);

    return pages;
});

// get all public complaints
async function getComplaints(page = 1) {
    resetErrorAndLoading();

    try {
        const params = new URLSearchParams();
        params.set("page", String(page));

        if (searchComplaintNo.value) params.set("complaint_no", searchComplaintNo.value);
        if (statusFilter.value) params.set("status", statusFilter.value);

        const res = await api.get(`/complaints?${params.toString()}`);
        const response = res.data?.data;

        complaints.value = (response?.data ?? []).map((c) => ({
            ...c,
            likes: c.likes_count ?? 0,
            dislikes: c.dislikes_count ?? 0,
            my_reaction: c.my_reaction ?? null,
            comments_count: c.comments_count ?? 0,
        }));

        // complaints.value = response?.data ?? [];
        currentPage.value = response?.current_page ?? 1;
        lastPage.value = response?.last_page ?? 1;
        total.value = response?.total ?? 0;
        perPage.value = response?.per_page ?? 20;
        fromItem.value = response?.from ?? 0;
        toItem.value = response?.to ?? 0;

        // console.log("API Response:", res.data);
    } catch (err) {
        console.error("complaints load error:", err);
        handleApiError(err, "Failed to load complaints", complaints);

        complaints.value = [];
        currentPage.value = 1;
        lastPage.value = 1;
        total.value = 0;
        fromItem.value = 0;
        toItem.value = 0;
    } finally {
        loading.value = false;
    }
}


function formatStatus(status) {
    if (!status) return "N/A";
    return status.replaceAll("_", " ");
}

function statusBadge(status) {
    const s = (status || "").toLowerCase();

    if (s === "pending")
        return "bg-amber-100 text-amber-800 ring-1 ring-amber-200 dark:bg-amber-900/30 dark:text-amber-200 dark:ring-amber-800/60";

    if (s === "in_progress")
        return "bg-blue-100 text-blue-800 ring-1 ring-blue-200 dark:bg-blue-900/30 dark:text-blue-200 dark:ring-blue-800/60";

    if (s === "resolved")
        return "bg-emerald-100 text-emerald-800 ring-1 ring-emerald-200 dark:bg-emerald-900/30 dark:text-emerald-200 dark:ring-emerald-800/60";

    if (s === "rejected")
        return "bg-red-100 text-red-800 ring-1 ring-red-200 dark:bg-red-900/30 dark:text-red-200 dark:ring-red-800/60";

    if (s === "closed")
        return "bg-slate-200 text-slate-800 ring-1 ring-slate-300 dark:bg-slate-700 dark:text-slate-100 dark:ring-slate-600";

    // extra statuses (optional)
    if (s === "assigned")
        return "bg-indigo-100 text-indigo-800 ring-1 ring-indigo-200 dark:bg-indigo-900/30 dark:text-indigo-200 dark:ring-indigo-800/60";

    if (s === "in_review")
        return "bg-purple-100 text-purple-800 ring-1 ring-purple-200 dark:bg-purple-900/30 dark:text-purple-200 dark:ring-purple-800/60";

    if (s === "on_hold")
        return "bg-pink-100 text-pink-800 ring-1 ring-pink-200 dark:bg-pink-900/30 dark:text-pink-200 dark:ring-pink-800/60";

    return "bg-slate-100 text-slate-700 ring-1 ring-slate-200 dark:bg-slate-800 dark:text-slate-200 dark:ring-slate-700";
}

function statusDot(status) {
    const s = (status || "").toLowerCase();
    if (s === "pending") return "bg-amber-500";
    if (s === "in_progress") return "bg-blue-500";
    if (s === "resolved") return "bg-emerald-500";
    if (s === "rejected") return "bg-red-500";
    if (s === "closed") return "bg-slate-500";
    if (s === "assigned") return "bg-indigo-500";
    if (s === "in_review") return "bg-purple-500";
    if (s === "on_hold") return "bg-pink-500";
    return "bg-slate-400";
}



/**
 * Complain Rection like and dislike with comment
 */

function applyReactionResult(target, data) {
    target.likes = data.likes_count ?? data.like_count ?? data.likes ?? 0;
    target.dislikes = data.dislikes_count ?? data.dislike_count ?? data.dislikes ?? 0;
    target.my_reaction = data.my_reaction ?? null;

    // যদি আপনি UI তে likes_count দেখান, এটাও আপডেট করুন
    target.likes_count = target.likes;
    target.dislikes_count = target.dislikes;
}

async function getLike(complain){
    loading.value = true;
    successMsg.value = "";
    errorMsg.value = "";

    try{
        const res = await api.post(`/complaints/like/${complain.id}`);
        // console.log(res.data);
        // successMsg.value = `Likes: ${res.data.data.likes}, Dislikes: ${res.data.data.dislikes}`;
        applyReactionResult(complain, res.data.data);
    } catch(err){
        console.log("API error:", err?.response?.data || err?.message);
        errorMsg.value = err?.response?.data?.error
            || err?.response?.data?.message
            || err?.message
            || "Something went wrong";
    } finally {
        loading.value = false;
    }
}

async function getDisLike(complain){
    loading.value = true;
    successMsg.value = "";
    errorMsg.value = "";

    try{
        const res = await api.post(`/complaints/dis-like/${complain.id}`);
        // console.log(res.data);
        // successMsg.value = `Likes: ${res.data.data.likes}, Dislikes: ${res.data.data.dislikes}`;
        applyReactionResult(complain, res.data.data);
    } catch(err){
        console.log("API error:", err?.response?.data || err?.message);
        errorMsg.value = err?.response?.data?.error
            || err?.response?.data?.message
            || err?.message
            || "Something went wrong";
    } finally {
        loading.value = false;
    }
}


/**
 * Complain comment
 */
const commentText = reactive({});

const form = reactive({
    complain_id: null,
});

async function submitComment(){
    resetErrorAndLoading();

    const id = form.complain_id;
    if (!id) {
        errorMsg.value = "Select a complaint first.";
        loading.value = false;
        return;
    }

    const text = (commentText[id] || "").trim();
    if (!text) {
        errorMsg.value = "Write something first.";
        loading.value = false;
        return;
    }

    try {        
        const res = await api.post("/complaints/comment", {
            complain_id: id,
            comment: text,
            parent_id: null,
            is_internal: false
        });
        commentText[id] = "";
        // console.log(res.data.message);

        const created = res.data?.data;
        // complaint id বের করো (safe)
        const cid = created?.complaint_id ?? form.complain_id; // id = form.complain_id (focused complaint id)

        commentsOpen[cid] = true;
        if (!Array.isArray(commentsByComplaint[cid])) commentsByComplaint[cid] = [];
        if (created) commentsByComplaint[cid].unshift(created);

        // Count update always
        const targetComplaint = complaints.value.find(x => x.id === cid);
        if (targetComplaint && created?.comments_count != null) {
            targetComplaint.comments_count = created.comments_count;
        }

    } catch (err) {
        if (err?.response?.status === 422) {
            const errors = err.response.data?.errors;
            errorMsg.value = errors?.comment?.[0] || "Validation error";
        } else {
            errorMsg.value = err?.response?.data?.message || "Failed to submit comment.";
        }
    } finally {
        loading.value = false;
    }
};


const commentsByComplaint = reactive({});   // { [complaintId]: [] }
const commentsOpen = reactive({});          // { [complaintId]: true/false }
const commentsLoading = reactive({});       // { [complaintId]: true/false }
const commentsError = reactive({});         // { [complaintId]: "..." }

function commentUserAvatar(user) {
    const photo = user?.photo;
    return photo ? makeImg(photo) : defaultAvatar;
}

function formatDateTime(date) {
    if (!date) return "";
    return new Date(date).toLocaleString("en-BD", {
        year: "numeric", month: "short", day: "numeric",
        hour: "2-digit", minute: "2-digit"
    });
}

function formatCount(value) {
    const num = Number(value) || 0;

    if (num >= 1000000000) {
        return (num / 1000000000).toFixed(1).replace(/\.0$/, '') + 'B';
    }
    if (num >= 1000000) {
        return (num / 1000000).toFixed(1).replace(/\.0$/, '') + 'M';
    }
    if (num >= 1000) {
        return (num / 1000).toFixed(1).replace(/\.0$/, '') + 'k';
    }

    return num.toString();
}

async function toggleComments(complaint) {
    const id = complaint.id;

    if (!Array.isArray(commentsByComplaint[id])) commentsByComplaint[id] = [];
    if (commentsLoading[id] == null) commentsLoading[id] = false;
    if (commentsError[id] == null) commentsError[id] = "";

    commentsOpen[id] = !commentsOpen[id];

    if (commentsOpen[id] && commentsByComplaint[id].length === 0) {
        await fetchComments(id);
    }
}

async function fetchComments(complaintId) {
    commentsLoading[complaintId] = true;
    commentsError[complaintId] = "";

    try {
        const res = await api.get(`/complaints/get-comment/${complaintId}`);
        const list = res.data?.data;
        commentsByComplaint[complaintId] = Array.isArray(list) ? list : [];
    } catch (err) {
        commentsError[complaintId] = err?.response?.data?.message || "Failed to load comments";
        commentsByComplaint[complaintId] = [];
    } finally {
        commentsLoading[complaintId] = false;
    }
}



// menu open state (one at a time)
const openMenu = reactive({ complaintId: null, commentId: null });

function isCommentMenuOpen(complaintId, commentId) {
    return openMenu.complaintId === complaintId && openMenu.commentId === commentId;
}

function toggleCommentMenu(complaintId, commentId) {
    if (isCommentMenuOpen(complaintId, commentId)) {
        openMenu.complaintId = null;
        openMenu.commentId = null;
    } else {
        openMenu.complaintId = complaintId;
        openMenu.commentId = commentId;
    }
}

function canManageComment(c) {
    const me = authUser.value;
    if (!me) return false;
    return c?.user?.id === me.id || me.role === "admin";
}

// close menu when clicking anywhere else
function closeMenu() {
    openMenu.complaintId = null;
    openMenu.commentId = null;
}

// edit state
const editState = reactive({
    complaintId: null,
    commentId: null,
    text: "",
});

function isEditingComment(complaintId, commentId) {
    return editState.complaintId === complaintId && editState.commentId === commentId;
}

function startEditComment(complaintId, c) {
    closeMenu();
    editState.complaintId = complaintId;
    editState.commentId = c.id;
    editState.text = c.comment || "";
}

function cancelEdit() {
    editState.complaintId = null;
    editState.commentId = null;
    editState.text = "";
}

// UI-only save (backend later)
function saveEditComment(complaintId) {
    const cid = editState.commentId;
    if (!cid) return;

    const list = commentsByComplaint[complaintId] || [];
    const idx = list.findIndex(x => x.id === cid);
    if (idx !== -1) {
        list[idx].comment = editState.text.trim();
    }

    cancelEdit();
}

// UI-only delete confirm (backend later)
async function askDeleteComment(complaintId, c) {
    closeMenu();
    const ok = confirm("Delete this comment?");
    if (!ok) return;
    
    try {
        const res = await api.delete(`/complaints/delete-comment/${c.id}`);

        // remove from UI list
        commentsByComplaint[complaintId] =
        (commentsByComplaint[complaintId] || []).filter(x => x.id !== c.id);

        // sync count from backend
        const newCount = res.data?.data?.comments_count;
        const target = complaints.value.find(x => x.id === complaintId);
        if (target) {
            target.comments_count = (newCount != null) ? newCount : Math.max(0, (target.comments_count ?? 0) - 1);
        }

    } catch (err) {
        errorMsg.value = err?.response?.data?.message || "Failed to delete comment.";
    }
}

function onBodyClick() {
    closeMenu();
}




// login user data show {makeImg} inport in api
const authUser = ref(null);
const isLoggedIn = ref(false);

async function loadAuthUser() {
    try {
        const token = localStorage.getItem("token");
        if (!token) {
            isLoggedIn.value = false;
            authUser.value = null;
            return;
        }

        const res = await api.get("/user");
        authUser.value = res.data?.data ?? res.data;
        isLoggedIn.value = true;
    } catch (err) {
        isLoggedIn.value = false;
        authUser.value = null;
    }
}

const avatarUrl = computed(() => {
    const photo = authUser.value?.photo;
    return photo ? makeImg(photo) : defaultAvatar;
});






const sidebarOpen = ref(false);
const isDark = ref(false);
function applyTheme(dark) {
    isDark.value = dark;
    document.documentElement.classList.toggle("dark", dark);
    localStorage.setItem("theme", dark ? "dark" : "light");
}

function toggleTheme() {
  applyTheme(!isDark.value);
}

function handleEsc(e) {
    if (e.key === "Escape") sidebarOpen.value = false;
}

/* ESC to close drawer */
onMounted(() => {
    getComplaints();
    loadAuthUser();

    document.addEventListener("click", onBodyClick);

    window.addEventListener("keydown", handleEsc);
    const saved = localStorage.getItem("theme");
    if (saved === "dark") applyTheme(true);
    else if (saved === "light") applyTheme(false);
    else {
        const systemDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
        applyTheme(systemDark);
    }
});

onBeforeUnmount(() => {
    window.removeEventListener("keydown", handleEsc);

    document.removeEventListener("click", onBodyClick);
});
</script>

<style>

</style>