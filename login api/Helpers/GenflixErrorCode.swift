//
//  GenflixErrorCode.swift
//  login api
//
//  Created by Yudha on 08/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import UIKit

let GenflixErrorDomain = "GenflixErrorDomain"

enum GenflixErrorCode{
    case UnknownError
    case JSONParserError
    case InvalidUsernameOrPassword
    case ClientError(reason: String)
    case ServerError(reason: String)
    case VersionError(code: Int, reason: String)
}

func errorWithCode(code: GenflixErrorCode) -> NSError {
    switch code {
    case .UnknownError:
        return NSError(domain: GenflixErrorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown Error"])
    case .JSONParserError:
        return NSError(domain: GenflixErrorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "JSON parser error"])
    case .InvalidUsernameOrPassword:
        return NSError(domain: GenflixErrorDomain, code: 403, userInfo: [NSLocalizedDescriptionKey: "Invalid Email address or Password"])
    case let .ClientError(reason):
        return NSError(domain: GenflixErrorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: reason])
    case let .ServerError(reason):
        return NSError(domain: GenflixErrorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: reason])
    case let .VersionError(code, reason):
        return NSError(domain: GenflixErrorDomain, code: code, userInfo: [NSLocalizedDescriptionKey: reason])
    }
}
