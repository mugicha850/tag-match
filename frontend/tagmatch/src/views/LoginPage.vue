<template>
  <v-app>
    <v-sheet class="bg-light-green-lighten-5 pa-12" rounded>
      <div id="signup" class="title">
        <h1 class="text-h3">ログイン</h1>
        <h4>tanaka@example.com</h4>
      </div>
      <div id="signup" class="title">
        <v-btn class="small-btn" text color="light-green-lighten-5" to="sign_up">新規作成はこちら</v-btn>
      </div>  
        <v-card class="mx-auto px-6 py-8" max-width="344">
        <v-form
            v-model="form"
            @submit.prevent="onSubmit"
        >
            <v-text-field
            v-model="emailInput"
            :readonly="loading"
            :rules="[emailRules]"
            class="mb-2"
            clearable
            label="Email"
            ></v-text-field>

            <v-text-field
            v-model="password"
            type="password"
            :readonly="loading"
            :rules="[passwordRules]"
            clearable
            label="Password"
            placeholder="Enter your password"
            ></v-text-field>

            <br>

            <v-btn
            :disabled="!form"
            :loading="loading"
            block
            color="success"
            size="large"
            type="submit"
            variant="elevated"
            >
            ログイン
            </v-btn>

            <v-alert
            dense
            text
            type="success"
            class="success-message"
            v-if="message"
            >
              {{ message }}
            </v-alert>

            <v-alert
            dense
            text
            type="error"
            class="success-message"
            v-if="errorMessage"
            >
              {{ errorMessage }}
            </v-alert>

        </v-form>
        </v-card>
    </v-sheet>
  </v-app>
</template>

<script>
import axios from 'axios';
  export default {
    data: () => ({
      form: false,
      emailInput: null,
      password: null,
      loading: false,
      message: null,
      errorMessage: null,
      email: window.localStorage.getItem('uid'),
      family_name: localStorage.getItem('family_name'), 
    }),

    methods: {
       async onSubmit () {
        if (!this.form) return
        this.loading = true

        setTimeout(() => (this.loading = false), 2000)

        try {
          const response = await axios.post('http://localhost:8000/auth/sign_in', { 
            email: this.emailInput,
            password: this.password
          })

          const accessToken = response.headers['access-token'];
          const client = response.headers['client'];
          const uid = response.headers['uid'];
          const family_name = response.data.data['family_name'];

          if (accessToken && client && uid) {
            window.localStorage.setItem('access-token', accessToken);
            window.localStorage.setItem('client', client);
            window.localStorage.setItem('uid', uid);
            window.localStorage.setItem('family_name', family_name);

            this.$emit('updateUser', { family_name, email: uid });
          }

          console.log({ response })

          this.$router.push('/articles')
          return response
          
        } catch (error) {
          console.error("Error:", error.response.data);
          localStorage.errorMessage = "ログインに失敗しました。"
          
        }
      },
      emailRules (v) {
        if (!v) return 'メールアドレスを入力してください。';
        if (/^[a-z.-]+@[a-z.-]+\.[a-z]+$/i.test(v)) return true;
        return '正しいメールアドレスを入力してください。';
      },
      passwordRules (v) {
        return !!v || 'パスワードを入力してください。'
      },
    },
    mounted() {
      if(localStorage.message) {
        this.message = localStorage.message
        localStorage.message = ''
      }
    }
  }
</script>
<style>
#signup.title {
    text-align: center;
}
.small-btn {
    padding: 0px 8px;   /* ボタンのパディングを調整してサイズを小さくします */
    font-size: 12px;   /* テキストのフォントサイズを変更します */
    margin: 12px;
    box-shadow: none !important;  /* ここでボタンのシャドウを削除 */
}
.success-message {
  margin-top: 20px
}
</style>