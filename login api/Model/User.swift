//
//  User.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class User: Object {
    @objc dynamic var user_id: String?
    @objc dynamic var customer_id: String?
    @objc dynamic var full_name: String?
    @objc dynamic var email: String?
    @objc dynamic var ref_telco_number: String?
    @objc dynamic var phone_number: String?
    @objc dynamic var gender: String?
    @objc dynamic var city: String?
    @objc dynamic var birth_date: String?
    @objc dynamic var address: String?
    @objc dynamic var register_via: String?
    @objc dynamic var store: String?
    @objc dynamic var premium_expired: String?
    @objc dynamic var is_renewal: String?
    @objc dynamic var premium_days: Int64 = 0
    @objc dynamic var current_time: String?
    
    override static func primaryKey() -> String? {
        return "user_id"
    }
    
    static func with(realm: Realm, json: JSON) -> User? {
        let identifier = json["user_id"].stringValue
        if identifier == "" {
            return nil
        }
        
        var user = realm.object(ofType: User.self, forPrimaryKey: identifier)
        
        if user == nil {
            user = User()
            user?.user_id = identifier
        }else {
            user = User(value: user!)
        }
        if json["email"].exists() {
            user?.email = json["email"].string
        }
        if json["full_name"].exists() {
            user?.full_name = json["full_name"].string
        }
        if json["gender"].exists() {
            user?.gender = json["gender"].string
        }
        if json["current_time"].exists() {
            user?.current_time = json["current_time"].string
        }
        if json["is_renewal"].exists() {
            user?.is_renewal = json["is_renewal"].string
        }
        if json["premium_expired"].exists() {
            user?.premium_expired = json["premium_expired"].string
        }
        if json["store"].exists() {
            user?.store = json["store"].string
        }
        if json["register_via"].exists() {
            user?.register_via = json["register_via"].string
        }
        if json["address"].exists() {
            user?.address = json["address"].string
        }
        if json["birth_date"].exists() {
            user?.birth_date = json["birth_date"].string
        }
        if json["city"].exists() {
            user?.city = json["city"].string
        }
        if json["phone_number"].exists() {
            user?.phone_number = json["phone_number"].string
        }
        if json["ref_telco_number"].exists() {
            user?.ref_telco_number = json["ref_telco_number"].string
        }
        if json["customer_id"].exists() {
            user?.customer_id = json["customer_id"].string
        }
        
        return user
    }
    
    static func with(json: JSON) -> User? {
        return with(realm: try! Realm(), json: json)
    }
}
