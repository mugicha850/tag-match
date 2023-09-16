<template>
  <v-navigation-drawer width="244">
    <v-sheet
      color="grey-lighten-5"
      height="128"
      width="100%"
    ></v-sheet>

    <MessageLinks v-if="selectedIcon === 'mdi-message-text'" />
    <AccountLinks v-if="selectedIcon === 'mdi-account'" />
    <MagnifyLinks v-if="selectedIcon === 'mdi-magnify'" />

  </v-navigation-drawer>
</template>

<script>
import MessageLinks from './WiRe/MessageLinks.vue';
import MagnifyLinks from './WiRe/MagnifyLinks.vue';
import AccountLinks from './WiRe/AccountLinks.vue';

export default {
  name: 'SideBar',
  props: {
    selectedIcon: {
      type: String,
      default: ''
    }
  },
  components: {
    MessageLinks,
    MagnifyLinks,
    AccountLinks,
  }
}
</script>
