import { createStore } from 'vuex'
import logout from './modules/logout';
import login from '../store/modules/login';

// 新しいストアインスタンスを作成します
const store = createStore({
  state: {
    selectedIcon: null,
    baseLinks: [
      ['mdi-message-text', '/chat'],
      ['mdi-account', '/users'],
      ['mdi-magnify', '/settings'],
      ['mdi-login', '/auth/sign_in'],
      ['mdi-logout', '/auth/sign_out'],
    ],
  },
  mutations: {
    setSelectedIcon(state, icon) {
      state.selectedIcon = icon;
    },
  },

  getters: {
    shouldDisplayIcon: (state) => (icon) => {
      if (icon === 'mdi-login') return !state.logout.isLoggedIn;
      if (icon === 'mdi-logout') return state.logout.isLoggedIn;
      return true;
    },  
  },
  modules: {
    logout,
    login,
  }
});

export default store;