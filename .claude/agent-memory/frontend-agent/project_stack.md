---
name: project-stack
description: Stack tecnologica e configuracao do projeto Sistema de Solicitacao de Ferias FE
metadata:
  type: project
---

Stack obrigatoria: Vue 3 Composition API, TypeScript strict, Vuetify 3, vee-validate 4 com defineRule (sem Yup), Pinia, Axios, Vite.

Build tool: Vite 5 com plugin-vue e vite-plugin-vuetify (autoImport: true).

**Why:** Definido nos requisitos do sistema. Vuetify auto-import elimina imports manuais de componentes.

**How to apply:** Nunca adicionar Yup. Sempre usar defineRule do vee-validate. Componentes Vuetify sao globais, nao precisam de import nas SFCs.
