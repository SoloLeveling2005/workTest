<script>
import axios from "axios";
import router from "@/router";

export default {
  // eslint-disable-next-line vue/multi-word-component-names,vue/no-reserved-component-names
  name:"Header",
  props:{
    page:String,
    user:Object,
    userLogoutH:Function
  },
  data(){
    return {
      notifications:[],
      menuStatus:false
    }
  },
  created() {

  },
  methods:{
    changeMenuStatus() {
      this.menuStatus = false
    },
    newNotification(message, status) {
      this.notifications.push({
        message:message,
        status:status
      })
      setTimeout(()=>{
        this.notifications.pop()
      }, 4000)
    },
    userLogout() {
      axios.post('http://127.0.0.1:8000/api/user/logout', {
        headers:{
          Authorization:`Bearer ${localStorage.getItem('token')}`,
          "Content-Type":"application/json"
        }
      }).then(response=>{
        if (response.status === 201) {
          localStorage.removeItem('token')
          return router.push('/')
        }
        console.log(response)
      }).catch(error=>{
        if (error.response.status === 401) {
          localStorage.removeItem('token')
          this.newNotification('Авторизация истекла','alert-info');
          this.$emit('userLogoutH')
        }
      })
    }
  }
}
</script>

<template>
  <div class="w-100 bg-303b44 text-white" @click="changeMenuStatus()">
    <div class="container py-2">
      <router-link to="/" class="fs-3 text-white">News</router-link>
    </div>
  </div>
  <div class="shadow" v-if="page !== 'login'" @click="changeMenuStatus()">
    <div class="container py-2 d-flex align-items-center justify-content-between">
      <div>
        <router-link to="/" :class="'fw-normal me-4 text-dark '" :style="'cursor:pointer; '+(page==='home'?'':'opacity:.9;')">Лента</router-link>
      </div>
      <div class="d-flex align-items-center" v-if="user.authStatus !== null">
        <div v-if="user.authStatus" class="position-relative">
          <img class="py-1" style="width: 30px; cursor:pointer;" src="@/assets/img/free-icon-user-149071.png" alt="" @click.stop="menuStatus=true">
          <div class="position-absolute card end-0 mt-1 py-3" @click.stop="" v-if="menuStatus">
            <router-link :to="{name:'myNews'}" class="menu-elem">Мои новости</router-link>
            <router-link :to="{name:'newsCreate'}" class="menu-elem">Создать новость</router-link>
            <div class="menu-elem exit" @click="userLogout()">Выход</div>
          </div>
        </div>
        <router-link v-if="!user.authStatus" :to="{name:'login'}" class="btn bg-548eaa text-white py-2 px-4" style="font-size: 14px">Войти</router-link>
      </div>
    </div>
  </div>
  <div class="w-100 d-flex justify-content-center" style="position: fixed; bottom:0;">
    <div class="w-75 d-flex justify-content-end">
      <div class="mt-2 w-25">
        <template v-for="notification in notifications" v-bind:key="notification" >
          <div :class="'w-100 alert '+(notification.status)">
            {{notification.message}}
          </div>
        </template>
      </div>
    </div>
  </div>
</template>

<style scoped>
.menu-elem {
  cursor: pointer;
  width: 250px;
  padding: 10px 15px;
  transition: .4s;
  color: black;
}
.menu-elem:hover {
  color: #548eaa;
}
.exit:hover {
  color: red !important;
}
</style>
