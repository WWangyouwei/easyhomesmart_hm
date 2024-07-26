import { NavComponent } from '../views/NavComponent'
import { WebComponent } from '../views/WebComponent'
@Entry
@Component
export struct WebComp {
  build() {
    Column() {
      NavComponent({
        title: 'webview'
      })
      WebComponent({
        url: 'https://www.baidu.com'
      })
    }
  }
}