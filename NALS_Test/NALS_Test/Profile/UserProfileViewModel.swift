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
    
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func numberOfRow() -> Int {
        return RowType.allCases.count
    }
    
    func userListTableCellViewModel() -> UserListTableCellViewModel? {
        return UserListTableCellViewModel(imageData: user?.imageData,
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
        guard let login = user?.login else {
            return
        }

        let api = GetDetailAPI()
        api.getUserDetail(login: login) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.cancelRequest))
                return
            }
            switch result {
            case .success(let response):
                this.user?.updateData(newData: response)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
