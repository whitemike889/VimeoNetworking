//
//  PublishToSocialJobConnection.swift
//  VimeoNetworking
//
//  Created by Jason Hawkins on 11/14/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

@objc public class PublishToSocialJobBlockers: VIMModelObject {

}

@objc public class PublishToSocialJobConstraints: VIMModelObject {

}

@objc public class PublishToSocialJobConnection: VIMConnection {
    @objc public var publishBlockers: PublishToSocialJobBlockers?
    @objc public var publishConstraints: PublishToSocialJobConstraints?
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
}
