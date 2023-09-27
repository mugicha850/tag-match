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

      <DisplayIcon
        :shouldDisplayIcon="shouldDisplayIcon"
        :onIconClick="onIconClick"
        :baseLinks="baseLinks"
      />

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
import DisplayIcon from './DisplayIcon.vue';
import ArticlesPage from '@/views/ArticlesPage.vue';
import SvgIcon from '@jamescoyle/vue-icon';
import { mdiAccount } from '@mdi/js';
import { mdiMagnify } from '@mdi/js';
import { mdiLogin } from '@mdi/js';
import { mdiLogout } from '@mdi/js';
import { useStore } from 'vuex';
import { computed } from 'vue';

export default {
  setup() {
    const store = useStore();
    const selectedIcon = computed(() => store.state.selectedIcon);
    const email = computed(() => store.state.email);
    const family_name = computed(() => store.state.family_name);
    const isLoggedIn = computed(() => store.state.isLoggedIn);
    const baseLinks = computed(() => store.state.baseLinks);

    // getters
    const shouldDisplayIcon = store.getters.shouldDisplayIcon;

    // actions
    const logout = () => store.dispatch('logout');

    const onIconClick = (icon) => {
      store.commit('setSelectedIcon', icon);
      if (icon === 'mdi-logout') {
        logout();
      }
    };

    return { selectedIcon, email, family_name, isLoggedIn, baseLinks, shouldDisplayIcon, onIconClick }
  },
  components: {
    SvgIcon,
    SideBar,
    DisplayIcon
  },
}
</script>