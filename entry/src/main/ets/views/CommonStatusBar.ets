/**
 * 自定义App顶部状态栏
 */
import router from '@ohos.router'
import window from '@ohos.window';
import { LogUtils } from '../utils/LogUtils';
import { Button } from '@kit.InputKit';

@Component
export struct CommonStatusBar {
  @Prop statusBarColor?: Color;
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.setSystemStatusBar()
  }

  setSystemStatusBar() {
    window.getLastWindow(getContext(this), (error, data) => {
      let avoidArea1 = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      let avoidArea2 = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);

      this.statusBarHeight = px2vp(avoidArea1.topRect.height);
      LogUtils.debug("顶部状态栏的高度", `${this.statusBarHeight}`)
    })
  }

  build() {
    Blank()
      .width("100%")
      .height(this.statusBarHeight)
      .backgroundColor(this.statusBarColor)
  }
}