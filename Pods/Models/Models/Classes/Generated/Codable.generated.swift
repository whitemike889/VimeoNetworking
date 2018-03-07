// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Activity
{
    enum CodingKeys: String, CodingKey
    {
        case clip
        case type
        case time
        case user
    }
}

extension Category
{
    enum CodingKeys: String, CodingKey
    {
        case resourceKey = "resource_key"
        case uri
        case name
        case pictures
        case metadata
    }
}

extension CategoryConnections
{
    enum CodingKeys: String, CodingKey
    {
        case users
        case videos
    }
}

extension CategoryInteractions
{
    enum CodingKeys: String, CodingKey
    {
        case follow
    }
}

extension CategoryMetadata
{
    enum CodingKeys: String, CodingKey
    {
        case connections
        case interactions
    }
}

extension Channel
{
    enum CodingKeys: String, CodingKey
    {
        case resourceKey = "resource_key"
        case uri
        case name
        case description
        case privacy
        case pictures
        case metadata
        case user
    }
}

extension ChannelConnections
{
    enum CodingKeys: String, CodingKey
    {
        case users
        case videos
    }
}

extension ChannelInteractions
{
    enum CodingKeys: String, CodingKey
    {
        case follow
    }
}

extension ChannelMetadata
{
    enum CodingKeys: String, CodingKey
    {
        case connections
        case interactions
    }
}

extension ChannelPrivacy
{
    enum CodingKeys: String, CodingKey
    {
        case view
    }
}

extension Comment
{
    enum CodingKeys: String, CodingKey
    {
        case resourceKey = "resource_key"
        case uri
        case text
        case user
        case metadata
    }
}

extension CommentConnections
{
    enum CodingKeys: String, CodingKey
    {
        case replies
    }
}

extension CommentMetadata
{
    enum CodingKeys: String, CodingKey
    {
        case connections
    }
}

extension Connection
{
    enum CodingKeys: String, CodingKey
    {
        case uri
    }
}

extension Email
{
    enum CodingKeys: String, CodingKey
    {
        case email
    }
}

extension HLSFile
{
    enum CodingKeys: String, CodingKey
    {
        case link
        case log
    }
}

extension Interaction
{
    enum CodingKeys: String, CodingKey
    {
        case uri
    }
}

extension MembershipInteraction
{
    enum CodingKeys: String, CodingKey
    {
        case uri
        case added
    }
}

extension Pictures
{
    enum CodingKeys: String, CodingKey
    {
        case sizes
    }
}

extension Play
{
    enum CodingKeys: String, CodingKey
    {
        case progressive
        case hls
        case status
    }
}

extension Preferences
{
    enum CodingKeys: String, CodingKey
    {
        case videos
    }
}

extension ProgressiveFile
{
    enum CodingKeys: String, CodingKey
    {
        case width
        case height
        case link
    }
}

extension QuantifiedConnection
{
    enum CodingKeys: String, CodingKey
    {
        case uri
        case total
    }
}

extension Size
{
    enum CodingKeys: String, CodingKey
    {
        case width
        case height
        case link
    }
}

extension Space
{
    enum CodingKeys: String, CodingKey
    {
        case free
        case max
        case used
    }
}

extension Stats
{
    enum CodingKeys: String, CodingKey
    {
        case plays
    }
}

extension UploadQuota
{
    enum CodingKeys: String, CodingKey
    {
        case space
    }
}

extension User
{
    enum CodingKeys: String, CodingKey
    {
        case resourceKey = "resource_key"
        case uri
        case name
        case location
        case bio
        case account
        case pictures
        case metadata
        case badge
        case preferences
        case contentFilter = "content_filter"
        case uploadQuota = "upload_quota"
        case emails
    }
}

extension UserBadge
{
    enum CodingKeys: String, CodingKey
    {
        case type
        case text
    }
}

extension UserConnections
{
    enum CodingKeys: String, CodingKey
    {
        case channels
        case followers
        case following
        case likes
        case moderatedChannels = "moderated_channels"
        case videos
        case shared
    }
}

extension UserInteractions
{
    enum CodingKeys: String, CodingKey
    {
        case follow
        case block
        case report
    }
}

extension UserMetadata
{
    enum CodingKeys: String, CodingKey
    {
        case connections
        case interactions
    }
}

extension UserReportInteraction
{
    enum CodingKeys: String, CodingKey
    {
        case uri
        case reason
    }
}

extension Video
{
    enum CodingKeys: String, CodingKey
    {
        case resourceKey = "resource_key"
        case uri
        case name
        case description
        case duration
        case width
        case height
        case privacy
        case pictures
        case stats
        case metadata
        case user
        case status
        case badge
    }
}

extension VideoBadge
{
    enum CodingKeys: String, CodingKey
    {
        case type
        case pictures
    }
}

extension VideoConnections
{
    enum CodingKeys: String, CodingKey
    {
        case comments
        case likes
        case related
        case recommendations
    }
}

extension VideoInteractions
{
    enum CodingKeys: String, CodingKey
    {
        case watchLater = "watchlater"
        case like
        case report
    }
}

extension VideoMetadata
{
    enum CodingKeys: String, CodingKey
    {
        case connections
        case interactions
    }
}

extension VideoPreferences
{
    enum CodingKeys: String, CodingKey
    {
        case privacy
        case password
    }
}

extension VideoPrivacy
{
    enum CodingKeys: String, CodingKey
    {
        case view
        case comments
        case embed
        case download
        case add
    }
}

extension VideoReportInteraction
{
    enum CodingKeys: String, CodingKey
    {
        case uri
        case reason
    }
}

