import router from '@ohos.router'
import { MMKV } from '@tencent/mmkv'
import { StorageKeys } from '../constants/StorageKeys'
import { logger } from '../http/logger'
import { RoutePath } from '../route/RoutePath'
import { AppUtils } from '../utils/AppUtils'
import { themeManager } from '../utils/themeManager'
import { ImageKnife } from '@ohos/imageknife'

@Entry
@Component
struct SplashPage {
  @State message: string = 'Hello World'

  aboutToAppear() {
    // 文件缓存
    ImageKnife.getInstance().initFileCache(getContext(this), 256, 256 * 1024 * 1024)
    themeManager.initThemeSetting()
    themeManager.enableFullScreen()
    AppUtils.getVersionName()
    setTimeout(() => {
      this.goMainPage()
    }, 1000)
  }

  build() {
    Column() {
      Image($r('app.media.splash_top'))
        .objectFit(ImageFit.ScaleDown)
        .align(Alignment.TopStart)
        .margin({ top: $r('app.float.size_80') })
        .width($r('app.float.size_350'))
        .height($r('app.float.size_350'))

      Image($r('app.media.splash_btm_1'))
        .objectFit(ImageFit.ScaleDown)
        .align(Alignment.TopStart)
        .margin({ top: $r('app.float.size_20') })
        .width($r('app.float.size_120'))
        .height($r('app.float.size_80'))
      Text().layoutWeight(1)
      Image($r('app.media.splash_btm'))
        .objectFit(ImageFit.ScaleDown)
        .width($r('app.float.size_140'))
        .height($r('app.float.size_120'))
        .align(Alignment.Bottom)
        .onClick(() => this.goMainPage())
    }
    .width('100%').height('100%')
  }

  goMainPage() {
    // let token = MMKV.defaultMMKV().decodeString(StorageKeys.TOKEN)
    // logger.info("token" + token)
    // if (token != null && token != '') {
    //   router.replaceUrl({ url: RoutePath.MainPage })
    // } else {
    //   router.replaceUrl({ url: RoutePath.LoginCodePage })
    // }
    router.replaceUrl({ url: RoutePath.MainPage })
  }
}