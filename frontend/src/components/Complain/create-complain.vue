<template>
    <div class="min-h-screen bg-white dark:bg-slate-900 transition-colors duration-200">
        <Header
        @open-sidebar="sidebarOpen = true"
        @search="onSearch"
        :isDark="isDark" @toggle-theme="toggleTheme"
        />

        <div class="flex  min-h-[calc(100vh-56px)]">
            <Navbar v-model="active" :open="sidebarOpen" @close="sidebarOpen=false" />
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
                        <h1 class="text-xl sm:text-2xl font-bold text-gray-800 dark:text-gray-100">Create new complain</h1>
                        <p class="text-sm text-gray-700 dark:text-slate-300"></p>
                    </div>
                    <!-- <button
                        type="button"
                        @click="resetComplaintForm"
                        class="rounded-xl border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50"
                        >
                        Reset
                    </button> -->
                </div>

                <div class="mx-auto w-full max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                  <!-- Page Header -->
                  <div class="mb-6 rounded-2xl border border-slate-200 bg-white dark:bg-slate-900 p-4 sm:p-5 shadow-sm">
                    <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                      <div>
                        <div class="flex items-center gap-2">
                          <span class="inline-flex items-center rounded-full border border-indigo-200 bg-indigo-50 dark:bg-slate-600 px-2.5 py-1 text-xs font-medium text-indigo-700 dark:text-indigo-100">
                            নাগরিক সেবা
                          </span>
                          <span class="inline-flex items-center rounded-full border border-slate-200 bg-slate-100 dark:bg-slate-600 px-2.5 py-1 text-xs font-medium text-slate-600 dark:text-indigo-100">
                            Complaint Portal
                          </span>
                        </div>
                        <h1 class="mt-2 text-lg font-semibold text-slate-800 dark:text-slate-100 sm:text-xl">
                          Submit a Complaint
                        </h1>
                        <p class="mt-1 text-sm text-slate-500">
                          Fill in the details below to submit your complaint. You can track status later using the complaint number.
                        </p>
                      </div>

                      <div class="grid grid-cols-2 gap-2 sm:w-auto">
                        <div class="rounded-xl border border-slate-200 bg-slate-50 dark:bg-slate-800 px-3 py-2 text-center">
                          <p class="text-xs text-slate-500 dark:text-slate-100">Status</p>
                          <p class="text-sm font-semibold text-slate-700 dark:text-slate-100">Open</p>
                        </div>
                        <div class="rounded-xl border border-slate-200 bg-slate-50 dark:bg-slate-800 px-3 py-2 text-center">
                          <p class="text-xs text-slate-500 dark:text-slate-100">Channel</p>
                          <p class="text-sm font-semibold text-slate-700 dark:text-slate-100">Web</p>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- Main Form Card -->
                  <div class="rounded-2xl border border-slate-200 bg-white dark:bg-slate-900 shadow-sm">
                    <div class="border-b border-slate-100 px-4 py-3 sm:px-6">
                      <h2 class="text-sm font-semibold text-slate-700 dark:text-slate-100">Complaint Submission Form</h2>
                    </div>

                    <div class="p-4 sm:p-6">
                      <form @submit.prevent="submitComplaint" class="space-y-6">
                        <!-- Top alerts -->
                        <div
                          v-if="errorMsg"
                          class="rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700"
                        >
                          {{ errorMsg }}
                        </div>

                        <div
                          v-if="successMsg"
                          class="rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700"
                        >
                          {{ successMsg }}
                        </div>

                        <!-- =========================
                            Location Section
                        ========================== -->
                        <section class="rounded-2xl border border-slate-200 bg-slate-50 dark:bg-slate-900 p-4 md:p-5">
                          <div class="mb-4 flex items-center justify-between gap-3">
                            <div>
                              <h3 class="text-sm font-semibold text-slate-800 dark:text-slate-100 md:text-base">Location Information</h3>
                              <p class="text-xs text-slate-500">Select complaint area and address</p>
                            </div>
                            <span class="hidden sm:inline-flex rounded-full bg-white dark:bg-gray-900 px-2.5 py-1 text-xs text-slate-500 dark:text-slate-100 border border-slate-200">
                              Required first
                            </span>
                          </div>

                          <div class="grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-4">
                            <!-- Division -->
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Division <span class="text-red-500">*</span>
                              </label>
                              <select
                                v-model="form.division_id"
                                @change="onDivisionChange"
                                required
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              >
                                <option value="" disabled>-- Select Division --</option>
                                <option v-for="val in divisions" :key="val.id" :value="val.id">
                                  {{ val.name }} - {{ val.bn_name }}
                                </option>
                              </select>
                            </div>

                            <!-- District -->
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                District <span class="text-red-500">*</span>
                              </label>
                              <select
                                v-model="form.district_id"
                                @change="onDistrictChange"
                                :disabled="!form.division_id"
                                required
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 disabled:cursor-not-allowed disabled:bg-slate-100 disabled:text-slate-400"
                              >
                                <option value="" disabled>
                                  {{ form.division_id ? '-- Select District --' : 'Select division first' }}
                                </option>
                                <option v-for="dist in districts" :key="dist.id" :value="dist.id">
                                  {{ dist.name }} - {{ dist.bn_name }}
                                </option>
                              </select>
                              <p v-if="form.division_id && districts.length === 0" class="mt-2 text-xs text-amber-600">
                                No district found for this division.
                              </p>
                            </div>

                            <!-- Upazila -->
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Upazila <span class="text-red-500">*</span>
                              </label>
                              <select
                                v-model="form.upazila_id"
                                @change="onUpazilaChange"
                                :disabled="!form.district_id"
                                required
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 disabled:cursor-not-allowed disabled:bg-slate-100 disabled:text-slate-400"
                              >
                                <option value="" disabled>
                                  {{ form.district_id ? '-- Select Upazila --' : 'Select district first' }}
                                </option>
                                <option v-for="upa in upazilas" :key="upa.id" :value="upa.id">
                                  {{ upa.name }} - {{ upa.bn_name }}
                                </option>
                              </select>
                              <p v-if="form.district_id && upazilas.length === 0" class="mt-2 text-xs text-amber-600">
                                No upazila found for this district.
                              </p>
                            </div>

                            <!-- Police Station -->
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">Police Station</label>
                              <select
                                v-model="form.police_station_id"
                                :disabled="!form.upazila_id || policeStations.length === 0"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 disabled:cursor-not-allowed disabled:bg-slate-100 disabled:text-slate-400"
                              >
                                <option value="" disabled>
                                  {{ form.upazila_id ? '-- Select Police Station --' : 'Select upazila first' }}
                                </option>
                                <option v-for="ps in policeStations" :key="ps.id" :value="ps.id">
                                  {{ ps.name }} - {{ ps.bn_name }}
                                </option>
                              </select>
                              <p v-if="form.upazila_id && policeStations.length === 0" class="mt-2 text-xs text-amber-600">
                                No police station found for this upazila.
                              </p>
                            </div>
                          </div>

                          <div class="mt-4 grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-3">
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600">Ward No</label>
                              <input
                                v-model="form.ward_no"
                                type="text"
                                placeholder="e.g. 07"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>

                            <div class="xl:col-span-2">
                              <label class="mb-2 block text-xs font-semibold text-slate-600">Address Line</label>
                              <input
                                v-model="form.address_line"
                                type="text"
                                placeholder="House, road, village / area"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>

                            <div class="md:col-span-2 xl:col-span-3">
                              <label class="mb-2 block text-xs font-semibold text-slate-600">Landmark</label>
                              <input
                                v-model="form.landmark"
                                type="text"
                                placeholder="Near school / market / bridge (optional)"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>
                          </div>
                        </section>

                        <!-- =========================
                            Complaint Details
                        ========================== -->
                        <section class="rounded-2xl border border-slate-200 bg-slate-50 dark:bg-slate-900 p-4 md:p-5">
                          <div class="mb-4 flex items-center justify-between gap-3">
                            <div>
                              <h3 class="text-sm font-semibold text-slate-800 dark:text-white md:text-base">Complaint Details</h3>
                              <p class="text-xs text-slate-500">Category, title, description and priority</p>
                            </div>
                            <span class="hidden sm:inline-flex rounded-full bg-white dark:bg-slate-800 dark:text-white px-2.5 py-1 text-xs text-slate-500 border border-slate-200">
                              Main issue info
                            </span>
                          </div>

                          <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Category <span class="text-red-500">*</span>
                              </label>
                              <select
                                v-model="form.category_id"
                                @change="onCategoryChange"
                                required
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              >
                                <option value="" disabled>-- Select Category --</option>
                                <option v-for="val in categories" :key="val.id" :value="val.id">
                                  {{ val.name }} - {{ val.bn_name }}
                                </option>
                              </select>
                            </div>

                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Sub-Category <span class="text-red-500">*</span>
                              </label>
                              <select
                                v-model="form.sub_category_id"
                                :disabled="!form.category_id || subcategories.length === 0"
                                required
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 disabled:cursor-not-allowed disabled:bg-slate-100 disabled:text-slate-400"
                              >
                                <option value="" disabled>
                                  {{ form.category_id ? '-- Select Sub-Category --' : 'Select category first' }}
                                </option>
                                <option v-for="val in subcategories" :key="val.id" :value="val.id">
                                  {{ val.name }} - {{ val.bn_name }}
                                </option>
                              </select>
                              <p v-if="form.category_id && subcategories.length === 0" class="mt-2 text-xs text-amber-600">
                                No sub-categories found for this category.
                              </p>
                            </div>

                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Priority <span class="text-red-500">*</span>
                              </label>
                              <select
                                v-model="form.priority"
                                required
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              >
                                <option value="low">Low</option>
                                <option value="medium">Medium</option>
                                <option value="high">High</option>
                                <option value="urgent">Urgent</option>
                              </select>
                            </div>

                            <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
                              <label class="flex items-center gap-3 rounded-xl border border-slate-200 bg-white dark:bg-slate-800 px-3 py-2.5">
                                <input
                                  v-model="form.is_public"
                                  type="checkbox"
                                  class="h-4 w-4 rounded border-slate-300 text-indigo-600 focus:ring-indigo-500"
                                />
                                <span class="text-sm text-slate-700 dark:text-indigo-100">Show publicly</span>
                              </label>

                              <label class="flex items-center gap-3 rounded-xl border border-slate-200 bg-white dark:bg-slate-800 px-3 py-2.5">
                                <input
                                  v-model="form.is_anonymous"
                                  type="checkbox"
                                  class="h-4 w-4 rounded border-slate-300 text-indigo-600 focus:ring-indigo-500"
                                />
                                <span class="text-sm text-slate-700 dark:text-indigo-100">Anonymous</span>
                              </label>
                            </div>

                            <div class="md:col-span-2">
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Complaint Title <span class="text-red-500">*</span>
                              </label>
                              <input
                                v-model="form.title"
                                type="text"
                                required
                                maxlength="255"
                                placeholder="Short summary of your complaint"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>

                            <div class="md:col-span-2">
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Description <span class="text-red-500">*</span>
                              </label>
                              <textarea
                                v-model="form.description"
                                required
                                rows="5"
                                placeholder="Write details of the problem, when it started, and what support you need..."
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-slate-800 dark:text-white px-3 py-2.5 text-sm resize-y focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              ></textarea>
                            </div>
                          </div>
                        </section>

                        <!-- =========================
                            Complainant Info
                        ========================== -->
                        <section class="rounded-2xl border border-slate-200 bg-slate-50 dark:bg-slate-900 p-4 md:p-5">
                          <div class="mb-4 flex items-center justify-between gap-3">
                            <div>
                              <h3 class="text-sm font-semibold text-slate-800 dark:text-slate-100 md:text-base">Complainant Information</h3>
                              <p class="text-xs text-slate-500">Your contact details for update and follow-up</p>
                            </div>
                            <span class="hidden sm:inline-flex rounded-full bg-white dark:bg-slate-900 px-2.5 py-1 text-xs text-slate-500 dark:text-slate-100 border border-slate-200">
                              Contact info
                            </span>
                          </div>

                          <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Full Name <span class="text-red-500">*</span>
                              </label>
                              <input
                                v-model="form.complainant_name"
                                type="text"
                                required
                                placeholder="Enter your full name"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-gray-900 dark:text-slate-100 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>

                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">
                                Phone Number <span class="text-red-500">*</span>
                              </label>
                              <input
                                v-model="form.complainant_phone"
                                type="tel"
                                required
                                placeholder="01XXXXXXXXX"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-gray-900 dark:text-slate-100 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>

                            <div class="md:col-span-2">
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">Email (Optional)</label>
                              <input
                                v-model="form.complainant_email"
                                type="email"
                                placeholder="you@example.com"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-gray-900 dark:text-slate-100 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>
                          </div>
                        </section>

                        <!-- =========================
                            Attachments
                        ========================== -->
                        <section class="rounded-2xl border border-slate-200 bg-slate-50 dark:bg-slate-900 p-4 md:p-5">
                          <div class="mb-4 flex items-center justify-between gap-3">
                            <div>
                              <h3 class="text-sm font-semibold text-slate-800 dark:text-slate-100 md:text-base">Attachments</h3>
                              <p class="text-xs text-slate-500">Upload photo, document or evidence</p>
                            </div>
                            <span class="hidden sm:inline-flex rounded-full bg-white dark:bg-gray-900 px-2.5 py-1 text-xs text-slate-500 dark:text-slate-100 border border-slate-200">
                              Optional
                            </span>
                          </div>

                          <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">Primary Attachment</label>
                              <div class="rounded-xl border border-dashed border-slate-300 bg-white dark:bg-gray-900 p-3">
                                <input
                                  type="file"
                                  @change="onSingleFileChange"
                                  class="block w-full text-sm text-slate-600 dark:text-slate-100 file:mr-3 file:rounded-lg file:border-0 file:bg-indigo-50 file:px-3 file:py-2 file:text-indigo-700 hover:file:bg-indigo-100"
                                />
                                <p class="mt-2 text-xs text-slate-50 dark:text-slate-100">JPG, PNG, PDF (max size based on backend validation)</p>
                              </div>
                            </div>

                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">Multiple Attachments</label>
                              <div class="rounded-xl border border-dashed border-slate-300 bg-white dark:bg-gray-900 p-3">
                                <input
                                  type="file"
                                  multiple
                                  @change="onMultipleFilesChange"
                                  class="block w-full text-sm text-slate-600 dark:text-slate-100 file:mr-3 file:rounded-lg file:border-0 file:bg-indigo-50 file:px-3 file:py-2 file:text-indigo-700 hover:file:bg-indigo-100"
                                />
                                <p class="mt-2 text-xs text-slate-500 dark:text-slate-100">You can upload multiple supporting files.</p>
                              </div>
                            </div>
                          </div>

                          <div
                            v-if="form.attachment || (form.attachments && form.attachments.length)"
                            class="mt-4 rounded-xl border border-slate-200 bg-white dark:bg-slate-900 p-3"
                          >
                            <p class="mb-2 text-xs font-semibold text-slate-700 dark:text-slate-100">Selected files</p>

                            <ul class="space-y-1 text-xs text-slate-600 dark:text-slate-100">
                              <li v-if="form.attachment" class="flex items-center justify-between gap-2">
                                <span class="truncate">Primary: {{ form.attachment.name }}</span>
                                <button type="button" @click="form.attachment = null" class="text-red-600 hover:text-red-700">
                                  Remove
                                </button>
                              </li>

                              <li
                                v-for="(file, index) in form.attachments"
                                :key="`${file.name}-${index}`"
                                class="flex items-center justify-between gap-2"
                              >
                                <span class="truncate">{{ index + 1 }}. {{ file.name }}</span>
                                <button
                                  type="button"
                                  @click="form.attachments.splice(index, 1)"
                                  class="text-red-600 hover:text-red-700"
                                >
                                  Remove
                                </button>
                              </li>
                            </ul>
                          </div>
                        </section>

                        <!-- =========================
                            Map Coordinates
                        ========================== -->
                        <section class="rounded-2xl border border-slate-200 bg-slate-50 dark:bg-slate-900 p-4 md:p-5">
                          <div class="mb-4 flex items-center justify-between gap-3">
                            <div>
                              <h3 class="text-sm font-semibold text-slate-800 dark:text-slate-100 md:text-base">Map Coordinates</h3>
                              <p class="text-xs text-slate-500">Optional GPS location if you know it</p>
                            </div>
                            <span class="hidden sm:inline-flex rounded-full bg-white dark:bg-gray-900 px-2.5 py-1 text-xs text-slate-500 dark:text-slate-100 border border-slate-200">
                              Optional
                            </span>
                          </div>

                          <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">Latitude</label>
                              <input
                                v-model="form.latitude"
                                type="number"
                                step="0.0000001"
                                placeholder="23.8103"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-gray-900 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>

                            <div>
                              <label class="mb-2 block text-xs font-semibold text-slate-600 dark:text-slate-100">Longitude</label>
                              <input
                                v-model="form.longitude"
                                type="number"
                                step="0.0000001"
                                placeholder="90.4125"
                                class="w-full rounded-xl border border-slate-200 bg-white dark:bg-gray-900 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                              />
                            </div>
                          </div>
                        </section>

                        <!-- =========================
                            Submit Actions
                        ========================== -->
                        <div class="sticky bottom-0 z-10 rounded-2xl border border-slate-200 bg-white dark:bg-slate-900 p-3 backdrop-blur md:p-4">
                          <div class="flex flex-col-reverse items-stretch justify-between gap-3 sm:flex-row sm:items-center">
                            <div class="text-xs text-slate-500 dark:text-slate-100">
                              <span class="text-red-500">*</span> Required fields must be completed before submission.
                            </div>

                            <div class="flex items-center gap-2">
                              <button
                                type="button"
                                @click="resetComplaintForm"
                                :disabled="loading"
                                class="inline-flex items-center justify-center rounded-xl border border-slate-300 px-4 py-2.5 text-sm font-medium text-slate-700 dark:text-slate-100 hover:bg-slate-50 hover:dark:bg-slate-700 disabled:opacity-60"
                              >
                                Reset
                              </button>

                              <button
                                type="submit"
                                :disabled="loading"
                                class="inline-flex min-w-[150px] items-center justify-center rounded-xl bg-indigo-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-indigo-700 disabled:cursor-not-allowed disabled:opacity-60"
                              >
                                <svg
                                  v-if="loading"
                                  class="mr-2 h-4 w-4 animate-spin"
                                  xmlns="http://www.w3.org/2000/svg"
                                  fill="none"
                                  viewBox="0 0 24 24"
                                >
                                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z"></path>
                                </svg>
                                {{ loading ? "Submitting..." : "Submit Complaint" }}
                              </button>
                            </div>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, onBeforeUnmount, reactive } from "vue";
