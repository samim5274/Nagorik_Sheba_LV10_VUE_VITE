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
                    <div class="w-full overflow-hidden rounded-2xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900 shadow-sm">
                        <!-- Table Header Area -->
                        <div class="flex flex-col gap-3 border-b border-slate-200 dark:border-slate-700 px-4 py-4 sm:flex-row sm:items-center sm:justify-between">
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
                        </div>

                        <!-- Table -->
                        <div class="w-full overflow-x-auto max-h-[500px]">
                            <table class="w-full whitespace-nowrap">
                                <!-- <thead>
                                    <tr class="border-b border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800/70 text-left text-xs font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                                    <th class="px-4 py-3">Complaint</th>
                                    <th class="px-4 py-3">Location</th>
                                    </tr>
                                </thead> -->

                                <tbody class="divide-y divide-slate-200 dark:divide-slate-700 bg-white dark:bg-slate-900">
                                    <tr
                                        v-for="complaint in complaints"
                                        :key="complaint.id" @click="viewComplaint(complaint)"
                                        class="text-sm text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition hover:underline">
                                        
                                        <!-- Complaint Info -->
                                        <td class="px-4 py-4 align-top">
                                            <div class="space-y-1">
                                                <div class="flex items-center gap-2">
                                                    <p class="font-semibold text-slate-800 dark:text-slate-100">
                                                        {{ complaint.title }} - 
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

                                                <p class="text-xs font-medium text-indigo-600 dark:text-indigo-400">
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
                <div class="xl:col-span-4 bg-gray-50 dark:bg-[#0c1326] border dark:border-slate-700 rounded-md p-3 text-white">
                    <h4 class="pb-2">My Complain</h4>
                    <div class="w-full overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full whitespace-no-wrap">
                            <thead>
                                <tr
                                class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800"
                                >
                                <th class="px-4 py-3">Client</th>
                                <th class="px-4 py-3">Amount</th>
                                <th class="px-4 py-3">Status</th>
                                <th class="px-4 py-3">Date</th>
                                </tr>
                            </thead>
                            <tbody
                                class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                <tr class="text-gray-700 dark:text-gray-400">
                                <td class="px-4 py-3">
                                    <div class="flex items-center text-sm">
                                    <!-- Avatar with inset shadow -->
                                    <div
                                        class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
                                    >
                                        <img
                                        class="object-cover w-full h-full rounded-full"
                                        src="https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjE3Nzg0fQ"
                                        alt=""
                                        loading="lazy"
                                        />
                                        <div
                                        class="absolute inset-0 rounded-full shadow-inner"
                                        aria-hidden="true"
                                        ></div>
                                    </div>
                                    <div>
                                        <p class="font-semibold">Hans Burger</p>
                                        <p class="text-xs text-gray-600 dark:text-gray-400">
                                        10x Developer
                                        </p>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    $ 863.45
                                </td>
                                <td class="px-4 py-3 text-xs">
                                    <span
                                    class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                                    >
                                    Approved
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    6/10/2020
                                </td>
                                </tr>

                                <tr class="text-gray-700 dark:text-gray-400">
                                <td class="px-4 py-3">
                                    <div class="flex items-center text-sm">
                                    <!-- Avatar with inset shadow -->
                                    <div
                                        class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
                                    >
                                        <img
                                        class="object-cover w-full h-full rounded-full"
                                        src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&facepad=3&fit=facearea&s=707b9c33066bf8808c934c8ab394dff6"
                                        alt=""
                                        loading="lazy"
                                        />
                                        <div
                                        class="absolute inset-0 rounded-full shadow-inner"
                                        aria-hidden="true"
                                        ></div>
                                    </div>
                                    <div>
                                        <p class="font-semibold">Jolina Angelie</p>
                                        <p class="text-xs text-gray-600 dark:text-gray-400">
                                        Unemployed
                                        </p>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    $ 369.95
                                </td>
                                <td class="px-4 py-3 text-xs">
                                    <span
                                    class="px-2 py-1 font-semibold leading-tight text-orange-700 bg-orange-100 rounded-full dark:text-white dark:bg-orange-600"
                                    >
                                    Pending
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    6/10/2020
                                </td>
                                </tr>

                                <tr class="text-gray-700 dark:text-gray-400">
                                <td class="px-4 py-3">
                                    <div class="flex items-center text-sm">
                                    <!-- Avatar with inset shadow -->
                                    <div
                                        class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
                                    >
                                        <img
                                        class="object-cover w-full h-full rounded-full"
                                        src="https://images.unsplash.com/photo-1551069613-1904dbdcda11?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjE3Nzg0fQ"
                                        alt=""
                                        loading="lazy"
                                        />
                                        <div
                                        class="absolute inset-0 rounded-full shadow-inner"
                                        aria-hidden="true"
                                        ></div>
                                    </div>
                                    <div>
                                        <p class="font-semibold">Sarah Curry</p>
                                        <p class="text-xs text-gray-600 dark:text-gray-400">
                                        Designer
                                        </p>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    $ 86.00
                                </td>
                                <td class="px-4 py-3 text-xs">
                                    <span
                                    class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700"
                                    >
                                    Denied
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    6/10/2020
                                </td>
                                </tr>

                                <tr class="text-gray-700 dark:text-gray-400">
                                <td class="px-4 py-3">
                                    <div class="flex items-center text-sm">
                                    <!-- Avatar with inset shadow -->
                                    <div
                                        class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
                                    >
                                        <img
                                        class="object-cover w-full h-full rounded-full"
                                        src="https://images.unsplash.com/photo-1551006917-3b4c078c47c9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjE3Nzg0fQ"
                                        alt=""
                                        loading="lazy"
                                        />
                                        <div
                                        class="absolute inset-0 rounded-full shadow-inner"
                                        aria-hidden="true"
                                        ></div>
                                    </div>
                                    <div>
                                        <p class="font-semibold">Rulia Joberts</p>
                                        <p class="text-xs text-gray-600 dark:text-gray-400">
                                        Actress
                                        </p>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    $ 1276.45
                                </td>
                                <td class="px-4 py-3 text-xs">
                                    <span
                                    class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                                    >
                                    Approved
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    6/10/2020
                                </td>
                                </tr>

                                <tr class="text-gray-700 dark:text-gray-400">
                                <td class="px-4 py-3">
                                    <div class="flex items-center text-sm">
                                    <!-- Avatar with inset shadow -->
                                    <div
                                        class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
                                    >
                                        <img
                                        class="object-cover w-full h-full rounded-full"
                                        src="https://images.unsplash.com/photo-1546456073-6712f79251bb?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjE3Nzg0fQ"
                                        alt=""
                                        loading="lazy"
                                        />
                                        <div
                                        class="absolute inset-0 rounded-full shadow-inner"
                                        aria-hidden="true"
                                        ></div>
                                    </div>
                                    <div>
                                        <p class="font-semibold">Wenzel Dashington</p>
                                        <p class="text-xs text-gray-600 dark:text-gray-400">
                                        Actor
                                        </p>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    $ 863.45
                                </td>
                                <td class="px-4 py-3 text-xs">
                                    <span
                                    class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700"
                                    >
                                    Expired
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    6/10/2020
                                </td>
                                </tr>

                                <tr class="text-gray-700 dark:text-gray-400">
                                <td class="px-4 py-3">
                                    <div class="flex items-center text-sm">
                                    <!-- Avatar with inset shadow -->
                                    <div
                                        class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
                                    >
                                        <img
                                        class="object-cover w-full h-full rounded-full"
                                        src="https://images.unsplash.com/photo-1502720705749-871143f0e671?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=b8377ca9f985d80264279f277f3a67f5"
                                        alt=""
                                        loading="lazy"
                                        />
                                        <div
                                        class="absolute inset-0 rounded-full shadow-inner"
                                        aria-hidden="true"
                                        ></div>
                                    </div>
                                    <div>
                                        <p class="font-semibold">Dave Li</p>
                                        <p class="text-xs text-gray-600 dark:text-gray-400">
                                        Influencer
                                        </p>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    $ 863.45
                                </td>
                                <td class="px-4 py-3 text-xs">
                                    <span
                                    class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                                    >
                                    Approved
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    6/10/2020
                                </td>
                                </tr>
                            </tbody>
                            </table>
                        </div>
                        <div
                            class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800">
                            <span class="flex items-center col-span-3">
                            Showing 21-30 of 100
                            </span>
                            <span class="col-span-2"></span>
                            <!-- Pagination -->
                            <span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
                            <nav aria-label="Table navigation">
                                <ul class="inline-flex items-center">
                                <li>
                                    <button
                                    class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple"
                                    aria-label="Previous"
                                    >
                                    <svg
                                        aria-hidden="true"
                                        class="w-4 h-4 fill-current"
                                        viewBox="0 0 20 20"
                                    >
                                        <path
                                        d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                        clip-rule="evenodd"
                                        fill-rule="evenodd"
                                        ></path>
                                    </svg>
                                    </button>
                                </li>
                                <li>
                                    <button
                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                                    >
                                    1
                                    </button>
                                </li>
                                <li>
                                    <button
                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                                    >
                                    2
                                    </button>
                                </li>
                                <li>
                                    <button
                                    class="px-3 py-1 text-white transition-colors duration-150 bg-purple-600 border border-r-0 border-purple-600 rounded-md focus:outline-none focus:shadow-outline-purple"
                                    >
                                    3
                                    </button>
                                </li>
                                <li>
                                    <button
                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                                    >
                                    4
                                    </button>
                                </li>
                                <li>
                                    <span class="px-3 py-1">...</span>
                                </li>
                                <li>
                                    <button
                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                                    >
                                    8
                                    </button>
                                </li>
                                <li>
                                    <button
                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                                    >
                                    9
                                    </button>
                                </li>
                                <li>
                                    <button
                                    class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple"
                                    aria-label="Next"
                                    >
                                    <svg
                                        class="w-4 h-4 fill-current"
                                        aria-hidden="true"
                                        viewBox="0 0 20 20"
                                    >
                                        <path
                                        d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                        clip-rule="evenodd"
                                        fill-rule="evenodd"
                                        ></path>
                                    </svg>
                                    </button>
                                </li>
                                </ul>
                            </nav>
                            </span>
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

onMounted(() => {
    getComplaints(1);
});
</script>

<style>

</style>