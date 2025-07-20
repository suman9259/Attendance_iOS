//
//  WebService.swift
//  qootuma
//
//  Created by Dhruv Rawat on 18/09/24.
//

import Foundation
import UIKit


class WebService {
    
    static let sharedInstance = WebService()
    
   
    /**
     GET API REQUEST...
     */
    
    func getApiRequest(endPoint: String,
                       withParams dictParams: Dictionary<String, Any>,
                       _ completionClosure: @escaping (_ Result: Data?) -> (),
                       _ errorClosure: @escaping (_ error: ApiErrorModel) -> (),
                       _ networkClosure: @escaping () -> () = {}) {
        
        NetworkManager.shared.getRequest(withServiceName: endPoint, requestParameters: dictParams) {
            (result: Data?, error: Error?, errorType: ErrorType, statusCode: HTTPStatusCodeConstants) in
            
            switch statusCode {
            case .SUCCESS, .CREATED:
                if let resultData = result {
                    completionClosure(resultData)
                } else {
                    completionClosure(nil)
                }
                
            case .NO_CONTENT, .FORBIDDEN, .BAD_REQUEST, .USER_EXISTS, .SERVER_ERROR:
                if let errorData = result {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: errorData))
                } else {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
                }
            case .UNAUTHORIZED, .TOKEN_EXPIRED:
                self.handleLogout(result: result)
            case .SESSION_EXPIRED:
                self.handleSessionExipred(result: result)
            case .BLOCKED:
                self.handleLogout(result: result)
            case .NO_RESPONSE:
                self.handleNetworkFailure()
            default:
                errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
            }
        }
    }
    
    /**
     POST API REQUEST...
     */
    
    func postApiRequest(endPoint: String,
                        withParams dictParams: Dictionary<String, Any>,
                        showProgress: Bool? = true,
                        _ completionClosure: @escaping (_ Result: Data?) -> (),
                        _ errorClosure: @escaping (_ error: ApiErrorModel) -> (),
                        _ networkClosure: @escaping () -> () = {}) {
        
        NetworkManager.shared.postRequest(withServiceName: endPoint, requestParameters: dictParams, showProgress: showProgress) {
            (result: Data?, error: Error?, errorType: ErrorType, statusCode: HTTPStatusCodeConstants) in
            
            switch statusCode {
            case .SUCCESS, .CREATED:
                if let resultData = result {
                    completionClosure(resultData)
                } else {
                    completionClosure(nil)
                }
                
            case .NO_CONTENT, .FORBIDDEN, .BAD_REQUEST, .USER_EXISTS, .SERVER_ERROR, .SERVER_ERROR:
                
                if let errorData = result {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: errorData))
                } else {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
                }
            case .UNAUTHORIZED, .TOKEN_EXPIRED:
                self.handleLogout(result: result)
            case .SESSION_EXPIRED:
                self.handleSessionExipred(result: result)
            case .BLOCKED:
                self.handleLogout(result: result)
            case .NO_RESPONSE:
                self.handleNetworkFailure()
            default:
                errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
            }
        }
    }

    
    
    /**
     PUT API REQUEST...
     */
    func putApiRequest(endPoint: String, withParams dictParams: Dictionary<String, Any>, _ completionClosure: @escaping (_ Result: Data?) -> (),
                       _ errorClosure: @escaping (_ error: ApiErrorModel) -> ()) {
        
        NetworkManager.shared.putRequest(withServiceName: endPoint, requestParameters: dictParams) {
            (result: Data?, error: Error?, errorType: ErrorType, statusCode: HTTPStatusCodeConstants) in
            
            switch statusCode {
            case .SUCCESS, .CREATED:
                if let resultData = result {
                    completionClosure(resultData)
                } else {
                    completionClosure(nil)
                }
                
            case .NO_CONTENT, .FORBIDDEN, .BAD_REQUEST, .USER_EXISTS, .SERVER_ERROR:
                
                if let errorData = result {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: errorData))
                } else {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
                }
            case .UNAUTHORIZED, .TOKEN_EXPIRED:
                self.handleLogout(result: result)
            case .SESSION_EXPIRED:
                self.handleSessionExipred(result: result)
            case .BLOCKED:
                self.handleLogout(result: result)
            case .NO_RESPONSE:
                self.handleNetworkFailure()
            default:
                errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
            }
        }
    }
    
   
    /**
     DELETE API REQUEST...
     */
    func deleteApiRequest(endPoint: String, withParams dictParams: Dictionary<String, Any>, _ completionClosure: @escaping (_ Result: Data?) -> (),
                          _ errorClosure: @escaping (_ error: ApiErrorModel) -> ()) {
        
        NetworkManager.shared.deleteRequest(withServiceName: endPoint, requestParameters: dictParams) {
            (result: Data?, error: Error?, errorType: ErrorType, statusCode: HTTPStatusCodeConstants) in
            
            switch statusCode {
            case .SUCCESS, .CREATED:
                if let resultData = result {
                    completionClosure(resultData)
                } else {
                    completionClosure(nil)
                }
                
            case .NO_CONTENT, .FORBIDDEN, .BAD_REQUEST, .USER_EXISTS, .SERVER_ERROR:
                
                if let errorData = result {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: errorData))
                } else {
                    errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
                }
            case .UNAUTHORIZED, .TOKEN_EXPIRED:
                self.handleLogout(result: result)
            case .SESSION_EXPIRED:
                self.handleSessionExipred(result: result)
            case .BLOCKED:
                self.handleLogout(result: result)
            case .NO_RESPONSE:
                self.handleNetworkFailure()
            default:
                errorClosure(ApiErrorModel(errorCode: statusCode, errorData: nil))
            }
        }
    }
    
  
    /**
     MULTIPART API REQUEST...
     */
    func multipartRequest(endPoint : String, withImage imageSelected: UIImage, _ completionClosure: @escaping (_ Result: Data?) -> (), _ errorClosure: @escaping (_ path: String) -> ()) {
        
        NetworkManager.shared.requestMultipartApi(with: endPoint, withRequestType: .post, withImage: imageSelected, withImageName: "file")
        {(result: Data?, error: Error?, errorType: ErrorType, statusCode: HTTPStatusCodeConstants) in
            let dictResponse = self.getDictionary(result)
            let imgResponse = dictResponse["data"]
            
            switch statusCode {
            case .SUCCESS:
                if let resultData = result {
                    completionClosure(resultData)
                } else {
                    completionClosure(nil)
                }
                break
            case .NO_CONTENT, .FORBIDDEN, .BAD_REQUEST:
                errorClosure(self.getErrorMessage(dictResponse))
            case .SESSION_EXPIRED:
                self.handleSessionExipred(result: result)
            default:
                errorClosure("Some error occured. Try again!!!")
                break
            }
        }
    }
    

    /**
     PDF MULTIPART API REQUEST...
     */
    
    func uploadPdfApi(fileUrl: URL, mimeType : String, _ completionClosure: @escaping (_ Result: Data?) -> (), _ errorClosure: @escaping (String) -> ()) {
        do {
            let fileData = try Data(contentsOf: fileUrl)
            let fileName = fileUrl.lastPathComponent
            let mimeType = mimeType
            
            NetworkManager.shared.requestMultipartApi(
                with: "",
                withRequestType: .post,
                fileData: fileData,
                fileName: fileName,
                mimeType: mimeType,
                paramName: "file"
            ) { result, error, errorType, statusCode in
                let dictResponse = self.getDictionary(result)
                let imgResponse = dictResponse["data"]
                switch statusCode {
                case .SUCCESS:
                    if let resultData = result {
                        completionClosure(resultData)
                    } else {
                        completionClosure(nil)
                    }
                    break
                case .NO_CONTENT, .FORBIDDEN, .BAD_REQUEST:
                    errorClosure(self.getErrorMessage(dictResponse))
                case .SESSION_EXPIRED:
                    self.handleSessionExipred(result: result)
                default:
                    errorClosure("Some error occured. Try again!!!")
                    break
                }
            }
        } catch {
            print("file upload error ::: \(error)")
        }
    }
    
   
    func getDictionary(_ dictData: Any?) -> Dictionary<String, Any> {
        guard let dict = dictData as? Dictionary<String, Any> else {
            guard let arr = dictData as? [Any] else { return [:] }
            return getDictionary(arr.count > 0 ? arr[0] : [:])
        }
        return dict
    }
    
    func getErrorMessage(_ dictResponse: Dictionary<String, Any>) -> String {
        if !String.getString(dictResponse[KeyConstants.kMessage]).isEmpty {
            return String.getString(dictResponse[KeyConstants.kMessage])
        } else {
            return NSLocalizedString("Something went wrong", comment: "")
        }
    }
    
    
    private func handleLogout(result: Data?) {
        if let errorData = result {
            do {
                let errorModel = try JSONDecoder().decode(ErrorModel.self, from: errorData)
                let msg = errorModel.errors?.first?.msg ?? errorModel.message ?? ""
//                NotificationCenter.default.post(name: Notification.Name.kShowLogoutAlert, object: nil, userInfo: [KeyConstants.kMessage: msg])
            } catch {
            }
        } else {
        }
    }
    
    private func handleSessionExipred(result: Data?) {
        if let errorData = result {
            do {
                let errorModel = try JSONDecoder().decode(ErrorModel.self, from: errorData)
                let msg = errorModel.errors?.first?.msg ?? errorModel.message ?? ""
//                NotificationCenter.default.post(name: Notification.Name.kSessionExpiredAlert, object: nil, userInfo: [KeyConstants.kMessage: msg])
            } catch {
                
            }
        } else {
        }
    }
    
    private func handleNetworkFailure() {
//        NotificationCenter.default.post(name: Notification.Name.kNetworkFailure, object: nil, userInfo: [KeyConstants.kMessage: ""])
    }
}


struct ApiErrorModel {
    
    var errorCode : HTTPStatusCodeConstants?
    var errorData : Data?
    
}

enum HTTPStatusCodeConstants {
    
    case NO_RESPONSE
    case SUCCESS
    case CREATED
    case ACCEPTED
    case NO_CONTENT
    case UNAUTHORIZED
    case BAD_REQUEST
    case FORBIDDEN
    case NOT_FOUND
    case METHOD_NOT_ALLOWED
    case CONFLICT
    case USER_EXISTS
    case BLOCKED
    case SERVER_ERROR
    case TOKEN_EXPIRED
    case SESSION_EXPIRED
}
