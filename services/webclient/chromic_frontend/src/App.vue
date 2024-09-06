<template>
  <v-app>
<!--    class="unselectable"-->
    <AppBar/>
    <v-main>

        <router-view/>

      <!--      CHROMIC-->
    </v-main>
    <AppFooter />
  </v-app>
</template>

<script setup>
import AppBar from '@/components/AppBar.vue'
import AppFooter from "@/components/AppFooter.vue";
</script>
