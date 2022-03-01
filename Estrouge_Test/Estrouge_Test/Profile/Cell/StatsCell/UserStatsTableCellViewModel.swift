//
//  UserStatsTableCellViewModel.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import Foundation

final class UserStatsTableCellViewModel {
    
    var totalPubRepo: Int?
    var totalFollower: Int?
    var totalFollowing: Int?
    
    init(totalPubRepo: Int?, totalFollower: Int?, totalFollowing: Int?) {
        self.totalPubRepo = totalPubRepo
        self.totalFollower = totalFollower
        self.totalFollowing = totalFollowing
    }
}
