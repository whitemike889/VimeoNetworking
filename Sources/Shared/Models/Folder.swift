//
//  Folder.swift
//  AFNetworking
//
//  Created by Song, Alexander on 12/12/18.
//

import Foundation

public class Folder: VIMModelObject, ConnectionsProviding, ConnectionsParsing
{
    /// The created time for the Folder
    @objc dynamic public private(set) var createdTime: NSDate?
    
    /// The meta data for the Folder
    @objc dynamic internal var metadata: Metadata?
    
    /// The modified time for the Folder
    @objc dynamic public private(set) var modifiedTime: NSDate?
    
    /// The name for the Folder
    @objc dynamic public private(set) var name: String?
    
    /// The resource key for the Folder
    @objc dynamic public private(set) var resourceKey: String?
    
    /// The Slack webhook ID
    @objc dynamic public private(set) var slackIncomingWebhooksId: NSNumber?
    
    /// The Slack integration channel
    @objc dynamic public private(set) var slackIntegrationChannel: String?
    
    /// The Slack language preference for notifications on channel
    @objc public private(set) var slackLanguagePreference: String?
    
    /// The user preferences for Slack notifications
    @objc public private(set) var slackUserPreferences: [String]?
    
    /// The URI for the Folder
    @objc dynamic public private(set) var uri: String?
    
    /// The user that owns the Folder
    @objc dynamic public private(set) var user: VIMUser?
    
    /// The connections associated with the Folder
    public internal(set) var connections: [Folder.ConnectionKeys: VIMConnection] = [:]
    
    /// The slack language preference for the Folder, mapped to a Swift-only enum
    public private(set) var languagePreference: SlackLanguagePreference?
    
    /// The slack user preferences for the Folder, mapped to a Swift-only enum
    public private(set) var userPreferences: [SlackUserPreferences]?
    
    /// The created time for the Folder, converted to a Date type
    @objc public private(set) var createdDate: Date?
    
    /// The modified time for the Folder, converted to a Date type
    @objc public private(set) var modifiedDate: Date?
    
    // MARK: - VIMModelObject overrides
    
    public override func didFinishMapping()
    {
        if let metadata = metadata
        {
            connections = parse(metadata)
        }
        
        if let slackLanguagePreferenceString = slackLanguagePreference
        {
            languagePreference = SlackLanguagePreference(rawValue: slackLanguagePreferenceString)
        }
        
        if let slackUserPreferences = slackUserPreferences
        {
            userPreferences = slackUserPreferences.compactMap { SlackUserPreferences(rawValue: $0) }
        }
    }
    
    public override func getObjectMapping() -> Any
    {
        return Mappings.membersByEncodingKeys
    }
    
    public override func getClassForObjectKey(_ key: String!) -> AnyClass?
    {
        return Mappings.classesByEncodingKeys[key]
    }
}

extension Folder
{
    struct Mappings
    {
        static let membersByEncodingKeys = [
            "created_time": "createdTime",
            "modified_time": "modifiedTime",
            "resource_key": "resourceKey",
            "slack_incoming_webhooks_id": "slackIncomingWebhooksId",
            "slack_integration_channel": "slackIntegrationChannel"
        ]
        
        static let classesByEncodingKeys = [
            "user": VIMUser.self
        ]
    }
}

// MARK: - ConnectionsParsing

extension Folder
{
    public enum ConnectionKeys: String, MetadataKeys
    {
        case videos
    }
    
    var connectionMapping: [Folder.ConnectionKeys: VIMConnection.Type]
    {
        return [:]
    }
}

// MARK: - Nested Types

extension Folder
{
    public enum SlackLanguagePreference: String
    {
        case de = "de-DE"
        case en = "en"
        case es = "es"
        case fr = "fr-FR"
        case ja = "ja-JP"
        case ko = "ko-KR"
        case pt = "pt-BR"
    }
    
    public enum SlackUserPreferences: String
    {
        case collectionChange = "COLLECTION_CHANGE"
        case privacyChange = "PRIVACY_CHANGE"
        case reviewPage = "REVIEW_PAGE"
        case videoDetail = "VIDEO_DETAIL"
    }
}
