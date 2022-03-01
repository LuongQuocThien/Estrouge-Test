//
//  GetDetailAPI.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import Alamofire

struct GetDetailAPI {
    
    let endpoint = "https://api.github.com/users"
    
    func getUserDetail(login: String, completion: @escaping Completion<User>) {
        let path = endpoint + "/" + login
        
        Alamofire.SessionManager.default.requestWithoutCache(path, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let data = try?
                        JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                else {
                    completion(.failure(Api.Error.cancelRequest))
                    return
                }
                do {
                    let decodedInfo = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(decodedInfo))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
