import ApiService from '@/services/api.service'
import App from './App.vue'
import router from '@/router'
import {createApp} from 'vue'
import {createPinia} from 'pinia'
import {registerPlugins} from '@/plugins'

// Initialize the ApiService
ApiService.init()

// Create the app instance
const pinia = createPinia()
const app = createApp(App)
app.use(router)
app.use(pinia)

// Register global components, directives, and plugins
registerPlugins(app)

// Mount the app
app.mount('#app')