import { useRouter } from "vue-router";
import api from "../../services/api";

import Navbar from '../Dashboard/navbar.vue'
import Header from '../Dashboard/header.vue'
import Message from '../Message/message.vue'

const router = useRouter();

const loading = ref(false);
const errorMsg = ref("");
const successMsg = ref("");
const divisions = ref([]);
const districts = ref([]);
const upazilas = ref([]);
const policeStations = ref([]);

const categories = ref([]);
const subcategories = ref([]);

const form = reactive({
  // =========================
  // Complaint Basic Info
  // =========================
  title: "",
  description: "",

  category_id: "",
  sub_category_id: "", // use this name (match DB column)

  priority: "medium", // low | medium | high | urgent

  // =========================
  // Location
  // =========================
  division_id: "",
  district_id: "",
  upazila_id: "",
  police_station_id: "",

  ward_no: "",
  address_line: "",
  landmark: "",

  latitude: "",
  longitude: "",

  // =========================
  // Complainant Info
  // =========================
  complainant_name: "",
  complainant_phone: "",
  complainant_email: "",

  // =========================
  // Visibility / Privacy
  // =========================
  is_public: true,
  is_anonymous: false,

  // =========================
  // Attachments
  // =========================
  attachment: null,      // single file
  attachments: [],       // multiple files (File[])

  // =========================
  // Optional Metadata (frontend can send)
  // =========================
  source: "web",
  submitted_device: "",
  submitted_platform: "",
  submitted_browser: "",

  // =========================
  // Admin-only (usually not in public form)
  // keep if same form used in admin panel
  // =========================
  assigned_to: "",
  admin_remark: "",
  action_taken: "",
  rejected_reason: "",
  status: "pending",
});

