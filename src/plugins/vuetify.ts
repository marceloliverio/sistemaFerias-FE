import { createVuetify } from 'vuetify'
import { pt } from 'vuetify/locale'
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'

export const vuetify = createVuetify({
  locale: {
    locale: 'pt',
    messages: { pt },
  },
  theme: {
    defaultTheme: 'light',
    themes: {
      light: {
        colors: {
          primary: '#000E34',
          secondary: '#001754',
          accent: '#3988FF',
          error: '#B11414',
          info: '#3988FF',
          success: '#2E7D32',
          warning: '#F57C00',
          surface: '#FCFCFC',
          background: '#F0F2F5',
          'on-primary': '#F6F6F6',
          'on-secondary': '#F6F6F6',
        },
      },
    },
  },
  defaults: {
    VCard: {
      elevation: 0,
      rounded: 'lg',
      border: true,
    },
    VBtn: {
      variant: 'elevated',
      rounded: 'pill',
    },
    VTextField: {
      variant: 'outlined',
      density: 'comfortable',
    },
    VSelect: {
      variant: 'outlined',
      density: 'comfortable',
    },
    VTextarea: {
      variant: 'outlined',
      density: 'comfortable',
    },
    VChip: { rounded: 'lg' },
  },
})
