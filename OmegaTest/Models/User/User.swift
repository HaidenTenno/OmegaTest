//
//  User.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 19.06.2021.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var age = 0
    @objc dynamic var phoneNumber = ""
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    
    init(firstName: String, lastName: String, age: Int, phoneNumber: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.password = password
    }
    
    override static func primaryKey() -> String? {
        return "email"
    }
    
}
