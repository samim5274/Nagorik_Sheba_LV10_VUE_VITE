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
                <!-- <div class="flex items-center gap-3">
                    <button class="rounded-xl px-4 py-2 text-sm font-semibold bg-slate-200 dark:bg-white/10 
                    dark:text-white border border-white/10 hover:bg-white/15 transition">Export</button>
                </div> -->
            </div>

            <!-- Cards Grid -->
            <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3 mt-4">
                <div
                    v-for="card in statusCards"
                    :key="card.key"
                    data-aos="fade-up"
                    class="group relative overflow-hidden rounded-2xl bg-white/95 dark:bg-slate-900
                        border border-slate-200/60 dark:border-slate-700
                        shadow-md hover:shadow-xl transition-all duration-300 p-6">

                    <!-- Soft glow -->
                    <div class="pointer-events-none absolute -top-16 -right-16 h-40 w-40 rounded-full blur-3xl opacity-40" :class="card.glow"></div>

                        <div class="flex items-center justify-between">
                            <h2 class="text-sm font-semibold text-slate-500 dark:text-slate-400">
                                {{ card.title }}
                            </h2>

                        <div
                            class="h-10 w-10 flex items-center justify-center rounded-xl"
                            :class="card.iconWrap">
                            <i :class="card.icon + ' text-lg'"></i>
                        </div>
                    </div>

                    <div class="mt-6">
                        <h3 class="text-3xl font-bold text-slate-900 dark:text-white">
                            {{ formatCount(card.value ?? 0) }}
                        </h3>

                        <p v-if="card.subtext" class="mt-2 flex items-center text-sm font-medium" :class="card.subtextClass">
                            <i :class="card.subIcon + ' mr-2'"></i>
                            {{ card.subtext }}
                        </p>

                        <p v-else class="mt-2 text-sm text-slate-500 dark:text-slate-400">
                            Updated just now
                        </p>
                    </div>

                    <div class="mt-6">
                        <span
                            class="inline-flex items-center gap-2 px-3 py-1 text-xs font-medium rounded-full
                                bg-slate-100 dark:bg-slate-800
                                text-slate-700 dark:text-slate-300
                                border border-slate-200 dark:border-slate-600">
                            <span class="h-2 w-2 rounded-full" :class="card.dot"></span>
                            {{ card.pill }}
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
                        <div class="w-full overflow-x-auto max-h-[950px] mb-3">
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
                                <span class="font-semibold text-slate-700">{{ publicFromItem }}</span>
                                –
                                <span class="font-semibold text-slate-700">{{ publicToItem }}</span>
                                of
                                <span class="font-semibold text-slate-700">{{ publicTotal }}</span>
                            </p>

                            <div class="flex flex-wrap items-center justify-end gap-2">
                                <!-- First -->
                                <button
                                    @click="getComplaints(1)"
                                    :disabled="publicPage === 1 || publicLoading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-angles-left"></i>
                                </button>

                                <!-- Prev -->
                                <button
                                    @click="getComplaints(Math.max(1, publicPage - 1))"
                                    :disabled="publicPage === 1 || publicLoading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-chevron-left"></i>
                                </button>

                                <!-- Pages -->
                                <button
                                    v-for="page in publicVisiblePages"
                                    :key="String(page)"
                                    :disabled="page === '...' || publicLoading"
                                    @click="page !== '...' && getComplaints(page)"
                                    class="rounded-lg border px-3 py-1.5 text-xs font-semibold"
                                    :class="[
                                        page === '...'
                                            ? 'border-slate-200 bg-white dark:bg-slate-900 text-slate-400 cursor-default'
                                            : publicPage === page
                                                ? 'border-slate-900 bg-slate-900 dark:bg-slate-100 text-white dark:text-slate-900'
                                                : 'border-slate-200 bg-white dark:bg-slate-900 text-slate-700 dark:text-slate-100 hover:bg-slate-50'
                                    ]">
                                    {{ page }}
                                </button>

                                <!-- Next -->
                                <button
                                    @click="getComplaints(Math.min(publicLastPage, publicPage + 1))"
                                    :disabled="publicPage === publicLastPage || publicLoading"
                                    class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                    <i class="fa-solid fa-angle-right"></i>
                                </button>

                                <!-- Last -->
                                <button
                                    @click="getComplaints(publicLastPage)"
                                    :disabled="publicPage === publicLastPage || publicLoading"
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
                    <div class="w-full overflow-x-auto max-h-[950px] mb-3">
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
                    </div>
                    <!-- Pegination section -->
                    <div class="flex flex-col gap-2 border-slate-200 px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
                        <p class="text-xs text-slate-500">
                            Showing
                            <span class="font-semibold text-slate-700">{{ myFromItem }}</span>
                            –
                            <span class="font-semibold text-slate-700">{{ myToItem }}</span>
                            of
                            <span class="font-semibold text-slate-700">{{ myTotal }}</span>
                        </p>

                        <div class="flex flex-wrap items-center justify-end gap-2">
                            <!-- First -->
                            <button
                                @click="getMyComplaints(1)"
                                :disabled="myPage === 1 || myLoading"
                                class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                <i class="fa-solid fa-angles-left"></i>
                            </button>

                            <!-- Prev -->
                            <button
                                @click="getMyComplaints(Math.max(1, myPage - 1))"
                                :disabled="myPage === 1 || myLoading"
                                class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                <i class="fa-solid fa-chevron-left"></i>
                            </button>

                            <!-- Pages -->
                            <button
                                v-for="page in myVisiblePages"
                                :key="String(page)"
                                :disabled="page === '...' || myLoading"
                                @click="page !== '...' && getMyComplaints(page)"
                                class="rounded-lg border px-3 py-1.5 text-xs font-semibold"
                                :class="[
                                    page === '...'
                                        ? 'border-slate-200 bg-white dark:bg-slate-900 text-slate-400 cursor-default'
                                        : myPage === page
                                            ? 'border-slate-900 bg-slate-900 dark:bg-slate-100 text-white dark:text-slate-900'
                                            : 'border-slate-200 bg-white dark:bg-slate-900 text-slate-700 dark:text-slate-100 hover:bg-slate-50'
                                ]">
                                {{ page }}
                            </button>

                            <!-- Next -->
                            <button
                                @click="getMyComplaints(Math.min(myLastPage, myPage + 1))"
                                :disabled="myPage === myLastPage || myLoading"
                                class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                <i class="fa-solid fa-angle-right"></i>
                            </button>

                            <!-- Last -->
                            <button
                                @click="getMyComplaints(myLastPage)"
                                :disabled="myPage === myLastPage || myLoading"
                                class="rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 disabled:opacity-40">
                                <i class="fa-solid fa-angles-right"></i>
                            </button>
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

