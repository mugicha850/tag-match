import Vue from 'vue';
import Router from 'vue-router'
import Users from './views/Users'
import EcArticles from './views/EcArticle'
import UserNewPage from './views/UserNewPage'

Vue.use(Router)

export default new Router({
    mode: "history",
    routes: [{ 
        path: "/users", component: Users
    },
    {
        path: "/article", component: EcArticles
    },
    {
        path: "/user/new", component: UserNewPage
    }    
    ]
});