<template>
  <Header page="login" ref="header" :user="user"/>
  <div class="w-100 h-100  d-flex align-items-center justify-content-center">
   <div class="w-50 h-50" v-if="mode==='login'">
     <h3 class="w-100 text-center mb-5">Авторизация</h3>

     <label for="" class="mt-3 mb-2 fs-5">Логин</label>
     <input type="text" class="form-control border-2 border-dark" v-model="login">
     <label for="" class="mt-3 mb-2 fs-5">Пароль</label>
     <input type="password" class="form-control border-2 border-dark" v-model="password">

     <button class="btn btn-success w-100 mt-4" @click="loginH()">Вход</button>
     <div class="w-100 mt-2 text-center" style="cursor: pointer;" @click="mode='register'">Еще не зарегистрировался?</div>
   </div>
    <div class="w-50 h-50" v-if="mode==='register'">
      <h3 class="w-100 text-center mb-5">Регистрация</h3>

      <label for="" class="mt-3 mb-2 fs-5">Логин</label>
      <input type="text" class="form-control border-2 border-dark" v-model="login">
      <label for="" class="mt-3 mb-2 fs-5">Пароль</label>
      <input type="password" class="form-control border-2 border-dark" v-model="password">
      <label for="" class="mt-3 mb-2 fs-5">Повторите пароль</label>
      <input type="password" class="form-control border-2 border-dark" v-model="repeatPassword">

      <button class="btn btn-success w-100 mt-4" @click="registerH()">Регистрация</button>
      <div class="w-100 mt-2 text-center" style="cursor: pointer;" @click="mode='login'">Авторизоваться</div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import router from "@/router";
import Header from "@/components/Header.vue";
export default {
  data() {
    return {
      mode:'login',
      login:'',
      password:'',
      repeatPassword:'',
      user:{
        authStatus:false,
        info:{},
      }
    }
  },
  components:{
    // eslint-disable-next-line vue/no-reserved-component-names
    Header
  },
  created() {
    this.checkUserAuthorization()
  },
  methods:{
    // Получить ифнормацию о пользователе.
    getUserInfo(token) {
      axios.get('http://127.0.0.1:8000/api/user/info', {
        headers:{
          Authorization:`Bearer ${token}`,
          "Content-Type":"application/json"
        }
      }).then(response=>{
        if (response.status === 200) {
          this.user.info = response.data
          this.user.authStatus = true
        }
        console.log(response)
      }).catch(error=>{
        console.log(error)
      })
    },
    // Проверка на авторизацию
    checkUserAuthorization() {
      let token = localStorage.getItem('token')
      // Проверяем на установленный токен
      if (token) {
        // Делаем запрос на получение информации о пользователе
        this.getUserInfo(token)
      }
    },
    loginH() {
      if (this.login === '' || this.password === '') {
        return this.$refs.header.newNotification('Поля не заполнены','alert-danger');
      }
      axios.post('http://127.0.0.1:8000/api/user/login', {
        login:this.login,
        password:this.password
      }, {}).then(response=>{
        console.log(response)
        if (response.status === 200) {
          let token = response.data.token
          localStorage.setItem('token', token)
          this.$refs.header.newNotification('Вы успешно авторизовались','alert-success');
          return router.push('/')
        }
      }).catch(error=>{
        console.log(error)
        if (error.response.status === 404) {
          return this.$refs.header.newNotification(error.response.data.message,'alert-danger');
        }
      })
    },
    registerH(){
      if (this.login === '' || this.password === '' || this.repeatPassword === '') {
        return this.$refs.header.newNotification('Поля не заполнены','alert-danger');
      }
      if (this.password !== this.repeatPassword) {
        return this.$refs.header.newNotification('Пароли не совпадают','alert-danger');
      }
      axios.post('http://127.0.0.1:8000/api/user/register', {
        login:this.login,
        password:this.password
      }, {}).then(response=>{
        console.log(response)
        if (response.status === 201) {
          return this.loginH()
        }
      }).catch(error=>{
        console.log(error)
        if (error.response.status === 422) {
          return this.$refs.header.newNotification('Пользователь с такими данными уже сущестует','alert-danger');
        }
      })
    },

  }
}
</script>
<style scoped>

</style>