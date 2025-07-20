//
//  HomeViewModel.swift
//  Attendance
//
//  Created by CodeAegis's Macbook Pro i9 on 09/07/25.
//

import Foundation


class HomeViewModel: BaseViewModel {
    
    
    
    func authenticateUserApi() {
        
        let param: Dictionary<String, Any> = [KeyConstants.kUserName: "995637",
                                              KeyConstants.kPassword: "Panda@9794",
                                              KeyConstants.kDeviceToken: "729FBF4F-8DB4-4B1F-8CA4-5247EE6D32D8"]
        
        WebService.sharedInstance.postApiRequest(endPoint: NetworkUrl.kLogin, withParams: param, { result in
            
        }, { error in
            self.onApiFailure?(error)
        })
        
    }
    
    
}
