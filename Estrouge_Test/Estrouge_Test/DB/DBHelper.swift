//
//  DBHelper.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import Realm
import RealmSwift

final class DBHelper {
    
    static func getUsers() -> [User] {
        guard let realm = try? Realm() else {
            return []
        }
        
        return Array(realm.objects(User.self))
    }
    
    static func add(_ users: [User]) {
        do {
            guard let realm = try? Realm() else {
                return
            }
            
            try realm.write {
                realm.add(users, update: Realm.UpdatePolicy.all)
            }
        } catch let error {
            print(error)
        }
    }
    
    static func update(_ block: () -> ()) {
        do {
            guard let realm = try? Realm() else {
                return
            }
            try realm.write {
                block()
            }
        } catch let error {
            print(error)
        }
    }
}
