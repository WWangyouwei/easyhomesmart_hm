import { webview } from '@kit.ArkWeb'
import { logger } from '../http/logger'

@Component
export struct WebComponent {
  layoutMode: WebLayoutMode = WebLayoutMode.NONE
  url:string = ""
  onLoad: () => void = () => {
  }
  controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Web({ src: this.url, controller: this.controller })
      .javaScriptAccess(true)
      .onPageEnd(() => {
        this.onLoad()
      })
      .onErrorReceive(event => {
        logger.error(event!.error.getErrorInfo())
      })
      .layoutMode(this.layoutMode)
      .layoutWeight(1)
  }
}