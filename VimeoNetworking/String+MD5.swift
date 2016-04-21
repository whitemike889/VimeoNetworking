//
//  String+MD5.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/13/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

// credit: http://stackoverflow.com/a/24408724
// note: requires the following import in the bridging header: #import <CommonCrypto/CommonCrypto.h>

extension String
{
    var md5: String
    {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen
        {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
}