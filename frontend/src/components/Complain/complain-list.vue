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
                                <span class="text-base leading-none">＋</span>
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
                                        :key="complaint.id" @click="viewComplaint(complaint)"
                                        class="text-sm text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition">
                                        
                                        <!-- Complaint Info -->
                                        <td class="px-4 py-4 align-top">
                                            <div class="space-y-1">
                                                <div class="flex items-center gap-2">
                                                    <p class="font-semibold text-slate-800 dark:text-slate-100">
                                                        <span class="hover:underline hover:cursor-pointer">{{ complaint.title }}</span> - 
                                                        <span
                                                            class="inline-flex rounded-full px-2.5 py-1 text-xs font-semibold"
                                                            :class="{
                                                                'bg-slate-100 text-slate-700 dark:bg-slate-700 dark:text-slate-200': complaint.priority === 'low',
                                                                'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300': complaint.priority === 'medium',
                                                                'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-300': complaint.priority === 'high',
                                                                'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300': complaint.priority === 'urgent'
                                                            }"
                                                            >
                                                            {{ complaint.priority }}
                                                        </span> - 
                                                        <span class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 text-xs font-semibold capitalize" :class="statusBadge(complaint.status)">
                                                            <span class="h-1.5 w-1.5 rounded-full" :class="statusDot(complaint.status)"></span>
                                                            {{ formatStatus(complaint.status) }}
                                                        </span>
                                                    </p>

                                                    <span
                                                        v-if="complaint.is_anonymous"
                                                        class="inline-flex rounded-full bg-purple-100 px-2 py-0.5 text-[10px] font-medium text-purple-700 dark:bg-purple-900/30 dark:text-purple-300">
                                                        Anonymous
                                                    </span>
                                                </div>

                                                <p class="text-xs font-medium text-indigo-600 dark:text-indigo-400 hover:underline hover:cursor-pointer">
                                                    #{{ complaint.complaint_no || 'N/A' }}
                                                </p>

                                                <p class="text-xs text-slate-500 dark:text-slate-400 line-clamp-2">
                                                    {{ formatDate(complaint.created_at) }} - {{ formatTime(complaint.created_at) }} <br>
                                                    <!-- {{ complaint.description?.length > 25 ? complaint.description.slice(0, 25) + '...' : complaint.description }} -->
                                                </p>

                                                <div class="flex flex-wrap gap-1 pt-1">
                                                    <span
                                                    class="inline-flex rounded-full bg-slate-100 dark:bg-slate-800 px-2 py-0.5 text-[11px] text-slate-600 dark:text-slate-300"
                                                    >
                                                    {{ complaint.category?.name || 'No Category' }}
                                                    </span>

                                                    <span
                                                    v-if="complaint.sub_category"
                                                    class="inline-flex rounded-full bg-blue-50 dark:bg-blue-900/20 px-2 py-0.5 text-[11px] text-blue-700 dark:text-blue-300"
                                                    >
                                                    {{ complaint.sub_category?.name }}
                                                    </span>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Location -->
                                        <td class="px-4 py-4 align-top">
                                            <div class="space-y-1 text-xs text-slate-600 dark:text-slate-400">
                                                <p>
                                                    {{ complaint.division?.name || '-' }},
                                                    {{ complaint.district?.name || '-' }}
                                                    {{ complaint.upazila?.name || '-' }}
                                                    <span v-if="complaint.police_station?.name">
                                                    , {{ complaint.police_station?.name }}
                                                    </span>
                                                </p>
                                                <p class="truncate max-w-[180px]">
                                                    {{ complaint.address_line || 'No address' }}
                                                </p>
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
import { onMounted, onBeforeUnmount, ref, computed, watch } from "vue";
import { useRouter } from "vue-router";
import api from "../../services/api";

import Navbar from '../Dashboard/navbar.vue'
import Header from '../Dashboard/header.vue'
import Message from '../Message/message.vue'

const router = useRouter();

const complaints = ref([]);
const loading = ref(false);
const errorMsg = ref("");
const successMsg = ref("");

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
});
</script>

<style>

</style>