//
//  CGFloat.swift
//  login api
//
//  Created by yudha on 15/08/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import UIKit

/*
 Extension to make it convenient
 We can have a computed property called adjusted that adjusts the size based on the ratio
 */
extension CGFloat {
    var adjusted: CGFloat {
        return self * Device.ratio
    }
}
extension Double {
    var adjusted: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}
extension Int {
    var adjusted: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}
