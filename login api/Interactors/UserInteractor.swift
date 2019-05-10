//
//  UserInteractor.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import SwiftyJSON

class UserInteractor: BaseInteractor {
    var user = Variable<User?>(nil)
    
    func signIn(email: String, password: String) -> Observable<User> {
        return api.signIn(email: email, password: password).do(onNext: {
            user in
            self.user.value = user
            if let u = user.user_id {
                PreferenceManager.instance.userId = u
            }
            if let e = user.email {
                PreferenceManager.instance.email = e
            }
            
            if let p = user.premium_expired {
                PreferenceManager.instance.premiumDate = p
            }
            
            try! self.realm.write {
                self.realm.create(User.self, value: user, update: true)
            }
        })
    }
}
