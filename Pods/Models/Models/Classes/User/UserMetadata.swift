//
//  Metadata.swift
//  Videos
//
//  Created by King, Gavin on 2/5/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct UserMetadata: Model
{
    public let connections: UserConnections?
    public let interactions: UserInteractions?
}
