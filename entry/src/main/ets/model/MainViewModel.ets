/**
 * MainAbility的ViewModel
 */
import { TabBarModel } from './TabBarModel';

export class MainViewModel {
  /**
   * 首页底部Tab显示数据
   */
  tabTitle : TabBarModel[] = [
    {
      index: 0,
      title: "首页",
      imageActivated: $r('app.media.home_1_pre'),
      imageOriginal: $r('app.media.home_1_nor')
    },
    {
      index: 1,
      title: "场景",
      imageActivated: $r('app.media.home_2_pre'),
      imageOriginal: $r('app.media.home_2_nor')
    },
    {
      index: 2,
      title: "热门",
      imageActivated: $r('app.media.home_3_pre'),
      imageOriginal: $r('app.media.home_3_nor')
    },
    {
      index: 3,
      title: "商城",
      imageActivated: $r('app.media.home_4_pre'),
      imageOriginal: $r('app.media.home_4_nor')
    },
    {
      index: 4,
      title: "我的",
      imageActivated: $r('app.media.home_4_pre'),
      imageOriginal: $r('app.media.home_4_nor')
    }
  ]
}

let mainViewModel = new MainViewModel();

export default mainViewModel as MainViewModel;