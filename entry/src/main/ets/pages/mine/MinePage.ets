import { ListView, RefreshController, RefreshDataSource} from '@abner/refresh';
import { postUserInfo } from '../../http/apiService';
import { CommonStatusBar } from '../../views/CommonStatusBar';
import {ImageKnifeComponent} from '@ohos/imageknife'
import { UserInfoBean } from '../../http/requestDataBean';

@Entry
@Component
export struct MinePage {
  controller: RefreshController = new RefreshController()
  private dataSource: RefreshDataSource = new RefreshDataSource()

  aboutToAppear() {
    let array: Array<Object> = []
    array.push('')
    array.push([
      { image: $r('app.media.dp_my_cell_jtgl'), title: '家庭管理' } as MinePageItem,
      { image: $r('app.media.dp_my_cell_jtgl'), title: '固件升级' } as MinePageItem
    ])
    array.push({image: $r('app.media.dp_my_cell_third'), title: '连接第三平台' } as MinePageItem)
    array.push({image: $r('app.media.dp_my_cell_about'), title: '关于我们' } as MinePageItem)
    array.push({image: $r('app.media.dp_my_cell_set'), title: '设置' } as MinePageItem)
    array.push({image: $r('app.media.dp_my_cell_help'), title: '帮助与反馈' } as MinePageItem)
    this.dataSource.initData(array)
    this.getUserInfo()
  }

  @Builder
  itemLayout(item: Object, index: number): void {
    if (index == 0) {
      // 头部
      Column() {
        CommonStatusBar({})
        Row() {
          Text('我的')
            .fontColor('#1D1F24')
            .fontSize($r('app.float.size_text_20'))
            .padding({left: $r('app.float.size_15')})
          Image($r('app.media.home_notify_ld'))
            .width($r('app.float.size_38'))
            .height($r('app.float.size_38'))
            .objectFit(ImageFit.Contain)
            .margin({ right: $r('app.float.size_15') })
            .onClick(() => {

            })
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)
        Row() {
          ImageKnifeComponent({
            imageKnifeOption: {
              loadSrc: (item as UserInfoBean).userAvatarPath,
              placeholderSrc: $r('app.media.dp_user_head'),
              errorholderSrc: $r('app.media.dp_user_head'),
              objectFit: ImageFit.Cover,
              border: {radius:30}
            }
          })
            .width(60)
            .height(60)
            .margin({ left: $r('app.float.size_20') })
          Column() {
            Text((item as UserInfoBean).userName == null ? "--" : (item as UserInfoBean).userName)
              .textAlign(TextAlign.Start)
              .fontColor('#1D1F24')
              .fontSize($r('app.float.size_text_20'))
            Row() {
              Text('查看个人信息')
                .fontColor('#801d1f24')
                .fontSize($r('app.float.size_text_12'))
              Image($r('app.media.dp_arrow_three'))
                .height($r('app.float.size_10'))
                .objectFit(ImageFit.Contain)
                .margin({ left: $r('app.float.size_2') })
                .onClick(() => {

                })
            }
            .margin({ top: $r('app.float.size_6') })
          }
          .margin({ left: $r('app.float.size_18') })
          .alignItems(HorizontalAlign.Start)
        }
        .width("100%")
        .margin({ top: $r('app.float.size_36'), bottom: $r('app.float.size_26') })
      }
      .width("100%")
    } else if (index == 1) {
      // 家庭管理、固件升级
      Flex({
        direction: FlexDirection.Row,
        justifyContent: FlexAlign.SpaceBetween
      }) {
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center}) {
          Image($r('app.media.dp_my_cell_jtgl'))
            .width($r('app.float.size_40'))
            .height($r('app.float.size_40'))
            .objectFit(ImageFit.Contain)
            .margin({ left: $r('app.float.size_15') })
            .onClick(() => {

            })
          Text('家庭管理')
            .fontColor('#1D1F24')
            .fontSize($r('app.float.size_text_14'))
            .margin({left: $r('app.float.size_5')})
        }
        .height('100%')
        .margin({ left: $r('app.float.size_15') })
        .backgroundColor(Color.White)
        .border({ radius: $r('app.float.size_15')})
        .flexGrow(1)
        Flex() {}
        .width($r('app.float.size_10'))
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Start }) {
          Image($r('app.media.dp_my_cell_gjsj'))
            .width($r('app.float.size_40'))
            .height($r('app.float.size_40'))
            .objectFit(ImageFit.Contain)
            .margin({ left: $r('app.float.size_15') })
            .onClick(() => {

            })
          Text('固件升级')
            .fontColor('#1D1F24')
            .fontSize($r('app.float.size_text_14'))
            .margin({left: $r('app.float.size_5')})
        }
        .height('100%')
        .margin({ right: $r('app.float.size_15') })
        .backgroundColor(Color.White)
        .border({ radius: $r('app.float.size_15')})
        .flexGrow(1)
      }
      .width("100%")
      .height($r('app.float.size_64'))
      .margin({ top: $r('app.float.size_10'), bottom: $r('app.float.size_10') })
    } else {
      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center}) {
        Image((item as MinePageItem).image)
          .width($r('app.float.size_40'))
          .height($r('app.float.size_40'))
          .objectFit(ImageFit.Contain)
          .margin({ left: $r('app.float.size_15') })
          .onClick(() => {

          })
        Text((item as MinePageItem).title)
          .fontColor('#1D1F24')
          .fontSize($r('app.float.size_text_14'))
          .margin({left: $r('app.float.size_5')})
      }
      .height($r('app.float.size_68'))
      .margin({ left: $r('app.float.size_15'), right: $r('app.float.size_15') })
      .backgroundColor(Color.White)
      .border({
        radius: {
          topLeft: (item as MinePageItem).title == '连接第三平台' ? $r('app.float.size_15') : 0,
          topRight: (item as MinePageItem).title == '连接第三平台' ? $r('app.float.size_15') : 0,
          bottomLeft: (item as MinePageItem).title == '帮助与反馈' ? $r('app.float.size_15') : 0,
          bottomRight: (item as MinePageItem).title == '帮助与反馈' ? $r('app.float.size_15') : 0
        }
      })
      .flexGrow(1)
    }
  }

  build() {
    Column() {
      ListView({
        controller: this.controller,
        lazyDataSource: this.dataSource,
        itemLayout: (item, index) => this.itemLayout(item, index),
        onRefresh: () => {
          this.getUserInfo()
        }
      })
    }
    .backgroundColor("#fff3f4f8")
    .backgroundImage($r("app.media.mine_bg"))
  }

  async getUserInfo() {
    let response = await postUserInfo()
    if (response.code == 0) {
      this.dataSource.changeData(0, response.data);
      setTimeout(() => {
        this.controller.finishRefresh();
      }, 1000)
    }
  }
}

interface MinePageItem {
  image: Resource;
  title: string;
}