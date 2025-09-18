import type { LoginPayload, LoginResponse } from '@/types'

import api from './api'

export const login = async (payload: LoginPayload): Promise<LoginResponse> => {
  const { data } = await api.post('/auth/login', payload, {
    headers: {
      skipAuthInterceptor: 'true',
    },
  })
  return data
}

export const logoutApi = async () => {
  return api.post('/auth/logout', null, {
    headers: { skipAuthInterceptor: 'true' },
  })
}
