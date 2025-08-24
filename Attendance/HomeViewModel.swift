//
//  HomeViewModel.swift
//  Attendance
//
//  Created by CodeAegis's Macbook Pro i9 on 09/07/25.
//

import Foundation
import SwiftyJSON


class HomeViewModel: BaseViewModel {
    
    func authenticateUserApi(completion: @escaping (String, String) -> Void) {
        
        let param: Dictionary<String, Any> = [KeyConstants.kUserName: "995637",
                                              KeyConstants.kPassword: "Panda@9794",
                                              KeyConstants.kDeviceToken: "729FBF4F-8DB4-4B1F-8CA4-5247EE6D32D8"]
        
        WebService.sharedInstance.postApiRequest(endPoint: NetworkUrl.kLogin, withParams: param, { data in
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let dataDict = json["data"] as? [String: Any],
                   let shifts = dataDict["shifts"] as? [[String: Any]],
                   let firstShift = shifts.first,
                   let shiftName = firstShift["shift_name_lang"] as? String,
                   let shiftRules = firstShift["shift_rule"] as? [[String: Any]],
                   let firstRule = shiftRules.first,
                   let startTime = firstRule["start_time"] as? String,
                   let endTime = firstRule["end_time"] as? String {
                    
                    completion(shiftName, "\(startTime) - \(endTime)")
                }
            } catch {
                print("Failed to parse JSON: \(error)")
            }
            
        }, { error in
            self.onApiFailure?(error)
        })
        
    }
    
    
}
