//
//  StoryboardManager.swift
//  login api
//
//  Created by Yudha on 10/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import UIKit

class StoryboardManager : NSObject {
    static let instance = StoryboardManager()
    
    let main: UIStoryboard
    
    override init() {
        main = UIStoryboard(name: "Main", bundle: nil)
        
        super.init()
    }
}
