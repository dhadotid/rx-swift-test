//
//  APIConnector.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct APIResponse {
    var code: Int
    var message: String
    var result: JSON
    var token: String
    
    init(code: Int, message: String, result: JSON, token: String) {
        self.code = code
        self.message = message
        self.result = result
        self.token = token
    }
}

class APIConnector: NSObject {
    static let instance = APIConnector()
    let manager: APIManager
    let homeURLString: String
    let dateFormatter: DateFormatter
    
    private let API_SIGNIN = "/basic/member/login"
    
    override init() {
        homeURLString = Config.HomeURLString
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        manager = APIManager(configuration: configuration)
        super.init()
    }
    
    func signIn(email: String, password: String) -> Observable<User> {
        let parameters: [String: String] = [
            "basic-auth": (email + ":" + password).toBase64()!
        ]
        let request = manager.request(homeURLString + API_SIGNIN, method: .post, parameters: parameters, headers : parameters)
        return request.rx_JSON()
            .mapJSONResponse()
            .map { response in
                if response.code == 200 {
                    print("token: ", response.token)
                    PreferenceManager.instance.token = response.token
                    if let user = User.with(json: response.result){
                        return user
                    }else {
                        throw errorWithCode(code: .InvalidUsernameOrPassword)
                    }
                }else {
                    throw errorWithCode(code: .InvalidUsernameOrPassword)
                }
            }
    }
}

class APIManager: SessionManager {
    
    internal override func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        var overridedParameters = [String: AnyObject]()
        if let parameters = parameters {
            overridedParameters = parameters as [String: AnyObject]
        }
        
        do {
            let a = try url.asURL().absoluteString.lowercased()
            if a.range(of: "room") != nil || a.range(of: "get-user-total-balance") != nil  || a.range(of: "search-property") != nil {
                print("room is exists")
            }else{
                overridedParameters["cache_time"] = 60 as AnyObject
            }
        }catch {
            
        }
        
        if LocaleManager.instance.language == .Indonesia {
            overridedParameters["lang"] = "id" as AnyObject
        }else {
            overridedParameters["lang"] = "en" as AnyObject
        }
        
        var overridedHeaders = [String: String]()
        let userAgent = UIDevice.current.name + "; " + UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        overridedHeaders["User-Agent"] = userAgent
        overridedHeaders["api-key"] = Config.APIKey
        
        overridedHeaders["app-id"] = "web"
        overridedHeaders["os-name"] = "ios"
        overridedHeaders["app-version"] = "1"
        overridedHeaders["device-id"] = DeviceManager.UUID()
        
        if let token = PreferenceManager.instance.token, PreferenceManager.instance.userId != nil {
            print("Masuk")
            overridedHeaders["token"] = token
        }
        if LocaleManager.instance.language == .Indonesia {
            overridedHeaders["lang"] = "id"
        }else {
            overridedHeaders["lang"] = "en"
        }
        
        if let info = Bundle.main.infoDictionary, let version = info["CFBundleShortVersionString"] as? String {
            overridedHeaders["app-version"] = version
            overridedHeaders["X-Client-Version"] = version
        }
        
        if let headers = headers {
            for (key, value) in headers {
                overridedHeaders[key] = value
            }
        }
        
        return super.request(url, method: method, parameters: overridedParameters, encoding: encoding, headers: overridedHeaders)
    }
}

extension Observable {
    func mapPaymentResponse() -> Observable<String> {
        return map{ (item: E) -> String in
            print("Isi item \(item)")
            guard let json = item as? String else{
                fatalError("Not a String")
            }
            print("Isi \(json)")
            return json
        }
    }
    
    func mapJSONResponse() -> Observable<APIResponse> {
        return map { (item: E) -> APIResponse in
            guard let json = item as? JSON else {
                fatalError("Not a JSON")
            }
            print("to be mapped: ", json)
            var code = 200
            var message = ""
            var result = json
            if json["errors"].exists(){
                code = 500
                if let element = json["errors"].string{
                    message = element
                }else if json["errors"]["message"].exists(){
                    message = json["errors"]["message"].string != nil ? json["errors"]["message"].string! : ""
                }else if json["errors"]["email"].exists(){
                    message = json["errors"]["email"][0].rawString()!
                }else {
                    message = json["errors"].rawString()!
                }
            }else if json["error"].exists(){
                code = 500
                if json["error"] != []{
                    message = json["error"] != JSON.null ? json["error"]["message"].string! : ""
                }
            }else if json["data"].exists(){
                result = json["data"]
            }else {
                result = json
            }
            var token = ""
            
            if json["message"].exists() {
                message = json["message"].stringValue
                if message.contains("INVALID_TOKEN_OR_TOKEN_EXPIRED") || message.contains("HEADER_NOT_COMPLETE"){
                    PreferenceManager.instance.userId = nil
                    PreferenceManager.instance.token = nil
                }
            }
            
            if json["token"].exists(){
                token = json["token"].stringValue
            }
            
            return APIResponse(code: code, message: message, result: result, token: token)
        }
    }
}
