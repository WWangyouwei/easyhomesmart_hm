@Component
export struct MinePage{
  build(){
    Stack({ alignContent: Alignment.Top }){
      Text('我的').fontColor('#333333')
    }
  }
}