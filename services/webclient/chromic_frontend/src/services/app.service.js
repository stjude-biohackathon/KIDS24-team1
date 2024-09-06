import ApiService from '@/services/api.service'

const dataURL = import.meta.env.VITE_APP_BASE_URL + import.meta.env.VITE_APP_BASE_API


class AppError extends Error {
    constructor(errorCode, message) {
        super(message);
        this.name = this.constructor.name;
        this.message = message;
        this.errorCode = errorCode;
    }
}

const endpoints = {
    getFilterValues: '/filtervalues/',
    getSamples: '/listsamples/'
}

const AppService = {
    getFilterValues: async function (data) {
        try {
            const requestData = {
                method: 'post',
                url: dataURL + endpoints.getFilterValues,
                data: data
            }
            const response = await ApiService.customRequest(requestData)
            return response.data
        } catch (error) {
            throw new AppError(error.response.status, error.response.data)
        }
    },
    getSampleData: async function (query, data) {
        try {
            const requestData = {
                method: 'post',
                url: dataURL + endpoints.getSamples + query,
                data: data
            }
            const response = await ApiService.customRequest(requestData)
            return response.data
        } catch (error) {
            throw new AppError(error.response.status, error.response.data)
        }
    },
    checkTbString: function (str) {
        return str.startsWith('TB') && (str.length === 10 || str.length === 11)
    },
    checkSjuidString: function (str, len) {
        return str.startsWith('SJH') && str.length === len
    }
}

export default AppService
export {AppService, AppError}