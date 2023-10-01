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
            @submit.prevent="onLogin"
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
            :disabled="onButton"
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
import { useStore } from 'vuex';
import { ref, computed, onMounted } from 'vue';

export default {
  setup() {
    const store = useStore();
    const form = ref(false);
    const emailInput = ref(store.state.emailInput);
    const password = ref(store.state.password);
    const loading = ref(false);
    const message = computed(() => store.state.message);
    const errorMessage = computed(() => store.state.errorMessage);
    const email = computed(() => store.state.email);
    const family_name = computed(() => store.state.family_name);
    const accessToken = computed(() => store.state.login.accessToken);
    const client = computed(() => store.state.onLogin.client);
    const onButton = computed(() => {
      // formの値に応じてloadingの状態を返す
      if (!emailInput.value || !password.value) {
        return true;
      }
      return loading.value;
    });
    // getters
    const shouldDisplayIcon = store.getters.shouldDisplayIcon;

    // actions
    const onLogin = () => {
      store.dispatch('onLogin');
      console.log('Login button clicked');
      console.log(form.value);
      console.log(loading.value);
    };
    // メールアドレスのバリデーションルール
    const emailRules = ref(v => {
      if (!v) return 'メールアドレスを入力してください。';
      if (/^[a-z.-]+@[a-z.-]+\.[a-z]+$/i.test(v)) return true;
      return '正しいメールアドレスを入力してください。';
    });

    // パスワードのバリデーションルール
    const passwordRules = ref(v => {
      return !!v || 'パスワードを入力してください。';
    });


    onMounted(() => {
      if (localStorage.message) {
        // Composition API内で`this`は使用されません。
        // 代わりに、直接変数やリアクティブな参照を使用します。
        // この場合、メッセージ変数が必要です。
        state.message = localStorage.message
        localStorage.message = ''
      }
    });

    return { form, emailInput, password, loading, message, errorMessage, email, family_name, accessToken, client, onButton, shouldDisplayIcon, onLogin, emailRules, passwordRules};
  },
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