import axios from 'axios';

const state = {
  isLoggedIn: !!(window.localStorage.getItem('access-token') && window.localStorage.getItem('client') && window.localStorage.getItem('uid')),
  email: window.localStorage.getItem('uid'),
  family_name: window.localStorage.getItem('family_name')
};

const mutations = {
  logout(state) {
    state.email = '';
    state.family_name = '';
    state.isLoggedIn = false;
    window.localStorage.removeItem('access-token');
    window.localStorage.removeItem('client');
    window.localStorage.removeItem('uid');
    window.localStorage.removeItem('family_name');      
  },
};

const actions = {
  async logout({ commit, state }) {
    try {
      console.log("aaa");
      const response = await axios.delete('http://localhost:8000/auth/sign_out', {
        headers: {
          uid: state.email,
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client')
        }
      });

      console.log("ログアウトしました");
      commit('logout');

      console.log({response});
      return response;
    } catch (error) {
      console.log({error});
    }
  },
};

export default {
  state,
  mutations,
  actions,
}