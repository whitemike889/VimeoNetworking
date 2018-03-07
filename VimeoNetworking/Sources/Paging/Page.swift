//
//  Page.swift
//  VimeoNetworking
//
//  Created by King, Gavin on 1/29/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

public struct Page<T: Codable>: Codable
{
    public let total: Int
    public let page: Int
    public let perPage: Int
    public let paging: Paging
    public let data: [T]
}

extension Page
{
    enum CodingKeys: String, CodingKey
    {
        case total
        case page
        case perPage = "per_page"
        case paging
        case data
    }
}
