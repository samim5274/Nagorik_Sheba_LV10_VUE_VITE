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

</script>

<style>

</style>