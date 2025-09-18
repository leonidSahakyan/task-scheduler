import axios from 'axios'
import qs from 'qs'
import { useUserStore } from '@/stores/userStore'
import router from '@/router'
import { useToast, POSITION } from 'vue-toastification'

const toast = useToast()

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL + '/api/',
  paramsSerializer: (params) => qs.stringify(params, { arrayFormat: 'repeat' }),
})

api.interceptors.request.use((config) => {
  const userStore = useUserStore()

  if (config.headers?.['skipAuthInterceptor']) {
    return config
  }

  if (!userStore.isLoggedIn) {
    return Promise.reject(new axios.Cancel('User logged out'))
  }

  if (userStore.accessToken) {
    config.headers.Authorization = `Bearer ${userStore.accessToken}`
  }

  return config
})

api.interceptors.response.use(
  (response) => response,
  (error) => {
    const userStore = useUserStore()

    if (error.config?.headers?.['skipAuthInterceptor']) {
      return Promise.reject(error)
    }

    if (!userStore.isLoggedIn) {
      return Promise.reject(new axios.Cancel('User logged out'))
    }

    if (error.response?.status === 401) {
      userStore.logout()
      router.push('/login')
    }

    toast.error(error.response?.data?.message || 'Something went wrong. Please try again.', {
      icon: false,
      position: POSITION.TOP_CENTER,
      timeout: 3000,
      closeOnClick: true,
      hideProgressBar: true,
    })

    return Promise.reject(error)
  },
)

export default api
