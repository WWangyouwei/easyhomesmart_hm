import { MMKV } from '@tencent/mmkv'
import { StorageKeys } from '../../constants/StorageKeys'
import { postHomeInfo } from '../../http/apiService'
import { logger } from '../../http/logger'
import { AppUtils } from '../../utils/AppUtils'

@Entry
@Component
export struct HomePage {
  @State homeBg: Resource = $r('app.media.theme_5')
  @State homeName: string = ""

  aboutToAppear(): void {
    this.getHomeInfo()
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Image(this.homeBg).objectFit(ImageFit.Fill)
      Column() {
        Row() {
          Row() {
            Image($r('app.media.home_local_white'))
              .width(20)
            Text('东城区')
              .fontColor($r('app.color.color_fff'))
              .textAlign(TextAlign.Center)
              .margin({ left: $r('app.float.size_3') })
          }
          .backgroundColor('#22000000')
          .borderRadius(14)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .padding({
            right: $r('app.float.size_10'),
            left: $r('app.float.size_10'),
            top: $r('app.float.size_3'),
            bottom: $r('app.float.size_3')
          })

          Blank()
          Image($r('app.media.home_notify_white'))
            .width(30)
            .height(30)
            .margin({
              right: $r('app.float.size_10')
            })
          Image($r('app.media.bg_home_add_white'))
            .width(30)
            .height(30)
            .align(Alignment.End)

        }
        .width('100%')
        .margin({ top: $r('app.float.size_35') })
        .padding({ left: $r('app.float.size_16'), right: $r('app.float.size_16') })

        this.homeNameView()
      }.alignItems(HorizontalAlign.Start)
    }
  }

  @Builder
  homeNameView() {
    Row() {
      Text(this.homeName).fontSize(20).fontColor($r('app.color.color_white')).fontWeight(FontWeight.Medium)
      Polygon({ width: 3, height: 6 })
        .points([[0, 0], [0, 6], [6, 3]])
        .fill($r('app.color.color_white'))
        .margin({left: $r('app.float.size_3')})
    }.margin({left: $r('app.float.size_16'),top: $r('app.float.size_30')})
  }

  //获取首页信息接口
  async getHomeInfo() {
    let response = await postHomeInfo("")
    if (response.data) {
      AppUtils.saveHomeId(response.data.homeId)
      AppUtils.saveDefaultHomeId(response.data.homeId)
      let mk = MMKV.defaultMMKV()
      mk.encodeInt32(StorageKeys.THEME, response.data.theme)
      this.setHomeBg(response.data.theme)
      this.homeName = response.data.homeName ?? ''
    }
  }

  setHomeBg(theme?: number) {
    if (theme != null) {
      switch (theme) {
        case 1:
          this.homeBg = $r('app.media.theme_1')
          this.showBlackTheme()
          break;
        case 2:
          this.homeBg = $r('app.media.theme_2')
          this.showBlackTheme()
          break;
        case 3:
          this.homeBg = $r('app.media.theme_3')
          this.showBlackTheme()
          break;
        case 4:
          this.homeBg = $r('app.media.theme_4')
          this.showBlackTheme()
          break;
        case 6:
          this.homeBg = $r('app.media.theme_5')
          this.showWhiteTheme()
          break;
        default:
          this.homeBg = $r('app.media.theme_6')
          this.showWhiteTheme()
          break;
      }
    }
  }

  //黑色主题
  showBlackTheme() {

  }

  //白色主题
  showWhiteTheme() {

  }
}