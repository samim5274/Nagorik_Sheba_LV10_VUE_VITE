<template>
    <main class="min-h-screen bg-gray-50 dark:bg-[#0C1326]">
        <div class="mx-auto px-4 sm:px-6 lg:px-8 py-5">

            <!-- Top bar (Title + optional actions/search) -->
            <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                <div>
                    <h1 class="text-xl sm:text-2xl font-bold text-gray-800 dark:text-gray-100">Dashboard Overview</h1>
                    <p class="text-sm text-gray-700 dark:text-slate-300">Complaints summary & performance</p>
                </div>

                <!-- Optional: right side button -->
                <div class="flex items-center gap-3">
                    <button class="rounded-xl px-4 py-2 text-sm font-semibold bg-slate-200 dark:bg-white/10 
                    dark:text-white border border-white/10 hover:bg-white/15 transition">Export</button>
                </div>
            </div>

            <!-- Cards Grid -->
            <div class="mt-8 grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">

            <!-- Card -->
            <div
                data-aos="fade-up"
                class="group relative overflow-hidden rounded-2xl
                    bg-white/95 dark:bg-slate-900
                    border border-slate-200/60 dark:border-slate-700
                    shadow-md hover:shadow-xl
                    transition-all duration-300 p-6">
                <div class="flex items-center justify-between">
                <h2 class="text-sm font-semibold text-slate-500 dark:text-slate-400">
                    Total Complaints
                </h2>

                <div class="h-10 w-10 flex items-center justify-center rounded-xl
                            bg-amber-100 dark:bg-amber-500/20
                            text-amber-600 dark:text-amber-400">
                    <i class="fa-solid fa-triangle-exclamation text-lg"></i>
                </div>
                </div>

                <div class="mt-6">
                <h3 class="text-3xl font-bold text-slate-900 dark:text-white">150</h3>

                <p class="mt-2 flex items-center text-sm font-medium text-green-600 dark:text-green-400">
                    <i class="fa-solid fa-arrow-trend-up mr-2"></i>
                    +12% from last month
                </p>
                </div>

                <div class="mt-6">
                <span class="inline-flex items-center gap-2 px-3 py-1 text-xs font-medium rounded-full
                            bg-slate-100 dark:bg-slate-800
                            text-slate-700 dark:text-slate-300
                            border border-slate-200 dark:border-slate-600">
                    <span class="h-2 w-2 rounded-full bg-green-500"></span>
                    Complaint Records
                </span>
                </div>
            </div>

            <!-- Card 2 -->
            <div data-aos="fade-up"
                class="group relative overflow-hidden rounded-2xl
                    bg-white/95 dark:bg-slate-900
                    border border-slate-200/60 dark:border-slate-700
                    shadow-md hover:shadow-xl
                    transition-all duration-300 p-6">
                <div class="flex items-center justify-between">
                <h2 class="text-sm font-semibold text-slate-500 dark:text-slate-400">Pending</h2>
                <div class="h-10 w-10 flex items-center justify-center rounded-xl
                            bg-orange-100 dark:bg-orange-500/20
                            text-orange-600 dark:text-orange-400">
                    <i class="fa-solid fa-clock text-lg"></i>
                </div>
                </div>

                <div class="mt-6">
                <h3 class="text-3xl font-bold text-slate-900 dark:text-white">36</h3>
                <p class="mt-2 flex items-center text-sm font-medium text-orange-600 dark:text-orange-400">
                    <i class="fa-solid fa-arrow-trend-up mr-2"></i>
                    +5% this week
                </p>
                </div>

                <div class="mt-6">
                <span class="inline-flex items-center gap-2 px-3 py-1 text-xs font-medium rounded-full
                            bg-slate-100 dark:bg-slate-800
                            text-slate-700 dark:text-slate-300
                            border border-slate-200 dark:border-slate-600">
                    <span class="h-2 w-2 rounded-full bg-orange-500"></span>
                    Waiting for action
                </span>
                </div>
            </div>

            <!-- Card 3 -->
            <div data-aos="fade-up"
                class="group relative overflow-hidden rounded-2xl
                    bg-white/95 dark:bg-slate-900
                    border border-slate-200/60 dark:border-slate-700
                    shadow-md hover:shadow-xl
                    transition-all duration-300 p-6">
                <div class="flex items-center justify-between">
                <h2 class="text-sm font-semibold text-slate-500 dark:text-slate-400">Resolved</h2>
                <div class="h-10 w-10 flex items-center justify-center rounded-xl
                            bg-emerald-100 dark:bg-emerald-500/20
                            text-emerald-700 dark:text-emerald-400">
                    <i class="fa-solid fa-circle-check text-lg"></i>
                </div>
                </div>

                <div class="mt-6">
                <h3 class="text-3xl font-bold text-slate-900 dark:text-white">114</h3>
                <p class="mt-2 flex items-center text-sm font-medium text-emerald-700 dark:text-emerald-400">
                    <i class="fa-solid fa-arrow-trend-up mr-2"></i>
                    +18% from last month
                </p>
                </div>

                <div class="mt-6">
                <span class="inline-flex items-center gap-2 px-3 py-1 text-xs font-medium rounded-full
                            bg-slate-100 dark:bg-slate-800
                            text-slate-700 dark:text-slate-300
                            border border-slate-200 dark:border-slate-600">
                    <span class="h-2 w-2 rounded-full bg-emerald-500"></span>
                    Completed
                </span>
                </div>
            </div>

            <!-- Card 4 -->
            <div data-aos="fade-up"
                class="group relative overflow-hidden rounded-2xl
                    bg-white/95 dark:bg-slate-900
                    border border-slate-200/60 dark:border-slate-700
                    shadow-md hover:shadow-xl
                    transition-all duration-300 p-6">
                <div class="flex items-center justify-between">
                <h2 class="text-sm font-semibold text-slate-500 dark:text-slate-400">Today New</h2>
                <div class="h-10 w-10 flex items-center justify-center rounded-xl
                            bg-sky-100 dark:bg-sky-500/20
                            text-sky-700 dark:text-sky-400">
                    <i class="fa-solid fa-bolt text-lg"></i>
                </div>
                </div>

                <div class="mt-6">
                <h3 class="text-3xl font-bold text-slate-900 dark:text-white">9</h3>
                <p class="mt-2 flex items-center text-sm font-medium text-sky-700 dark:text-sky-400">
                    <i class="fa-solid fa-arrow-trend-up mr-2"></i>
                    +2 since morning
                </p>
                </div>

                <div class="mt-6">
                <span class="inline-flex items-center gap-2 px-3 py-1 text-xs font-medium rounded-full
                            bg-slate-100 dark:bg-slate-800
                            text-slate-700 dark:text-slate-300
                            border border-slate-200 dark:border-slate-600">
                    <span class="h-2 w-2 rounded-full bg-sky-500"></span>
                    Fresh complaints
                </span>
                </div>
            </div>

            </div>
        </div>

        <div class="mx-auto px-4 sm:px-6 lg:px-8 py-5">
            <div class="grid grid-cols-1 xl:grid-cols-12 gap-4">
                <div class="xl:col-span-8 bg-gray-50 dark:bg-[#0c1326] border dark:border-slate-700 rounded-md p-3 text-white">
                    <h4 class="pb-2">Public Complain</h4>
                    <div class="w-full overflow-hidden rounded-2xl dark:border-slate-700  shadow-sm">
                        <!-- Table Header Area -->
                        <!-- <div class="flex flex-col gap-3 border-b border-slate-200 dark:border-slate-700 px-4 py-4 sm:flex-row sm:items-center sm:justify-between">
                            <div>
                            <h2 class="text-base font-semibold text-slate-800 dark:text-slate-100">Complaint List</h2>
                            <p class="text-sm text-slate-500 dark:text-slate-400">Manage and monitor all submitted complaints</p>
                            </div>

                            <div class="flex flex-col gap-2 sm:flex-row sm:items-center">
                            <input
                                type="text"
                                placeholder="Search complaint..."
                                class="w-full sm:w-64 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-sm text-slate-700 dark:text-slate-100 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500"
                            />

                            <select
                                class="rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-sm text-slate-700 dark:text-slate-100 focus:outline-none focus:ring-2 focus:ring-indigo-500"
                            >
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
                        </div> -->

                        <!-- List -->
                        <div class="w-full overflow-x-auto max-h-[500px] mb-3">
                            <div class="space-y-3">
                                <!-- Items -->
                                <article
                                    v-for="complaint in complaints"
                                    :key="complaint.id"
                                    @click="viewComplaint(complaint)"
                                    class="group cursor-pointer rounded-2xl border border-slate-200 bg-white p-4 shadow-sm transition
                                        hover:shadow-md hover:bg-slate-50/60
                                        dark:border-slate-700 dark:bg-slate-900 dark:hover:bg-slate-800/40">
                                    <div class="flex items-start gap-4">
                                        <!-- left icon -->
                                        <div class="mt-0.5 flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl border border-slate-200 bg-slate-50 text-slate-600
                                                    dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200">
                                            <i class="fa-regular fa-file-lines"></i>
                                        </div>

                                        <!-- content -->
                                        <div class="min-w-0 flex-1">
                                            <!-- top row -->
                                            <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
                                                <!-- left -->
                                                <div class="min-w-0">
                                                    <div class="flex flex-wrap items-center gap-2">
                                                        <h3 class="truncate text-sm font-bold text-slate-900 dark:text-slate-100 group-hover:underline">
                                                            {{ complaint.title || "Untitled Complaint" }}
                                                        </h3>

                                                        <span
                                                            class="inline-flex items-center rounded-full border border-slate-200 bg-slate-50 px-2 py-0.5 text-[11px] font-semibold text-slate-600
                                                                dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200">
                                                            #{{ complaint.complaint_no || "N/A" }}
                                                        </span>

                                                        <span
                                                            v-if="complaint.is_anonymous"
                                                            class="inline-flex items-center rounded-full bg-purple-100 px-2 py-0.5 text-[11px] font-semibold text-purple-700
                                                                dark:bg-purple-900/30 dark:text-purple-300"
                                                        >
                                                            Anonymous
                                                        </span>

                                                        <span
                                                            v-if="complaint.is_public"
                                                            class="inline-flex items-center rounded-full bg-emerald-100 px-2 py-0.5 text-[11px] font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300">
                                                            Public
                                                        </span>
                                                    </div>

                                                    <!-- tags -->
                                                    <div class="mt-2 flex flex-wrap gap-2">
                                                        <span class="inline-flex rounded-full bg-slate-100 px-2 py-0.5 text-[11px] text-slate-700 dark:bg-slate-800 dark:text-slate-200">
                                                            {{ complaint.category?.name || "No Category" }}
                                                        </span>

                                                        <span
                                                            v-if="complaint.sub_category?.name"
                                                            class="inline-flex rounded-full bg-blue-50 px-2 py-0.5 text-[11px] text-blue-700 dark:bg-blue-900/20 dark:text-blue-300">
                                                            {{ complaint.sub_category?.name }}
                                                        </span>
                                                    </div>

                                                    <!-- meta line -->
                                                    <p class="mt-2 text-xs text-slate-500 dark:text-slate-400">
                                                        <span class="inline-flex items-center gap-2">
                                                            <i class="fa-regular fa-clock"></i>
                                                            {{ formatDate(complaint.created_at) }} • {{ formatTime(complaint.created_at) }}
                                                        </span>
                                                    </p>
                                                </div>

                                                <!-- right: badges -->
                                                <div class="flex flex-wrap items-center gap-2">
                                                    <span class="inline-flex rounded-full px-2.5 py-1 text-xs font-semibold capitalize" :class="priorityBadge(complaint.priority)">
                                                        {{ complaint.priority || "N/A" }}
                                                    </span>

                                                    <span class="inline-flex rounded-full px-2.5 py-1 text-xs font-semibold capitalize" :class="statusBadge(complaint.status)" >
                                                        {{ formatStatus(complaint.status) }}
                                                    </span>
                                                </div>
                                            </div>

                                            <!-- location -->
                                            <div class="mt-3 flex flex-col gap-1 text-xs text-slate-600 dark:text-slate-400 sm:flex-row sm:items-center sm:justify-between">
                                                <p class="truncate">
                                                    <i class="fa-solid fa-location-dot me-2"></i>
                                                    {{ complaint.division?.name || "-" }},
                                                    {{ complaint.district?.name || "-" }}
                                                    <span v-if="complaint.upazila?.name">, {{ complaint.upazila?.name }}</span>
                                                    <span v-if="complaint.police_station?.name">, {{ complaint.police_station?.name }}</span>
                                                    <span v-if="complaint.attachments?.length" class="inline-flex items-center ml-2">
                                                        <i class="fa-solid fa-paperclip me-2"></i>
                                                        {{ complaint.attachments.length }} attachment(s)
                                                    </span>
                                                </p>

                                                <p class="truncate sm:max-w-[320px]">
                                                    {{ complaint.address_line || "No address" }}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </article>

                                <!-- Empty -->
                                <div
                                    v-if="!loading && (!complaints || complaints.length === 0)"
                                    class="rounded-2xl border border-slate-200 bg-white p-8 text-center dark:border-slate-700 dark:bg-slate-900">
                                    <p class="text-sm font-semibold text-slate-800 dark:text-slate-100">No complaints found.</p>
                                    <p class="mt-1 text-xs text-slate-500 dark:text-slate-400">Try adjusting filters or search.</p>
                                </div>
                            </div>
                        </div>
                        <!-- Pegination section -->
                        <div class="flex flex-col gap-2 border-slate-200 bg-white dark:bg-slate-900 shadow-sm px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
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
                <div class="xl:col-span-4 bg-gray-50 dark:bg-[#0c1326] border dark:border-slate-700 rounded-md p-3 text-white">
                    <h4 class="pb-2">My Complain</h4>
                    <!-- <p class="text-xs text-red-500">Count: {{ myComplaints.length }}</p> -->
                    <div class="w-full overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <div class="space-y-3">
                                <!-- List items -->
                                <article
                                    v-for="c in myComplaints"
                                    :key="c.id" 
                                    class="group rounded-2xl border border-slate-200 bg-white p-4 shadow-sm transition hover:shadow-md dark:border-slate-700 dark:bg-slate-900">

                                    <div class="flex items-start gap-4">
                                        <!-- icon chip -->
                                        <div class="mt-0.5 flex h-10 w-10 shrink-0 items-center justify-center rounded-2xl border border-slate-200 bg-slate-50 text-slate-600 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200">
                                            <i class="fa-regular fa-file-lines"></i>
                                        </div>

                                        <!-- main -->
                                        <div class="min-w-0 flex-1">
                                            <!-- top row -->
                                            <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
                                                <div class="min-w-0">
                                                    <div class="flex flex-wrap items-center gap-2">
                                                        <h3 @click="viewComplaint(c)" class="truncate text-sm font-bold text-slate-900 dark:text-slate-100 hover:underline hover:cursor-pointer">
                                                            {{ c.title || "Untitled Complaint" }}
                                                        </h3>

                                                        <span class="inline-flex items-center rounded-full border border-slate-200 bg-slate-50 px-2 py-0.5 text-[11px] font-semibold text-slate-600 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200">
                                                            #{{ c.complaint_no || "N/A" }}
                                                        </span>

                                                        <!-- <span
                                                            v-if="c.is_anonymous"
                                                            class="inline-flex items-center rounded-full bg-purple-100 px-2 py-0.5 text-[11px] font-semibold text-purple-700 dark:bg-purple-900/30 dark:text-purple-300">
                                                            Anonymous
                                                        </span>

                                                        <span
                                                            v-if="c.is_public"
                                                            class="inline-flex items-center rounded-full bg-emerald-100 px-2 py-0.5 text-[11px] font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300">
                                                            Public
                                                        </span> -->
                                                    </div>

                                                    <p class="mt-1 text-xs text-slate-500 dark:text-slate-400">
                                                        {{ c.category?.name || "Category N/A" }}
                                                        <span class="mx-1">•</span>
                                                        {{ c.sub_category?.name || "Sub N/A" }}
                                                        <span class="mx-1">•</span>
                                                        {{ c.district?.name || "District N/A" }}
                                                        <span v-if="c.upazila?.name">, {{ c.upazila?.name }}</span>
                                                        <span v-if="c.ward_no"> (Ward {{ c.ward_no }})</span>
                                                    </p>
                                                </div>

                                                <!-- badges -->
                                                <!-- <div class="flex flex-wrap items-center gap-2">
                                                    <span class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-semibold capitalize" :class="priorityBadge(c.priority)">
                                                    {{ c.priority || "N/A" }}
                                                    </span>

                                                    <span class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-semibold capitalize" :class="statusBadge(c.status)">
                                                    {{ formatStatus(c.status) }}
                                                    </span>
                                                </div> -->

                                                <div v-if="c.status === 'pending'" class="flex flex-wrap items-center gap-2">
                                                    <span class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-semibold capitalize text-red-500">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                    </span>
                                                </div>
                                            </div>

                                            <!-- bottom meta -->
                                            <div class="mt-3 flex flex-wrap items-center gap-x-4 gap-y-2 text-xs text-slate-500 dark:text-slate-400">
                                                <span class="inline-flex items-center gap-2">
                                                    <i class="fa-regular fa-clock"></i>
                                                    {{ formatDate(c.created_at) }} • {{ formatTime(c.created_at) }}
                                                </span>

                                                <span v-if="c.assigned_to" class="inline-flex items-center gap-2">
                                                    <i class="fa-solid fa-user-check"></i>
                                                    Assigned
                                                </span>

                                                <!-- <span v-if="c.attachments?.length" class="inline-flex items-center gap-2">
                                                    <i class="fa-solid fa-paperclip"></i>
                                                    {{ c.attachments.length }} attachment(s)
                                                </span> -->
                                            </div>

                                            <!-- actions -->
                                            <!-- <div class="mt-4 flex flex-wrap items-center justify-end gap-2">
                                                <button
                                                    type="button"
                                                    @click="viewComplaint(c)"
                                                    class="inline-flex items-center gap-2 rounded-xl border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-700 shadow-sm hover:bg-slate-50 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-100 dark:hover:bg-slate-800">
                                                    <i class="fa-regular fa-eye"></i>
                                                    View
                                                </button>

                                                <button
                                                    v-if="c.status === 'pending'"
                                                    type="button"
                                                    @click="onDelete(c)"
                                                        class="inline-flex items-center gap-2 rounded-xl border border-red-200 bg-red-50 px-3 py-2 text-xs font-semibold text-red-700 shadow-sm
                                                        hover:bg-red-100 active:bg-red-200 transition
                                                        dark:border-red-800 dark:bg-red-950/30 dark:text-red-300 dark:hover:bg-red-900/40
                                                        focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 dark:focus:ring-offset-slate-900">
                                                    <i class="fa-solid fa-trash-can"></i>
                                                    Delete
                                                </button>
                                            </div> -->
                                        </div>
                                    </div>
                                </article>

                                <!-- Empty -->
                                <div
                                    v-if="!loading && (myComplaints?.length ?? 0) === 0"
                                    class="rounded-2xl border border-slate-200 bg-white p-8 text-center dark:border-slate-700 dark:bg-slate-900">
                                    <p class="text-sm font-semibold text-slate-800 dark:text-slate-100">No complaints found</p>
                                    <p class="mt-1 text-xs text-slate-500 dark:text-slate-400">Try changing filters or create a new complaint.</p>
                                </div>
                            </div>
                        </div>
                        <!-- Pegination section -->
                        <div class="flex flex-col gap-2 border-slate-200 px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
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
                                    @click="getMyComplaints(1)"
                                    :disabled="currentPage === 1 || loading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-angles-left"></i>
                                </button>

                                <!-- Prev -->
                                <button
                                    @click="getMyComplaints(Math.max(1, currentPage - 1))"
                                    :disabled="currentPage === 1 || loading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </button>

                                <!-- Pages -->
                                <button
                                    v-for="page in visiblePages"
                                    :key="String(page)"
                                    :disabled="page === '...' || loading"
                                    @click="page !== '...' && getMyComplaints(page)"
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
                                    @click="getMyComplaints(Math.min(lastPage, currentPage + 1))"
                                    :disabled="currentPage === lastPage || loading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-angle-right"></i>
                                </button>

                                <!-- Last -->
                                <button
                                    @click="getMyComplaints(lastPage)"
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
    </main>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import { useRouter } from "vue-router";
