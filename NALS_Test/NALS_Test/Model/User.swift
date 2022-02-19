//
//  User.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import Realm
import RealmSwift

final class User: Object, Codable {
    
    @objc dynamic var avataUrl: String? = nil
    @objc dynamic var imageData: Data? = nil
    @objc dynamic var userName: String? = nil
    @objc dynamic var url: String? = nil
    @objc dynamic var location: String? = nil
    @objc dynamic var bio: String? = nil
    @objc dynamic var pubRepo: Int = 0
    @objc dynamic var follower: Int = 0
    @objc dynamic var following: Int = 0
    
    override class func primaryKey() -> String? {
        return "userName"
    }
    
    required override init() {
        super.init()
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        avataUrl = decoder.decode(CodingKeys.avataUrl, as: String.self)
        userName = decoder.decode(CodingKeys.userName, as: String.self)
        url = decoder.decode(CodingKeys.url, as: String.self)
        location = decoder.decode(CodingKeys.location, as: String.self)
        bio = decoder.decode(CodingKeys.bio, as: String.self)
        pubRepo = decoder.decode(CodingKeys.pubRepo, as: Int.self) ?? 0
        follower = decoder.decode(CodingKeys.follower, as: Int.self) ?? 0
        following = decoder.decode(CodingKeys.following, as: Int.self) ?? 0
    }
    
    func updateData(newData: User) {
        DBHelper.update {
            self.location = newData.location
            self.bio = newData.bio
            self.pubRepo = newData.pubRepo
            self.follower = newData.follower
            self.following = newData.following
        }
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
