import bundleManager from '@ohos.bundle.bundleManager'
import { MMKV } from '@tencent/mmkv';
import { StorageKeys } from '../constants/StorageKeys';
import { StorageUtils } from './StorageUtils';


export class AppUtils {
  private constructor() {
  }
  //获取版本名
  static getVersionName(){
    let versionName = "2.3.1"
    try {
      let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT;
      bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
        versionName = data.versionName;
        StorageUtils.put(getContext(),StorageKeys.APP_VERSION_NAME,versionName,"")
      });
    } catch (err) {
    }
  }

  //获取UserId
  static getUserId():string{
    let id = MMKV.defaultMMKV().decodeBool(StorageKeys.USER_ID)
    return id + ""
  }

  //存储HomeId
  static saveUserId(homeId: string){
    MMKV.defaultMMKV().encodeString(StorageKeys.HOME_ID,homeId)
  }

  //获取HomeId
  static getHomeId(){
    return MMKV.defaultMMKV().decodeString(StorageKeys.HOME_ID)
  }
}

// export const util = new AppUtils()