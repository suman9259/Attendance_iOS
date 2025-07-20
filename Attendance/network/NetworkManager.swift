//
//  NetworkManager.swift
//  qootuma
//
//  Created by Dhruv Rawat on 18/09/24.
//

import Foundation
import Alamofire
import AlamofireImage
import SVProgressHUD


public enum kHTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

public enum ErrorType: Error {
    case noNetwork, requestSuccess, requestFailed, requestCancelled
}

public class NetworkManager {
    
    internal static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    
    func getRequest(withServiceName serviceName: String, requestParameters dictParams: Dictionary<String, Any>, completionClosure:@escaping (_ result: Data?, _ error: Error?, _ errorType: ErrorType, _ statusCode: HTTPStatusCodeConstants) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            showProgressHUD()
            
            
            let headers = getHeader()
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: dictParams)
            
            print("Header: \(headers)")
            print("Connecting to Host with URL \(kBaseUrl)\(serviceName) with parameters: \(params)")
            
            Alamofire.Session.default.request(serviceUrl, method: .get, parameters: dictParams, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                                                                                                                                                                { (DataResponse) in
                SVProgressHUD.dismiss()
                switch DataResponse.result
                {
                case .success(let JSON):
                    let response = self.getResponseFromDictionary(data: DataResponse.data!)
                    completionClosure(DataResponse.data!, response.error, .requestSuccess, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                case .failure(let error):
                    print( "json error: \(error.localizedDescription)")
                    completionClosure(nil, error, .requestFailed, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                }
            })
        } else {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, .NO_RESPONSE)
        }
    }
    
    
    func postRequest(withServiceName serviceName: String, requestParameters dictParams: Dictionary<String, Any>, showProgress: Bool? = true, completionClosure:@escaping (_ result: Data?, _ error: Error?, _ errorType: ErrorType, _ statusCode: HTTPStatusCodeConstants) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            if showProgress == true {
                showProgressHUD()
            }
            
            
            let headers = getHeader()
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: dictParams)
            
            print("Header: \(headers)")
            print("Connecting to Host with URL \(kBaseUrl)\(serviceName) with parameters: \(params)")
            
            Alamofire.Session.default.request(serviceUrl, method: .post, parameters: dictParams, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                                                                                                                                                                    { (DataResponse) in
                SVProgressHUD.dismiss()
                switch DataResponse.result
                {
                case .success(let JSON):
                    let response = self.getResponseFromDictionary(data: DataResponse.data!)
                    completionClosure(DataResponse.data!, response.error, .requestSuccess, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                case .failure(let error):
                    print( "json error: \(error.localizedDescription)")
                    completionClosure(nil, error, .requestFailed, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                }
            })
        } else {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, .NO_RESPONSE)
        }
    }
    
    func putRequest(withServiceName serviceName: String, requestParameters dictParams: Dictionary<String, Any>, completionClosure:@escaping (_ result: Data?, _ error: Error?, _ errorType: ErrorType, _ statusCode: HTTPStatusCodeConstants) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            showProgressHUD()
            
            
            let headers = getHeader()
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: dictParams)
            
            print("Header: \(headers)")
            print("Connecting to Host with URL \(kBaseUrl)\(serviceName) with parameters: \(params)")
            
            Alamofire.Session.default.request(serviceUrl, method: .put, parameters: dictParams, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                                                                                                                                                                { (DataResponse) in
                SVProgressHUD.dismiss()
                switch DataResponse.result
                {
                case .success(let JSON):
                    let response = self.getResponseFromDictionary(data: DataResponse.data!)
                    completionClosure(DataResponse.data!, response.error, .requestSuccess, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                case .failure(let error):
                    print( "json error: \(error.localizedDescription)")
                    completionClosure(nil, error, .requestFailed, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                }
            })
        } else {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, .NO_RESPONSE)
        }
    }
    
    func deleteRequest(withServiceName serviceName: String, requestParameters dictParams: Dictionary<String, Any>, completionClosure:@escaping (_ result: Data?, _ error: Error?, _ errorType: ErrorType, _ statusCode: HTTPStatusCodeConstants) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            showProgressHUD()
            
            
            let headers = getHeader()
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: dictParams)
            
            print("Header: \(headers)")
            print("Connecting to Host with URL \(kBaseUrl)\(serviceName) with parameters: \(params)")
            
            Alamofire.Session.default.request(serviceUrl, method: .delete, parameters: dictParams, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                                                                                                                                                                    { (DataResponse) in
                SVProgressHUD.dismiss()
                switch DataResponse.result
                {
                case .success(let JSON):
                    let response = self.getResponseFromDictionary(data: DataResponse.data!)
                    completionClosure(DataResponse.data!, response.error, .requestSuccess, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                case .failure(let error):
                    print( "json error: \(error.localizedDescription)")
                    completionClosure(nil, error, .requestFailed, self.getHTTPStatusCode(DataResponse.response?.statusCode))
                }
            })
        } else {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, .NO_RESPONSE)
        }
    }
    
    
    func requestMultipartApi(with serviceName: String, withRequestType requestType: HTTPMethod, withImage image: UIImage?, withImageName imageName: String, completionClosure: @escaping (_ result: Data?, _ error: Error?, _ errorType: ErrorType, _ statusCode: HTTPStatusCodeConstants) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            showProgressHUD()
            let headers = getHeader()
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: [:])
            
            print("Header: \(headers)")
            print("Connecting to Host with URL \(kBaseUrl)\(serviceName) with parameters: \(params)")
            
            
            Alamofire.Session.default.upload(multipartFormData:{ (multipartFormData: MultipartFormData) in
                
                //
                if let imageToUpload = image {
                    if let imageData: Data = imageToUpload.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: imageName, fileName: "\(self.getCurrentTimeAsPathName())", mimeType: "image/jpeg")
                    }
                }
            }, to: serviceUrl, method: requestType, headers: headers).responseJSON { (dataResponse: AFDataResponse<Any>) in
                
                switch dataResponse.result
                {
                case .success:
                    SVProgressHUD.dismiss()
                    let response = self.getResponseFromDictionary(data: dataResponse.data!)
                    completionClosure(dataResponse.data!, response.error, .requestSuccess, self.getHTTPStatusCode(dataResponse.response?.statusCode))
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    completionClosure(nil, error, .requestFailed, self.getHTTPStatusCode(400))
                }
            }
        }
        else
        {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, .NO_RESPONSE)
        }
    }
    
    func requestMultipartApi(
        with serviceName: String,
        withRequestType requestType: HTTPMethod,
        fileData: Data?,
        fileName: String,
        mimeType: String,
        paramName: String,
        completionClosure: @escaping (_ result: Data?, _ error: Error?, _ errorType: ErrorType, _ statusCode: HTTPStatusCodeConstants) -> ()
    ) {
        if NetworkReachabilityManager()?.isReachable == true {
            
            showProgressHUD()
            let headers = getHeader()
            let serviceUrl = getServiceUrl(string: serviceName)
            let params = getPrintableParamsFromJson(postData: [:])
            
            Alamofire.Session.default.upload(multipartFormData:{ multipartFormData in
                if let data = fileData {
                    multipartFormData.append(data, withName: paramName, fileName: fileName, mimeType: mimeType)
                }
            }, to: serviceUrl, method: requestType, headers: headers).responseJSON { response in
                
                switch response.result {
                case .success:
                    SVProgressHUD.dismiss()
                    let responseData = self.getResponseFromDictionary(data: response.data!)
                    completionClosure(response.data!, responseData.error, .requestSuccess, self.getHTTPStatusCode(response.response?.statusCode))
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    completionClosure(nil, error, .requestFailed, self.getHTTPStatusCode(400))
                }
            }
        } else {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, .NO_RESPONSE)
        }
    }
    
    func getCurrentTimeAsPathName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HHmmss"
        return formatter.string(from: Date())
    }
    
    private func showProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.show()
    }
    
    private func getHTTPStatusCode(_ value: Any?) -> HTTPStatusCodeConstants {
        
        let statusCode = Int.getInt(value)
        switch statusCode {
        case 200:
            return .SUCCESS
        case 201:
            return .CREATED
        case 202:
            return .ACCEPTED
        case 204:
            return .NO_CONTENT
        case 400:
            return .BAD_REQUEST
        case 401:
            return .UNAUTHORIZED
        case 403:
            return .FORBIDDEN
        case 404:
            return .NOT_FOUND
        case 405:
            return .METHOD_NOT_ALLOWED
        case 409:
            return .CONFLICT
        case 422:
            return .USER_EXISTS
        case 419:
            return .BLOCKED
        case 440:
            return .TOKEN_EXPIRED
        case 441 :
            return .SESSION_EXPIRED
        case 500:
            return .SERVER_ERROR
        default:
            return .NO_RESPONSE
        }
    }
    
    private func getHeader() -> HTTPHeaders {
        
        var headers: HTTPHeaders = []
        headers.add(HTTPHeader.init(name: "accept", value: "application/json"))
        headers.add(HTTPHeader.init(name: "Content-Type", value: "application/json"))
        headers.add(HTTPHeader.init(name: "code", value: "260401"))
        
        var accessToken = ""
        
        let userDefault = FunctionsConstants.kSharedUserDefaults
        
        if userDefault.getAccessToken().isEmpty == false {
            accessToken = userDefault.getAccessToken()
            print("access token found")
        } else if userDefault.getTempToken().isEmpty == false {
            accessToken = userDefault.getTempToken()
            print("temp token found")
        }
        
        var token = ""
        
        if accessToken.isNullOrEmpty == false {
            token = "\("Bearer") \(accessToken)"
        } else {
            token = ""
        }
        
        headers.add(HTTPHeader.init(name: KeyConstants.kAuthorization, value: token))
        
        
        return headers
    }
    
    private func getServiceUrl(string: String) -> String {
        if string.contains("http") {
            return string
        }
        else {
            return kBaseUrl + string
        }
    }
    
    private func getPrintableParamsFromJson(postData: Dictionary<String, Any>) -> String  {
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: postData, options:JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = String(data:jsonData, encoding:String.Encoding.ascii)
            return theJSONText ?? ""
        }
        catch let error as NSError {
            
            print( error)
            return ""
        }
    }
    
    private func getResponseDataArrayFromData(data: Data) -> (responseData: [Any]?, error: NSError?) {
        do {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
            return (responseData, nil)
        }
        catch let error as NSError {
            
            print( "json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
    private func getResponseFromDictionary(data: Data) -> (responseData: Dictionary<String, Any>, error: Error?) {
        do {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
            print("RESPONSE :::: \(responseData)")
            return (responseData, nil)
        }
        catch let error {
            print( "json error: \(error.localizedDescription)")
            return ([:], error)
        }
    }
}
