import Foundation

struct EnvironmentVariable {
    // APIのエンドポイント、AppDelegateで取得
    var apiEndpoint: String = ""

    // リソースのエンドポイント、AppDelegateで取得
    var resourceEndpoint: String = ""

    // AdmobのユニットID、AppDelegateで取得
    var admobAlarmListUnitID: String = ""
    var admobConfigUnitID: String = ""
}

var environmentVariable = EnvironmentVariable()
