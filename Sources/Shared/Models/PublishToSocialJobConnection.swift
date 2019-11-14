//
//  PublishToSocialJobConnection.swift
//  VimeoNetworking
//
//  Created by Jason Hawkins on 11/14/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

@objc public class PublishJobBlockers: VIMModelObject {
    @objc public var facebook: [String]?
    @objc public var youtube: [String]?
    @objc public var linkedin: [String]?
    @objc public var twitter: [String]?
}

@objc public class PublishJobConstraints: VIMModelObject {
    @objc public var duration: NSNumber?
    @objc public var size: NSNumber?
}

@objc public class PublishJobConnection: VIMConnection {
    @objc public var publishBlockers: PublishJobBlockers?
    @objc public var publishConstraints: [PublishJobConstraints]?
    // options
    // uri

    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.publishBlockers:
            return PublishJobBlockers.self
        case String.Key.publishConstraints:
            return PublishJobConstraints.self
        default:
            return nil
        }
    }
}

private extension String {
    struct Blockers {
        static let size = "SIZE"
        static let duration = "DURATION"
        static let facebookNoPages = "FP_NO_PAGES"
        static let linkedInNoOrganizations = "LI_NO_ORGANIZATIONS"
    }

    struct Constraints {
        static let size = "size"
        static let duration = "duration"
    }

    struct Key {
        static let publishBlockers = "publish_blockers"
        static let publishConstraints = "publish_constraints"
    }
}
