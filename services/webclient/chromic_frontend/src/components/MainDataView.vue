<template>
  <v-container :fluid="true" class="mx-auto">
    <v-card class="window-card">
      <v-card-title>
        <v-row class="mt-1">
          <v-col class="d-flex justify-start">
            <v-btn
                prepend-icon="$arrowLeft"
                variant="tonal"
                color="primary"
                class="mb-4 mr-2"
                @click="backHome"
            >Back
            </v-btn>
            <v-btn
                color="primary"
                variant="tonal"
                class="mb-4 mr-2"
                @click="resetFields"
            >
              Reset
              <v-icon class="pl-1" icon="$refresh" size="x-large"/>
            </v-btn>
            <v-btn
                color="success"
                variant="tonal"
                class="mb-4"
                @click="exportResults"

            >
              Export
              <v-tooltip
                  activator="parent"
                  location="end"
              >Export limited to a snippet of the first 1,000 rows.
              </v-tooltip>
              <v-icon class="pl-1" icon="$download" size="x-large"/>
            </v-btn>
          </v-col>
        </v-row>
      </v-card-title>
      <v-card-text class="pb-9 px-6">
        <v-row>
          <v-col>
            <v-text-field
                :disabled="uploadedFile_c.length > 0"
                density="comfortable"
                type="text"
                label="Sample SJUID"
                v-model="sampleSjuid"
            />
            <v-text-field
                :disabled="uploadedFile_c.length > 0"
                density="comfortable"
                type="text"
                label="Subject SJUID"
                v-model="subjectSjuid"
            />
            <v-text-field
                :disabled="uploadedFile_c.length > 0"
                density="comfortable"
                type="text"
                label="Compbio ID"
                v-model="compBioId"
            />
          </v-col>
          <v-col>
            <v-text-field
                :disabled="uploadedFile_c.length > 0"
                density="comfortable"
                type="text"
                label="TB Number"
                v-model="tbNumber"
            />
            <v-autocomplete
                :disabled="uploadedFile_c.length > 0"
                density="comfortable"
                label="Assays"
                :items="filterValues"
                item-title="assay"
                item-value="assay"
                :clearable="true"
                :multiple="true"
                :chips="true"
                small-chips
                closable-chips
                v-model="assays"
            />
          </v-col>
          <v-col>
            <v-textarea
                density="comfortable"
                type="text"
                readonly
                label="Bulk Search"
                v-model="uploadedFile_c"
            />
          </v-col>
        </v-row>
        <v-divider/>
        <v-data-table-server
            class="data-table rounded-corners elevation-1"
            density="compact"
            :headers="headers"
            :items="sampleData.results"
            :loading="tableLoading"
            :items-length="sampleData.count || 0"
            v-model:items-per-page="tableOptions.itemsPerPage"
            v-model:page="tableOptions.page"
            v-model:sort-by="tableOptions.sortBy"
            :items-per-page-options="tableOptions.itemsPerPageOptions"
            item-value="srm_sample"
        />
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script setup>
import {computed, onBeforeMount, ref, watch, nextTick} from 'vue'
import {useRouter} from "vue-router"
import {AppError, AppService} from '@/services/app.service'
import {ExportService} from "@/services/export.service";
import {useAppStore} from "@/store";

const router = useRouter()
const store = useAppStore()
const headers = ref([
  {title: 'SRM Sample', key: 'srm_sample', sortable: true, visible: true},
  {title: 'Sample Name', key: 'samplename', sortable: true, visible: true},
  {title: 'Assay', key: 'assay', sortable: true, visible: true},
  {title: 'Sequencer', key: 'sequencer', sortable: true, visible: true},
  {title: 'Run Type', key: 'runtype', sortable: true, visible: true},
  {title: 'Read Length', key: 'readlength', sortable: false, visible: true},
  {title: 'Reference Genome', key: 'referencegenome', sortable: true, visible: true},
  {title: 'Human Derived', key: 'ishumanderived', sortable: true, visible: true},
  {title: 'TB Number', key: 'tb_number', sortable: true, visible: true},
  {title: 'SJUID Sample', key: 'sjuid_sample', sortable: true, visible: true},
  {title: 'SJUID Subject', key: 'sjuid_subject', sortable: true, visible: true}, // compbioid
  {title: 'Compbio ID', key: 'compbioid', sortable: true, visible: true},
  {title: 'BAM Path', key: 'bampath', sortable: true, visible: true},
  {title: 'SRM Order', key: 'srm_order', sortable: true, visible: true},
  {title: 'Requestor First Name', key: 'requestor_firstname', sortable: true, visible: true},
  {title: 'Requestor Last Name', key: 'requestor_lastname', sortable: true, visible: true},
  {title: 'Requestor Email', key: 'requestor_email', sortable: true, visible: true},
  {title: 'PI First Name', key: 'pi_firstname', sortable: true, visible: true},
  {title: 'PI Last Name', key: 'pi_lastname', sortable: true, visible: true},
  {title: 'PI Email', key: 'pi_email', sortable: true, visible: true},
  {title: 'Order Date', key: 'order_date', sortable: true, visible: true},
])

