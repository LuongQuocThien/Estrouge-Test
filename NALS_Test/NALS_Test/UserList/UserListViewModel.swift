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
}
