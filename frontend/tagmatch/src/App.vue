<template>
  <div>
    <nav>
      <router-link 
        to="/users"
        active-class="link--active"
        exact
        class="link"
      >Users</router-link>
      <router-link 
        to="/article"
        active-class="link--active"
        exact
        class="link"
      >EcArticles</router-link>
      <router-link 
        to="/user/new"
        active-class="link--active"
        exact
        class="link"
      >UserNewPage</router-link>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      club_advisor: []
    }
  },
  mounted () {
    axios
      .get('http://localhost:8000/club_advisor/users')
      .then(response => {
        this.club_advisor = response.data;
        console.log(response.data);
      })
  }
}
</script>

<style>
  .link {
    margin-right: 20px;
  }
  .link--active {
    font-size: 20px;
  }
</style>
