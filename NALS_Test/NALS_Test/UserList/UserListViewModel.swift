//
//  UserListViewModel.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import Foundation

final class UserListViewModel {
    
    var users: [User] = []
    
    func numberOfRow() -> Int {
        return users.count
    }
    
    func userListTableCellViewModel(indexPath: IndexPath) -> UserListTableCellViewModel? {
        guard indexPath.row < users.count else { return nil }
        return UserListTableCellViewModel(user: users[indexPath.row])
    }
    
    func getUserList(completion: @escaping APICompletion) {
        let api = GetUserAPI()
        
        api.getUserList { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.cancelRequest))
                return
            }
            switch result {
            case .success(let response):
                this.users = response
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
