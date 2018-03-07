//
//  VimeoModelResponseSerializer.swift
//  AFNetworking-iOS
//
//  Created by King, Gavin on 3/7/18.
//

import Foundation

class VimeoModelResponseSerializer: VimeoResponseSerializer
{
    override func responseObject(for response: URLResponse?, data: Data?, error: NSErrorPointer) -> Any?
    {
        return super.responseObject(for: response, data: data, error: error)
    }
}
