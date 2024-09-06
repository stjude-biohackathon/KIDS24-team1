<template>
  <v-app-bar
      class="unselectable"
      :color="currentTheme === 'light' ? 'primary' : 'gray-darken-4'"
      elevation="1"
      :flat="true"
  >
    <template v-if="currentTheme === 'light'" v-slot:image>
      <v-img
          gradient="to bottom right, #17818F, #7ad0e4"
      />
    </template>
    <img class="ml-4" src="@/assets/SJ-Icon-White.svg" :width="70" alt=""/>
    <span v-if="router.currentRoute.value.name === 'dataview'">
      <img src="@/assets/Frame%2020.svg" :width="300" alt="" class="ml-n6"/>
    </span>

    <v-spacer/>
    <div v-if="eed" class="mr-4">
      {{ eedTextOne }}
      <v-icon color="red" icon="$heart" size="small" v-if="eeIcon"/>
      {{ eedTextTwo }}
    </div>

    <v-chip class="mx-4" @click="changeTheme" v-if="!eed" color="red-darken-5" @contextmenu="ee($event)">
      <v-icon class="mr-1" :color="theme.global.name.value === 'light' ? 'white' : 'black'" icon="$whiteBalanceSunny"
              size="18"/>
      <v-icon class="ml-1" :color="theme.global.name.value === 'dark' ? 'white' : 'black'" icon="$weatherNight"
              size="18"/>
    </v-chip>
  </v-app-bar>

</template>

<script setup>
import {ref, computed, onBeforeMount} from 'vue'
import {useTheme} from 'vuetify'
import {useRouter} from 'vue-router'

const theme = useTheme()
const router = useRouter()

const eed = ref(false)
const eeIcon = ref(false)
const eedTextOne = ref('')
const eedTextTwo = ref('')

const currentTheme = computed(() => {
  return theme.global.name.value
})

const changeTheme = () => {
  if (theme.global.name.value === 'light') {
    theme.global.name.value = 'dark';
    localStorage.setItem('theme', theme.global.name.value)
  } else {
    theme.global.name.value = 'light'
    localStorage.setItem('theme', theme.global.name.value)
  }
}

function ee(event) {
  event.preventDefault()
  if (!eed.value) {
    eed.value = true
    updateText()
  }
}

async function updateText() {
  eedTextOne.value = ''
  eedTextTwo.value = ''
  let textOne = [...'made with']
  let textTwo = [...'by tonia, stephanie, louis, daniel, john, and alex']

  for (let i = 0; i < textOne.length; i++) {
    eedTextOne.value += textOne[i]
    await sleep(100)
  }

  await sleep(100)
  eeIcon.value = true;
  await sleep(100)

  for (let i = 0; i < textTwo.length; i++) {
    eedTextTwo.value += textTwo[i]
    await sleep(100)
  }
  await sleep(2000)
  eed.value = false
  eeIcon.value = false
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

onBeforeMount(() => {
  if (localStorage.getItem('theme')) {
    theme.global.name.value = localStorage.getItem('theme')
  } else {
    theme.global.name.value = 'light'
    localStorage.setItem('theme', 'light')
  }
})
</script>
