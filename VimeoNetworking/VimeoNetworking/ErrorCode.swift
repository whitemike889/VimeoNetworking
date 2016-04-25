//
//  ErrorCode.swift
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/25/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public enum VimeoErrorCode: Int
{
    // Upload
    case UploadStorageQuotaExceeded = 4101
    case UploadDailyQuotaExceeded = 4102
    
    case InvalidRequestInput = 2204 // root error code for all invalid parameters errors below
    
    // Password-protected video playback
    case VideoPasswordIncorrect = 2222
    case NoVideoPasswordProvided = 2223
    
    // Authentication
    case EmailTooLong = 2216
    case PasswordTooShort = 2210
    case PasswordTooSimple = 2211
    case NameInPassword = 2212
    case EmailNotRecognized = 2217
    case PasswordEmailMismatch = 2218
    case NoPasswordProvided = 2209
    case NoEmailProvided = 2214
    case InvalidEmail = 2215
    case NoNameProvided = 2213
    case NameTooLong = 2208
    case FacebookJoinInvalidToken = 2303
    case FacebookJoinNoToken = 2306
    case FacebookJoinMissingProperty = 2304
    case FacebookJoinMalformedToken = 2305
    case FacebookJoinDecryptFail = 2307
    case FacebookJoinTokenTooLong = 2308
    case FacebookLoginNoToken = 2312
    case FacebookLoginMissingProperty = 2310
    case FacebookLoginMalformedToken = 2311
    case FacebookLoginDecryptFail = 2313
    case FacebookLoginTokenTooLong = 2314
    case FacebookInvalidInputGrantType = 2221
    case FacebookJoinValidateTokenFail = 2315
    case FacebookInvalidNoInput = 2207
    case FacebookInvalidToken = 2300
    case FacebookMissingProperty = 2301
    case FacebookMalformedToken = 2302
    case EmailAlreadyRegistered = 2400
    case EmailBlocked = 2401
    case EmailSpammer = 2402
    case EmailPurgatory = 2403
    case URLUnavailable = 2404
    case Timeout = 5000
    case TokenNotGenerated = 5001
}

public enum HTTPStatusCode: Int
{
    case ServiceUnavailable = 503
    case Unauthorized = 401
    case Forbidden = 403
}

public enum LocalErrorCode: Int
{
    // VimeoClient
    case Undefined = 9000
    case InvalidResponseDictionary = 9001
    case RequestMalformed = 9002
    case CachedResponseNotFound = 9003
    
    // AuthenticationController
    case AuthToken = 9004
    case CodeGrant = 9005
    case CodeGrantState = 9006
    case NoResponse = 9007
}