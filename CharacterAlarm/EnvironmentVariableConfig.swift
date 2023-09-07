import Foundation

struct EnvironmentVariableConfig {
    // APIのエンドポイント
    static var apiEndpoint: String {
        return Bundle.main.infoDictionary?["API_ENDPOINT"] as? String ?? ""
    }
    
    // リソースのエンドポイント
    static var resourceEndpoint: String {
        return Bundle.main.infoDictionary?["RESOURCE_ENDPOINT"] as? String ?? ""
    }
    
    // AdmobのユニットID: AlarmList
    static var admobAlarmListUnitID: String {
        return Bundle.main.infoDictionary?["ADMOB_ALARM_LIST"] as? String ?? ""
    }
    
    // AdmobのユニットID: Config
    static var admobConfigUnitID: String {
        return Bundle.main.infoDictionary?["ADMOB_CONFIG"] as? String ?? ""
    }
    
    // サブスクのIDを取得
    static var subscriptionProductID: String {
        return Bundle.main.infoDictionary?["SUBSCRIPTION_PRODUCT_ID"] as? String ?? ""
    }
}
