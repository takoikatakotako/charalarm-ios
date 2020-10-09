import Foundation

class ResourceStore {
    static func downloadSelfIntroduction(charaDomain: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: ResourceHandler.getSelfIntroductionUrlString(charaDomain: charaDomain))!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    let message = """
                クライアントエラー(\(error.localizedDescription))
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                    print(message)
                    completion(.failure(CharalarmError.clientError))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    let message = """
                サーバーエラー
                URL: \(url.absoluteURL)
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                    print(message)
                    completion(.failure(CharalarmError.serverError))
                    return
                }
                
                if response.statusCode == 200 {
                    do {
                        try FileHandler.saveFile(directoryName: charaDomain, fileName: "self-introduction.caf", data: data)
                        completion(.success("自己紹介の保存に成功しました"))
                    } catch {
                        let message = """
                    ファイル保存に失敗
                    File: \(#file)
                    Function: \(#function)
                    Line: \(#line)
                    """
                        print(message)
                        completion(.failure(error))
                    }
                } else {
                    let message = """
                サーバーエラー
                URL: \(url.absoluteURL)
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                    print(message)
                    completion(.failure(CharalarmError.serverError))
                }
            }
        }
        task.resume()
    }    
}
