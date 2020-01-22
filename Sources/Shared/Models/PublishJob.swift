//
//  PublishJob.swift
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

/// Data related to all supported publishing platforms, including date of first publish and a unique resource key.
@objcMembers
public class PublishJob: VIMModelObject {
    
    internal private(set) var firstPublishDateString: String?
    
    /// The time as a `Date` when the user first published this post.
    public private(set) var firstPublishDate: Date?
    
    /// The status of the post on each of the supported platforms.
    public private(set) var destinations: PublishDestinations?

    /// The unique identifier for this publish job.
    public private(set) var resourceKey: String?
    
    // MARK: - Overrides
    
    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case Constants.Key.destinations:
            return PublishDestinations.self
        default:
            return nil
        }
    }
    
    public override func getObjectMapping() -> Any? {
        return [
            Constants.Key.firstPublishDate: Constants.Value.firstPublishDate,
            Constants.Key.resourceKey: Constants.Value.resourceKey
        ]
    }
    
    public override func didFinishMapping() {
        self.firstPublishDate = self.formatDate(from: self.firstPublishDateString)
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

private struct Constants {
    struct Key {
        static let destinations = "destinations"
        static let firstPublishDate = "first_publish_date"
        static let resourceKey = "resource_key"
    }
    
    struct Value {
        static let firstPublishDate = "firstPublishDateString"
        static let resourceKey = "resourceKey"
    }
}
