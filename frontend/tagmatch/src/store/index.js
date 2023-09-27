import { createStore } from 'vuex';
import { logout } from './modules/logout';

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
    shouldDisplayIcon: (rootState) => (icon) => {
      if (icon === 'mdi-login') return !rootState.logout.isLoggedIn;
      if (icon === 'mdi-logout') return rootState.logout.isLoggedIn;
      return true;
    },  
  },
  modules: {
    logout
  }
});

export default store;