import Vue from 'vue'
import App from './App.vue'
import router from "./router";
import EcArticle from './views/EcArticle.vue'

Vue.component ('EcArticle', EcArticle);

Vue.config.productionTip = false

new Vue({
  router: router,
  render: h => h(App),
}).$mount('#app')
