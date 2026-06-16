<template>
  <div>
    <VNavigationDrawer v-model="drawer" :rail="rail" permanent>
      <VListItem
        prepend-icon="mdi-beach"
        title="Férias"
        nav
      >
        <template #append>
          <VBtn
            :icon="rail ? 'mdi-chevron-right' : 'mdi-chevron-left'"
            variant="text"
            @click="rail = !rail"
          />
        </template>
      </VListItem>

      <VDivider />

      <VList density="compact" nav>
        <VListItem
          v-for="item in menuItems"
          :key="item.name"
          :prepend-icon="item.icon"
          :title="item.title"
          :to="{ name: item.name }"
          :active="route.name === item.name"
          rounded="lg"
        />
      </VList>

      <template #append>
        <VDivider />
        <VList density="compact" nav>
          <VListItem
            prepend-icon="mdi-logout"
            title="Sair"
            rounded="lg"
            @click="handleLogout"
          />
        </VList>
      </template>
    </VNavigationDrawer>

    <VAppBar elevation="0" border="b">
      <VAppBarTitle>
        {{ route.meta.titulo ?? 'Sistema de Férias' }}
      </VAppBarTitle>

      <template #append>
        <div class="d-flex align-center ga-2 mr-4">
          <VIcon icon="mdi-account-circle" size="28" color="primary" />
          <div class="d-flex flex-column align-end" v-if="!rail">
            <span class="text-body-2 font-weight-medium">{{ authStore.nomeUsuario }}</span>
            <span class="text-caption text-medium-emphasis">{{ authStore.usuario?.role }}</span>
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
