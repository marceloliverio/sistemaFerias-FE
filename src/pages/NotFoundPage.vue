<template>
  <VContainer fluid class="fill-height">
    <VRow justify="center" align="center" class="fill-height">
      <VCol cols="12" class="text-center">
        <VIcon icon="mdi-map-marker-off" size="96" color="grey-lighten-2" />
        <h1 class="text-h3 font-weight-bold mt-4 text-medium-emphasis">404</h1>
        <p class="text-h6 text-medium-emphasis mt-2">Página não encontrada</p>
        <p class="text-body-2 text-disabled mt-1">
          A rota que você está tentando acessar não existe.
        </p>
        <VBtn
          color="primary"
          prepend-icon="mdi-home"
          class="mt-6"
          :to="{ name: 'dashboard' }"
        >
          Ir para o Dashboard
        </VBtn>
      </VCol>
    </VRow>
  </VContainer>
</template>