const publicLoading = ref(false);
const myLoading = ref(false);

const publicPagination = ref({
    currentPage: 1,
    lastPage: 1,
    total: 0,
    perPage: 10,
    from: 0,
    to: 0,
});

const myPagination = ref({
    currentPage: 1,
    lastPage: 1,
    total: 0,
    perPage: 10,
    from: 0,
    to: 0,
});

// loading + error reset
function resetErrorAndLoading(type = "public") {
    errorMsg.value = "";

    publicLoading.value = false;
    myLoading.value = false;

    if (type === "public") {
        publicLoading.value = true;
    }

    if (type === "my") {
        myLoading.value = true;
    }
}

// common error handler
function handleApiError(err, fallbackMessage, targetRef = null) {
    console.error(fallbackMessage, err);
    errorMsg.value = err?.response?.data?.message || fallbackMessage;

    if (targetRef) {
        targetRef.value = [];
    }
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
const publicPage = ref(1);
const publicLastPage = ref(1);
const publicTotal = ref(0);
const publicPerPage = ref(15);
const publicFromItem = ref(0);
const publicToItem = ref(0);

const myPage = ref(1);
const myLastPage = ref(1);
const myTotal = ref(0);
const myPerPage = ref(15);
const myFromItem = ref(0);
const myToItem = ref(0);

const publicVisiblePages = computed(() => {
    const pages = [];
    const last = publicLastPage.value;
    const cur = publicPage.value;

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

const myVisiblePages = computed(() => {
    const pages = [];
    const last = myLastPage.value;
    const cur = myPage.value;

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
    resetErrorAndLoading("public");

    try {
        const res = await api.get(`/complaints?page=${page}`);
        const response = res.data?.data;

        complaints.value = response?.data ?? [];
        publicPage.value = response?.current_page ?? 1;
        publicLastPage.value = response?.last_page ?? 1;
        publicTotal.value = response?.total ?? 0;
        publicPerPage.value = response?.per_page ?? 15;
        publicFromItem.value = response?.from ?? 0;
        publicToItem.value = response?.to ?? 0;
    } catch (err) {
        handleApiError(err, "Failed to load complaints", complaints);

        complaints.value = [];
        publicPage.value = 1;
        publicLastPage.value = 1;
        publicTotal.value = 0;
        publicFromItem.value = 0;
        publicToItem.value = 0;
    } finally {
        publicLoading.value = false;
    }
}

async function getMyComplaints(page = 1) {
    resetErrorAndLoading("my");

    try {
        const params = new URLSearchParams();
        params.set("page", String(page));

        const res = await api.get(`/complaints/view?${params.toString()}`);
        const response = res.data?.data;

        myComplaints.value = response?.data ?? [];
        myPage.value = response?.current_page ?? 1;
        myLastPage.value = response?.last_page ?? 1;
        myTotal.value = response?.total ?? 0;
        myPerPage.value = response?.per_page ?? 15;
        myFromItem.value = response?.from ?? 0;
        myToItem.value = response?.to ?? 0;
    } catch (err) {
        handleApiError(err, "Failed to load complaints", myComplaints);

        myComplaints.value = [];
        myPage.value = 1;
        myLastPage.value = 1;
        myTotal.value = 0;
        myFromItem.value = 0;
        myToItem.value = 0;
    } finally {
        myLoading.value = false;
    }
}

const stats = ref({
    pending: 0,
    in_progress: 0,
    resolved: 0,
    rejected: 0,
    closed: 0,
    assigned: 0,
    in_review: 0,
    on_hold: 0,
    today_new: 0,
});

async function getStats() {
    try {
        const res = await api.get("/complaints/stats");
        stats.value = res.data?.data ?? stats.value;
    } catch (e) {
        console.error("Stats load error:", e);
    }
}

const statusCards = computed(() => [
    // Extra Card: Today New
    {
        key: "today_new",
        title: "Today New",
        value: stats.value.today_new,
        icon: "fa-solid fa-bolt",
        iconWrap: "bg-sky-100 dark:bg-sky-500/20 text-sky-700 dark:text-sky-400",
        glow: "bg-sky-400/30 dark:bg-sky-500/20",
        dot: "bg-sky-500",
        pill: "Fresh complaints",
        subIcon: "fa-solid fa-sun",
        subtext: "Created today",
        subtextClass: "text-sky-700 dark:text-sky-400",
    },

    {
        key: "pending",
        title: "Pending",
        value: stats.value.pending,
        icon: "fa-solid fa-clock",
        iconWrap: "bg-amber-100 dark:bg-amber-500/20 text-amber-700 dark:text-amber-400",
        glow: "bg-amber-400/30 dark:bg-amber-500/20",
        dot: "bg-amber-500",
        pill: "Waiting for action",
        subIcon: "fa-solid fa-hourglass-half",
        subtext: "Needs review",
        subtextClass: "text-amber-700 dark:text-amber-400",
    },
    {
        key: "in_progress",
        title: "In Progress",
        value: stats.value.in_progress,
        icon: "fa-solid fa-spinner",
        iconWrap: "bg-blue-100 dark:bg-blue-500/20 text-blue-700 dark:text-blue-400",
        glow: "bg-blue-400/30 dark:bg-blue-500/20",
        dot: "bg-blue-500",
        pill: "Work ongoing",
        subIcon: "fa-solid fa-screwdriver-wrench",
        subtext: "Processing now",
        subtextClass: "text-blue-700 dark:text-blue-400",
    },
    {
        key: "resolved",
        title: "Resolved",
        value: stats.value.resolved,
        icon: "fa-solid fa-circle-check",
        iconWrap: "bg-emerald-100 dark:bg-emerald-500/20 text-emerald-700 dark:text-emerald-400",
        glow: "bg-emerald-400/30 dark:bg-emerald-500/20",
        dot: "bg-emerald-500",
        pill: "Completed",
        subIcon: "fa-solid fa-check",
        subtext: "Successfully solved",
        subtextClass: "text-emerald-700 dark:text-emerald-400",
    },
    {
        key: "rejected",
        title: "Rejected",
        value: stats.value.rejected,
        icon: "fa-solid fa-circle-xmark",
        iconWrap: "bg-red-100 dark:bg-red-500/20 text-red-700 dark:text-red-400",
        glow: "bg-red-400/30 dark:bg-red-500/20",
        dot: "bg-red-500",
        pill: "Not accepted",
        subIcon: "fa-solid fa-ban",
        subtext: "Needs correction",
        subtextClass: "text-red-700 dark:text-red-400",
    },
    {
        key: "closed",
        title: "Closed",
        value: stats.value.closed,
        icon: "fa-solid fa-lock",
        iconWrap: "bg-slate-200 dark:bg-slate-700 text-slate-700 dark:text-slate-200",
        glow: "bg-slate-400/30 dark:bg-slate-500/20",
        dot: "bg-slate-500",
        pill: "Finalized",
        subIcon: "fa-solid fa-shield",
        subtext: "Archived",
        subtextClass: "text-slate-700 dark:text-slate-300",
    },
    {
        key: "assigned",
        title: "Assigned",
        value: stats.value.assigned,
        icon: "fa-solid fa-user-check",
        iconWrap: "bg-indigo-100 dark:bg-indigo-500/20 text-indigo-700 dark:text-indigo-400",
        glow: "bg-indigo-400/30 dark:bg-indigo-500/20",
        dot: "bg-indigo-500",
        pill: "Assigned to officer",
        subIcon: "fa-solid fa-user-gear",
        subtext: "Owner set",
        subtextClass: "text-indigo-700 dark:text-indigo-400",
    },
    {
        key: "in_review",
        title: "In Review",
        value: stats.value.in_review,
        icon: "fa-solid fa-magnifying-glass",
        iconWrap: "bg-purple-100 dark:bg-purple-500/20 text-purple-700 dark:text-purple-400",
        glow: "bg-purple-400/30 dark:bg-purple-500/20",
        dot: "bg-purple-500",
        pill: "Under review",
        subIcon: "fa-solid fa-clipboard-check",
        subtext: "Verification running",
        subtextClass: "text-purple-700 dark:text-purple-400",
    },
    {
        key: "on_hold",
        title: "On Hold",
        value: stats.value.on_hold,
        icon: "fa-solid fa-pause",
        iconWrap: "bg-pink-100 dark:bg-pink-500/20 text-pink-700 dark:text-pink-400",
        glow: "bg-pink-400/30 dark:bg-pink-500/20",
        dot: "bg-pink-500",
        pill: "Paused temporarily",
        subIcon: "fa-solid fa-circle-pause",
        subtext: "Waiting info",
        subtextClass: "text-pink-700 dark:text-pink-400",
    },
]);

onMounted(() => {
    getComplaints(1);
    getMyComplaints(1);
    getStats();
});
</script>

<style>

</style>