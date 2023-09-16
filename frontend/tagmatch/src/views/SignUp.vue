<template>
  <v-app>
    <v-sheet class="bg-light-green-lighten-5 pa-12" rounded>
      <div id="signup" class="title">
          <h1 class="text-h3">新規作成</h1>
      </div>
      <div id="signup" class="title">
        <v-btn class="small-btn" text color="light-green-lighten-5" to="sign_in">ログインはこちら</v-btn>
      </div>  
      <v-card class="mx-auto px-6 py-8" max-width="470">
        <v-form v-model="form" @submit.prevent="onSubmit">
            
          <v-row>
            <!-- Family Name & Family Name Kana -->
            <v-col cols="6">
              <v-text-field
                v-model="family_name"
                :readonly="loading"
                :rules="[nameRules]"
                class="mb-2"
                clearable
                label="姓"
              ></v-text-field>

              <v-text-field
                v-model="family_name_kana"
                :readonly="loading"
                :rules="[nameKanaRules]"
                class="mb-2"
                clearable
                label="姓(カタカナ)"
              ></v-text-field>
            </v-col>

            <!-- Given Name & Given Name Kana -->
            <v-col cols="6">
              <v-text-field
                v-model="given_name"
                :readonly="loading"
                :rules="[nameRules]"
                class="mb-2"
                clearable
                label="名"
              ></v-text-field>

              <v-text-field
                v-model="given_name_kana"
                :readonly="loading"
                :rules="[nameKanaRules]"
                class="mb-2"
                clearable
                label="名(カタカナ)"
              ></v-text-field>
            </v-col>
          </v-row>

          <v-text-field
            v-model="email"
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
            :rules="[passwordRule]"
            clearable
            label="Password"
            placeholder="Enter your password"
          ></v-text-field>

          <v-text-field
            v-model="passwordConfirmation"
            type="password"
            :readonly="loading"
            :rules="[passwordRules]"
            clearable
            label="Password(確認用)"
            placeholder="Enter your password"
          ></v-text-field>

          <v-radio-group  
            inline 
            v-model="sex"
            :rules="[requiredRule]">
              <v-radio label="男" value="male"></v-radio>
              <v-radio label="女" value="female"></v-radio>
          </v-radio-group>

          <div class="mb-2">- 生年月日 -</div>
          <v-row>
            <v-col cols="6">
              <v-select 
                label="西暦" 
                :rules="[requiredRule]"
                :items="years" 
                v-model="year" 
                @change="resetDay" 
                filled dense>
              </v-select>
            </v-col>
            <v-col cols="3">
              <v-select 
                label="月" 
                :rules="[requiredRule]"
                :items="months" 
                v-model="month" 
                @change="resetDay" 
                filled dense>
              </v-select>
            </v-col>
            <v-col cols="3">
              <v-select label="日" 
                :items="days" 
                :rules="[requiredRule]"
                v-model="day" 
                filled dense>
              </v-select>
            </v-col>
          </v-row>
          
          <div class="mb-2">- 役割 -</div>
          <v-radio-group  
            inline 
            v-model="role"
            :rules="[requiredRule]">
              <v-radio label="一般" value="external_coach"></v-radio>
              <v-radio label="教員" value="club_advisor"></v-radio>
          </v-radio-group>

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
            Sign up
          </v-btn>

          <v-alert
            dense
            outlined
            type="error"
            class="error-message"
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
    email: '@example.com',
    password: null,
    passwordConfirmation: '',
    loading: false,
    family_name: '',
    given_name: '',
    family_name_kana: '',
    given_name_kana: '',
    suspended: false,
    // 生年月日用のデータプロパティ
    year: '',
    month: '',
    day: '',
    sex: '',
    birthday: '',
    role: '',
    message: null,
  }),

  methods: {
    async onSubmit() {
      if (!this.form) return;

      this.loading = true;

      setTimeout(() => (this.loading = false), 2000);

      const userData = {
        family_name: this.family_name,
        family_name_kana: this.family_name_kana,
        given_name: this.given_name,
        given_name_kana: this.given_name_kana,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation,
        sex: this.sex,
        birthday: `${this.year}-${this.month}-${this.day}`,
        role: this.role
      };
      console.log(this.email, this.family_name);

      try {
        const response = await axios.post('http://localhost:8000/auth', { user: userData });
        if (response.data.status === 'ok') {
          // 登録成功時の処理
          alert('登録完了！');
        }

        localStorage.message = "新規作成に成功しました。"

        // TOPにリダイレクト
        this.$router.push('/auth/sign_in')
      } catch (error) {
        // エラーハンドリング
        console.error("Error:", error.response.data);

        this.errorMessage = 'ユーザーの新規作成に失敗しました。'

      } finally {
        this.loading = false;
      }
    },
    emailRules(v) {
      if (!v) return 'メールアドレスを入力してください。';
      if (/^[a-z.-]+@[a-z.-]+\.[a-z]+$/i.test(v)) return true;
      return '正しいメールアドレスを入力してください。';
    },
    passwordRule(v) {
      return !!v || 'パスワードを入力してください。';
    },
    nameRules(v) {
      return !!v || '名前を入力してください。';
    },
    nameKanaRules(v) {
      if (!v) return '名前を入力してください。';
      if (!/^[\u30A0-\u30FF]+$/g.test(v)) return 'カタカナで入力してください。'; 
      return true;
    },
    requiredRule(v) {
      return !!v || 'この項目は必須です。';
    },
    passwordRules(v) {
      if (v !== this.password) return 'パスワードが一致しません。';
      return !!v || 'この項目は必須です。';
    },
    // 生年月日用のメソッド
    resetDay() {
      this.day = '';
    },
  },

  computed: {
    // 生年月日用の計算プロパティ
    years() {
      const currentYear = new Date().getFullYear();
      const startYear = currentYear - 18;
      const years = []
      for (let year = startYear; year >= 1900; year--) {
        years.push(year)
      }
      return years
    },

    months() {
      return [...Array(12)].map((_, i) => i + 1);
    },
    days() {
      if (this.year && this.month) {
        return [...Array(new Date(this.year, this.month, 0).getDate())].map(
          (_, i) => i + 1
        );
      }
      return [];
    },
  },

  mounted() {
    if(localStorage.errorMessage) {
      this.errorMessage = localStorage.errorMessage
      localStorage.errorMessage = ''
    }
  }
};
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
.error-message {
  margin-top: 20px
}
</style>