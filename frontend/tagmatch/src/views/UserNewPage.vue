<template>
    <form @submit.prevent="createClubAdvisor">
        <div>
            <label>email</label>
            <input v-model="club_advisor.email" type="text">
        </div>
        <div>
            <label>password</label>
            <input v-model="club_advisor.password" type="text">
        </div>
        <div>
            <label>family_name</label>
            <input v-model="club_advisor.family_name" type="text">
        </div>
        <div>
            <label>given_name</label>
            <input v-model="club_advisor.given_name" type="text">
        </div>
        <div>
            <label>family_name_kana</label>
            <input v-model="club_advisor.family_name_kana" type="text">
        </div>
        <div>
            <label>given_name_kana</label>
            <input v-model="club_advisor.given_name_kana" type="text">
        </div>
        <div>
            <label>career</label>
            <input v-model="club_advisor.career" type="number">
        </div>
        <div>
            <label>start_date</label>
            <input v-model="club_advisor.start_date" type="date">
        </div>
        <div>
            <label>end_date</label>
            <input v-model="club_advisor.end_date" type="date">
        </div>
        <div>
            <label>sport_id</label>
            <input v-model="club_advisor.sport_id" type="number">
        </div>
        <div>
            <label>area_id</label>
            <input v-model="club_advisor.area_id" type="number">
        </div>
        <div>
            <label>school_id</label>
            <input v-model="club_advisor.school_id" type="number">
        </div>
        <div>
            <label>club_id</label>
            <input v-model="club_advisor.club_id" type="number">
        </div>
        <div>
            <label>birthday</label>
            <input v-model="club_advisor.birthday" type="date">
        </div>
        <div>
            <label>性別</label>
            <select v-model="club_advisor.sex">
                <option>other</option>
                <option>male</option>
                <option>female</option>
            </select>
        </div>
        <button type="submit">Commit</button>
    </form>
</template>
<script>
    import axios from 'axios';
    export default {
        data: function () {
            return {
                club_advisor: {
                    email: '',
                    password: '',
                    family_name: '',
                    given_name: '',
                    family_name_kana: '',
                    given_name_kana: '',
                    career: '',
                    start_date: '',
                    end_date: '',
                    suspended: '',
                    sport_id: '',
                    area_id: '',
                    school_id: '',
                    club_id: '',
                    created_at: '',
                    updated_at: '',
                    birthday: '',
                    sex: ''
                }
            }
        },
        methods: {
            createClubAdvisor: function () {
                axios
                    .post('http://localhost:8000/club_advisor/users', this.clubadvisor)
                    .then(response => (this.club_advisors = response.data))

            }
        }
    }
</script>