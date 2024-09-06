<template>
  <!-- Div containing the Snackbar element used for error notification -->
  <div class="text-center">
    <v-snackbar v-model="internalSnack" :timeout="timeout" :color="snackColor" top>
      {{ snackText }}
      <template v-slot:actions>
        <v-btn text="Close" @click="$emit('close_click')"/>
      </template>
    </v-snackbar>
  </div>
</template>

<script setup>
import { ref, watchEffect } from 'vue'

const props = defineProps({
  snack: Boolean,
  snackColor: String,
  snackText: String
})
const timeout = ref(-1);
const internalSnack = ref(props.snack)


watchEffect(() => {
  internalSnack.value = props.snack
})
</script>
