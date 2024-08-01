import { CommonTopBar } from '../../views/CommonTopBar'
import { router } from '@kit.ArkUI'
import { DefaultBar } from '../../views/DefaultBar'
import { passLogin, postUserInfo } from '../../http/apiService'
import { MMKV } from '@tencent/mmkv'
import { StorageKeys } from '../../constants/StorageKeys'
import { RoutePath } from '../../route/RoutePath'
import showToast from '../../utils/ToastUtils'


@Entry
@Component
export struct LoginPwPage{
  phoneController: TextInputController = new TextInputController()
  @State phone: string = ''
  @State password: string = ''
  @State checkBoxIv: Resource= $r('app.media.home_select_nor')
  @State isChecked: boolean = false
  build() {
    Stack({ alignContent: Alignment.Top }){
      Image($r('app.media.home_login_bg')).objectFit(ImageFit.Fill)
      Column(){
        CommonTopBar({
          title: '',
          rightBtn: '验证码登录',
          rightClick: (()=>{
            router.back()
          })
        })
        Text('账号密码登录')
          .fontSize(20)
          .fontColor($r('app.color.color_333333'))
          .fontWeight(FontWeight.Medium)
          .margin({
            top: $r('app.float.size_50'),
            left: $r('app.float.size_20')
          })
        this.phoneView()
        this.passWordView()
        this.agreementView()
        DefaultBar({
          buttonTv:'登录',
          onBtnClick: (()=>{
            if (this.phone === '') {
              showToast("请输入手机号")
              return
            }
            if (this.password === '') {
              showToast("请输入密码")
              return
            }
            this.login()
          })
        }).margin({
          left:$r('app.float.size_20'),
          right:$r('app.float.size_20')
        })
      }.alignItems(HorizontalAlign.Start)
    }
  }

  async login() {
    //登录
    let response = await passLogin(this.phone, this.password)
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

  @Builder
  phoneView() {
    TextInput({ text: this.phone, placeholder: '请输入手机号', controller: this.phoneController })
      .placeholderColor($r('app.color.color_999'))
      .placeholderFont({ size: 14, weight: 400 })
      .caretColor('#5CB5AE')
      .width('100%')
      .height(40)
      .margin({
        top: $r('app.float.size_30'),
        right: $r('app.float.size_20')
      })
      .fontSize(14)
      .fontColor($r('app.color.color_333333'))
      .backgroundColor('#00000000')
      .showUnderline(true)
      .type(InputType.Number)
      .borderRadius(30)
      .underlineColor('#FFEAEAEA')
      .onChange((value: string) => {
        this.phone = value
      })
  }
  @Builder
  passWordView() {
    TextInput({ text: this.password, placeholder: '请输入密码', controller: this.phoneController })
      .placeholderColor($r('app.color.color_999'))
      .placeholderFont({ size: 14, weight: 400 })
      .caretColor('#5CB5AE')
      .width('100%')
      .height(40)
      .margin({
        top: $r('app.float.size_20'),
        right: $r('app.float.size_20')
      })
      .fontSize(14)
      .fontColor($r('app.color.color_333333'))
      .backgroundColor('#00000000')
      .showUnderline(true)
      .underlineColor('#EAEAEA')
      .type(InputType.Password)
      .onChange((value: string) => {
        this.password = value
      })
  }
  @Builder
  agreementView() {
    Row() {
      Image(this.checkBoxIv)
        .height($r('app.float.size_20'))
        .width($r("app.float.size_20"))
        .margin({ left: $r('app.float.size_20') })
      Text('我已同意并阅读').fontSize(14).fontColor($r('app.color.color_999')).opacity(0.5).margin({ left: $r('app.float.size_5') })
      Text('《用户协议》').fontSize(14).fontColor($r('app.color.color_FFAACC05'))
      Text('《隐私协议》').fontSize(14).fontColor($r('app.color.color_FFAACC05'))
    }.onClick(()=>{
      if (this.isChecked == false) {
        this.isChecked = true
        this.checkBoxIv = $r('app.media.home_select_pre_1')
      }else{
        this.isChecked = false
        this.checkBoxIv = $r('app.media.home_select_nor')
      }
    }).margin({ top: $r('app.float.size_20') })
  }
}