//
//  VimeoCodableResponseSerializer.swift
//  AFNetworking-iOS
//
//  Created by King, Gavin on 3/7/18.
//

import Foundation

class VimeoCodableResponseSerializer: VimeoResponseSerializer
{
    override func responseObject(for response: URLResponse?, data: Data?, error: NSErrorPointer) -> Any?
    {
        return data
    }
}
