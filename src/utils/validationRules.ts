import { defineRule } from 'vee-validate'

export function registrarRegras(): void {
  defineRule('required', (value: unknown): boolean | string => {
    if (value === null || value === undefined || value === '') {
      return 'Este campo é obrigatório.'
    }
    return true
  })

  defineRule('email', (value: string): boolean | string => {
    if (!value) return true
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    return regex.test(value) || 'Informe um e-mail válido.'
  })

  defineRule('minLength', (value: string, [min]: [number]): boolean | string => {
    if (!value) return true
    return (
      value.length >= min || `Mínimo de ${min} caracteres.`
    )
  })

  defineRule('maxLength', (value: string, [max]: [number]): boolean | string => {
    if (!value) return true
    return (
      value.length <= max || `Máximo de ${max} caracteres.`
    )
  })

  defineRule('dataFuturaOuHoje', (value: string): boolean | string => {
    if (!value) return true
    const hoje = new Date()
    hoje.setHours(0, 0, 0, 0)
    const data = new Date(value)
    return data >= hoje || 'A data não pode ser no passado.'
  })

  defineRule('dataFimAposInicio', (value: string, [dataInicio]: [string]): boolean | string => {
    if (!value || !dataInicio) return true
    const inicio = new Date(dataInicio)
    const fim = new Date(value)
    return fim >= inicio || 'A data de fim deve ser igual ou após a data de início.'
  })

  // Valida apenas o formato exigido pela API (\d{3}\.\d{3}\.\d{3}-\d{2}),
  // sem verificar dígitos verificadores de CPF.
  defineRule('cpfFormato', (value: string): boolean | string => {
    if (!value) return true
    const regex = /^\d{3}\.\d{3}\.\d{3}-\d{2}$/
    return regex.test(value) || 'Informe o CPF no formato 123.456.789-00.'
  })
}
