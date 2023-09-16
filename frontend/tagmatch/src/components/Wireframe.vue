<template>
  <v-app id="inspire">
    <v-system-bar>
      <v-spacer></v-spacer>

      <v-icon>mdi-square</v-icon>

      <v-icon>mdi-circle</v-icon>

      <v-icon>mdi-triangle</v-icon>
    </v-system-bar>

    <v-navigation-drawer
      color="grey-lighten-3"
      rail
    >
      <v-avatar
        class="d-block text-center mx-auto mt-4"
        color="grey-darken-1"
        size="36"
      ></v-avatar>

      <v-divider class="mx-3 my-5"></v-divider>

      <router-link :to="to" v-for="[icon, to] in baseLinks" :key="icon">
        <v-icon
          @click="onIconClick(icon)"
          class="d-block text-center mx-auto mb-9"
          color="blue"
          size="28"
          v-if="shouldDisplayIcon(icon)"
        >
          {{ icon }}
        </v-icon>
      </router-link>

    </v-navigation-drawer>

    <SideBar :selectedIcon="selectedIcon" />

    <v-app-bar
      class="px-3"
      color="grey-lighten-4"
      flat
      height="72"
    >
      <v-spacer></v-spacer>

      <v-responsive max-width="156">
        <v-text-field
          bg-color="grey-lighten-1"
          density="compact"
          flat
          hide-details
          rounded="pill"
          variant="solo-filled"
        ></v-text-field>
      </v-responsive>
    </v-app-bar>

    <v-main>
      <p>こんにちは、<span class="name">{{ family_name }}</span>さん</p>
      <p class="email">現在、 {{ email }} でログイン中です</p>
      <router-view></router-view>
    </v-main>

    <v-navigation-drawer location="right">
      <v-list>
        <v-list-item
          v-for="n in 5"
          :key="n"
          :title="`Item ${ n }`"
          link
        ></v-list-item>
      </v-list>
    </v-navigation-drawer>
  </v-app>
</template>

<script>
import SideBar from './SideBar.vue';
import ArticlesPage from '@/views/ArticlesPage.vue';
import SvgIcon from '@jamescoyle/vue-icon';
import { mdiAccount } from '@mdi/js';
import { mdiMagnify } from '@mdi/js';
import { mdiLogin } from '@mdi/js';
import { mdiLogout } from '@mdi/js';
import axios from 'axios';

export default {
  data: () => ({
    selectedIcon: null,
    email: window.localStorage.getItem('uid'),
    family_name: window.localStorage.getItem('family_name'), 
    baseLinks: [
      ['mdi-message-text', '/chat'],
      ['mdi-account', '/users'],
      ['mdi-magnify', '/settings'],
      ['mdi-login', '/auth/sign_in'],
      ['mdi-logout', '/auth/sign_out'],
      // ... その他のリンク
    ],
    isLoggedIn: !!(
      window.localStorage.getItem('access-token') &&
      window.localStorage.getItem('client') &&
      window.localStorage.getItem('uid')
    )
  }),
  path: mdiAccount, mdiMagnify, mdiLogin, mdiLogout,
  methods: {
    onIconClick(icon) {
      this.selectedIcon = icon;
      if (icon === 'mdi-logout') {
        this.logout();
      }
    },
    async logout() {
      try {
        console.log("aaa")
        const response = await axios.delete('http://localhost:8000/auth/sign_out',{
          headers: {
            uid: this.email,
            "access-token": window.localStorage.getItem('access-token'),
            client: window.localStorage.getItem('client')
          }
        });

        console.log("ログアウトしました")
        window.localStorage.removeItem('access-token')
        window.localStorage.removeItem('client')
        window.localStorage.removeItem('uid')
        window.localStorage.removeItem('family_name')

        // ログアウト成功時、isLoggedInをfalseにする
        this.isLoggedIn = false;

        this.email = '';
        this.family_name = '';

        localStorage.message = "ログアウトに成功しました。"
        this.$router.push('sign_in')

        console.log({response})
        return response
      }catch (error) {
        console.log({error})
      }
    },
    shouldDisplayIcon(icon) {
      if (icon === 'mdi-login') return !this.isLoggedIn;
      if (icon === 'mdi-logout') return this.isLoggedIn;
    return true;  // その他のアイコンは常に表示
    },
  },
  mounted() {
    this.family_name = localStorage.getItem('family_name');
    this.email = localStorage.getItem('uid');

    if(localStorage.email) {
      this.email = localStorage.email;
      localStorage.email = '';
    }
    if(localStorage.family_name) {
      this.family_name = localStorage.family_name;
      localStorage.family_name = '';
    }
  },
  components: {
    SvgIcon,
    SideBar
  },
}
</script>