//
//  UserListTableCellViewModel.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import Foundation

final class UserListTableCellViewModel {
    
    var imageData: Data?
    var userName: String?
    var url: String?
    
    init(imageData: Data?, userName: String?, url: String?) {
        self.imageData = imageData
        self.userName = userName
        self.url = url
    }
}
