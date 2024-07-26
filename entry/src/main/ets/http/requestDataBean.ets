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
  homeId:string
  id?: string
  homeName?: string
  homeLocation?: string
  longitude?: object
  latitude?: object
  theme?: number
  province?: object
  city?: object
  county?: object
  boardWallpaper?: object
  boardSort?: string
  defaultHome?: number
  createTime?: string
  updateTime?: string
  delFlag?: string
  roomQuantity?: string
  deviceQuantity?: string
  onlineQuantity?: string
  offlineQuantity?: string
  relation?: number
}
