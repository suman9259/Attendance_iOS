//
//  KeyConstants.swift
//  locksmith-user
//
//  Created by Dhruv Rawat on 17/12/24.
//

import Foundation
import UIKit



struct FunctionsConstants {
    
    static let kSharedUserDefaults = UserDefaults.standard
    static let kSharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let kScreenWidth = UIScreen.main.bounds.width
    static let kScreenHeight = UIScreen.main.bounds.height
}



struct KeyConstants {
    
    
    static let kMessage = "message"
    static let kAuthorization = "Authorization"
    
    
    static let kUserName = "username"
    static let kPassword = "password"
    static let kDeviceToken = "device_token"
}
