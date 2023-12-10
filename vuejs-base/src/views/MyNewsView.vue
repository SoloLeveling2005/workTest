<script>
import axios from "axios";
import router from "@/router";
import Header from "@/components/Header.vue";

export default {
  data() {
    return {
      newsList:[],
      paginate:{
        pagesCount:0,
        currentPage:1
      },
      user:{
        authStatus:null,
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
    this.getNewsList()
  },
  methods:{
    // Смена страницы
    changePage(page) {
      if (page!==this.paginate.currentPage) {
        this.paginate.currentPage = page
        this.getNewsList()
      }
    },
    // Получение всех новостей
    getNewsList() {
      axios.get(`http://127.0.0.1:8000/api/news/myList?page=${this.paginate.currentPage}`, {
        headers:{
          Authorization:`Bearer ${localStorage.getItem('token')}`,
          "Content-Type":"application/json"
        }
      }).then(response=>{
        console.log(response)
        if (response.status === 200) {
          this.newsList = response.data.data
          this.paginate.pagesCount = response.data.last_page
          this.paginate.currentPage = response.data.current_page
        }
      }).catch(error=>{
        console.log(error)
        if (error.response.status === 401) {
          localStorage.removeItem('token')
          this.userLogout()
          return router.push({name:'login'})
        }
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
        if (error.response.status === 401) {
          localStorage.removeItem('token')
          this.userLogout()
          return this.$refs.header.newNotification('Время аутентификации истекло','alert-danger');
        }
      })
    },
    // Проверка на авторизацию
    checkUserAuthorization() {
      let token = localStorage.getItem('token')
      // Проверяем на установленный токен
      if (token) {
        // Делаем запрос на получение информации о пользователе
        this.getUserInfo(token)
      } else {
        this.user = {
          authStatus:false,
          info:{},
        }
      }
    },
    // Удаление новости
    newsDelete(news_id) {
      axios.delete(`http://127.0.0.1:8000/api/news/${news_id}/delete`, {
        headers:{
          Authorization:`Bearer ${localStorage.getItem('token')}`,
          "Content-Type":"application/json"
        }
      }).then(response=>{
        console.log(response)
        if (response.status === 200) {
          this.getNewsList()
          return this.$refs.header.newNotification('Новость успешно удалена','alert-success');
        }
      }).catch(error=>{
        console.log(error)
        if (error.response.status === 401) {
          localStorage.removeItem('token')
          this.userLogout()
          return this.$refs.header.newNotification('Время аутентификации истекло','alert-danger');
        }
      })
    },

    //
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
    <Header page="myNews" :user="user" ref="header" @userLogoutH="userLogout"/>
    <div class="container">
      <div class="mx-4 mb-4 pb-5">
        <h3 class="mt-4 fw-bold fs-4">Лента</h3>
        <section class="my-5" v-if="newsList.length === 0">
          <h5>Пока тут нет новостей. {{user.authStatus?'Вы можете добавить свою новость в своем личном кабинете.':'Вы можете добавить свою новость авторизовавшись и войдя в личный кабинет.'}}</h5>
        </section>
        <template v-for="news in newsList" v-bind:key="news">
          <section>
            <div class="mt-5">
              <div>

                <div class="mt-3">
                  <h4 class="fw-bold fs-5" style="cursor:pointer;">{{news.title}}</h4>
                </div>
                <img class="w-50 mt-2" :src="'http://127.0.0.1:8000/'+news.img_url" alt="">
                <div class="mt-3 w-50">
                  {{news.text}}
                </div>
                <router-link :to="{name:'news', params:{newsId:news.id}}" class="btn mt-3" style="border: 1.5px solid #548eaa !important; color: #548eaa; font-size: 14px; border-radius: 3px;">Читать далее</router-link>
                <button class="btn mt-3 ms-3" style="border: 1.5px solid red !important; color: red; font-size: 14px; border-radius: 3px;" @click="newsDelete(news.id)">Удалить новость</button>

              </div>
            </div>
            <div class="mt-4 d-flex align-items-center" style="opacity: .8;">
              <div class="d-flex align-items-center justify-content-center" style="cursor:pointer; margin-right: 35px;">
                <img style="width: 21px !important;" class="w-50 me-2" src="@/assets/img/free-icon-eye-159604.png" alt="">
                <span>{{news.wakes.length}}</span>
              </div>
              <div class="d-flex align-items-center justify-content-center" style="cursor:pointer; margin-right: 35px;">
                <img style="width: 20px !important;" class="w-50 me-2" src="@/assets/img/free-icon-like-126473.png" alt="">
                <span>{{news.assessments.length}}</span>
              </div>
              <div class="d-flex align-items-center justify-content-center" style="cursor:pointer; margin-right: 35px;">
                <img style="width: 20px !important;" class="w-50 me-2" src="@/assets/img/free-icon-comment-3193061.png" alt="">
                <span>{{news.comments.length}}</span>
              </div>
            </div>
          </section>
        </template>
        <ul class="pagination mt-4 d-flex justify-content-end" v-if="this.paginate.pagesCount>1">
          <li class="page-item disabled" v-if="paginate.currentPage === 1"><a class="page-link" href="#">Previous</a></li>
          <li style="cursor: pointer;" class="page-item" v-if="paginate.currentPage !== 1" @click="changePage(paginate.currentPage-1)"><a class="page-link" href="#">Previous</a></li>
          <li class="page-item" v-for="page in this.paginate.pagesCount" style="cursor: pointer;">
            <a class="page-link active" v-if="page===paginate.currentPage">{{page}}</a>
            <a class="page-link" v-if="page!==paginate.currentPage" @click="changePage(page)">{{page}}</a>
          </li>
          <li class="page-item disabled"><a class="page-link" v-if="this.paginate.pagesCount === paginate.currentPage">Next</a></li>
          <li style="cursor: pointer;" class="page-item"><a class="page-link" v-if="this.paginate.pagesCount !== paginate.currentPage" @click="changePage(paginate.currentPage+1)">Next</a></li>
        </ul>
      </div>
    </div>

  </section>

</template>
<style scoped>

</style>