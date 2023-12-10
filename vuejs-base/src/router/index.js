import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/news/:newsId',
      name: 'news',
      component: () => import('../views/NewsView.vue')
    },
    {
      path: '/news/create',
      name: 'newsCreate',
      component: () => import('../views/NewsCreateView.vue')
    },
    {
      path:'/login',
      name:'login',
      component: () => import('../views/LoginView.vue')
    },
    {
      path:'/myNews',
      name:'myNews',
      component: () => import('../views/MyNewsView.vue')
    }
  ]
})

export default router
