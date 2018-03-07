//
//  CategoryMetadata.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct CategoryMetadata: Model
{
    public let connections: CategoryConnections?
    public let interactions: CategoryInteractions?
}
