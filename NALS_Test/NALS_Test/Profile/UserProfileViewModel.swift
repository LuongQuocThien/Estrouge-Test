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
    
    var avataUrl: String?
    var userName: String?
    var location: String?
    var bio: String?
    var pubRepo: Int?
    var follower: Int?
    var following: Int?
    
    init(userName: String?, location: String?, bio: String?, pubRepo: Int?, follower: Int?, following: Int?) {
        self.userName = userName
        self.location = location
        self.bio = bio
        self.pubRepo = pubRepo
        self.follower = follower
        self.following = following
    }
    
    func numberOfRow() -> Int {
        return RowType.allCases.count
    }
    
    func userListTableCellViewModel() -> UserListTableCellViewModel? {
        return UserListTableCellViewModel(avataUrl: avataUrl, userName: userName, url: location)
    }
    
    func aboutUserTableCellViewModel() -> AboutUserTableCellViewModel? {
        return AboutUserTableCellViewModel(about: bio)
    }
    
    func userStatsTableCellViewModel() -> UserStatsTableCellViewModel? {
        return UserStatsTableCellViewModel(totalPubRepo: pubRepo, totalFollower: follower, totalFollowing: following)
    }
}
