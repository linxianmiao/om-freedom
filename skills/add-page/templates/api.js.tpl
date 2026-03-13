import { __HTTP_INSTANCE__ } from './http'

const PATH = '__PATH_PREFIX__'

export default {
  getList(params) {
    return __HTTP_INSTANCE__.post(`${PATH}/list`, params)
  },

  getDetail(id) {
    return __HTTP_INSTANCE__.get(`${PATH}/${id}`)
  },

  create(data) {
    return __HTTP_INSTANCE__.post(`${PATH}`, data)
  },

  update(data) {
    return __HTTP_INSTANCE__.put(`${PATH}/${data.id}`, data)
  },

  delete(id) {
    return __HTTP_INSTANCE__.delete(`${PATH}/${id}`)
  },
}
