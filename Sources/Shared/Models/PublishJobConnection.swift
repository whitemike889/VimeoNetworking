//
//  PublishJobConnection.swift
//  VimeoNetworking
//
//  Copyright © 2019 Vimeo. All rights reserved.
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

@objc public class PublishJobBlockers: VIMModelObject {
    @objc public var facebook: [String]?
    @objc public var youtube: [String]?
    @objc public var linkedin: [String]?
    @objc public var twitter: [String]?
}

@objc public class PublishConstraints: VIMModelObject {
    @objc public var duration: NSNumber?
    @objc public var size: NSNumber?
}

@objc public class PublishJobConstraints: VIMModelObject {
    @objc public var faceebok: PublishConstraints?
    @objc public var youtube: PublishConstraints?
    @objc public var linkedin: PublishConstraints?
    @objc public var twitter: PublishConstraints?

    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.facebook,
             String.Key.youtube,
             String.Key.linkedin,
             String.Key.twitter:
            return PublishConstraints.self
        default:
            return nil
        }
    }
}

@objc public class PublishJobConnection: VIMConnection {
    @objc public var publishBlockers: PublishJobBlockers?
    @objc public var publishConstraints: PublishJobConstraints?

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
        static let facebook = "facebook"
        static let youtube = "youtube"
        static let linkedin = "linkedin"
        static let twitter = "twitter"
    }
}
