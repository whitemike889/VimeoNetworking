//
//  FakeDataSource.swift
//  Vimeo
//
//  Created by Westendorf, Michael on 7/25/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation
@testable import VimeoNetworkingExample_iOS

class FakeDataSource<T: VIMMappable>
{
    private let mapper = VIMObjectMapper()
    
    var items: [T]?
    var error: NSError?
    
    init(jsonData: [String: AnyObject], keyPath: String)
    {                
        mapper.addMappingClass(T.self, forKeypath: keyPath)
        
        let mappedData = mapper.applyMappingToJSON(jsonData)
        if let objects = mappedData["data"] as? [T]
        {
            self.items = objects
        }
        else if let object = mappedData as? T
        {
            self.items = [object]
        }
    }

    static func loadJSONFile(jsonFileName: String, withExtension: String) -> [String: AnyObject]
    {
        let jsonFilePath = NSBundle.mainBundle().pathForResource(jsonFileName, ofType: withExtension)
        let jsonData = NSData(contentsOfFile: jsonFilePath!)
        let jsonDict = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.AllowFragments)
        
        return (jsonDict as? [String: AnyObject])!
    }
}
