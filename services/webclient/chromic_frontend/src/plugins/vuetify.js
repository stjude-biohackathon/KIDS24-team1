/**
 * plugins/vuetify.js
 *
 * Framework documentation: https://vuetifyjs.com`
 */

// Styles
// import '@mdi/font/css/materialdesignicons.css'
// import 'vuetify/styles'
//
// // Composables
// import { createVuetify } from 'vuetify'
//
// // https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
// export default createVuetify({
//   theme: {
//     defaultTheme: 'dark',
//   },
// })
/**
 * plugins/vuetify.js
 *
 * Framework documentation: https://vuetifyjs.com`
 */
import { aliases, mdi } from 'vuetify/iconsets/mdi-svg'
import { createVuetify } from 'vuetify'
import {
  mdiAccount,
  mdiClose,
  mdiDownload,
  mdiExitToApp,
  mdiFlask,
  mdiHeart,
  mdiHelpCircleOutline,
  mdiLock,
  mdiRefresh,
  mdiWeatherNight,
  mdiWhiteBalanceSunny,
  mdiRocketLaunchOutline,
    mdiSlack,
    mdiTextBoxOutline,
  mdiOpenInNew,
    mdiArrowLeft,
    mdiGithub,
} from '@mdi/js'
import 'vuetify/styles'

export default createVuetify({
  icons: {
    defaultSet: 'mdi',
    aliases: {
      ...aliases,
      account: mdiAccount,
      close: mdiClose,
      download: mdiDownload,
      exittoapp: mdiExitToApp,
      flask: mdiFlask,
      heart: mdiHeart,
      helpcircleoutline: mdiHelpCircleOutline,
      lock: mdiLock,
      refresh: mdiRefresh,
      weatherNight: mdiWeatherNight,
      whiteBalanceSunny: mdiWhiteBalanceSunny,
      rocket: mdiRocketLaunchOutline,
      slack: mdiSlack,
      textbox: mdiTextBoxOutline,
      openInNew: mdiOpenInNew,
      arrowLeft: mdiArrowLeft,
      github: mdiGithub,
    },
    sets: {
      mdi,
    },
  },
  theme: {
    themes: {
      light: {
        colors: {
          success: '#008a1c',
          error: '#e03400',
          primary: '#1874dc',
          stJudeRedLight: '#d11947',
          stJudeRedDark: '#8d0034',
          stJudeGrayLight: '#dfe1df',
          stJudeGrayDark: '#474c55',
          stJudeRedLightButton: '#d11947',
        },
      },
      dark: {
        colors: {
          success: '#008a1c',
          error: '#e03400',
          primary: '#1874dc',
          stJudeRedLightButton: '#d11947',
        }
      }
    },
  },
})
