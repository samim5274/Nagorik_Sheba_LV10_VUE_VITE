<template>
    <div class="min-h-screen bg-white dark:bg-slate-950 transition-colors duration-200">
        <Header
        @open-sidebar="sidebarOpen = true"
        @search="onSearch"
        :isDark="isDark" @toggle-theme="toggleTheme"
        />

        <div class="flex  min-h-[calc(100vh-56px)]">
            <Navbar v-model="active" :open="sidebarOpen" @close="sidebarOpen=false" />

            <!-- Content -->
            <div class="flex-1 min-w-0 mx-auto px-4 sm:px-6 lg:px-8 py-5">
                <!-- Top bar (Title + optional actions/search) -->
                <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-xl sm:text-2xl font-bold text-gray-800 dark:text-gray-100">Create new complain</h1>
                        <p class="text-sm text-gray-700 dark:text-slate-300"></p>
                    </div>
                    <button
                        type="button"
                        @click="resetForm"
                        class="rounded-xl border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50"
                        >
                        Reset
                    </button>
                </div>

                <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                  <form @submit.prevent>
                      <div>
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                          <div>
                              <label class="block text-xs font-semibold text-slate-600 mb-2">Division <span class="text-red-500">*</span></label>
                              <select v-model="form.division_id" @change="onDivisionChange" required class="w-full rounded-xl border border-slate-200 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white">
                                  <option value="" selected disabled>-- Select Divison --</option>   
                                  <option v-for="val in divisions" :key="val.id" :value="val.id">{{ val.name }} - {{ val.bn_name }}</option>                               
                              </select>
                          </div>

                          <div>
                            <label class="block text-xs font-semibold text-slate-600 mb-2">District <span class="text-red-500">*</span></label>
                            <select v-model="form.district_id" @change="onDistrictChange" required class="w-full rounded-xl border border-slate-200 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white">
                                <option value="" selected disabled>-- District --</option>  
                                <option v-for="dist in districts" :key="dist.id" :value="dist.id">{{ dist.name }} - {{ dist.bn_name }}</option>                            
                            </select>

                            <p v-if="form.district_id && districts.length === 0" class="mt-2 text-xs text-amber-600">
                                No district found for this division.
                            </p>
                          </div>

                          <div>
                            <label class="block text-xs font-semibold text-slate-600 mb-2">Upazila <span class="text-red-500">*</span></label>
                            <select v-model="form.upazila_id" @change="onUpazilaChange" required class="w-full rounded-xl border border-slate-200 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white">
                                <option value="" selected disabled>-- Select Upazila --</option>
                                <option v-for="upa in upazilas" :key="upa.id" :value="upa.id">{{ upa.name }} - {{ upa.bn_name }}</option>
                            </select>

                            <p v-if="form.upazila_id && upazilas.length === 0" class="mt-2 text-xs text-amber-600">
                                No upazila found for this district.
                            </p>
                          </div>

                          <div v-if="policeStations.length > 0">
                            <label class="block text-xs font-semibold text-slate-600 mb-2">Police Station</label>
                            <select v-model="form.police_station_id" class="w-full rounded-xl border border-slate-200 px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white">
                                <option value="" disabled>-- Select Subcategory --</option>
                                <option v-for="ps in policeStations" :key="ps.id" :value="ps.id">{{ ps.name }} - {{ ps.bn_name }}</option>
                            </select>

                            <p v-if="form.police_station_id && policeStations.length === 0" class="mt-2 text-xs text-amber-600">
                                No police station found for this upazila.
                            </p>
                          </div>
                      </div>
                    </div>
                  </form>
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

const router = useRouter();

const loading = ref(false);
const errorMsg = ref("");
const successMsg = ref("");
const divisions = ref([]);
const districts = ref([]);
const upazilas = ref([]);
const policeStations = ref([]);

const form = reactive({
  division_id: "",
  district_id: "",
  upazila_id: "",
  police_station_id: "",
});

// form clear
function resetForm() {
    Object.assign(form, {
        division_id: "",
        district_id: "",
        upazila_id: "",
        policeStations: "",
        // title: "",
        // amount: "",
        // remark: ""
    })

    // divisions.value = [];
    districts.value = [];
    upazilas.value = [];
    policeStations.value = [];
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