/**
 * 展示Loading的Event
 * @param showLoading
 * @param "
 * @returns
 */
interface LoadingDialogEventInterface_1 {
  "showLoading": boolean;
  "loadingTips": string;
}

interface LoadingDialogEventInterface_2 {
  data: LoadingDialogEventInterface_1;
}

export function LoadingDialogEvent(showLoading: boolean, loadingTips: string = "加载中...") {
  return ({
    data: ({
      "showLoading": showLoading,
      "loadingTips": loadingTips
    } as LoadingDialogEventInterface_1)
  } as LoadingDialogEventInterface_2)
}
