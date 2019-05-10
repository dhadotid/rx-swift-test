//
//  LocaleManager.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import UIKit

enum AladinLanguage {
    case English
    case Indonesia
    
    func toString() -> String {
        if self == .Indonesia {
            return "id"
        }else {
            return "en"
        }
    }
}

enum AladinCurrency {
    case USD
    case IDR
}

class LocaleManager: NSObject {
    
    static let instance = LocaleManager()
    
    private let numberFormatter = NumberFormatter()
    private let dateFormatter = DateFormatter()
    
    var bundle: Bundle?
    
    var language: AladinLanguage {
        get {
            if let language = PreferenceManager.instance.language {
                if language == "id" {
                    return .Indonesia
                }
            }
            return .English
        }
        set(newLanguage) {
            if newLanguage == .Indonesia {
                PreferenceManager.instance.language = "id"
                languageSetup(language: "id")
                return
            }
            PreferenceManager.instance.language = "en"
            languageSetup(language: "en")
        }
    }
    func languageSetup(language: String?) -> Bundle {
        var tempLanguage: String?
        if let language = language {
            tempLanguage = language
        }else {
            tempLanguage = "en"
        }
        var bundle: Bundle?
        let path = Bundle.main.path(forResource: tempLanguage, ofType: "lproj")
        if path != nil {
            bundle = Bundle(path: path!)
        }
        if bundle == nil {
            bundle = Bundle.main
        }
        self.bundle = bundle
        return bundle!
    }
}
