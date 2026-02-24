<template>
  <header
    class="sticky top-0 z-30 border-b backdrop-blur
           bg-white/80 text-slate-900 border-slate-200
           dark:bg-slate-900/80 dark:text-slate-100 dark:border-white/10">
    <div class="h-14 px-4 lg:px-6 flex items-center gap-4">
      <!-- Left: Mobile menu -->
      <button
        class="lg:hidden p-2 rounded-lg
               hover:bg-slate-100 text-slate-700
               dark:hover:bg-white/10 dark:text-slate-200"
        aria-label="Open menu"
        @click="$emit('open-sidebar')"
      >
        <svg class="h-6 w-6" viewBox="0 0 24 24" fill="none" stroke="currentColor">
          <path stroke-linecap="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>

      <!-- Brand -->
      <div class="flex items-center gap-3 min-w-[120px]">
        <div class="font-semibold tracking-wide text-lg text-slate-900 dark:text-white">
          Nagorik Sheba
        </div>
      </div>

      <!-- Search -->
      <div class="hidden md:flex flex-1 justify-center">
        <div class="w-full max-w-2xl">
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">
              <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                <path stroke-linecap="round" stroke-width="2" d="M21 21l-4.35-4.35" />
                <path stroke-linecap="round" stroke-width="2" d="M10.5 18a7.5 7.5 0 1 1 0-15 7.5 7.5 0 0 1 0 15z" />
              </svg>
            </span>

            <input
              v-model="q"
              type="text"
              placeholder="Search for projects"
              class="w-full rounded-xl border outline-none
                    bg-white text-slate-900 border-slate-200 placeholder:text-slate-400
                    pl-10 pr-3 py-2.5
                    focus:ring-2 focus:ring-emerald-500/40
                    dark:bg-white/10 dark:text-slate-100 dark:border-white/10"
              @keydown.enter="$emit('search', q)"
            />
          </div>
        </div>
      </div>

      <!-- Actions -->
      <div class="flex items-center gap-2 min-w-[160px] justify-end">
        <!-- Theme -->
        <button
          class="p-2 rounded-lg transition
                 hover:bg-slate-100 text-slate-700
                 dark:hover:bg-white/10 dark:text-slate-200"
          aria-label="Theme"
          @click="$emit('toggle-theme')"
        >
          <!-- Moon (when light) -->
          <svg v-if="!isDark" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path stroke-linecap="round" stroke-width="2"
              d="M21 12.79A9 9 0 1 1 11.21 3a7 7 0 0 0 9.79 9.79z" />
          </svg>

          <!-- Sun (when dark) -->
          <svg v-else class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path stroke-linecap="round" stroke-width="2"
              d="M12 3v2M12 19v2M4.22 4.22l1.41 1.41M18.36 18.36l1.41 1.41M3 12h2M19 12h2M4.22 19.78l1.41-1.41M18.36 5.64l1.41-1.41" />
            <path stroke-linecap="round" stroke-width="2"
              d="M12 17a5 5 0 1 0 0-10 5 5 0 0 0 0 10z" />
          </svg>
        </button>

        <!-- Notifications -->
        <div class="relative" ref="notifWrap">
          <button
            class="relative p-2 rounded-lg transition
                   hover:bg-slate-100 text-slate-700
                   dark:hover:bg-white/10 dark:text-slate-200"
            aria-label="Notifications"
            @click.stop="toggleNotif"
          >
            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor">
              <path stroke-linecap="round" stroke-width="2"
                d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5" />
              <path stroke-linecap="round" stroke-width="2" d="M9 17a3 3 0 0 0 6 0" />
            </svg>

            <span class="absolute top-2 right-2 h-2 w-2 rounded-full bg-red-500 ring-2 ring-white dark:ring-slate-900"></span>
          </button>

          <div
            v-show="notifOpen"
            class="absolute z-50 right-0 mt-2 w-80 rounded-xl border shadow-xl overflow-hidden
                   bg-white text-slate-900 border-slate-200
                   dark:bg-slate-900 dark:text-slate-100 dark:border-white/10"
          >
            <div class="px-4 py-3 border-b border-slate-200 font-semibold dark:border-white/10">
              Notifications
            </div>

            <ul class="max-h-72 overflow-y-auto">
              <li class="px-4 py-3 cursor-pointer hover:bg-slate-50 dark:hover:bg-white/5">
                <div class="text-sm font-medium">New message</div>
                <div class="text-xs text-slate-500 mt-1 dark:text-slate-400">You have 2 unread messages</div>
              </li>
              <li class="px-4 py-3 cursor-pointer hover:bg-slate-50 dark:hover:bg-white/5">
                <div class="text-sm font-medium">Project updated</div>
                <div class="text-xs text-slate-500 mt-1 dark:text-slate-400">Windmill UI was updated</div>
              </li>
              <li class="px-4 py-3 cursor-pointer hover:bg-slate-50 dark:hover:bg-white/5">
                <div class="text-sm font-medium">Server warning</div>
                <div class="text-xs text-slate-500 mt-1 dark:text-slate-400">High CPU usage detected</div>
              </li>
            </ul>

            <div class="px-4 py-3 border-t border-slate-200 dark:border-white/10">
              <button
                class="w-full text-sm py-2 rounded-lg
                       bg-slate-900 text-white hover:bg-slate-800
                       dark:bg-white/10 dark:text-slate-100 dark:hover:bg-white/15"
              >
                View all
              </button>
            </div>
          </div>
        </div>

        <!-- Profile -->
        <div class="relative" ref="profileWrap">
          <button
            class="ml-1 flex items-center gap-2 rounded-full p-1 pr-2 transition
                   hover:bg-slate-100 dark:hover:bg-white/10"
            aria-label="Profile menu"
            @click.stop="toggleProfile"
          >
            <img class="h-8 w-8 rounded-full object-cover ring-2 ring-slate-200 dark:ring-white/10" :src="avatarUrl" alt="User" />
            <svg class="h-4 w-4 hidden sm:block text-slate-500 dark:text-slate-300" viewBox="0 0 24 24" fill="none" stroke="currentColor">
              <path stroke-linecap="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </button>

          <div
            v-show="profileOpen"
            class="absolute z-50 right-0 mt-2 w-56 rounded-xl border shadow-xl overflow-hidden
                   bg-white text-slate-900 border-slate-200
                   dark:bg-slate-900 dark:text-slate-100 dark:border-white/10"
          >
            <div class="px-4 py-3 border-b border-slate-200 dark:border-white/10">
              <div class="text-sm font-semibold">Samim</div>
              <div class="text-xs text-slate-500 dark:text-slate-400">samim@example.com</div>
            </div>

            <div class="py-2">
              <button class="w-full text-left px-4 py-2 text-sm hover:bg-slate-50 dark:hover:bg-white/10" @click="pickProfile('profile')">
                Profile
              </button>
              <button class="w-full text-left px-4 py-2 text-sm hover:bg-slate-50 dark:hover:bg-white/10" @click="pickProfile('settings')">
                Settings
              </button>
              <button class="w-full text-left px-4 py-2 text-sm hover:bg-slate-50 dark:hover:bg-white/10" @click="pickProfile('help')">
                Help
              </button>
            </div>

            <div class="border-t border-slate-200 dark:border-white/10">
              <button
                class="w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-slate-50
                       dark:text-red-300 dark:hover:bg-white/10"
                @click="pickProfile('logout')"
              >
                Logout
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup>
import { onBeforeUnmount, onMounted, ref } from "vue";
import { useRouter } from 'vue-router';
import api from '../../services/api';

