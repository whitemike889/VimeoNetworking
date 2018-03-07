//
//  Paging.swift
//  VimeoNetworking
//
//  Created by King, Gavin on 1/29/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

public struct Paging: Codable
{
    public let first: String
    public let last: String
    public let next: String?
    public let previous: String?
}
