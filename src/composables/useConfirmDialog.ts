import { ref } from 'vue'

interface ConfirmOptions {
  titulo?: string
  mensagem: string
  labelConfirmar?: string
  labelCancelar?: string
  cor?: string
}

const visivel = ref(false)
const opcoes = ref<ConfirmOptions>({ mensagem: '' })
let resolvePromise: ((value: boolean) => void) | null = null

export function useConfirmDialog() {
  function confirmar(opts: ConfirmOptions): Promise<boolean> {
    opcoes.value = { ...opts }
    visivel.value = true
    return new Promise<boolean>((resolve) => {
      resolvePromise = resolve
    })
  }

  function onConfirmar(): void {
    visivel.value = false
    resolvePromise?.(true)
    resolvePromise = null
  }

  function onCancelar(): void {
    visivel.value = false
    resolvePromise?.(false)
    resolvePromise = null
  }

  return { visivel, opcoes, confirmar, onConfirmar, onCancelar }
}
