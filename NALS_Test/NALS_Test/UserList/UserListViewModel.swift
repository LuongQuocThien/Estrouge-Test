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
        
        let user = users[indexPath.row]
        return UserListTableCellViewModel(avataUrl: user.avataUrl,
                                          userName: user.userName,
                                          url: user.url)
    }
    
    func userProfileViewModel(indexPath: IndexPath) -> UserProfileViewModel? {
        guard indexPath.row < users.count else { return nil }
        
        let userName = users[indexPath.row].userName
        return UserProfileViewModel(userName: userName)
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

#warning("If you dont want to load api in detail, use this code")
extension UserListViewModel {
    
    private func loadUserDetails(completion: @escaping () -> Void) {
        let userNames = users.map({ $0.userName })
        
        let dispatchGroup = DispatchGroup()
        
        for userName in userNames {
            dispatchGroup.enter()
            
            getUserProfile(userName: userName) { [weak self] result in
                dispatchGroup.leave()
                
                guard let this = self else {
                    return
                }
                
                switch result {
                case .success((let userName, let response)):
                    this.updateUserDetail(userName: userName, userInfo: response)
                case .failure(_):
                    break
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func updateUserDetail(userName: String, userInfo: User) {
        let user = users.first(where: { $0.userName == userName })
        user?.location = userInfo.location
        user?.bio = userInfo.bio
        user?.pubRepo = userInfo.pubRepo
        user?.follower = userInfo.follower
        user?.following = userInfo.following
    }
    
    func getUserProfile(userName: String?, completion: @escaping Completion<(String, User)>) {
        guard let userName = userName else {
            return
        }

        let api = GetDetailAPI()
        api.getUserDetail(userName: userName) { result in
            switch result {
            case .success(let response):
                completion(.success((userName, response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