const filterValues = ref([])
const sampleData = ref([])
const tableLoading = ref(false)
const tableOptions = ref({
  page: 1,
  itemsPerPage: 10,
  sortBy: [{key: 'samplename', order: 'desc'}],
  itemsPerPageOptions: [
    {value: 10, title: '10'},
    {value: 15, title: '15'},
    {value: 25, title: '25'},
    {value: 50, title: '50'},
  ]
})
watch(tableOptions, () => {
  getSamples()
}, {deep: true})

const tbNumber = computed({
  get() {
    return store.tbNumber
  },
  set(value) {
    store.setTbNumber(value)
    // TB-98-6112
    if (store.tbNumber.length >= 10) {
      getSamples()
    }
  }
})
const compBioId = computed({
  get() {
    return store.compBioId
  },
  set(value) {
    store.setCompBioId(value)
    if (store.compBioId.length >= 10) {
      getSamples()
    }
  }

})

const uploadedFile_c = computed(() => store.uploadedFile.join('\n'))

const bulkSubjectSjuid = computed({
  get() {
    return store.bulkSubjectSjuid
  },
  set(value) {
    store.setBulkSubjectSjuid(value)
  }
})
const bulkTbNumber = computed({
  get() {
    return store.bulkTbNumber
  },
  set(value) {
    store.setBulkTbNumber(value)
  }
})
const bulkSampleSjuid = computed({
  get() {
    return store.bulkSampleSjuid
  },
  set(value) {
    store.setBulkSampleSjuid(value)
  }
})
// end bulks
const assays = computed({
  get() {
    return store.assay
  },
  set(value) {
    store.setAssay(value)
    getSamples()
  }
})

const generateGetSamplesData = computed(() => {
  let data = {
    sort_by: [tableOptions.value.sortBy[0].key + '.' + tableOptions.value.sortBy[0].order],
    filters_depth1: {
      compbioid: [],
      tb_number: [],
      sjuid_sample: [],
      sjuid_subject: []
    },
    filters_depth2: {
      assay: []
    },
  }
  console.log('inside generateGetSamplesData', data)
  console.log('assays', assays.value)
  if (uploadedFile_c.value) {
    console.log('inside uploadedFile_c', uploadedFile_c)
    data.filters_depth1.tb_number = bulkTbNumber.value
    data.filters_depth1.sjuid_sample = bulkSampleSjuid.value
    data.filters_depth1.sjuid_subject = bulkSubjectSjuid.value
  } else {
    data.filters_depth1.compbioid.push(compBioId.value)
    data.filters_depth1.tb_number.push(tbNumber.value)
    data.filters_depth1.sjuid_sample.push(sampleSjuid.value)
    data.filters_depth1.sjuid_subject.push(subjectSjuid.value)
    data.filters_depth2.assay = assays.value
  }
  return data
})

const sampleSjuid = computed({
  get() {
    return store.sampleSjuid
  },
  set(value) {
    store.setSampleSjuid(value)
    if (store.sampleSjuid.length >= 11) {
      getSamples()
    }
  }
})

const subjectSjuid = computed({
  get() {
    return store.subjectSjuid
  },
  set(value) {
    store.setSubjectSjuid(value)
    if (store.subjectSjuid.length >= 9) {
      getSamples()
    }
  }
})

const backHome = () => {
  router.push({name: 'home',})
}

const getSamples = async () => {
  try {
    tableLoading.value = true
    let val = generateGetSamplesData.value
    let query = '?limit=' + tableOptions.value.itemsPerPage + '&page=' + tableOptions.value.page
    sampleData.value = await AppService.getSampleData(query, generateGetSamplesData.value)
    tableLoading.value = false
  } catch (error) {
    tableLoading.value = false
    if (error instanceof AppError) {
      console.log(error)
    }
  }
}
const getFilterValues = async () => {
  try {
    filterValues.value = await AppService.getFilterValues()
  } catch (error) {
    if (error instanceof AppError) {
      console.log(error)
    }
  }
}

const resetFields = () => {
  store.resetState()
  getSamples()
}

const exportResults = () => {
  getExportData().then((e) => {
    let csvData = ExportService.csvFirstLine(e.results)
    csvData += ExportService.csvEncoding(e.results)
    ExportService.csvLinkClick(csvData, 'chromic')
  })
}

const getExportData = async () => {
  try {
    return await AppService.getSampleData('', generateGetSamplesData.value)
  } catch (error) {
    tableLoading.value = false
    if (error instanceof AppError) {
      console.log(error)
    }
  }
}

onBeforeMount(() => {
  getSamples()
  getFilterValues()
})
</script>