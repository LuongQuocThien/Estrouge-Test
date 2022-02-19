//
//  UserListTableCellViewModel.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import Foundation

final class UserListTableCellViewModel {
    
    var avataUrl: String?
    var userName: String?
    var url: String?
    
    init(avataUrl: String?, userName: String?, url: String?) {
        self.avataUrl = avataUrl
        self.userName = userName
        self.url = url
    }
}
