//
//  UserProfileViewModel.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import Foundation

final class UserProfileViewModel {
    
    enum RowType: Int, CaseIterable {
        case userBasicInfo
        case about
        case stats
    }
    
    var userName: String?
    var user: User?
    
    init(userName: String?) {
        self.userName = userName
    }
    
    func numberOfRow() -> Int {
        return RowType.allCases.count
    }
    
    func userListTableCellViewModel() -> UserListTableCellViewModel? {
        return UserListTableCellViewModel(avataUrl: user?.avataUrl,
                                          userName: user?.userName, url: user?.location)
    }
    
    func aboutUserTableCellViewModel() -> AboutUserTableCellViewModel? {
        return AboutUserTableCellViewModel(about: user?.bio)
    }
    
    func userStatsTableCellViewModel() -> UserStatsTableCellViewModel? {
        return UserStatsTableCellViewModel(totalPubRepo: user?.pubRepo,
                                           totalFollower: user?.follower,
                                           totalFollowing: user?.following)
    }
    
    func getUserProfile(completion: @escaping APICompletion) {
        guard let userName = userName else {
            return
        }

        let api = GetDetailAPI()
        api.getUserDetail(userName: userName) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.cancelRequest))
                return
            }
            switch result {
            case .success(let response):
                this.user = response
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