import api from "../../services/api";

const router = useRouter();

const complaints = ref([]);
const myComplaints = ref([]);
const loading = ref(false);
const errorMsg = ref("");

// loading + error reset
function resetErrorAndLoading() {
    loading.value = true;
    errorMsg.value = "";
}

// common error handler
function handleApiError(err, fallbackMessage, targetRef = null) {
    console.error(fallbackMessage, err);
    errorMsg.value = err?.response?.data?.message || fallbackMessage;

    if (targetRef) {
        targetRef.value = [];
    }
}

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

function formatStatus(status) {
    return (status || "N/A").toString().replaceAll("_", " ");
}

// view complaint
function viewComplaint(complaint) {
    if (!complaint?.id) return;
    router.push(`/complaints/${complaint.id}/${complaint.complaint_no ?? ''}`);
}

function priorityBadge(priority) {
    const p = (priority || "").toLowerCase();
    if (p === "low") return "bg-slate-100 text-slate-700 dark:bg-slate-700 dark:text-slate-200";
    if (p === "medium") return "bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300";
    if (p === "high") return "bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-300";
    if (p === "urgent") return "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300";
    return "bg-slate-100 text-slate-700 dark:bg-slate-700 dark:text-slate-200";
}

function statusBadge(status) {
    const s = (status || "").toLowerCase();
    if (s === "pending") return "bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-300";
    if (s === "in_progress") return "bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300";
    if (s === "resolved") return "bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300";
    if (s === "rejected") return "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300";
    if (s === "closed") return "bg-slate-200 text-slate-700 dark:bg-slate-700 dark:text-slate-200";
    if (s === "assigned") return "bg-indigo-100 text-indigo-700 dark:bg-indigo-900/30 dark:text-indigo-300";
    if (s === "in_review") return "bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-300";
    if (s === "on_hold") return "bg-pink-100 text-pink-700 dark:bg-pink-900/30 dark:text-pink-300";
    return "bg-slate-100 text-slate-700 dark:bg-slate-700 dark:text-slate-200";
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
        const res = await api.get(`/complaints?page=${page}`);
        const response = res.data?.data;

        complaints.value = response?.data ?? [];
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

async function getMyComplaints(page = 1) {
    resetErrorAndLoading();

    try {

        const params = new URLSearchParams();
        params.set("page", String(page));

        const res = await api.get(`/complaints/view?${params.toString()}`);
        const response = res.data?.data;

        myComplaints.value = response?.data ?? [];
        currentPage.value = response?.current_page ?? 1;
        lastPage.value = response?.last_page ?? 1;
        total.value = response?.total ?? 0;
        perPage.value = response?.per_page ?? 20;
        fromItem.value = response?.from ?? 0;
        toItem.value = response?.to ?? 0;

        // console.log("API Response:", res.data);
    } catch (err) {
        console.error("complaints load error:", err);
        handleApiError(err, "Failed to load complaints");
        myComplaints.value = [];

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

onMounted(() => {
    getComplaints(1);
    getMyComplaints(1);
});
</script>

<style>

</style>