// form clear
function resetComplaintForm() {
  form.title = "";
  form.description = "";
  form.category_id = "";
  form.sub_category_id = "";
  form.priority = "medium";

  form.division_id = "";
  form.district_id = "";
  form.upazila_id = "";
  form.police_station_id = "";

  form.ward_no = "";
  form.address_line = "";
  form.landmark = "";
  form.latitude = "";
  form.longitude = "";

  form.complainant_name = "";
  form.complainant_phone = "";
  form.complainant_email = "";

  form.is_public = true;
  form.is_anonymous = false;

  form.attachment = null;
  form.attachments = [];

  // reset option lists
  districts.value = [];
  upazilas.value = [];
  policeStations.value = [];
  subcategories.value = [];

  errorMsg.value = "";
  successMsg.value = "";

  // master data reload
  getDivision();
  getCategory();
}

function onSingleFileChange(e) {
  form.attachment = e.target.files?.[0] || null;
}

function onMultipleFilesChange(e) {
  form.attachments = Array.from(e.target.files || []);
}

// ==============================
// Location Loaders (Clean Version)
// ==============================

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

// get division
async function getDivision() {
  resetErrorAndLoading();

  try{
    const res = await api.get('/create/get-division');
    divisions.value = res.data?.data ?? [];
  } catch (err){        
    console.error("Division load error:", err);
    handleApiError(err, "Failed to load divisions", divisions);
  } finally{
      loading.value = false;
  }
}

