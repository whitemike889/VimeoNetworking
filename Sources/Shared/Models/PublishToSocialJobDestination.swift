//
//  PublishToSocialJobDestination.swift
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

@objc public enum PublishToSocialDestinationStatus: Int {
    case error
    case finished
    case inProgress

    public var stringVlaue: String {
        switch self {
        case .error:
            return String.error
        case .finished:
            return String.finished
        case .inProgress:
            return String.inProgress
        }
    }
}

@objc public class PublishToSocialJobDestination: VIMModelObject {
    @objc public var status: String?
    @objc public var thirdPartyPostURL: String?
    @objc public var thirdPartyPostID: String?

    public override func getObjectMapping() -> Any? {
        return [
            String.Key.thirdPartyPostURL: String.Value.thirdPartyPostURL,
            String.Key.thirdPartyPostID: String.Value.thirdPartyPostID
        ]
    }
}

@objc public class PublishToSocialDestinations: VIMModelObject {
    @objc public var facebook: PublishToSocialJobDestination?
    @objc public var youtube: PublishToSocialJobDestination?
    @objc public var linkedin: PublishToSocialJobDestination?
    @objc public var twitter: PublishToSocialJobDestination?
}

@objc public class PublishToSocialJob: VIMModelObject {
    @objc public var firstPublishDateString: String?
    @objc public var firstPublishDate: Date?
    @objc public var destinations: PublishToSocialDestinations?

    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.destinations:
            return PublishToSocialDestinations.self
        default:
            return nil
        }
    }

    public override func getObjectMapping() -> Any? {
        return [
            String.Key.firstPublishDate: String.Value.firstPublishDate
        ]
    }
}

private extension String {
    struct Key {
        static let destinations = "destinations"
        static let firstPublishDate = "first_publish_date"
        static let thirdPartyPostURL = "third_party_post_url"
        static let thirdPartyPostID = "third_party_post_id"
    }

    struct Value {
        static let firstPublishDate = "firstPublishDateString"
        static let thirdPartyPostURL = "thirdPartyPostURL"
        static let thirdPartyPostID = "thirdPartyPostID"
    }

    static let error = "ERROR"
    static let finished = "FINISHED"
    static let inProgress = "IN_PROGRESS"
}
