import { createRouter, createWebHistory } from 'vue-router'
import Users from './views/Users'
import EcArticles from './views/EcArticle'
import UserNewPage from './views/UserNewPage'
import Login from './views/LoginPage'
import SignUp from './views/SignUp'
import ArticlePage from './views/ArticlesPage'
import ChatRoom from './components/ChatRoom'
import { validateToken } from './authGuard'

const routes = [
  { path: "/users", component: Users, meta: { requiresAuth: true } },
  { path: "/article", component: EcArticles },
  { path: "/user/new", component: UserNewPage },
  { path: "/auth/sign_in", name: 'Login', component: Login, meta: { requiresNotAuth: true } },
  { path: "/auth/sign_up", component: SignUp, meta: { requiresNotAuth: true } },
  { path: "/articles", name: 'ArticlePage',component: ArticlePage },
  { path: "/Chat", component: ChatRoom, meta: { requiresAuth: true }},
]

const router = createRouter({
    history: createWebHistory(),
    routes
})


router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    validateToken()
      .then(() => {
        next()
        console.log('requireAuthが呼ばれています！')
      })
      .catch(() => {
        next({ name: 'Login' })
        console.log('ログインページへ遷移します。')
      })
  } else if (to.matched.some(record => record.meta.requiresNotAuth)) {
    validateToken()
      .then(() => {
        next({ name: 'ArticlePage' })
      })
      .catch(() => {
        next()
      })
  } else {
    next()
  }
})


export default router;