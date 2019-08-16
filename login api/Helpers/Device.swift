//
//  Device.swift
//  login api
//
//  Created by yudha on 15/08/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import UIKit

class Device {
    
    // Base width in point, use iPhone 6
    static let base: CGFloat = 375
    
    static var ratio: CGFloat {
        return UIScreen.main.bounds.width / base
    }
}


