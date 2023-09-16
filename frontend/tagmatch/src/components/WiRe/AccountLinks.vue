<template>
  <div>
    <v-list-item
      v-for="[text, to] in accountLinks"
      :key="text"
      :title="`${ text }`"
      :to="to"
      link
    ></v-list-item>
  </div>
</template>

<script>
export default {
  name: 'accountLinks',
  data: () => ({
    accountLinks: [
      ['公開プロフィール', '/profile'],
      ['アカウント', '/account'],
      ['フォロー一覧', '/follows'],
      // ... その他のリンク
    ]
  })
}
</script>
