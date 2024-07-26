import { http } from '@kit.NetworkKit';
import { authStore } from './auth';
import { promptAction, router } from '@kit.ArkUI';
import { BusinessError } from '@ohos.base';
import { logger } from './logger';
import { MMKV } from '@tencent/mmkv';
import { StorageKeys } from '../constants/StorageKeys';
import showToast from '../utils/ToastUtils';

interface HdRequestOptions {
  baseURL?: string
}

type HdParams = Record<string, string | number | boolean>

export interface HdResponse<T> {
  code: number
  msg: string
  data: T
}

class HdHttp {
  baseURL: string

  constructor(options: HdRequestOptions) {
    this.baseURL = options.baseURL || ''
  }

  private request<T>(path: string, method: http.RequestMethod = http.RequestMethod.GET, extraData?: Object,showErrorToast: boolean = false) {
    const httpInstance = http.createHttp()

    const options: http.HttpRequestOptions = {
      header: {
        'Content-Type': 'application/json'
      },
      method,
      expectDataType: http.HttpDataType.OBJECT
    }

    let fullUrl = this.baseURL + path
    if (method === http.RequestMethod.GET && extraData) {
      const strArr = Object.keys(extraData)
        .filter(key => (extraData as HdParams)[key] !== undefined)
        .map(key => `${key}=${(extraData as HdParams)[key]}`)
      fullUrl += `?${strArr.join('&')}`
      logger.info(fullUrl)
    } else {
      options.extraData = extraData
      logger.info("请求参数：",JSON.stringify(options.extraData))
    }

    const token = MMKV.defaultMMKV().decodeString(StorageKeys.TOKEN)

    if (token && options.header) {
      options.header['Authorization'] = `${token}`
    }

    return httpInstance.request(fullUrl, options).then((res) => {
      if (res.result) {
        const result = res.result as HdResponse<T>
        if (result.code === 0) {
          logger.info(fullUrl, JSON.stringify(res.result).substring(0, 200))
          return result
        }else if (result.code === 10020 || result.code === 10002) {
          authStore.delUser()
          router.pushUrl({
            url: 'pages/login/LoginCodePage'
          }, router.RouterMode.Single)
          throw new Error('登录过期')
        }else{
          if (showErrorToast) {
            showToast(result.msg)
          }
        }
      }
      return Promise.reject(res.result)
    }).catch((err: BusinessError) => {
      logger.error(fullUrl, err.code?.toString(), err.message)
      promptAction.showToast({ message: err.message || '网络错误' })
      return Promise.reject(err)
    }).finally(() => {
      httpInstance.destroy()
    })
  }

  get<T>(url: string, data?: Object,showErrorToast?: boolean): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.GET, data,showErrorToast)
  }

  post<T>(url: string, data?: Object,showErrorToast?: boolean): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.POST, data, showErrorToast)
  }

  put<T>(url: string, data?: Object): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.PUT, data)
  }

  delete<T>(url: string, data?: Object): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.DELETE, data)
  }
}


export const hdHttp = new HdHttp({ baseURL: 'https://easyhomesmart-uat.juran.com.cn:8898/' })