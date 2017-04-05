//
//  Request+Purchasing.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Mike on 4/5/17.
//  Copyright © 2016 Vimeo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// `Request` to validate an IAP.  Returns the updated VIMUser object after the purchased item has been unlocked.
public typealias PurchaseRequest = Request<VIMUser>

public extension Request
{
    /**
     Create a `Request` to validate an IAP receipt and unlock the purchased product (Vimeo internal use only)
     
     - parameter productURI: the URI of the product to unlock
     - parameter storeReceipt: the Apple Store receipt
     - parameter retryPolicy: the retry policy to use for this request.  Defaults to SingleAttempt.
     
     - returns: a new `Request`
     */
    static func validatePurchaseRequest(productURI productURI: String, storeReceipt: String, retryPolicy: RetryPolicy? = .SingleAttempt) -> Request
    {
        let parameters = ["receipt": storeReceipt]
        
        return Request(method: .PUT, path: productURI, parameters: parameters, retryPolicy: retryPolicy)
    }
}
