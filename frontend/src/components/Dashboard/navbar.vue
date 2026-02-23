<template>
  <!-- Overlay (mobile) -->
  <div
    class="fixed inset-0 z-40 lg:hidden
           bg-black/40 dark:bg-black/60"
    :class="open ? 'block' : 'hidden'"
    @click="$emit('close')"
  />

  <aside
    class="fixed inset-y-0 left-0 z-50 w-72 h-screen
           border-r transform transition-transform duration-200
           lg:static lg:translate-x-0 lg:h-screen
           overflow-y-auto
           bg-white text-slate-900 border-slate-200
           dark:bg-slate-900 dark:text-slate-100 dark:border-white/10"
    :class="open ? 'translate-x-0' : '-translate-x-full'"
  >
    <!-- Brand -->
    <div class="h-16 px-5 flex items-center gap-3 border-b border-slate-200 dark:border-white/10">
      <span class="h-9 w-9 rounded-xl bg-emerald-500/20 flex items-center justify-center ring-1 ring-emerald-500/30">
        <span class="h-2.5 w-2.5 rounded-full bg-emerald-400"></span>
      </span>

      <div class="text-lg font-semibold tracking-wide">Windmill</div>

      <button
        class="ml-auto p-2 rounded-lg lg:hidden
               hover:bg-slate-100 text-slate-700
               dark:hover:bg-white/10 dark:text-slate-200"
        aria-label="Close menu"
        @click="$emit('close')"
      >
        <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor">
          <path stroke-linecap="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </div>

    <!-- Menu -->
    <nav class="p-3">
      <ul class="space-y-1">
        <li v-for="item in mainItems" :key="item.key">
          <button
            class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-left transition
                   focus:outline-none focus:ring-2 focus:ring-emerald-500/40
                   hover:bg-slate-100
                   dark:hover:bg-white/10"
            :class="modelValue === item.key
              ? 'bg-emerald-50 text-emerald-700 ring-1 ring-emerald-200 dark:bg-white/10 dark:text-white dark:ring-white/10'
              : ''"
            @click="pick(item.key)"
          >
            <span class="opacity-90"><component :is="item.icon" /></span>
            <span class="text-sm font-medium">{{ item.label }}</span>
          </button>
        </li>

        <!-- Pages dropdown -->
        <li>
          <button
            class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-left transition
                   focus:outline-none focus:ring-2 focus:ring-emerald-500/40
                   hover:bg-slate-100
                   dark:hover:bg-white/10"
            :class="pagesOpen
              ? 'bg-slate-100 ring-1 ring-slate-200 dark:bg-white/10 dark:ring-white/10'
              : ''"
            @click="pagesOpen = !pagesOpen"
          >
            <span class="opacity-90"><IconFolder /></span>
            <span class="text-sm font-medium flex-1">Pages</span>
            <svg
              class="h-4 w-4 transition-transform opacity-80"
              :class="pagesOpen ? 'rotate-180' : ''"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </button>

          <div
            v-show="pagesOpen"
            class="mt-1 ml-6 mr-2 rounded-xl ring-1
                   bg-slate-50 ring-slate-200
                   dark:bg-black/20 dark:ring-white/10"
          >
            <ul class="py-2">
              <li v-for="p in pageItems" :key="p.key">
                <button
                  class="w-full px-4 py-2 text-sm text-left transition
                         hover:bg-white
                         dark:hover:bg-white/10"
                  :class="modelValue === p.key
                    ? 'bg-white text-slate-900 font-medium dark:bg-white/10 dark:text-white'
                    : 'text-slate-700 dark:text-slate-200/90'"
                  @click="pick(p.key)"
                >
                  {{ p.label }}
                </button>
              </li>
            </ul>
          </div>
        </li>
      </ul>
    </nav>
  </aside>
</template>

<script setup>
import { computed, h, ref } from "vue";

defineProps({
  open: { type: Boolean, default: false },
  modelValue: { type: String, default: "dashboard" },
});

const emit = defineEmits(["close", "update:modelValue", "navigate"]);

const pagesOpen = ref(false);

function pick(key) {
  emit("update:modelValue", key);
  emit("navigate", key);
  emit("close"); // mobile drawer close
}

/* Icons */
const Icon = (paths) =>
  computed(() =>
    h(
      "svg",
      { class: "h-5 w-5", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor" },
      paths.map((d) => h("path", { d, "stroke-linecap": "round", "stroke-width": "2" }))
    )
  ).value;

const IconHome = Icon(["M3 10.5l9-7 9 7", "M9 21V12h6v9"]);
const IconForms = Icon(["M7 7h10", "M7 12h10", "M7 17h6"]);
const IconCards = Icon(["M4 7h16", "M4 17h16", "M4 7v10", "M20 7v10"]);
const IconCharts = Icon(["M4 19V5", "M4 19h16", "M8 15v-4", "M12 19v-8", "M16 13V7"]);
const IconButtons = Icon(["M8 12h8", "M12 8v8"]);
const IconModals = Icon(["M6 7h12", "M6 17h12", "M6 7v10", "M18 7v10"]);
const IconTables = Icon(["M4 7h16", "M4 12h16", "M4 17h16", "M8 7v10", "M16 7v10"]);
const IconFolder = Icon(["M3 7h6l2 2h10v10H3V7"]);

const mainItems = [
  { key: "dashboard", label: "Dashboard", icon: IconHome },
  { key: "forms", label: "Forms", icon: IconForms },
  { key: "cards", label: "Cards", icon: IconCards },
  { key: "charts", label: "Charts", icon: IconCharts },
  { key: "buttons", label: "Buttons", icon: IconButtons },
  { key: "modals", label: "Modals", icon: IconModals },
  { key: "tables", label: "Tables", icon: IconTables },
];

const pageItems = [
  { key: "login", label: "Login" },
  { key: "create-account", label: "Create account" },
  { key: "forgot-password", label: "Forgot password" },
  { key: "404", label: "404" },
  { key: "blank", label: "Blank" },
];
</script>