//
//  RequestExtension.swift
//  login api
//
//  Created by Yudha on 09/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

extension DataRequest{
    func rx_Raw(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<String> {
        let observable = Observable<String>.create{ observer in
            if let method = self.request?.httpMethod, let urlString = self.request?.url {
                if let body = self.request?.httpBody {
                    print(NSString(data: body, encoding: String.Encoding.utf8.rawValue))
                }
            }
            
            self.responseJSON(options: options){ response in
                if let error = response.result.error {
                    let string = String(data: response.data!, encoding: String.Encoding.utf8)
                    
                    if let str = string {
                        print("Masuk \(str)")
                        observer.onNext(str)
                        observer.onCompleted()
                    }else {
                        observer.onError(error)
                    }
                }else if let value = response.result.value {
                    let json = value
                    observer.onNext(json as! String)
                    observer.onCompleted()
                }else {
                    observer.onError(errorWithCode(code: .UnknownError))
                }
            }
            return Disposables.create(with: self.cancel)
        }
        return Observable.deferred { return observable}
    }
    
    func rx_JSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<JSON> {
        let observable = Observable<JSON>.create { observer in
            if let method = self.request?.httpMethod, let urlString = self.request?.url {
                print("[\(method)] \(urlString)")
                if let body = self.request?.httpBody {
                    print(NSString(data: body, encoding: String.Encoding.utf8.rawValue))
                }
            }
            
            self.responseJSON(options: options) { response in
                if let error = response.result.error {
                    let string = String(data: response.data!, encoding: String.Encoding.utf8)
                    print(string)
                    observer.onError(error)
                }else if let value = response.result.value {
                    let json = JSON(value)
                    if let error = json.error {
                        observer.onError(error)
                    }else {
                        observer.onNext(json)
                        observer.onCompleted()
                    }
                }else {
                    observer.onError(errorWithCode(code: .UnknownError))
                }
            }
            return Disposables.create(with: self.cancel)
        }
        return Observable.deferred{ return observable}
    }
}
