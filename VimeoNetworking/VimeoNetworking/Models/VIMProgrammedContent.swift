//
//  VIMCinemaItem.swift
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 9/26/16.
//  Copyright © 2016 Vimeo (https://vimeo.com)
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

public class VIMProgrammedContent: VIMModelObject
{
    dynamic public var uri: String?
    dynamic public var name: String?
    dynamic public var type: String?
    dynamic public var content: NSArray?
 
    dynamic private var metadata: [NSObject: AnyObject]?
    dynamic private var connections: [NSObject: AnyObject]?
    
    private struct Constants
    {
        static let ConnectionsKey = "connections"
    }
    
    // MARK: Public API
    
    public func connectionWithName(connectionName: String) -> VIMConnection?
    {
        return self.connections?[connectionName] as? VIMConnection
    }
    
    override public func getClassForCollectionKey(key: String!) -> AnyClass!
    {
        if key == "content"
        {
            return VIMVideo.self
        }
        
        return nil
    }
    
    override public func getClassForObjectKey(key: String!) -> AnyClass!
    {
        if key == "metadata"
        {
            return NSMutableDictionary.self
        }
        
        return nil
    }
    
    override public func didFinishMapping()
    {
        self.parseConnections()
    }
    
    // MARK: Parsing Helpers
    
    private func parseConnections()
    {
        guard let dict = self.metadata?[Constants.ConnectionsKey] as? [String: AnyObject] else
        {
            return
        }
     
        self.connections = [NSObject: AnyObject]()
        for (key, value) in dict
        {
            if let valueDict = value as? [NSObject: AnyObject]
            {
                self.connections?[key] = VIMConnection(keyValueDictionary: valueDict)
            }
        }
    }
    
}
