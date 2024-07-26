
@Component
export struct DefaultBar{
  @Prop buttonTv: string
  private onBtnClick?: () => void
  private constructor() {
    super()
  }
  build() {
    //按钮
    Row() {
      Button(this.buttonTv, { type: ButtonType.Capsule, stateEffect: true })
        .fontSize(16)
        .width('100%')
        .height($r('app.float.size_40'))
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.onBtnClick?.()
        })
    }
    .margin({ top: $r('app.float.size_30') })
    .borderRadius(30)
    .linearGradient({
      angle: 90,
      colors: [[0xAACC05, 0.0], [0x05CCB2, 1.0]]
    })
  }
}