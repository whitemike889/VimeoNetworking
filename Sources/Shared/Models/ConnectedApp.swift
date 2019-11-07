//
//  ConnectedApp.swift
//  VimeoNetworking
//
//  Created on 11/6/19.
//  Copyright (c) Vimeo (https://vimeo.com)
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

import Foundation

/// An enumeration of the supported connected app types.
/// - facebook: Represents a connection to Facebook.
/// - linkedin: Represents a connection to LinkedIn.
/// - twitter: Represents a connection to Twitter.
/// - youtube: Represents a connection to YouTube.
/// - none: Represents an unsupported platform or a malformed response.
@objc public enum ConnectedAppType: Int {
    case facebook
    case linkedin
    case twitter
    case youtube
    case none
}

/// A `ConnectedApp` represents a connection to a social media platform. Some activities, like simultaneously live
/// stream to multiple destinations, or publishing across platforms, require requesting specific scopes. The scopes
/// required will always be returned in the `neededScopes` array.
/// - Note: Some properties are specific to a particular platform. These cases have been noted in the documentation
///         where relevant.
@objc public class ConnectedApp: VIMModelObject {

    /// The date when the user established this connected app, as a String.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `addDate` is preferred.
    @objc public var addDateString: String?

    /// The date when the user established this connected app.
    @objc public var addDate: Date?

    /// Facebook only. A value of 1 maps to expired data access. A value of 0 maps to having data access.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `isDataAccessExpired` is preferred.
    @objc public var dataAccessIsExpired: NSNumber?

    /// Returns whether the user's data access has expired.
    /// - Note: Facebook only. Will always return false if the `ConnectedAppType` is not `.facebook`.
    @objc public lazy var isDataAccessExpired: Bool = {
        guard self.type == .facebook else { return false }
        return self.dataAccessIsExpired?.intValue != 0
    }()

    /// The list of remaining scopes on this connected app that the user needs for a particular Vimeo feature.
    @objc public var neededScopes: [String]?

    /// The list of third party pages associated with the user's account.
    /// - Note: Facebook and LinkedIn only.
    @objc public var pages: [String]?

    /// The unique identifier for the user on this connected app.
    @objc public var thirdPartyUserID: String?

    /// The user's display name on this connected app.
    @objc public var thirdPartyUserDisplayName: String?

    /// The type of the connected app, as a String.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `type` is preferred.
    @objc public var typeString: String?

    /// the type of the connected app.
    /// - Note: A returned value of `.none` indicates an unsupported `ConnectedAppType`, or a malformed response.
    @objc public var type: ConnectedAppType {
        switch self.typeString {
        case String.facebook:
            return .facebook
        case String.linkedin:
            return .linkedin
        case String.twitter:
            return .twitter
        case String.youtube:
            return .youtube
        default:
            return .none
        }
    }

    /// The API URI of this connected app.
    @objc public var uri: String?

    // MARK: - Overrides

    public override func getObjectMapping() -> Any? {
        return [
            String.Key.addDate: String.Value.addDate,
            String.Key.dataAccessIsExpired: String.Value.dataAccessIsExpired,
            String.Key.thirdPartyUserID: String.Value.thirdPartyUserID,
            String.Key.thirdPartyUserDisplayName: String.Value.thirdPartyUserDisplayName,
            String.Key.type: String.Value.type
        ]
    }

    public override func didFinishMapping() {
        self.addDate = self.formatDate(from: self.addDateString)
    }

    // MARK: - Private

    private func formatDate(from dateString: String?) -> Date? {
        guard let dateString = dateString,
            let date = VIMModelObject.dateFormatter().date(from: dateString) else {
                return nil
        }

        return date
    }
}

private extension String {
    struct Key {
        static let addDate = "add_date"
        static let dataAccessIsExpired = "data_access_is_expired"
        static let thirdPartyUserID = "third_party_user_id"
        static let thirdPartyUserDisplayName = "third_party_user_display_name"
        static let type = "type"
    }

    struct Value {
        static let addDate = "addDateString"
        static let dataAccessIsExpired = "dataAccessIsExpired"
        static let thirdPartyUserID = "thirdPartyUserID"
        static let thirdPartyUserDisplayName = "thirdPartyUserDisplayName"
        static let type = "typeString"
    }

    static let facebook = "facebook"
    static let linkedin = "linkedin"
    static let twitter = "twitter"
    static let youtube = "youtube"
}
