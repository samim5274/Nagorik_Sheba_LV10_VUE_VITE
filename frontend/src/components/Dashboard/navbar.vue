<template>
  <!-- Overlay (mobile) -->
  <div
    class="fixed inset-0 z-40 lg:hidden bg-black/40 dark:bg-black/60"
    v-show="open"
    @click="$emit('close')"
  />

  <aside
    class="fixed inset-y-0 left-0 z-50 w-72
      border-r transform transition-transform duration-200
      lg:static lg:translate-x-0 lg:h-auto
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

      <div class="text-lg font-semibold tracking-wide">Nagorik Sheba</div>

      <button
        class="ml-auto p-2 rounded-lg lg:hidden hover:bg-slate-100 text-slate-700
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
        <!-- Main items -->
        <li v-for="item in mainItems" :key="item.key">
          <button
            class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-left transition
                   focus:outline-none focus:ring-2 focus:ring-slate-500/40
                   hover:bg-slate-100 dark:hover:bg-white/10"
            :class="activeKey === item.key
              ? 'bg-emerald-50 text-emerald-700 ring-1 ring-emerald-200 dark:bg-white/10 dark:text-white dark:ring-white/10'
              : ''"
            @click="pick(item.key)"
          >
            <span class="opacity-90 w-5 text-center"><i :class="item.icon"></i></span>
            <span class="text-sm font-medium">{{ item.label }}</span>
          </button>
        </li>

        <!-- Pages dropdown -->
        <!-- <li>
          <button
            class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-left transition
                   focus:outline-none focus:ring-2 focus:ring-slate-500/40
                   hover:bg-slate-100 dark:hover:bg-white/10"
            :class="pagesOpen
              ? 'bg-slate-100 ring-1 ring-slate-200 dark:bg-white/10 dark:ring-white/10'
              : ''"
            @click="pagesOpen = !pagesOpen"
            type="button">
            <span class="opacity-90"><i class="fa-regular fa-folder-open"></i></span>
            <span class="text-sm font-medium flex-1">Other</span>

            <svg
              class="h-4 w-4 transition-transform opacity-80"
              :class="pagesOpen ? 'rotate-180' : ''"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor">
              <path stroke-linecap="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </button>

          <div
            v-show="pagesOpen"
            class="mt-1 ml-6 mr-2 rounded-xl ring-1
                   bg-slate-50 ring-slate-200
                   dark:bg-black/20 dark:ring-white/10">
            <ul class="py-2">
              <li v-for="p in pageItems" :key="p.key">
                <button
                  class="w-full px-4 py-2 text-sm text-left transition
                         hover:bg-white dark:hover:bg-white/10"
                  :class="activeKey === p.key
                    ? 'bg-white text-slate-900 font-medium dark:bg-white/10 dark:text-white'
                    : 'text-slate-700 dark:text-slate-200/90'"
                  @click="pick(p.key)">
                  {{ p.label }}
                </button>
              </li>
            </ul>
          </div>
        </li> -->
      </ul>
    </nav>
  </aside>
</template>

<script setup>
import { computed, h, ref, watch } from "vue";
import { useRoute, useRouter } from "vue-router";

const props = defineProps({
  open: { type: Boolean, default: false },
  modelValue: { type: String, default: "" },
});

const emit = defineEmits(["close", "update:modelValue", "navigate"]);

const route = useRoute();
const router = useRouter();

const pagesOpen = ref(false);

/* key -> route map */
const routeMap = {
  dashboard: "/dashboard",
  profile: "/profile",
  create: "/create",
  complainList: "/complain-list",
  mycomplain: "/my-complain",
  logout: "/login",
};

/* route দেখে active key */
const routeMatch = [
  { key: "mycomplain", prefixes: ["/complaints/view", "/my-complain"] },
  { key: "complainList", prefixes: ["/complaints", "/complain-list"] },
  { key: "create", prefixes: ["/create"] },
  { key: "dashboard", prefixes: ["/dashboard"] },
  { key: "logout", prefixes: ["/logout"] },
  { key: "profile", prefixes: ["/profile"] },
];

const activeKey = computed(() => {
  const path = route.path;
  const hit = routeMatch.find(r => r.prefixes.some(pre => path.startsWith(pre)));
  return hit?.key ?? "dashboard";
});

/* click: update + navigate + close (mobile) */
async function pick(key) {
  emit("update:modelValue", key);
  emit("navigate", key);

  const to = routeMap[key];
  if (to && route.path !== to) {
    await router.push(to);
  }

  // Pages এর ভিতর click করলে dropdown বন্ধ করতে চাইলে:
  // pagesOpen.value = false;

  // logout special case
  if (key === "logout") {
    try {
      await api.post("/logout"); // তোমার backend route অনুযায়ী
    } catch (e) {
      // ignore / show toast
    } finally {
      localStorage.removeItem("token"); // যদি token রাখো
      emit("close");
      return router.push("/login"); // বা "/"
    }
  }

  emit("close");
}

/* Icons helper */
const Icon = (paths) =>
  computed(() =>
    h(
      "svg",
      { class: "h-5 w-5", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor" },
      paths.map((d) => h("path", { d, "stroke-linecap": "round", "stroke-width": "2" }))
    )
  ).value;

const faIcons = {
  home: "fa-solid fa-house",
  forms: "fa-regular fa-clipboard",          // form/clipboard
  profile: "fa-regular fa-circle-user",      // profile
  cards: "fa-solid fa-id-card-clip",         // cards
  charts: "fa-solid fa-chart-column",        // charts
  buttons: "fa-regular fa-square-plus",      // add/button
  modals: "fa-regular fa-window-restore",    // modal/window
  tables: "fa-solid fa-table",               // table
  setting: "fa-solid fa-gear",               // settings
  folder: "fa-regular fa-folder-open",       // folder
  logout: "fa-solid fa-arrow-right-from-bracket",       // folder
};

const mainItems = [
  { key: "dashboard", label: "Dashboard", icon: faIcons.home },
  { key: "profile", label: "Profile", icon: faIcons.profile },
  { key: "mycomplain", label: "My complains", icon: faIcons.forms },
  { key: "complainList", label: "Complains", icon: faIcons.cards },
  // { key: "charts", label: "Charts", icon: faIcons.charts },
  { key: "create", label: "Create complain", icon: faIcons.buttons },
  // { key: "modals", label: "Modals", icon: faIcons.modals },
  // { key: "tables", label: "Tables", icon: faIcons.tables },
  { key: "setting", label: "Setting", icon: faIcons.setting },
  { key: "logout", label: "Logout", icon: faIcons.logout },
];

const pageItems = [
  { key: "login", label: "Login" },
  { key: "create-account", label: "Create account" },
  { key: "forgot-password", label: "Forgot password" },
  { key: "404", label: "404" },
  { key: "blank", label: "Blank" },
];

watch(
  () => activeKey.value,
  (k) => {
    const pageKeys = pageItems.map(x => x.key);
    if (pageKeys.includes(k)) pagesOpen.value = true;
  },
  { immediate: true }
);
</script>