const router = useRouter();

defineProps({
  isDark: { type: Boolean, default: false },
});

defineEmits(["open-sidebar", "toggle-theme", "search", "profile-action"]);

const q = ref("");
const avatarUrl = ref(
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=128&q=80"
);

/* dropdown states */
const notifOpen = ref(false);
const profileOpen = ref(false);

const notifWrap = ref(null);
const profileWrap = ref(null);

function toggleNotif() {
  notifOpen.value = !notifOpen.value;
  if (notifOpen.value) profileOpen.value = false;
}

function toggleProfile() {
  profileOpen.value = !profileOpen.value;
  if (profileOpen.value) notifOpen.value = false;
}

function closeAll() {
  notifOpen.value = false;
  profileOpen.value = false;
}

async function pickProfile(action) {
  console.log("profile action:", action);

  if (action !== "logout") {
    closeAll();
    return;
  }

  try{
    await api.post("/logout");
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    router.push("/login");
  }catch (error) {
    console.error("Logout failed:", error);
  } finally {
    closeAll();
  }
}

/* click outside -> close */
function onDocClick(e) {
  const t = e.target;
  const inNotif = notifWrap.value?.contains(t);
  const inProfile = profileWrap.value?.contains(t);
  if (!inNotif && !inProfile) closeAll();
}

/* ESC -> close */
function onKey(e) {
  if (e.key === "Escape") closeAll();
}

onMounted(() => {
  document.addEventListener("click", onDocClick);
  window.addEventListener("keydown", onKey);
});

onBeforeUnmount(() => {
  document.removeEventListener("click", onDocClick);
  window.removeEventListener("keydown", onKey);
});
</script>