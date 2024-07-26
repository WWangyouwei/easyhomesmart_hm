@Component
export struct BoardPage{
  build(){
    Stack({ alignContent: Alignment.Top }){
      Text('看板').fontColor('#333333')
    }
  }
}