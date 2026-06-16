import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const routes: RouteRecordRaw[] = [
  // -------------------------------------------------------
  // Publicas
  // -------------------------------------------------------
  {
    path: '/login',
    name: 'login',
    component: () => import('@/pages/LoginPage.vue'),
    meta: { requiresAuth: false, layout: 'blank' },
  },

  // -------------------------------------------------------
  // Autenticadas
  // -------------------------------------------------------
  {
    path: '/',
    redirect: '/dashboard',
  },
  {
    path: '/dashboard',
    name: 'dashboard',
    component: () => import('@/pages/DashboardPage.vue'),
    meta: { requiresAuth: true },
  },
  {
    path: '/solicitacoes',
    name: 'minhas-solicitacoes',
    component: () => import('@/pages/MinhasSolicitacoesPage.vue'),
    meta: { requiresAuth: true },
  },
  {
    path: '/solicitacoes/nova',
    name: 'nova-solicitacao',
    component: () => import('@/pages/NovaSolicitacaoPage.vue'),
    meta: { requiresAuth: true },
  },
  {
    path: '/solicitacoes/:id',
    name: 'solicitacao-detalhe',
    component: () => import('@/pages/DetalheSolicitacaoPage.vue'),
    meta: { requiresAuth: true },
    props: true,
  },
  {
    path: '/gerenciar',
    name: 'gerenciar-solicitacoes',
    component: () => import('@/pages/GerenciarSolicitacoesPage.vue'),
    meta: { requiresAuth: true, requiresGerenciar: true },
  },

  // -------------------------------------------------------
  // Fallback
  // -------------------------------------------------------
  {
    path: '/:pathMatch(.*)*',
    name: 'not-found',
    component: () => import('@/pages/NotFoundPage.vue'),
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
  scrollBehavior(_to, _from, savedPosition) {
    return savedPosition ?? { top: 0 }
  },
})

// -------------------------------------------------------
// Navigation guards
// -------------------------------------------------------
router.beforeEach((to, _from, next) => {
  const authStore = useAuthStore()

  if (to.meta.requiresAuth && !authStore.estaAutenticado) {
    next({ name: 'login', query: { redirect: to.fullPath } })
    return
  }

  if (to.meta.requiresGerenciar && !authStore.podeGerenciar) {
    next({ name: 'dashboard' })
    return
  }

  if (to.name === 'login' && authStore.estaAutenticado) {
    next({ name: 'dashboard' })
    return
  }

  next()
})

export default router
