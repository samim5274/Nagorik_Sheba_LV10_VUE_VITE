<template>
  <div class="min-h-screen bg-white dark:bg-slate-950 transition-colors duration-200">
    <Header
      @open-sidebar="sidebarOpen = true"
      @search="onSearch"
      :isDark="isDark" @toggle-theme="toggleTheme"
    />

    <div class="flex  min-h-[calc(100vh-56px)]">
      <Navbar
        v-model="active"
        :open="sidebarOpen"
        @close="sidebarOpen = false"
      />

      <!-- Content -->
      <div class="flex-1 min-w-0">
        <Main class="w-full h-full" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from "vue";
import { useRouter } from "vue-router";

import Navbar from './navbar.vue'
import Header from './header.vue'
import Main from './main.vue';

const sidebarOpen = ref(false);
const active = ref("dashboard");

const router = useRouter();

const isDark = ref(false);

function applyTheme(dark) {
  isDark.value = dark;   // VERY IMPORTANT
  document.documentElement.classList.toggle("dark", dark);
  localStorage.setItem("theme", dark ? "dark" : "light");
}

function toggleTheme() {
  applyTheme(!isDark.value);
}

function onSearch(q) {
  console.log("search:", q);
}



/* ESC to close drawer */
onMounted(() => {
  window.addEventListener("keydown", (e) => {
    if (e.key === "Escape") sidebarOpen.value = false;
  });

  const saved = localStorage.getItem("theme");

  if (saved === "dark") applyTheme(true);
  else if (saved === "light") applyTheme(false);
  else {
    const systemDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
    applyTheme(systemDark);
  }
});
</script>

<style>

</style>