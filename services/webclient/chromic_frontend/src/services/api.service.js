import axios from 'axios'

const ApiService = {

  init() {
    axios.defaults.baseURL = import.meta.env.VITE_APP_BASE_URL + import.meta.env.VITE_APP_BASE_API
  },

  post(resource, data) {
    return axios.post(resource, data)
  },

  customRequest(data) {
    return axios(data)
  }
};

export default ApiService
