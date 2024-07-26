import dataPreferences from '@ohos.data.preferences'
/**
 * 项目全局存储，使用ohos.data.preferences
 */
const defaultPreferenceName = "OPEN_EYE_PREFERENCES"

type ValueType = number | string | boolean | Array<number> | Array<string> | Array<boolean>;


export class StorageUtils {
  private constructor() {
  }

  static readonly context = getContext();

  /**
   * 获取Prefer实例
   * @param preferenceName
   * @returns
   */

  static async put(context:Context,key: string, value: ValueType, preferenceName: string = defaultPreferenceName) {
    // 获取实例
    let preferences = await dataPreferences.getPreferences(context,preferenceName)
    await preferences.put(key, value)
    //Tips Point ---此处一定要flush，要不然不能永久序列化到本地
    await preferences.flush()
  }
  /**
   * 获取值
   * @param key
   * @param defaultValue
   * @param preferenceName
   * @returns
   */
  static async get(context:Context,key: string, defaultValue: ValueType = "", preferenceName: string = defaultPreferenceName) {
    // 获取实例
    let preferences = await dataPreferences.getPreferences(context,preferenceName)
    return preferences.get(key, defaultValue)
  }

  /**
   * 删除值
   * @param key
   * @param preferenceName
   * @returns
   */
  static async delete(context:Context ,key: string, preferenceName: string = defaultPreferenceName) {
    let preferences = await dataPreferences.getPreferences(context,preferenceName)
    return await preferences.delete(key)
  }

  /**
   * 清空
   * @param preferenceName
   * @returns
   */
  static async clear(context:Context,preferenceName: string = defaultPreferenceName) {
    let preferences = await dataPreferences.getPreferences(context,preferenceName)
    return await preferences.clear()
  }
}