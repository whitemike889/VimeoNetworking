//
//  ObjectMappingTestUtilities.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/16/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import Foundation
import VimeoNetworking

class ResponseUtilities
{
    static func loadResponse(from fileName: String) -> VimeoClient.ResponseDictionary?
    {
        guard let fileUrl = Bundle(for: self).url(forResource: fileName, withExtension: nil) else
        {
            return nil
        }
        
        let jsonData = try! Data(contentsOf: fileUrl)
        let jsonDict = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        
        return jsonDict as? VimeoClient.ResponseDictionary
    }
}
