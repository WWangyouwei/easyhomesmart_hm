export interface GetCodeBean {
  accessToken: string
}


export interface UserInfoBean {
  id: string,
  userName: string,
  userSex: number,
  userPhone: string,
  userPassword: string,
  userAvatarPath: string,
  userStatus: string,
  isSetPassword: boolean,
  isDeveloper: boolean
}

export interface HomeInfoBean {
  homeId:string,
  homeName:string
}
