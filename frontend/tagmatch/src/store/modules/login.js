import axios from 'axios';

const state = {
  form: false,
  emailInput: null,
  password: null,
  loading: false,
  message: null,
  errorMessage: null,
  email: window.localStorage.getItem('uid'),
  family_name: localStorage.getItem('family_name'), 
  accessToken: window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
};

const  mutations = {
  onLogin(response) {
    const accessToken = response.headers['access-token'];
    const client = response.headers['client'];
    const uid = response.headers['uid'];
    const family_name = response.data.data['family_name'];
    window.localStorage.setItem('access-token', accessToken);
    window.localStorage.setItem('client', client);
    window.localStorage.setItem('uid', uid);
    window.localStorage.setItem('family_name', family_name);
  },
  SET_LOADING(state, value) {
    state.loading = value;
  },
};

const actions = {
  async onLogin ({ state, commit }) {
    if (!state.form) return
    commit('SET_LOADING', true);
    console.log('Login');

    // setTimeout(() => (this.loading = false), 2000)

    try {
      const response = await axios.post('http://localhost:8000/auth/sign_in', { 
        email: state.emailInput,
        password: state.password
      })
      commit('onLogin', response);

      console.log({ response })

      // this.$router.push('/articles')
      return response
      
    } catch (error) {
      console.error("Error:", error.response.data);
      localStorage.errorMessage = "ログインに失敗しました。"
      
    } finally {
      commit('SET_LOADING', false);
    }
  },
};

export default {
  state,
  mutations,
  actions,
}