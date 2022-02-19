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
    var location: String?
    var bio: String?
    var pubRepo: Int?
    var follower: Int?
    var following: Int?
    
    init(avataUrl: String?, userName: String?, url: String?,
         location: String?, bio: String?, pubRepo: Int?,
         follower: Int?, following: Int?) {
        self.avataUrl = avataUrl
        self.userName = userName
        self.url = url
        self.location = location
        self.bio = bio
        self.pubRepo = pubRepo
        self.follower = follower
        self.following = following
    }
    
    init(from decoder: Decoder) throws {
        avataUrl = decoder.decode(CodingKeys.avataUrl, as: String.self)
        userName = decoder.decode(CodingKeys.userName, as: String.self)
        url = decoder.decode(CodingKeys.url, as: String.self)
        location = decoder.decode(CodingKeys.location, as: String.self)
        bio = decoder.decode(CodingKeys.bio, as: String.self)
        pubRepo = decoder.decode(CodingKeys.pubRepo, as: Int.self)
        follower = decoder.decode(CodingKeys.follower, as: Int.self)
        following = decoder.decode(CodingKeys.following, as: Int.self)
    }
}

extension User {
    enum CodingKeys: String, CodingKey {
        case avataUrl = "avatar_url"
        case userName = "login"
        case url
        case location
        case bio
        case pubRepo = "public_repos"
        case follower = "followers"
        case following = "following"
    }
}
