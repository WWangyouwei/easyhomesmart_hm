import { MMKV } from '@tencent/mmkv'
import { StorageKeys } from '../../constants/StorageKeys'
import { postHomeInfo } from '../../http/apiService'
import { logger } from '../../http/logger'
import { AppUtils } from '../../utils/AppUtils'

@Component
export struct HomePage {
  name = MMKV.defaultMMKV().decodeString(StorageKeys.USER_NAME)
  @State homeBg: string = ''
  aboutToAppear(): void {
    this.getHomeInfo()
  }
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Image(this.homeBg)
        .objectFit(ImageFit.Fill)
    }
  }

  async getHomeInfo(){
    let response = await postHomeInfo(AppUtils.getUserId())
    if (response.data) {
      AppUtils.saveUserId(response.data.homeId)
      logger.debug("----------------id:"+AppUtils.getHomeId())
    }
  }
}