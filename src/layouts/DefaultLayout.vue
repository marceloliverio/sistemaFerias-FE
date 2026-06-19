<template>
  <div>
    <VNavigationDrawer
      v-model="drawer"
      :rail="rail"
      permanent
      style="background: #000E34; border-right: 1px solid rgba(255,255,255,0.08)"
    >
      <!-- Brand -->
      <div class="d-flex align-center px-4" style="height: 64px;">
        <div
          class="d-flex align-center justify-center rounded-lg"
          style="width: 36px; height: 36px; background: rgba(255,255,255,0.1); flex-shrink: 0;"
        >
          <VIcon icon="mdi-umbrella-beach" color="white" size="20" />
        </div>
        <span
          v-if="!rail"
          class="ml-3 font-weight-bold text-uppercase text-white"
          style="letter-spacing: 1px; font-size: 13px; white-space: nowrap;"
        >
          Férias
        </span>
        <VSpacer v-if="!rail" />
        <VBtn
          :icon="rail ? 'mdi-chevron-right' : 'mdi-chevron-left'"
          variant="text"
          color="white"
          density="compact"
          @click="rail = !rail"
        />
      </div>

      <VDivider style="border-color: rgba(255,255,255,0.1)" />

      <!-- Menu items -->
      <VList density="compact" nav class="mt-2 px-2">
        <VListItem
          v-for="item in menuItems"
          :key="item.name"
          :prepend-icon="item.icon"
          :title="item.title"
          :to="{ name: item.name }"
          rounded="lg"
          class="nav-item mb-1"
          :class="{ 'nav-item--active': route.name === item.name }"
        />
      </VList>

      <!-- Logout -->
      <template #append>
        <VDivider style="border-color: rgba(255,255,255,0.1)" />
        <VList density="compact" nav class="px-2 py-2">
          <VListItem
            prepend-icon="mdi-logout"
            title="Sair"
            rounded="lg"
            class="nav-item"
            @click="handleLogout"
          />
        </VList>
      </template>
    </VNavigationDrawer>

    <!-- AppBar navy -->
    <VAppBar color="primary" elevation="0" flat>
      <VAppBarTitle>
        <span
          class="font-weight-semibold text-uppercase text-white"
          style="letter-spacing: 0.5px; font-size: 14px;"
        >
          {{ route.meta.titulo ?? 'Sistema de Férias' }}
        </span>
      </VAppBarTitle>

      <template #append>
        <div class="d-flex align-center ga-2 mr-4">
          <VIcon icon="mdi-account-circle" color="white" size="28" />
          <div v-if="!rail" class="d-flex flex-column align-end">
            <span class="text-body-2 font-weight-medium text-white">{{ authStore.nomeUsuario }}</span>
            <span class="text-caption" style="color: rgba(255,255,255,0.65)">
              {{ authStore.usuario?.role }}
            </span>
          </div>
        </div>
      </template>
    </VAppBar>

    <VMain>
      <VContainer fluid class="pa-6">
        <slot />
      </VContainer>
    </VMain>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const drawer = ref(true)
const rail = ref(false)

interface MenuItem {
  name: string
  title: string
  icon: string
  somentePodeGerenciar?: boolean
}

const todosMenuItems: MenuItem[] = [
  { name: 'dashboard', title: 'Dashboard', icon: 'mdi-view-dashboard' },
  { name: 'nova-solicitacao', title: 'Nova Solicitação', icon: 'mdi-plus-circle' },
  { name: 'minhas-solicitacoes', title: 'Minhas Solicitações', icon: 'mdi-calendar-clock' },
  { name: 'gerenciar-solicitacoes', title: 'Gerenciar', icon: 'mdi-clipboard-check', somentePodeGerenciar: true },
]

const menuItems = computed(() =>
  todosMenuItems.filter((item) => !item.somentePodeGerenciar || authStore.podeGerenciar),
)

async function handleLogout(): Promise<void> {
  authStore.logout()
  await router.push({ name: 'login' })
}
</script>

<style scoped>
.nav-item :deep(.v-list-item__prepend .v-icon),
.nav-item :deep(.v-list-item-title) {
  color: rgba(255, 255, 255, 0.65);
  transition: color 0.15s ease;
}

.nav-item:hover :deep(.v-list-item__prepend .v-icon),
.nav-item:hover :deep(.v-list-item-title) {
  color: white;
}

.nav-item--active :deep(.v-list-item__prepend .v-icon),
.nav-item--active :deep(.v-list-item-title) {
  color: #3988FF !important;
}

.nav-item--active {
  background: rgba(57, 136, 255, 0.15) !important;
}
</style>
