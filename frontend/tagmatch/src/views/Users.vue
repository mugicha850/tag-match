<template>
    <div>
        <h3>Users</h3>
        <tr v-for="club_advisor in club_advisors" :key="club_advisor.id">
            <td>{{ club_advisor.id }}</td>
            <td>{{ club_advisor.email }}</td>
        </tr>
        <button @click="toUsers">EcArticleページにいく</button>
        <P>{{ count }}</P>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data: function() {
        return {
            club_advisors: []
        }
    },
    computed: {
        count() {
            return this.$store.state.count;
        }
    },
    mounted () {
        axios
            .get('http://localhost:8000/club_advisor/users')
            .then(response => (this.club_advisors = response.data))
    },
    methods: {
        toUsers() {
            this.$router.push({ path: "article" });
        }
    }
};
</script>