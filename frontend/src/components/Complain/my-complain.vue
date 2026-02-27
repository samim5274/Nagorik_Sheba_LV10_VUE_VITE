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
                        <h1 class="text-xl sm:text-2xl font-bold text-gray-800 dark:text-gray-100 py-4">My Complains</h1>
                        <p class="text-sm text-gray-700 dark:text-slate-300"></p>
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
                            <input
                                v-model.trim="searchComplaintNo"
                                type="text"
                                placeholder="Search complaint..."
                                class="w-full sm:w-64 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-sm text-slate-700 dark:text-slate-100 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500"
                            />

                                <select v-model="statusFilter" @change="getComplaints(1)"
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
                                        <td class="px-4 py-4 align-top" @click="viewComplaint(complaint)">
                                            <div class="space-y-1">
                                                <div class="flex items-center gap-2">
                                                    <p class="font-semibold text-slate-800 dark:text-slate-100">
                                                        <span class="hover:underline">{{ complaint.title }}</span> - 
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
                                                        <span
                                                            class="inline-flex rounded-full px-2.5 py-1 text-xs font-semibold"
                                                            :class="{
                                                                'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-300': complaint.status === 'pending',
                                                                'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300': complaint.status === 'in_progress',
                                                                'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300': complaint.status === 'resolved',
                                                                'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300': complaint.status === 'rejected',
                                                                'bg-slate-200 text-slate-700 dark:bg-slate-700 dark:text-slate-200': complaint.status === 'closed'
                                                            }"
                                                            >
                                                            {{ complaint.status }}
                                                        </span>
                                                    </p>

                                                    <span
                                                        v-if="complaint.is_anonymous"
                                                        class="inline-flex rounded-full bg-purple-100 px-2 py-0.5 text-[10px] font-medium text-purple-700 dark:bg-purple-900/30 dark:text-purple-300"
                                                        >
                                                        Anonymous
                                                    </span>
                                                </div>

                                                <p class="text-xs font-medium text-indigo-600 dark:text-indigo-400 hover:underline">
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

                                        <!-- Action -->
                                        <td class="px-4 py-4 align-top">
                                            <div class="flex items-center gap-2">
                                                <!-- Delete -->
                                                <button
                                                    @click.stop="deleteComplain(complaint)"
                                                    type="button"
                                                    class="inline-flex items-center gap-2 rounded-lg border border-rose-200 bg-rose-50 px-3 py-1.5
                                                        text-xs font-semibold text-rose-700 shadow-sm transition
                                                        hover:bg-rose-100 hover:border-rose-300
                                                        focus:outline-none focus:ring-2 focus:ring-rose-500/40
                                                        dark:border-rose-900/40 dark:bg-rose-900/20 dark:text-rose-300 dark:hover:bg-rose-900/30">
                                                    <i class="fa-regular fa-trash-can text-[12px]"></i>
                                                    Delete
                                                </button>
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



// search on
const searchComplaintNo = ref("");
let searchTimer = null;

function onSearchInput() {
    // debounce (typing থামলে 400ms পরে call)
    clearTimeout(searchTimer);
    searchTimer = setTimeout(() => {
        getComplaints(1); // search করলে always page 1
    }, 400);
}

const statusFilter = ref("");

// searchComplaintNo পরিবর্তন হলে auto search
watch(
    () => searchComplaintNo.value,
    () => onSearchInput(),
    // shorting
    () => statusFilter.value, 
    () => getComplaints(1)
);



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

        const res = await api.get(`/complaints/view?${params.toString()}`);
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


function deleteComplain(complain){
    if (!complain?.id) return;

    const ok = window.confirm(`Are you sure you want to delete complaint #${complain.complaint_no ?? complain.id}?`);
    if (!ok) return;

    loading.value = true;
    errorMsg.value = "";
    successMsg.value = "";
    
    try{
        const res = api.delete(`/complaints/delete/${complain.id}`);
        successMsg.value = res.data?.message || "Complaint deleted successfully.";

        // list থেকে remove (instant UI update)
        complaints.value = complaints.value.filter(c => c.id !== complain.id);
        // pagination total update (optional)
        total.value = Math.max(0, total.value - 1);
    } catch (err) {
        console.error("complaints delete error:", err);
        handleApiError(err, "Failed to delete complaints", complaints);
    } finally {
        loading.value = false;
    }
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