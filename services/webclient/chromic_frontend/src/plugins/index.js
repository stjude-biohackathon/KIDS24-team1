/**
 * plugins/index.js
 *
 * Automatically included in `./src/main.js`
 */

// Plugins
import { loadFonts } from './webfontloader.js'
import vuetify from './vuetify'
// import pinia from '@/stores'
// import router from '@/router'

export function registerPlugins (app) {
  loadFonts().then()
  app.use(vuetify)
    // .use(router)
    // .use(pinia)
}
