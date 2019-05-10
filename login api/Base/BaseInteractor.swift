//
//  BaseInteractor.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class BaseInteractor: NSObject {
    
    private var _realm: Realm?
    
    var realm: Realm {
        if let realm = _realm {
            return realm
        }
        return try! Realm()
    }
    
    let api: APIConnector
    let preference: PreferenceManager
    var lastError: NSError? = nil
    let disposeBag = DisposeBag()
    
    convenience override init() {
        self.init(realm: nil, apiConnector: APIConnector.instance, preferenceManager: PreferenceManager.instance)
    }
    
    init(realm: Realm?, apiConnector: APIConnector, preferenceManager: PreferenceManager) {
        if let realm = realm {
            _realm = realm
        }
        self.api = apiConnector
        self.preference = preferenceManager
    }
}
