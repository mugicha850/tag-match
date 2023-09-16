<template>
  <div>
    <v-list-item
      v-for="[text, to] in messageLinks"
      :key="text"
      :title="`Item ${ text }`"
      :to="to"
      link
    ></v-list-item>
  </div>
</template>

<script>
export default {
  name: 'MessageLinks',
  data: () => ({
    messageLinks: [
      ['公開プロフィール', '/profile'],
      ['アカウント', '/account'],
      ['フォロー一覧', '/follows'],
      // ... その他のリンク
    ]
  })
}
</script>
