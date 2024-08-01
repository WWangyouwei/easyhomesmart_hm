/**
 * 自定义App顶部Topbar
 */
import router from '@ohos.router'
import window from '@ohos.window';
import { LogUtils } from '../utils/LogUtils';
import { Button } from '@kit.InputKit';

@Component
export struct CommonTopBar {
  @Prop statusBarColor?: Color;
  @Prop topNavBarColor?: Color;
  @Prop backButton?: boolean;
  @Prop title?: String;
  @Prop richTitle?: String;
  onBackClick?: () => void
  rightBtn?: string | Resource;
  rightClick?: () => void
  @BuilderParam
  rightBtnListLayout?: () => void;
  @State statusBarHeight: number = 0
  @State indicatorHeight: number = 0
  @State bottomNavHeight: number = 0

  aboutToAppear() {
    this.setSystemStatusBar()
  }

  setSystemStatusBar() {
    window.getLastWindow(getContext(this), (error, data) => {
      let avoidArea1 = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      let avoidArea2 = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);

      this.statusBarHeight = px2vp(avoidArea1.topRect.height);
      LogUtils.debug("顶部状态栏的高度", `${this.statusBarHeight}`)

      this.indicatorHeight = avoidArea2.bottomRect.height;
      LogUtils.debug("导航条区域的高度", `${this.indicatorHeight}`)

      this.bottomNavHeight = px2vp(avoidArea1.bottomRect.height);
      LogUtils.debug("底部导航栏高度", `${this.bottomNavHeight}`)

      //2、设置系统状态栏颜色---该API废弃了，统一返回801，目前没找到好的方法设置状态栏文字的颜色，放弃了。。。。。。
      const systemBarProperties: window.SystemBarProperties = {
        //顶部状态栏颜色
        statusBarColor: "#ffffff",
        statusBarContentColor: "#ffffff",
        isStatusBarLightIcon: true
      }
      // data.setWindowSystemBarProperties(systemBarProperties, (err, result) => {
      //   LogUtils.debug("设置状态栏结果码", `${err.code}`)
      //   if (err.code == 0) {
      //     LogUtils.debug("状态栏设置成功")
      //   } else {
      //     LogUtils.debug("状态栏设置失败", `${err.message}`)
      //   }
      // })
    })
  }

  build() {
    Column() {
      Blank()
        .width("100%")
        .height(this.statusBarHeight)
        .backgroundColor(this.statusBarColor)
      Stack() {
        //返回按钮
        if (this.backButton == null || this.backButton == true) {
          Row() {
            Flex({
              alignItems: ItemAlign.Center
            }) {
              Image($r('app.media.back_top_black'))
                .width($r('app.float.size_29'))
                .height("100%")
                .padding({right: $r('app.float.size_20')})
                .objectFit(ImageFit.Contain)
                .margin({ left: $r('app.float.size_10') })
                .onClick(() => {
                  this.onBackClick?.()
                  router.back();
                })
            }
            .height("100%")
            .width($r('app.float.size_70'))
          }
          .width("50%")
          .height("100%")
          .margin({right: '50%'})
          .justifyContent(FlexAlign.Start)
        }
        //右侧按钮
        if (this.rightBtn != null) {
          Row() {
            if (typeof this.rightBtn === 'string') {
              Text(this.rightBtn as string)
                .height("100%")
                .width($r('app.float.size_137'))
                .textAlign(TextAlign.End)
                .fontColor($r('app.color.color_333333'))
                .fontSize($r('app.float.size_text_14'))
                .onClick(()=>{
                  this.rightClick?.()
                })
                .padding({
                  left: $r('app.float.size_10'),
                  right: $r('app.float.size_15')
                })
            } else {
              Image(this.rightBtn as Resource)
                .width($r('app.float.size_30'))
                .height("100%")
                .objectFit(ImageFit.Contain)
                .margin({ right: $r('app.float.size_10') })
                .onClick(() => {
                  this.rightClick?.()
                })
            }
          }
          .width("50%")
          .height("100%")
          .margin({left: '50%'})
          .justifyContent(FlexAlign.End)
        }
        //标题
        if (this.title != null) {
          Flex({
            alignItems: ItemAlign.Center
          }) {
            Text(this.title as string)
              .flexGrow(1)
              .textAlign(TextAlign.Center)
              .fontColor($r('app.color.color_333333'))
              .fontSize($r('app.float.size_text_16'))
              .align(Alignment.Center)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .height('100%')
          .margin({
            left: $r('app.float.size_70'),
            right: $r('app.float.size_70')
          })
          .align(Alignment.Center)
        } else if (this.richTitle != null) {
          Flex({
            direction: FlexDirection.Row,
            alignItems: ItemAlign.Center
          }) {
            RichText(this.richTitle as string)
              .flexGrow(1)
              .align(Alignment.Center)
          }
          .height('100%')
          .align(Alignment.Center)
        }
      }
      .width("100%")
      .height(this.indicatorHeight-this.statusBarHeight)
      // Flex({direction: FlexDirection.Row}) {
      //
      //   //
      //   // ForEach(this.rightBtnList, (item: Object, index: number) => {
      //   //   if (objectUnderTest instanceof Resource) {
      //   //     // 如果objectUnderTest是Resource类型，则执行这里的代码
      //   //     System.out.println("objectUnderTest is a Resource");
      //   //   } else {
      //   //     // 如果objectUnderTest不是Resource类型，则执行这里的代码
      //   //     System.out.println("objectUnderTest is not a Resource");
      //   //   }
      //   //
      //   //   if (item instanceof String) {
      //   //     Text(item as string)
      //   //       .textAlign(TextAlign.End)
      //   //       .fontColor($r('app.color.color_333333'))
      //   //       .fontSize($r('app.float.size_text_14'))
      //   //       .height($r('app.float.size_50'))
      //   //       .width($r('app.float.size_137'))
      //   //       .alignSelf(ItemAlign.End)
      //   //       .margin({ right: $r('app.float.size_15') })
      //   //       .onClick(()=>{
      //   //         this.rightClick?.()
      //   //       })
      //   //   } else if (isInstance(item, Resource.class)) {
      //   //     Image(item as Resource)
      //   //       .height($r('app.float.size_16'))
      //   //       .width($r('app.float.size_16'))
      //   //       .objectFit(ImageFit.ScaleDown)
      //   //       .align(Alignment.Center)
      //   //       .onClick(() => {
      //   //         this.onBackClick?.()
      //   //         router.back();
      //   //       })
      //   //   }
      //   // })
      //
      //   // if (this.rightTv != ''){
      //   //   Text(this.rightTv)
      //   //     .textAlign(TextAlign.End)
      //   //     .fontColor($r('app.color.color_333333'))
      //   //     .fontSize($r('app.float.size_text_14'))
      //   //     .height($r('app.float.size_50'))
      //   //     .width($r('app.float.size_137'))
      //   //     .alignSelf(ItemAlign.End)
      //   //     .margin({ right: $r('app.float.size_15') })
      //   //     .onClick(()=>{
      //   //       this.rightClick?.()
      //   //     })
      //   // }
      //   //
      //   // // 右侧按钮（iv）
      //   // if (this.rightIv != ''){
      //   //   Stack() {
      //   //     Image($r(this.rightIv))
      //   //       .height($r('app.float.size_16'))
      //   //       .width($r('app.float.size_16'))
      //   //       .objectFit(ImageFit.ScaleDown)
      //   //       .align(Alignment.Center)
      //   //       .onClick(() => {
      //   //         this.onBackClick?.()
      //   //         router.back();
      //   //       })
      //   //   }
      //   //   .height($r('app.float.size_50'))
      //   //   .width($r('app.float.size_50'))
      //   //   .alignSelf(ItemAlign.End)
      //   // }
      // }
      // .width("100%")
      // .height($r('app.float.size_50'))
      // .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .backgroundColor(this.topNavBarColor)
  }
  //
  // private getRightBtnList(): Array<Object> {
  //   let list = []
  //   this.rightBtnList.forEach((item, index) => {
  //     if (item instanceof String) {
  //
  //       let text = Text(item as string)
  //         .textAlign(TextAlign.End)
  //         .fontColor($r('app.color.color_333333'))
  //         .fontSize($r('app.float.size_text_14'))
  //         .height($r('app.float.size_50'))
  //         .width($r('app.float.size_137'))
  //         .alignSelf(ItemAlign.End)
  //         .margin({ right: $r('app.float.size_15') })
  //         .onClick(()=>{
  //           this.rightClick?.()
  //         })
  //       list.push(btn);
  //     } else if (item.type == 'icon') {
  //       let btn = {
  //         type: 'icon',
  //         icon: item.icon,
  //         onClick: item.onClick
  //       };
  //       list.push(btn);
  //     }
  //   })
  //   return list
  // }
}