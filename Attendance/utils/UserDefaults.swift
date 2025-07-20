//
//  UserDefaults.swift
//  locksmith-user
//
//  Created by Dhruv Rawat on 17/12/24.
//

import Foundation


extension UserDefaults {
    
    struct UserDefaultsConstants {
        
        static let kWalkthrough = "walkthrough"
        static let kAccessToken = "token"
        static let kTempToken = "temp_token"
        static let kUserData = "userdata"
        static let kFcmToken = "fcm_token"
        static let kRefreshToken = "refreshToken"
        static let kTempRefreshToken = "tempRefreshToken"
        static let kWorkerType = "workerType"
        static let kFaceAuthentication = "faceAuthentication"
        static let kMyGigsIndex = "myGigsIndex"
        static let kReferralCount = "referralCount"
        static let kCommissionValue = "commissionValue"
        
    }
    
    func setTempToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kTempToken)
        self.synchronize()
    }

    func getTempToken() -> String {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kTempToken) as? String
        return value == nil ? "" : value!
    }
    
    func setFcmToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kFcmToken)
        self.synchronize()
    }
    
    func getFcmToken() -> String {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kFcmToken) as? String
        return value == nil ? "" : value!
    }
    
    func setWalkThrough(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kWalkthrough)
        self.synchronize()
    }
    
    func getWalkThrough() -> Bool {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kWalkthrough) as? Bool
        return value == nil ? false : value!
    }
    
    func setAccessToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kAccessToken)
        self.synchronize()
    }
    
    func getAccessToken() -> String {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kAccessToken) as? String
        return value == nil ? "" : value!
    }
    
    
//    func setUserData(_ value: LoginData?) {
//        if let encodedUser = try? JSONEncoder().encode(value) {
//            UserDefaults.standard.set(encodedUser, forKey: UserDefaultsConstants.kUserData)
//            self.synchronize()
//        }
//    }
//    
//    func getUserData() -> LoginData? {
//        
//        if let savedUserData = UserDefaults.standard.data(forKey: UserDefaultsConstants.kUserData) {
//            if let savedUser = try? JSONDecoder().decode(LoginData.self, from: savedUserData) {
//                return savedUser
//            } else {
//                return nil
//            }
//        }
//        else {
//            return nil
//        }
//    }
    
    
    func setRefreshToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kRefreshToken)
        self.synchronize()
    }
    
    func getRefreshToken() -> String {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kRefreshToken) as? String
        return value == nil ? "" : value!
    }
    
    func setTempRefreshToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kTempRefreshToken)
        self.synchronize()
    }
    
    func getTempRefreshToken() -> String {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kTempRefreshToken) as? String
        return value == nil ? "" : value!
    }
    
    func setWorkerType(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kWorkerType)
        self.synchronize()
    }
    
    func getWorkerType() -> Bool {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kWorkerType) as? Bool
        return value ?? true
    }
    
    func setFaceAuthentication(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kFaceAuthentication)
        self.synchronize()
    }
    
    func getFaceAuthentication() -> Bool {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kFaceAuthentication) as? Bool
        return value ?? true
    }
    
    func setReferralCount(_ value: Int) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kReferralCount)
        self.synchronize()
    }
    
    func getReferralCount() -> Int {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kReferralCount) as? Int
        return value ?? 0
    }
    
    func setComissionValue(_ value: Int) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kCommissionValue)
        self.synchronize()
    }
    
    func getCommissionValue() -> Int {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kCommissionValue) as? Int
        return value ?? 0
    }
    
    
    func setMyGigsIndex(_ value: Int) {
        UserDefaults.standard.set(value, forKey: UserDefaultsConstants.kMyGigsIndex)
        self.synchronize()
    }
    
    func getMyGigsIndex() -> Int {
        let value = UserDefaults.standard.object(forKey: UserDefaultsConstants.kMyGigsIndex) as? Int
        return value ?? 0
    }
    
    
    func clearAllData() -> Void {
        for (key, _) in self.dictionaryRepresentation() {
            if key != UserDefaultsConstants.kWalkthrough && key != UserDefaultsConstants.kFcmToken { self.removeObject(forKey: key) }
        }
        self.synchronize()
    }
    
}