// get division wise districk
async function onDivisionChange() {
  resetErrorAndLoading();

  // Reset dependent fields
  form.district_id = "";
  form.upazila_id = "";
  form.police_station_id = "";

  districts.value = [];
  upazilas.value = [];
  policeStations.value = [];

  // No division selected
  if (!form.division_id) {
    loading.value = false;
    return;
  }

  try{
    const res = await api.get(`/create/get-district/${form.division_id}`);
    districts.value = res.data?.data ?? [];
    // console.log(districts.value);
  } catch (err){        
    console.error("Division load error:", err);
    handleApiError(err, "Failed to load districts", districts);
  } finally{
      loading.value = false;
  }
}

// get upazila
async function onDistrictChange() {
  resetErrorAndLoading();

  // Reset dependent fields
  form.upazila_id = "";
  form.police_station_id = "";

  upazilas.value = [];
  policeStations.value = [];

  // No district selected
  if (!form.district_id) {
    loading.value = false;
    return;
  }

  try{
    const res = await api.get(`/create/get-upazila/${form.district_id}`);
    upazilas.value = res.data?.data ?? [];
    // console.log(upazilas.value);
  } catch (err){        
    console.error("Division load error:", err);
    handleApiError(err, "Failed to load upazilas", upazilas);
  } finally{
      loading.value = false;
  }
}

