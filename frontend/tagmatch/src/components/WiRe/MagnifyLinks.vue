<template>
  <div>
    <v-list-item
      v-for="[text, to] in magnifyLinks"
      :key="text"
      :title="`Item ${ text }`"
      :to="to"
      link
    ></v-list-item>
  </div>
</template>

<script>
export default {
  name: 'magnifyLinks',
  data: () => ({
    magnifyLinks: [
      ['公開プロフィール', '/profile'],
      ['アカウント', '/account'],
      ['フォロー一覧', '/follows'],
      // ... その他のリンク
    ]
  })
}
</script>
