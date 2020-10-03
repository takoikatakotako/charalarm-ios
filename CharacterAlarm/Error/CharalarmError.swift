import Foundation

enum CharalarmError: Error {
    case clientError
    case serverError
    case parseError
}

extension CharalarmError:LocalizedError{
    var errorDescription:String?{
        switch self {
        case .clientError:
            return "クライアントエラー。ネットワークを確認してください"
        case .serverError:
            return "サーバーエラー。サーバーからのデータ取得に失敗しました。"
        case .parseError:
            return "クライアントエラー。データのパースに失敗しました。"
        }
    }
}
