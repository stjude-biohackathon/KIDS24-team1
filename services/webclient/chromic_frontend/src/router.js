import {createRouter, createWebHistory} from 'vue-router'

const routes = [
  /** catch all to redirect all undefined routes to home **/
  {
    path: '/:pathMatch(.*)*',
    redirect: '/',
  },
  /** redirect /home to / **/
  {
    path: '/home',
    redirect: '/',
  },
    /** this is the landing page route **/
  {
    path: '/',
    name: 'home',
    component: () => import('@/views/Home'),
  },
  /** this is the main data view route **/
  {
    path: '/dataview',
    name: 'dataview',
    component: () => import('@/components/MainDataView'),
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
