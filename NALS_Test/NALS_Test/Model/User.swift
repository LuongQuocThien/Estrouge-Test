//
//  User.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import Foundation

final class User: Codable {
    
    var avataUrl: String?
    var userName: String?
    var url: String?
    
    init(avataUrl: String?, userName: String?, url: String?) {
        self.avataUrl = avataUrl
        self.userName = userName
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        avataUrl = decoder.decode(CodingKeys.avataUrl, as: String.self)
        userName = decoder.decode(CodingKeys.userName, as: String.self)
        url = decoder.decode(CodingKeys.url, as: String.self)
    }
}

extension User {
    enum CodingKeys: String, CodingKey {
        case avataUrl = "avatar_url"
        case userName = "login"
        case url
    }
}
