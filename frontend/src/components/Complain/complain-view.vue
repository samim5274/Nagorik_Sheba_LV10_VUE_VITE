<template>
    <div class="min-h-screen bg-white dark:bg-slate-950 transition-colors duration-200">
        <Header
            @open-sidebar="sidebarOpen = true"
            @search="onSearch"
            :isDark="isDark"
            @toggle-theme="toggleTheme"
        />

        <div class="flex min-h-[calc(100vh-56px)]">
            <Navbar
                :open="sidebarOpen"
                @close="sidebarOpen = false"
            />

            <!-- Content -->
            <div class="flex-1 min-w-0 p-4 sm:p-6 lg:p-8">
                <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm dark:border-slate-700 dark:bg-slate-900">
                    <div v-if="loading" class="text-sm text-slate-500 dark:text-slate-400">
                        Loading complaint...
                    </div>

                    <div v-else-if="errorMsg" class="text-sm text-red-600 dark:text-red-400">
                        {{ errorMsg }}
                    </div>

                    <div v-else-if="complaint" class="space-y-6">
                        <!-- Header -->
                        <div class="flex flex-col gap-4 border-b border-slate-200 pb-5 dark:border-slate-700 md:flex-row md:items-start md:justify-between">
                            <div class="space-y-2">
                                <div class="flex flex-wrap items-center gap-2">
                                    <h1 class="text-xl font-bold text-slate-800 dark:text-slate-100 sm:text-2xl">
                                        {{ complaint.title }}
                                    </h1>

                                    <span
                                        class="inline-flex rounded-full px-2.5 py-1 text-xs font-semibold capitalize"
                                        :class="{
                                            'bg-slate-100 text-slate-700 dark:bg-slate-700 dark:text-slate-200': complaint.priority === 'low',
                                            'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300': complaint.priority === 'medium',
                                            'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-300': complaint.priority === 'high',
                                            'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300': complaint.priority === 'urgent'
                                        }"
                                    >
                                        {{ complaint.priority }}
                                    </span>

                                    <span
                                        class="inline-flex rounded-full px-2.5 py-1 text-xs font-semibold"
                                        :class="{
                                            'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-300': complaint.status === 'pending',
                                            'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300': complaint.status === 'in_progress',
                                            'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300': complaint.status === 'resolved',
                                            'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300': complaint.status === 'rejected',
                                            'bg-slate-200 text-slate-700 dark:bg-slate-700 dark:text-slate-200': complaint.status === 'closed',
                                            'bg-indigo-100 text-indigo-700 dark:bg-indigo-900/30 dark:text-indigo-300': complaint.status === 'assigned',
                                            'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-300': complaint.status === 'in_review',
                                            'bg-pink-100 text-pink-700 dark:bg-pink-900/30 dark:text-pink-300': complaint.status === 'on_hold'
                                        }"
                                    >
                                        {{ formatStatus(complaint.status) }}
                                    </span>

                                    <span
                                        v-if="complaint.is_anonymous"
                                        class="inline-flex rounded-full bg-purple-100 px-2.5 py-1 text-xs font-semibold text-purple-700 dark:bg-purple-900/30 dark:text-purple-300"
                                    >
                                        Anonymous
                                    </span>

                                    <span
                                        v-if="complaint.is_public"
                                        class="inline-flex rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-semibold text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300"
                                    >
                                        Public
                                    </span>
                                </div>

                                <p class="text-sm font-medium text-indigo-600 dark:text-indigo-400">
                                    #{{ complaint.complaint_no || 'N/A' }}
                                </p>

                                <p class="text-sm text-slate-500 dark:text-slate-400">
                                    Created: {{ formatDateTime(complaint.created_at) }}
                                </p>
                            </div>
                        </div>

                        <!-- Main Info Grid -->
                        <div class="grid grid-cols-1 gap-5 lg:grid-cols-3">
                            <!-- Left / Main -->
                            <div class="space-y-5 lg:col-span-2">
                                <!-- Description -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Complaint Description
                                    </h2>
                                    <p class="whitespace-pre-line text-sm leading-6 text-slate-700 dark:text-slate-300">
                                        {{ complaint.description || 'No description available.' }}
                                    </p>
                                </div>

                                <!-- Category -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Category Information
                                    </h2>

                                    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Category</p>
                                            <p class="mt-1 text-sm font-medium text-slate-800 dark:text-slate-100">
                                                {{ complaint.category?.name || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Sub Category</p>
                                            <p class="mt-1 text-sm font-medium text-slate-800 dark:text-slate-100">
                                                {{ complaint.sub_category?.name || 'N/A' }}
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Location -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Location Information
                                    </h2>

                                    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Division</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.division?.name || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">District</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.district?.name || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Upazila</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.upazila?.name || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Police Station</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.police_station?.name || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Ward No</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.ward_no || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Landmark</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.landmark || 'N/A' }}
                                            </p>
                                        </div>

                                        <div class="sm:col-span-2">
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Address</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.address_line || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Latitude</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.latitude || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Longitude</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.longitude || 'N/A' }}
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Admin Info -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Admin Handling
                                    </h2>

                                    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Assigned To</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.assigned_user?.name || 'Not assigned' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Assigned At</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.assigned_at ? formatDateTime(complaint.assigned_at) : 'N/A' }}
                                            </p>
                                        </div>

                                        <div class="sm:col-span-2">
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Admin Remark</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100 whitespace-pre-line">
                                                {{ complaint.admin_remark || 'N/A' }}
                                            </p>
                                        </div>

                                        <div class="sm:col-span-2">
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Action Taken</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100 whitespace-pre-line">
                                                {{ complaint.action_taken || 'N/A' }}
                                            </p>
                                        </div>

                                        <div class="sm:col-span-2">
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Rejected Reason</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100 whitespace-pre-line">
                                                {{ complaint.rejected_reason || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Resolved At</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.resolved_at ? formatDateTime(complaint.resolved_at) : 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Closed At</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.closed_at ? formatDateTime(complaint.closed_at) : 'N/A' }}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Sidebar -->
                            <div class="space-y-5">
                                <!-- Complainant -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Complainant Information
                                    </h2>

                                    <div class="space-y-3">
                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Name</p>
                                            <p class="mt-1 text-sm font-medium text-slate-800 dark:text-slate-100">
                                                {{ complaint.complainant_name || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Phone</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.complainant_phone || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Email</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100 break-all">
                                                {{ complaint.complainant_email || 'N/A' }}
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Submission -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Submission Info
                                    </h2>

                                    <div class="space-y-3">
                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Source</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.source || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">IP Address</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.submitted_ip || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Device</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.submitted_device || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Platform</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.submitted_platform || 'N/A' }}
                                            </p>
                                        </div>

                                        <div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Browser</p>
                                            <p class="mt-1 text-sm text-slate-800 dark:text-slate-100">
                                                {{ complaint.submitted_browser || 'N/A' }}
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Flags -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Flags
                                    </h2>

                                    <div class="flex flex-wrap gap-2">
                                        <span v-if="complaint.is_edited" class="rounded-full bg-blue-100 px-2.5 py-1 text-xs font-medium text-blue-700 dark:bg-blue-900/30 dark:text-blue-300">Edited</span>
                                        <span v-if="complaint.is_deleted_by_user" class="rounded-full bg-rose-100 px-2.5 py-1 text-xs font-medium text-rose-700 dark:bg-rose-900/30 dark:text-rose-300">Deleted by user</span>
                                        <span v-if="complaint.is_spam" class="rounded-full bg-red-100 px-2.5 py-1 text-xs font-medium text-red-700 dark:bg-red-900/30 dark:text-red-300">Spam</span>
                                        <span v-if="complaint.is_duplicate" class="rounded-full bg-orange-100 px-2.5 py-1 text-xs font-medium text-orange-700 dark:bg-orange-900/30 dark:text-orange-300">Duplicate</span>

                                        <span
                                            v-if="!complaint.is_edited && !complaint.is_deleted_by_user && !complaint.is_spam && !complaint.is_duplicate"
                                            class="rounded-full bg-slate-100 px-2.5 py-1 text-xs font-medium text-slate-700 dark:bg-slate-800 dark:text-slate-300"
                                        >
                                            No flags
                                        </span>
                                    </div>
                                </div>

                                <!-- Attachment -->
                                <div class="rounded-2xl border border-slate-200 p-4 dark:border-slate-700">
                                    <h2 class="mb-3 text-sm font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                        Attachments
                                    </h2>

                                    <div class="space-y-4">
                                        <div v-if="complaint.attachments && complaint.attachments.length">
                                        <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
                                            <div
                                            v-for="(file, index) in complaint.attachments"
                                            :key="index"
                                            class="rounded-xl border border-slate-200 p-2 dark:border-slate-700"
                                            >
                                            <div v-if="isImageFile(file)" class="overflow-hidden rounded-lg">
                                                <img
                                                :src="getFileUrl(file)"
                                                :alt="extractOriginalName(file)"
                                                class="h-40 w-full object-cover"
                                                />
                                            </div>

                                            <div class="mt-2">
                                                <a
                                                :href="getFileUrl(file)"
                                                target="_blank"
                                                class="text-sm font-medium text-indigo-600 hover:underline dark:text-indigo-400 break-all"
                                                >
                                                {{ extractOriginalName(file) }}
                                                </a>
                                                <p class="mt-1 text-xs text-slate-500 dark:text-slate-400">
                                                {{ file.mime_type || 'Unknown file type' }}
                                                </p>
                                            </div>
                                            </div>
                                        </div>
                                        </div>

                                        <p
                                        v-else
                                        class="text-sm text-slate-500 dark:text-slate-400"
                                        >
                                        No attachments found.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div v-else class="text-sm text-slate-500 dark:text-slate-400">
                        Complaint not found.
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted, onBeforeUnmount, ref } from "vue";
import { useRoute } from "vue-router";
import api, { makeImg } from "../../services/api";

import Navbar from "../Dashboard/navbar.vue";
import Header from "../Dashboard/header.vue";

const complaint = ref(null);
const loading = ref(false);
const errorMsg = ref("");

const route = useRoute();
const sidebarOpen = ref(false);
const isDark = ref(false);

function handleApiError(err, fallbackMessage) {
    console.error(fallbackMessage, err);
    errorMsg.value = err?.response?.data?.message || fallbackMessage;
}

async function getComplain() {
    loading.value = true;
    errorMsg.value = "";

    try {
        const id = route.params.id;
        const res = await api.get(`/complaints/${id}`);
        complaint.value = res.data?.data ?? null;
        // console.log("Complaint:", complaint.value);
    } catch (err) {
        console.error("Complaint load error:", err);
        handleApiError(err, "Failed to load complaint");
    } finally {
        loading.value = false;
    }
}



function formatStatus(status) {
    if (!status) return "N/A";
    return status.replaceAll("_", " ");
}

function formatDateTime(date) {
    if (!date) return "N/A";

    return new Date(date).toLocaleString("en-BD", {
        year: "numeric",
        month: "short",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
    });
}

function extractFilePath(file) {
    if (!file) return "";

    if (typeof file === "string") return file;

    return file.file_path || file.path || file.url || file.file_name || "";
}

function extractOriginalName(file) {
    if (!file) return "";

    if (typeof file === "string") return file;

    return file.original_name || file.file_name || "Attachment";
}

function getFileUrl(file) {
    const path = extractFilePath(file);
    if (!path) return "";
    return makeImg(path);
}

function isImageFile(file) {
    const mime = typeof file === "object" ? file.mime_type || "" : "";
    const path = extractFilePath(file);

    return mime.startsWith("image/") || /\.(jpg|jpeg|png|gif|webp|bmp|svg)$/i.test(path);
}








function applyTheme(dark) {
    isDark.value = dark;
    document.documentElement.classList.toggle("dark", dark);
    localStorage.setItem("theme", dark ? "dark" : "light");
}

function toggleTheme() {
    applyTheme(!isDark.value);
}

function onSearch(q) {
    console.log("search:", q);
}

function handleEsc(e) {
    if (e.key === "Escape") sidebarOpen.value = false;
}

onMounted(() => {
    getComplain();

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