<template>
  <v-container
      class="mx-auto mt-8"
      :fluid="true"
  >
    <v-responsive
        class="align-centerfill-height mx-auto mt-n16"
        max-width="1300"
    >
      <div class="text-center">
        <v-img
            v-if="currentTheme === 'light'"
            src="@/assets/Frame%2019.svg"
            height="200"
        />
        <v-img
            v-else
            src="@/assets/Frame%2020.svg"
            height="200"
        />
      </div>
      <v-row>
        <v-col cols="12">
          <v-card
              class="py-4 custom-outlined-card"
              rounded="lg"
              variant="outlined"
          >
            <template v-slot:title>
              <div class="tag-container">
                <h2 class="text-h5 font-weight-bold">Get Started</h2>
                <span class="push-end mr-4 side-by-side-container">
                <v-btn
                    prepend-icon="$openInNew"
                    variant="tonal"
                    color="primary"
                    @click="navigateToDataView"
                >Data View</v-btn>
                <v-btn
                    color="primary"
                    variant="tonal"
                    @click="resetFields"
                >
          Reset
          <v-icon class="pl-1" icon="$refresh" size="x-large"/>
        </v-btn>
              </span>
              </div>
            </template>
            <template v-slot:subtitle>
              <div class="text-subtitle-1">
                Start exploring the interface by searching <strong>sample SJUID</strong>, <strong>subject SJUID</strong>,
                <strong>TB number</strong>, or <strong>assay (shows below
                as assay(total)</strong>.<br>You can also upload a .csv file with your identifiers.
              </div>
            </template>
            <template v-slot:text>
              <v-row>
                <v-col>
                  <v-text-field
                      :disabled="selectedFilterValues.length > 0 || fnames"
                      density="comfortable"
                      label="Sample SJUID"
                      v-model="sampleSjuid"
                      type="text"
                      @keydown="spacePrevent"
                  />
                  <v-text-field
                      :disabled="selectedFilterValues.length > 0 || fnames"
                      density="comfortable"
                      label="Subject SJUID"
                      v-model="subjectSjuid"
                      type="text"
                      @keydown="spacePrevent"
                  />
                </v-col>
                <v-col>
                  <v-text-field
                      :disabled="selectedFilterValues.length > 0 || fnames"
                      density="comfortable"
                      label="TB Number"
                      v-model="tbNumber"
                      type="text"
                      @keydown="spacePrevent"
                  />
                  <v-text-field
                      :disabled="selectedFilterValues.length > 0 || fnames"
                      density="comfortable"
                      label="Compbio ID"
                      v-model="compBioId"
                      type="text"
                      @keydown="spacePrevent"
                  />
                </v-col>
                <v-col>
                  <ol class="ml-4">
                    <li>Only .csv files can be uploaded.</li>
                    <li>Please place your identifiers in the first column only. All other columns are ignored.</li>
                    <li>You may include a mix of <strong>Sample SJUID</strong>, <strong>Subject SJUID</strong>, or
                      <strong>TB Number</strong>.

                    </li>
                  </ol>
                  <v-file-input
                      :disabled="selectedFilterValues.length > 0 || tbNumber.length > 0 || sampleSjuid.length > 0 || subjectSjuid.length > 0"
                      accept=".csv"
                      :clearable="false"
                      :counter="true"
                      :error-count="errorMessages.file_upload.length"
                      :error-messages="errorMessages.file_upload"
                      label="Upload File"
                      show-size
                      truncate-length="999"
                      variant="underlined"
                      v-model="fnames"
                      @change="fileChange"
                  />
                </v-col>
              </v-row>
              <div class="line-container">
                <span class="line"></span>
                <span class="or-text">or</span>
                <span class="line"></span>
              </div>

              <v-row>
                <v-col cols="3" v-for="filterValue in filterValues" :key="filterValue.assay" :id="filterValue.assay">
                  <div v-if="tbNumber.length > 0 || sampleSjuid.length > 0 || subjectSjuid.length > 0"
                       class="ml-4 mr-4 fake-button-nocursor"
                       :id="filterValue.assay + '-div-id'"
                  >
                    <span :id="filterValue.assay + '-span-id'" class="ml-2">{{
                        filterValue.assay
                      }} ({{ filterValue.total }})</span>
                  </div>
                  <div
                      v-else
                      class="ml-4 mr-4 fake-button"
                      @click="toggleAssaySelection(filterValue.assay)"
                      :id="filterValue.assay + '-div-id'"
                  >
                    <span :id="filterValue.assay + '-span-id'" class="ml-2">{{
                        filterValue.assay
                      }} ({{ filterValue.total }})</span>
                  </div>
                </v-col>
              </v-row>
            </template>
          </v-card>
        </v-col>
        <v-col cols="6">
          <v-card
              append-icon="mdi-open-in-new"
              class="py-4"
              color="surface-variant"
              href="https://github.com/stjude-biohackathon/KIDS24-team1/wiki"
              prepend-icon="$textbox"
              rel="noopener noreferrer"
              rounded="lg"
              subtitle="Learn more about Chromic."
              target="_blank"
              title="Documentation"
              variant="text"
          >
            <v-overlay
                opacity=".06"
                scrim="primary"
                contained
                model-value
                persistent
            />
          </v-card>
        </v-col>
        <v-col cols="6">
          <v-card
              append-icon="mdi-open-in-new"
              class="py-4"
              color="surface-variant"
              href="https://stjude.enterprise.slack.com/archives/C07L2ND956F"
              prepend-icon="$slack"
              rel="noopener noreferrer"
              rounded="lg"
              subtitle="Connect with other Chromic users on Slack."
              target="_blank"
              title="Community"
              variant="text"
          >
            <v-overlay
                opacity=".06"
                scrim="primary"
                contained
                model-value
                persistent
            />
          </v-card>
        </v-col>
      </v-row>
    </v-responsive>
  </v-container>
</template>

<script setup>
import {computed, onBeforeMount, onMounted, onUnmounted, ref} from 'vue'
import {useTheme} from 'vuetify'
import {useAppStore} from '@/store'
import {AppService, AppError} from '@/services/app.service'
import {useRouter} from 'vue-router'

const store = useAppStore()
const router = useRouter()
const theme = useTheme()

const filterValues = ref([])
const selectedFilterValues = ref([])
const errorMessages = ref({
  data_preview: [],
  file_upload: []
})

const spacePrevent = (e) => {
  if (e.key === ' ') {
    e.preventDefault()
  }
}
const currentTheme = computed(() => {
  return theme.global.name.value
})

const tbNumber = computed({
  get() {
    return store.tbNumber
  },
  set(value) {
    console.log(value)
    store.setTbNumber(value)
    if (store.tbNumber.length >= 10) {
      console.log('fired tb search')
      getFilterValuesFiltered()
    }
    if (value === '') {
      getFilterValues()
    }
  }

})

const compBioId = computed({
  get() {
    return store.compBioId
  },
  set(value) {
    console.log(value)
    store.setCompBioId(value)
    if (store.compBioId.length >= 10) {
      console.log('fired cb search')
      getFilterValuesFiltered()
    }
    if (value === '') {
      getFilterValues()
    }
  }

})

const sampleSjuid = computed({
  get() {
    return store.sampleSjuid
  },
  set(value) {
    store.setSampleSjuid(value)
    if (store.sampleSjuid.length >= 11) {
      getFilterValuesFiltered()
    }
    if (value === '') {
      getFilterValues()
    }
  }
})

const subjectSjuid = computed({
  get() {
    return store.subjectSjuid
  },
  set(value) {
    console.log(value)
    store.setSubjectSjuid(value)
    if (store.subjectSjuid.length >= 9) {
      getFilterValuesFiltered()
    }
    if (value === '') {
      getFilterValues()
    }
  }
})

const getFilterValues = async () => {
  try {
    filterValues.value = await AppService.getFilterValues()
  } catch (error) {
    if (error instanceof AppError) {
      console.log(error)
    }
  }
}

const navigateToDataView = () => {
  store.assay = selectedFilterValues.value
  router.push({
    name: 'dataview',
    params: {myData: 'someData'}
  })
}

const toggleAssaySelection = (filterValue) => {
  const element = document.getElementById(filterValue + '-div-id')
  const elementSpan = document.getElementById(filterValue + '-span-id')
  element.classList.toggle('selected-color')
  elementSpan.classList.toggle('selected-text-color')
  const index = selectedFilterValues.value.indexOf(filterValue)
  if (index === -1) {
    selectedFilterValues.value.push(filterValue)
  } else {
    selectedFilterValues.value.splice(index, 1)
  }
}

const resetFields = () => {
  store.resetState()
  uploadedFile.value = []
  fnames.value = undefined
  bulkTbNumber.value = []
  bulkSampleSjuid.value = []
  bulkSubjectSjuid.value = []
  errorMessages.value.data_preview = []
  errorMessages.value.file_upload = []
  selectedFilterValues.value.forEach(item => {
    const element = document.getElementById(item + '-div-id')
    const elementSpan = document.getElementById(item + '-span-id')
    element.classList.remove('selected-color')
    elementSpan.classList.remove('selected-text-color')
  })
  selectedFilterValues.value.splice(0)
  getFilterValues()
}

// file stuff
const fnames = ref(undefined)
const uploadedFile = ref([])
const bulkTbNumber = ref([])
const bulkSampleSjuid = ref([])
const bulkSubjectSjuid = ref([])
const checkTbString = (str) => {
  return str.startsWith('TB') && (str.length === 10 || str.length === 11)
}
const checkSjuidString = (str, len) => {
  return str.startsWith('SJH') && str.length === len
}


const fileChange = (file) => {
  errorMessages.value.data_preview = []
  errorMessages.value.file_upload = []
  let tb_numbers = []
  let sample_sjuids = []
  let subject_sjuids = []
  if (file.target.files[0]) {
    let reader = new FileReader()
    reader.readAsText(file.target.files[0])
    reader.onload = function () {
      if (reader.result && typeof reader.result === 'string') {
        uploadedFile.value = reader.result.replace(/\r/g, '').split('\n')
        for (let index = 0; index < uploadedFile.value.length; index++) {
          uploadedFile.value[index] = uploadedFile.value[index].split(',')
          uploadedFile.value[index].forEach(function (part, index, array) {
            array[index] = part.trim()
          })
          if (checkTbString(uploadedFile.value[index][0])) {
            tb_numbers.push(uploadedFile.value[index][0])
            store.uploadedFile.push(uploadedFile.value[index][0])
          } else if (checkSjuidString(uploadedFile.value[index][0], 11)) {
            sample_sjuids.push(uploadedFile.value[index][0])
            store.uploadedFile.push(uploadedFile.value[index][0])
          } else if (checkSjuidString(uploadedFile.value[index][0], 9)) {
            subject_sjuids.push(uploadedFile.value[index][0])
            store.uploadedFile.push(uploadedFile.value[index][0])
          }
        }
      }
    }
    reader.onerror = function () {
      errorMessages.value.file_upload.push(String(reader.error))
    }
    store.setBulkTbNumber(tb_numbers)
    store.setBulkSampleSjuid(sample_sjuids)
    store.setBulkSubjectSjuid(subject_sjuids)
    getFilterValuesFiltered(tb_numbers, sample_sjuids, subject_sjuids)
  } else {
    errorMessages.value.data_preview = []
    errorMessages.value.file_upload = []
    uploadedFile.value = []
  }
}

const getFilterValuesFiltered = async (tb_numbers = [], sample_sjuids = [], subject_sjuids = [], compBioIds = []) => {
  try {
    let filtersFiltered = {
      filters: {
        compbioid: compBioIds,
        tb_number: tb_numbers,
        sjuid_sample: sample_sjuids,
        sjuid_subject: subject_sjuids
      }
    }
    compBioId.value && (filtersFiltered.filters.compbioid.push(compBioId.value))
    tbNumber.value && (filtersFiltered.filters.tb_number.push(tbNumber.value))
    sampleSjuid.value && (filtersFiltered.filters.sjuid_sample.push(sampleSjuid.value))
    subjectSjuid.value && (filtersFiltered.filters.sjuid_subject.push(subjectSjuid.value))

    console.log(filtersFiltered)
    let response = await AppService.getFilterValues(filtersFiltered)
    console.log(response)
    response = await AppService.getFilterValues(filtersFiltered)
    filterValues.value = response
  } catch (error) {
    if (error instanceof AppError) {
      console.log(error)
    }
  }
}
const handleEnterKey = (event) => {
  if (event.key === 'Enter') {
    console.log('Enter key pressed')
    navigateToDataView()
    // Add your custom logic here
  }
};
onBeforeMount(() => {
  store.resetState()
  getFilterValues()
})
onMounted(() => {
  window.addEventListener('keydown', handleEnterKey)
})

onUnmounted(() => {
  window.removeEventListener('keydown', handleEnterKey)
})
</script>
