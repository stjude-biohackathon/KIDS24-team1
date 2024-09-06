import { defineStore } from 'pinia'
import AppService from '@/services/app.service'

export const useAppStore = defineStore('app', {
    state: () => ({
        sampleSjuid: '',
        subjectSjuid: '',
        tbNumber: '',
        compBioId: '',
        assay: [],
        bulkTbNumber: [],
        bulkSampleSjuid: [],
        bulkSubjectSjuid: [],
        bulkErrorRecords: [],
        // file stuff
        fnames: undefined,
        uploadedFile: [],
        uploadTbNumberCount: 0,
        // uploadSampleSjuidCount: 0,
        // uploadSubjectSjuidCount: 0,
        // uploadErrorCount: 0,
        errorMessages: {
            data_preview: [],
            file_upload: []
        }
    }),
    getters: {
        getTbNumberCount(state){
            return state.bulkTbNumber.length
        },
        // uploadSampleSjuidCount(state){
        //     return state.bulkSampleSjuid.length
        // },
        // uploadSubjectSjuidCount(state){
        //     return state.bulkSubjectSjuid.length
        // },
        // uploadErrorCount(state){
        //     return state.bulkErrorRecords.length
        // },
    },
    actions: {
        resetState() {
            this.sampleSjuid = ''
            this.subjectSjuid = ''
            this.tbNumber = ''
            this.compBioId = ''
            this.assay = []
            this.bulkTbNumber = []
            this.bulkSampleSjuid = []
            this.bulkSubjectSjuid = []
            this.bulkErrorRecords = []
            this.fnames = undefined
            this.uploadedFile = []
            // this.uploadTbNumberCount = 0
            // this.uploadSampleSjuidCount = 0
            // this.uploadSubjectSjuidCount = 0
            // this.uploadErrorCount = 0
        },
        setSampleSjuid(sampleSjuid) {
            this.sampleSjuid = sampleSjuid.toUpperCase()
        },
        setSubjectSjuid(subjectSjuid) {
            this.subjectSjuid = subjectSjuid.toUpperCase()
        },
        setTbNumber(tbNumber) {
            this.tbNumber = tbNumber.toUpperCase()
        },
        setCompBioId(compBioId) {
            this.compBioId = compBioId.toUpperCase()
        },
        setAssay(assay){
            this.assay = assay
        },
        setBulkTbNumber(list){
            this.bulkTbNumber = list
        },
        setBulkSampleSjuid(list){
            this.bulkSampleSjuid = list
        },
        setBulkSubjectSjuid(list){
            this.bulkSubjectSjuid = list
        },
        setBulkErrorRecords(list){
            this.bulkErrorRecords = list
        },
        setFnames(list){
            this.fnames = list
        },
        setUploadedFile(list){
            this.uploadedFile = list
        },

        setUploadTbNumberCount(){
            // console.log(this.bulkTbNumber.length)
            this.uploadTbNumberCount = this.bulkTbNumber.length
        },
        setUploadSampleSjuidCount(cnt){
            this.uploadSampleSjuidCount = cnt
        },
        setUploadSubjectSjuidCount(cnt){
            this.uploadSubjectSjuidCount = cnt
        },
        setUploadErrorCount(cnt){
            this.uploadErrorCount = cnt
        },
        fileChange (file){
            this.errorMessages.data_preview = []
            this.errorMessages.file_upload = []
            let tb_numbers = []
            let sample_sjuids = []
            let subject_sjuids = []
            let error_records = []
            if (file.target.files[0]) {
                let reader = new FileReader()
                reader.readAsText(file.target.files[0])
                reader.onload = function () {
                    if (reader.result && typeof reader.result === 'string') {
                        this.uploadedFile = reader.result.replace(/\r/g, '').split('\n')
                        for (let index = 0; index < this.uploadedFile.length; index++) {
                            this.uploadedFile[index] = this.uploadedFile[index].split(',')
                            this.uploadedFile[index].forEach(function (part, index, array) {
                                array[index] = part.trim()
                            })
                            if(AppService.checkTbString(this.uploadedFile[index][0])) {
                                tb_numbers.push(this.uploadedFile[index][0])
                                // maybe update tb number list?
                            } else if (AppService.checkSjuidString(this.uploadedFile[index][0],11)) {
                                sample_sjuids.push(this.uploadedFile[index][0])
                            } else if (AppService.checkSjuidString(this.uploadedFile[index][0],9)) {
                                subject_sjuids.push(this.uploadedFile[index][0])
                            } else {
                                error_records.push(this.uploadedFile[index][0])
                            }
                        }
                    }
                }
                reader.onerror = function () {
                    // errorMessages.value.file_upload.push(String(reader.error))
                    console.log(String(reader.error))
                }
                this.setBulkTbNumber(tb_numbers)
                this.setUploadTbNumberCount()
                this.setBulkSampleSjuid(sample_sjuids)
                this.setBulkSubjectSjuid(subject_sjuids)
                this.setBulkErrorRecords(error_records)
            } else {
                // errorMessages.value.data_preview = []
                // errorMessages.value.file_upload = []
                // uploadedFile.value = []
                this.setUploadedFile([])
            }
        }
    },
})