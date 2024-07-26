import { hdHttp } from '../http/request'
import { AppUtils } from '../utils/AppUtils'
import { GET_SMS_CODE, HOME_INFO, LOGIN_SMS, PASSWORD_LOGON, POST_USER_INFO } from '../utils/UrlUtils'
import { GetCodeBean, HomeInfoBean, UserInfoBean } from './requestDataBean'

/**
 * 公共传参基类
 */
export class BaseParams {
  appVersion: string = ""
  clientType: string = "1"
  sourceType: string = "1"
  pushDevice: string = "Android"
}

export class GetCodeParams extends BaseParams {
  userPhone?: string
  smsCode: string = ""
}

export class PassLoginParams extends BaseParams {
  userPhone?: string
  userPassword: string = ""
}

export class HomeIdParams extends BaseParams {
  homeId?: string
  userId?: string
}

//发送验证码
export function sendCode(phone: string) {
  let pa = new GetCodeParams()
  pa.userPhone = phone
  return hdHttp.post<null>(GET_SMS_CODE, pa, true)
}
//验证码登录
export function smsLogin(phone: string, code: string) {
  let pa = new GetCodeParams()
  pa.userPhone = phone
  pa.smsCode = code
  return hdHttp.post<GetCodeBean>(LOGIN_SMS, pa, true)
}
//密码登录
export function passLogin(phone: string, pass: string) {
  let pa = new PassLoginParams()
  pa.userPhone = phone
  pa.userPassword = pass
  return hdHttp.post<GetCodeBean>(PASSWORD_LOGON, pa, true)
}
//用户详情
export function postUserInfo() {
  let pa = new BaseParams()
  return hdHttp.post<UserInfoBean>(POST_USER_INFO, pa, false)
}
//首页
export function postHomeInfo(id: string) {
  let pa = new HomeIdParams()
  pa.userId = AppUtils.getUserId()
  pa.homeId = id;
  return hdHttp.post<HomeInfoBean>(HOME_INFO, pa, false)
}









