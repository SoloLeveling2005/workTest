
<script>
import axios from "axios";
import router from "@/router";
import Header from "@/components/Header.vue";

export default {
  components: {Header},
  data() {
    return {
      user:{
        authStatus:null,
        info:{},
      },
      news:{},
      newComment:'',
      assessmentStatus:false,
      assessmentCount:null
    }
  },
  created() {
    this.getNewsInfo()
    this.checkUserAuthorization()
  },
  methods: {
    getNewsInfo() {
      axios.get(`http://127.0.0.1:8000/api/news/${this.$route.params.newsId}/`, {
        headers:{
          "Content-Type":'multipart/form-data',
        }
      }).then(response=>{
        console.log(response)
        if (response.status === 200) {
          this.news = response.data.news
        }
      }).catch(error=>{
        console.log(error)
        if (error.response.status === 401) {
          localStorage.removeItem('token')
          this.userLogout()
          this.$refs.header.newNotification('Время аутентификации истекло','alert-danger');
          return router.push('/')
        }
        if (error.response.status === 400) {
          this.$refs.header.newNotification('Карточки не существует','alert-danger');
          return router.push('/')
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
        return this.getUserInfo(token)
      } else {
        this.user = {
          authStatus:false,
          info:{},
        }
      }
    },
    // Сохранение комментария
    saveComment() {
      axios.post(`http://127.0.0.1:8000/api/news/${this.$route.params.newsId}/comments/create`, {
        'text':this.newComment
      }, {
        headers:{
          Authorization:`Bearer ${localStorage.getItem('token')}`,
          "Content-Type":"application/json"
        }
      }).then(response=>{
        console.log(response)
        if (response.status === 201) {
          this.news.comments.push({
            'user_id':this.user.info.id,
            'text':this.newComment
          });
          this.newComment = ""
          return this.$refs.header.newNotification('Комментарий успешно добавлен','alert-success');
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
    // Удаление комментария
    deleteComment(comment_id) {
      axios.delete(`http://127.0.0.1:8000/api/news/${this.$route.params.newsId}/comments/${comment_id}/delete`, {
        headers:{
          Authorization:`Bearer ${localStorage.getItem('token')}`,
          "Content-Type":"application/json"
        }
      }).then(response=>{
        console.log(response)
        if (response.status === 200) {
          let comments = this.news.comments
          for (let commentIndex in comments) {
            if (comments[commentIndex].id === comment_id) {
              delete comments[commentIndex]
              break;
            }
          }
          this.news.comments = comments
          console.log(this.news.comments)
          return this.$refs.header.newNotification('Комментарий успешно удален','alert-success');
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
    changeAssessment() {
      axios.patch(`http://127.0.0.1:8000/api/news/${this.$route.params.newsId}/assessments/change`, {
      }, {
        headers:{
          Authorization:`Bearer ${localStorage.getItem('token')}`,
          "Content-Type":"application/json"
        }
      }).then(response=>{
        console.log(response)
        if (response.status === 201) {
          this.assessmentStatus = response.data.status
          this.assessmentCount = response.data.count
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


    //
    changeMenuStatus() {
      this.$refs.header.changeMenuStatus();
    },
    userLogout() {
      this.user = {
        authStatus:false,
        info:{},
      }
      this.assessmentStatus = null
    }
  }
}
</script>
<template>
  <Header page="newsView" :user="user" ref="header" @userLogoutH="userLogout"/>
  <section class="w-100 h-100 container pb-3" @click="changeMenuStatus()">
    <section class="w-75 ps-4 pb-4" v-if="news.title">
      <div class="mt-5">
        <div>
          <div class="d-flex align-items-center">
            <img class="me-2" src="@/assets/img/free-icon-user-149071.png" alt="" style="width: 30px;">
            <span class="me-1">{{news.author.login}}</span>
            <span style="opacity: .9">{{String(news.author.created_at).split('T')[0]}}</span>
          </div>
          <div class="mt-3">
            <h4 class="fw-bold fs-5" style="cursor:pointer;">{{news.title}}</h4>
          </div>
          <img class="w-75 mt-2" :src="'http://127.0.0.1:8000/'+news.img_url" alt="">
          <div class="mt-3 w-50">
            {{news.text}}
          </div>
        </div>
      </div>
      <div class="mt-4 d-flex align-items-center" style="opacity: .8;">
        <div class="d-flex align-items-center justify-content-center" style="margin-right: 35px;">
          <img style="width: 21px !important;cursor:pointer;" class="w-50 me-2" src="@/assets/img/free-icon-eye-159604.png" alt="" title="Просмотры">
          <span>{{news.wakes.length}}</span>
        </div>
        <div class="d-flex align-items-center justify-content-center" style=" margin-right: 35px;">
          <img v-if="assessmentStatus" @click="changeAssessment()" style="width: 20px !important; cursor:pointer;" class="w-50 me-2" src="@/assets/img/free-icon-like-126473-active.png" alt="" title="Оценки">
          <img v-if="!assessmentStatus" @click="changeAssessment()" style="width: 20px !important; cursor:pointer;" class="w-50 me-2" src="@/assets/img/free-icon-like-126473.png" alt="" title="Оценки">
          <span>{{(assessmentCount===null)?news.assessments.length:assessmentCount}}</span>
        </div>
        <div class="d-flex align-items-center justify-content-center" style="margin-right: 35px;">
          <img style="width: 20px !important; cursor:pointer;" class="w-50 me-2" src="@/assets/img/free-icon-comment-3193061.png" alt="" title="Комментарии">
          <span>{{news.comments.length}}</span>
        </div>
      </div>
      <div>
        <h5 class="mt-5 fs-5 fw-bold">Комментарии <span style="color: #548eaa;" class="fs-4">{{news.comments.length}}</span></h5>
        <div v-if="news.comments.length===0" class="fs-6 mt-3">
          Тут пока нет комментариев
        </div>
        <div v-if="news.comments.length>0">
          <div v-for="comment in news.comments" v-bind:key="news.comments[comment]">
            <div class="card my-2" v-if="comment">
              <div class="card-body d-flex justify-content-between align-items-center">
                <span>{{comment.text}}</span>
                <img v-if="comment.user_id === user.info.id" class="comment-delete" src="@/assets/img/free-icon-close-2976286.png" alt="" @click="deleteComment(comment.id)">
              </div>
            </div>
          </div>
        </div>
        <hr>
        <div>
          <h6>Ваш комментарий</h6>
          <textarea class="mt-2" placeholder="Комментарий" v-model="newComment"></textarea>
          <button class="btn send-comment-button" v-if="!newComment" disabled>Сохранить</button>
          <button class="btn send-comment-button" v-if="newComment" @click="saveComment()">Сохранить</button>
        </div>
      </div>
    </section>

  </section>
</template>
<style scoped>
a {
  text-decoration: none;
}
img {
  width: 100%;
}
textarea {
  width: 100%;
  height: 180px;
  outline: none;
  padding: 10px;
  font-size: 16px;
  resize: none;
}
.send-comment-button {
  border: 1px solid black;
  border-radius: 0;
  padding: 7px 20px;
  font-size: 14px;
}
.comment-delete {
  width: 25px;
  opacity: .6;
  padding: 5px;
  cursor: pointer;
  transition: .2s;
}
.comment-delete:hover {
  opacity: 1;
}

</style>