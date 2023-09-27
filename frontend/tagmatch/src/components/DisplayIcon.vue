<template>
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
</template>
<script>
export default {
  props: {
    shouldDisplayIcon: {
      type: Function,
      required: true
    },
    onIconClick: {
      type: Function,
      required: true
    },
    baseLinks: {
      type: Array, // または適切な型に変更
      required: true
    }
  }
}
</script>