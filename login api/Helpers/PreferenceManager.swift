//
//  PreferenceManager.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import CoreLocation

class PreferenceManager: NSObject {
    
    static let instance = PreferenceManager()
    
    private static let LastLocationLatitude = "lastLocationLatitude"
    private static let LastLocationLongitude = "lastLocationLongitude"
    private static let UserId = "id"
    private static let PhoneNumber = "phoneNumber"
    private static let Email = "email"
    private static let PremiumDate = "premiumDate"
    private static let FullName = "fullName"
    private static let Token = "token"
    private static let BuildVersion = "buildVersion"
    private static let Launched = "launched"
    private static let UseCodeNow = "useCodeNow"
    private static let Language = "lang"
    private static let Currency = "currency"
    
    private let userDefaults: UserDefaults
    
    override init() {
        userDefaults = UserDefaults.standard
    }
    
    init(userDefaults: UserDefaults){
        self.userDefaults = userDefaults
    }
    
    var lastLocation: CLLocationCoordinate2D? {
        get {
            if let latitude = userDefaults.object(forKey: PreferenceManager.LastLocationLatitude) as? Double,
                let longitude = userDefaults.object(forKey: PreferenceManager.LastLocationLongitude) as? Double {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
            return nil
        }
        set(newLocation){
            if let latitude = newLocation?.latitude,
                let longitude = newLocation?.longitude {
                userDefaults.set(latitude, forKey: PreferenceManager.LastLocationLatitude)
                userDefaults.set(longitude, forKey: PreferenceManager.LastLocationLongitude)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.LastLocationLatitude)
                userDefaults.removeObject(forKey: PreferenceManager.LastLocationLongitude)
            }
        }
    }
    
    var userId: String? {
        get {
            if let userId = userDefaults.value(forKey: PreferenceManager.UserId) as? String {
                return userId
            }
            return nil
        }
        set(newId){
            if let id = newId {
                userDefaults.set(id, forKey: PreferenceManager.UserId)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.UserId)
            }
        }
    }
    
    var buildVersion: Int? {
        get {
            return userDefaults.object(forKey: PreferenceManager.BuildVersion) as? Int
        }
        set(newBuildVersion){
            if let buildVersion = newBuildVersion {
                userDefaults.set(buildVersion, forKey: PreferenceManager.BuildVersion)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.BuildVersion)
            }
        }
    }
    
    var token: String? {
        get {
            return userDefaults.object(forKey: PreferenceManager.Token) as? String
        }
        set(newToken) {
            if let token = newToken {
                userDefaults.set(token, forKey: PreferenceManager.Token)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.Token)
            }
        }
    }
    
    var fullName: String? {
        get {
            return userDefaults.object(forKey: PreferenceManager.FullName) as? String
        }
        set(newFullName){
            if let fullName = newFullName {
                userDefaults.set(fullName, forKey: PreferenceManager.FullName)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.FullName)
            }
        }
    }
    
    var email: String? {
        get {
            return userDefaults.object(forKey: PreferenceManager.Email) as? String
        }
        set(newEmail){
            if let email = newEmail {
                userDefaults.set(email, forKey: PreferenceManager.Email)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.Email)
            }
        }
    }
    
    var premiumDate: String? {
        get {
            return userDefaults.object(forKey: PreferenceManager.PremiumDate) as? String
        }
        set(newPremiumDate){
            if let premiumDate = newPremiumDate {
                userDefaults.set(premiumDate, forKey: PreferenceManager.PremiumDate)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.PremiumDate)
            }
        }
    }
    
    var phoneNumber: String? {
        get {
            return userDefaults.object(forKey: PreferenceManager.PhoneNumber) as? String
        }
        set(newPhoneNumber){
            if let phoneNumber = newPhoneNumber {
                userDefaults.set(phoneNumber, forKey: PreferenceManager.PhoneNumber)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.PhoneNumber)
            }
        }
    }
    
    var launched: Bool? {
        get {
            return userDefaults.bool(forKey: PreferenceManager.Launched)
        }
        set(launched){
            if let launched = launched {
                userDefaults.set(launched, forKey: PreferenceManager.Launched)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.Launched)
            }
        }
    }
    
    var language: String? {
        get {
            return userDefaults.string(forKey: PreferenceManager.Language)
        }
        set(newLanguage){
            if let language = newLanguage {
                userDefaults.set(language, forKey: PreferenceManager.Language)
            }else {
                userDefaults.removeObject(forKey: PreferenceManager.Language)
            }
        }
    }
}
