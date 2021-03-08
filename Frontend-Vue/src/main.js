import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'
import axios from 'axios';

Vue.config.productionTip = false

axios.defaults.baseURL='http://localhost/1-PROYECTOS/PROYECTO%20WEB/DESARROLLO/Proyecto-Ing-WEB/Frontend-Vue/public/Backend-PHP/',

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
