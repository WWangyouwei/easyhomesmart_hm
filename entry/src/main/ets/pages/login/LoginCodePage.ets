import router from '@ohos.router'
import showToast from '../../utils/ToastUtils'
import { postUserInfo, sendCode, smsLogin } from '../../http/apiService'

import { StorageKeys } from '../../constants/StorageKeys'
import { MMKV } from '@tencent/mmkv'
import { RoutePath } from '../../route/RoutePath'
import { DefaultBar } from '../../views/DefaultBar'

@Entry
@Component
export struct LoginCodePage {
  controller: VideoController = new VideoController()
  phoneController: TextInputController = new TextInputController()
  @State phone: string = ''
  @State code: string = ''
  @State postCode: boolean = false
  @State getCodeTv: string = ''
  @State timeNum: number = 60
  @State buttonTv: string = '获取验证码'
  time: number = 0
  @State checkBoxIv: Resource = $r('app.media.home_select_nor')
  @State isChecked: boolean = false

  aboutToAppear() {
    this.controller.start()
  }

  //StorageUtils.put(StorageKeys.USER_INFO_KEY, "allen")
  build() {
    Stack({ alignContent: Alignment.Top }) {
      this.MyVideos()
      Column() {
        this.TopView()
        Image($r('app.media.logo_icon'))
          .height(60)
          .width(60)
          .objectFit(ImageFit.ScaleDown)
          .margin({
            left: $r('app.float.size_30'), right: $r('app.float.size_30'),top: $r('app.float.size_120')
          })
        Image($r('app.media.home_login_text'))
          .width(150)
          .height(60)
          .margin({ top: $r('app.float.size_20'),left: $r('app.float.size_30') })
          .objectFit(ImageFit.ScaleDown)

        this.phoneView()
        //验证码
        this.codeView()
        //按钮
        DefaultBar({
          buttonTv: this.buttonTv,
          onBtnClick: (()=>{
            this.btnClick()
          })
        }).margin({left: $r('app.float.size_30') ,right: $r('app.float.size_30')})

        //协议
        this.agreementView()
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ top: $r('app.float.size_20')})
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.Transparent)
    .width('100%')
    .height('100%')
  }
  btnClick (){
    if (this.postCode == true) {
      //登录
      if (this.code == "") {
        showToast("请输入验证码")
        return
      }
      this.login()
    } else {
      //获取验证码
      if (this.phone == "") {
        showToast("请输入手机号")
        return
      } else if (this.isChecked == false) {
        showToast("请勾选下方隐私条款")
        return
      }
      this.getCode()
    }
  }
  async getCode() {
    //获取验证码
    let response = await sendCode(this.phone)
    if (response.data) {
      showToast("发送成功")
      this.postCode = true
      this.buttonTv = '登录'
      this.startTimer()
    }
  }

  async login() {
    //登录
    let response = await smsLogin(this.phone, this.code)
    if (response.data) {
      MMKV.defaultMMKV().encodeString(StorageKeys.TOKEN, response.data.accessToken)
      this.getUserInfo();
    }
  }

  async getUserInfo() {
    let response = await postUserInfo()
    if (response.data) {
      MMKV.defaultMMKV().encodeString(StorageKeys.USER_INFO, JSON.stringify(response.data))
      MMKV.defaultMMKV().encodeString(StorageKeys.USER_ID, response.data.id)
      MMKV.defaultMMKV().encodeString(StorageKeys.USER_NAME, response.data.userName)
      router.replaceUrl({ url: RoutePath.MainPage })
    }
  }

  startTimer() {
    this.time = setInterval(() => {
      this.timeNum--
      this.getCodeTv = `${this.timeNum}秒`
      if (this.timeNum == 0) {
        clearTimeout(this.time)
        this.timeNum = 60
        this.getCodeTv = '再次获取验证码'
      }
    }, 1000)
  }

  @Builder
  phoneView() {
    TextInput({ text: this.phone, placeholder: '请输入手机号', controller: this.phoneController })
      .placeholderColor(Color.White)
      .placeholderFont({ size: 14, weight: 400 })
      .caretColor(Color.White)
      .height(40)
      .fontSize(14)
      .fontColor(Color.White)
      .backgroundColor('#44FFFFFF')
      .inputFilter('[0-9]', (e) => {
        console.log(JSON.stringify(e))
      })
      .margin({ top: $r('app.float.size_20'),left: $r('app.float.size_30') ,right: $r('app.float.size_30')})
      .borderRadius(30)
      .onChange((value: string) => {
        this.phone = value
      })
  }

  @Builder
  codeView() {
    Row() {
      TextInput({ text: this.code, placeholder: '请输入验证码', controller: this.phoneController })
        .placeholderColor(Color.White)
        .placeholderFont({ size: 14, weight: 400 })
        .caretColor('app.color.color_FFAACC05')
        .fontSize(14)
        .layoutWeight(1)
        .height('100')
        .fontColor(Color.White)
        .inputFilter('[0-9]', (e) => {
          console.log(JSON.stringify(e))
        })
        .margin({ top: $r('app.float.size_10'),left: $r('app.float.size_30') ,right: $r('app.float.size_30')})
        .onChange((value: string) => {
          this.code = value
        })
      Text(this.getCodeTv)
        .fontColor(Color.White)
        .fontSize(12)
        .margin({ right: $r('app.float.size_10') })
        .onClick(() => {
          if (this.getCodeTv === "再次获取验证码") {
            this.getCode()
          }
        })
    }
    .width('100%')
    .height(40)
    .backgroundColor('#44FFFFFF')
    .margin({ top: $r('app.float.size_30') })
    .borderRadius(30)
    .visibility(this.postCode ? Visibility.Visible : Visibility.None)
  }

  @Builder
  TopView() {
    Row() {
      Image($r('app.media.back_white'))
        .height($r('app.float.size_16'))
        .width($r('app.float.size_16'))
        .objectFit(ImageFit.ScaleDown)
        .align(Alignment.Center)
        .onClick(() => {
          router.back();
        })
      // 设置最小宽度为160
      Blank('160')
      Text('密码登录')
        .fontSize(14)
        .fontColor(Color.White)
        .onClick(()=>{
          router.pushUrl({ url: RoutePath.LoginPwPage })
        })
    }
    .backgroundColor(Color.Transparent)
    .borderRadius(15)
    .padding({ top: $r('app.float.size_35'), left: $r('app.float.size_15'), right: $r('app.float.size_15') })
    .width('100%')
  }

  @Builder
  agreementView() {
    Row() {
      Image(this.checkBoxIv)
        .height($r('app.float.size_20'))
        .width($r("app.float.size_20"))
      Text('我已同意并阅读').fontSize(14).fontColor(Color.White).opacity(0.5).margin({ left: $r('app.float.size_5') })
      Text('《用户协议》').fontSize(14).fontColor(Color.White)
      Text('《隐私协议》').fontSize(14).fontColor(Color.White)
    }.onClick(() => {
      if (this.isChecked == false) {
        this.isChecked = true
        this.checkBoxIv = $r('app.media.home_select_pre_1')
      } else {
        this.isChecked = false
        this.checkBoxIv = $r('app.media.home_select_nor')
      }
    })
    .margin({ top: $r('app.float.size_20'),left: $r('app.float.size_30') ,right: $r('app.float.size_30')})
  }

  @Builder
  MyVideos() {
    Column() {
      Video({
        src: $rawfile('login_media.mp4'),
        currentProgressRate: PlaybackSpeed.Speed_Forward_1_00_X,
        controller: this.controller
      })
        .width('100%')
        .height('100%')
        .autoPlay(true)
        .controls(false)
        .loop(true)
        .onStart(() => {
        })
    }
    .width('100%')
    .height('100%')
  }

  aboutToDisappear() {
    clearTimeout(this.time)
  }
}