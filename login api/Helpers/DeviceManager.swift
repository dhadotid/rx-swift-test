//
//  DeviceManager.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import SAMKeychain

class DeviceManager: NSObject {
    
    static func UUID() -> String? {
        
        let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        let accountName = "incoding"
        let elseID = UIDevice.current.name + "-" + UIDevice.current.localizedModel
        var applicationUUID = SAMKeychain.password(forService: bundleName, account: accountName)
        
        if applicationUUID == nil {
            applicationUUID = UIDevice.current.identifierForVendor!.uuidString
            
            let query = SAMKeychainQuery()
            query.service = bundleName
            query.account = accountName
            query.password = applicationUUID
            query.synchronizationMode = SAMKeychainQuerySynchronizationMode.no
            
            do {
                try query.save()
            }catch let error as NSError {
                print("SAMKeychainQuery Exception: \(error)")
            }
        }
        if let appUUID = applicationUUID {
            return appUUID
        }
        print("uuid doesn't exist! so this is the else: \(elseID)")
        return elseID
    }
}
