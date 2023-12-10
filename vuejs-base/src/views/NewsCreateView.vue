<script>
import axios from "axios";
import router from "@/router";
import Header from "@/components/Header.vue";

export default {
  components: {Header},
  data() {
    return {
      title:'',
      text:'',
      user:{
        authStatus:null,
        info:{},
      }
    }
  },
  created() {
    this.checkUserAuthorization()
  },
  methods:{
    createNews() {
      if (this.title.trim() === '' || this.text.trim() === '') {
        return this.$refs.header.newNotification('Поля не заполнены','alert-warning');
      }

      let fileInput = document.querySelector("#img-file");
      let file = fileInput.files[0];

      axios.post('http://127.0.0.1:8000/api/news/create', {
        'title':this.title,
        'text':this.text,
        'img':file,
      }, {
        headers:{
          Authorization:`Bearer ${localStorage.getItem('token')}`,
          "Content-Type":'multipart/form-data',
        }
      }).then(response=>{
        if (response.status === 200) {
          router.push({ path: '/' })
          this.$refs.header.newNotification('Новость успешно создана','alert-success');
        }
      }).catch(error=>{
        console.log(error)
        if (error.response.status === 401) {
          localStorage.removeItem('token')
          this.userLogout()
          this.$refs.header.newNotification('Время аутентификации истекло','alert-danger');
          return router.push('/')
        }
        return this.$refs.header.newNotification('Не все поля были заполнены корректно','alert-warning');
      })
    },
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

    // Header component
    changeMenuStatus() {
      this.$refs.header.changeMenuStatus();
    },
    userLogout() {
      this.user = {
        authStatus:false,
        info:{},
      }
    }
  }
}
</script>
<template>
  <section @click="changeMenuStatus()" class="w-100 h-100">
    <Header page="newsCreate" :user="user" ref="header" @userLogoutH="userLogout"/>
    <div class="container">
      <div class="w-75">
        <div class="mx-4 mb-4">
          <h3 class="mt-4 fw-bold fs-4 mb-5">Создание новости</h3>
          <div class="ps-4">
            <div class="mb-3">
              <img src="@/assets/img/free-icon-user-149071.png" alt="" style="width: 30px;">
              <span class="ms-2">{{user.info.login}}</span>
            </div>
            <input v-model="title" type="text" class="input" placeholder="Заголовок">
            <textarea v-model="text" placeholder="Текст новости"></textarea>
            <hr>
            <h5 class="mb-3">Выберите картинку</h5>
            <input type="file" class="form-control" id="img-file">
            <button class="btn btn-primary mt-3 w-100" @click="createNews()">Сохранить</button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.input {
  width: 100%;
  padding: 10px;
  font-size: 30px;
  outline: none;
  border: 0;
}
textarea {
  width: 100%;
  height: 400px;
  outline: none;
  border: 0;
  padding: 10px;
  font-size: 20px;
  resize: none;
}
#img-file {
  border: 2px solid black;
}
</style>