// get police station
async function onUpazilaChange() {
  resetErrorAndLoading();

  // Reset dependent field
  form.police_station_id = "";
  policeStations.value = [];

  // No upazila selected
  if (!form.upazila_id) {
    loading.value = false;
    return;
  }

  try{
    const res = await api.get(`/create/get-policeStations/${form.upazila_id}`);
    policeStations.value = res.data?.data ?? [];
    // console.log(policeStations.value);
  } catch (err){        
    console.error("Division load error:", err);
    handleApiError(err, "Failed to load police stations", policeStations);
  } finally{
      loading.value = false;
  }
}

// get category
async function getCategory() {
  resetErrorAndLoading();

  try {
    const res = await api.get('/create/get-category');
    categories.value = res.data?.data ?? [];
    // console.log(categories.value)
  } catch (err) {
    console.error("Category load error:", err);
    handleApiError(err, "Failed to load categories", categories);
  } finally {
    loading.value = false;
  }
}


// get category wise subcategory
async function onCategoryChange() {
  resetErrorAndLoading();

  // Reset dependent field
  form.sub_category_id = "";

  subcategories.value = [];

  // No category selected
  if (!form.category_id) {
    loading.value = false;
    return;
  }

  try {
    const res = await api.get(`/create/get-subcategory/${form.category_id}`);
    subcategories.value = res.data?.data ?? [];
    // console.log(subcategories.value);
  } catch (err) {
    console.error("Subcategory load error:", err);
    handleApiError(err, "Failed to load subcategories", subcategories);
  } finally {
    loading.value = false;
  }
}















const sidebarOpen = ref(false);
const active = ref("dashboard");

const isDark = ref(false);

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

/* ESC to close drawer */
onMounted(() => {


  getDivision();
  getCategory();

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