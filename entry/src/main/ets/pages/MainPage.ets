import MainViewModel from '../model/MainViewModel'
import { TabBarModel } from '../model/TabBarModel'
import { CommonConstants } from '../utils/CommonConstants'
import { LogUtils } from '../utils/LogUtils'
import { LoadingDialog } from '../views/LoadingDialog'
import { BoardPage } from './board/BoardPage'
import { HomePage } from './home/HomePage'
import { MinePage } from './mine/MinePage'
import { ScenePage } from './scene/ScenePage'
import { ShopPage } from './shop/ShopPage'

@Entry
@Component
export struct MainPage {
  @State loadingTips: string = "加载中..."
  @State loadingShow: boolean = false
  @State selectedIndex: number = 0
  @Provide homeTabSelected: number = 0
  //全局的loading
  loadingDialogController: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({ loadingTips: this.loadingTips }),
    autoCancel: false,
    gridCount: 2,
    cancel: () => {
      this.loadingShow = false
    }
  })

  build() {
    Column() {
      Tabs({
        index: this.selectedIndex,
        barPosition: BarPosition.End,
      }) {
        TabContent() {
          HomePage()
        }
        .tabBar(this.TabBottom(MainViewModel.tabTitle[0], 0))
        TabContent() {
          ScenePage()
        }
        .tabBar(this.TabBottom(MainViewModel.tabTitle[1], 1))
        TabContent() {
          BoardPage()
        }
        .tabBar(this.TabBottom(MainViewModel.tabTitle[2], 2))
        TabContent() {
          ShopPage()
        }
        .tabBar(this.TabBottom(MainViewModel.tabTitle[3], 3))
        TabContent() {
          MinePage()
        }
        .tabBar(this.TabBottom(MainViewModel.tabTitle[4], 4))
      }
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .scrollable(false)
      .barHeight($r('app.float.tab_bar_height'))
      .onChange((index: number) => {
        this.selectedIndex = index;
        this.homeTabSelected = index
        LogUtils.error("----------" + index)
      })
    }
  }

  @Builder TabBottom(item: TabBarModel, index: number) {
    Column() {
      Image(this.selectedIndex == index ? item.imageActivated : item.imageOriginal)
        .height($r('app.float.tab_image_size'))
        .width($r('app.float.tab_image_size'))
        .margin({
          top: $r('app.float.tab_margin_top'),
          bottom: $r('app.float.tab_margin_bottom')
        })
      Text(item.title)
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .height($r('app.float.tab_text_height'))
        .fontSize($r('app.float.tab_text_font_size'))
        .fontWeight(CommonConstants.TAB_ITEM_FONT_WEIGHT)
        .fontColor(this.selectedIndex === index ? $r('app.color.color_6D6F66') : $r('app.color.color_B0B0B0'))
        .textAlign(TextAlign.Center)
        .margin({
          bottom: $r('app.float.tab_text_margin_bottom')
        })
    }
    .justifyContent(FlexAlign.Center)
    .height(CommonConstants.FULL_HEIGHT_PERCENT)
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .backgroundColor($r("app.color.color_f5f5f5"))
  }
}