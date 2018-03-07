// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Activity
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += Video.filters().map({ "clip." + $0 })
        filters += ["type"]
        filters += ["time"]
        filters += User.filters().map({ "user." + $0 })
        return filters
    }
}

extension Category
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["resourceKey"]
        filters += ["uri"]
        filters += ["name"]
        filters += Pictures.filters().map({ "pictures." + $0 })
        filters += ChannelMetadata.filters().map({ "metadata." + $0 })
        return filters
    }
}

extension CategoryConnections
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += QuantifiedConnection.filters().map({ "users." + $0 })
        filters += QuantifiedConnection.filters().map({ "videos." + $0 })
        return filters
    }
}

extension CategoryInteractions
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += MembershipInteraction.filters().map({ "follow." + $0 })
        return filters
    }
}

extension CategoryMetadata
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += CategoryConnections.filters().map({ "connections." + $0 })
        filters += CategoryInteractions.filters().map({ "interactions." + $0 })
        return filters
    }
}

extension Channel
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["resourceKey"]
        filters += ["uri"]
        filters += ["name"]
        filters += ["description"]
        filters += ChannelPrivacy.filters().map({ "privacy." + $0 })
        filters += Pictures.filters().map({ "pictures." + $0 })
        filters += ChannelMetadata.filters().map({ "metadata." + $0 })
        filters += User.filters().map({ "user." + $0 })
        return filters
    }
}

extension ChannelConnections
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += QuantifiedConnection.filters().map({ "users." + $0 })
        filters += QuantifiedConnection.filters().map({ "videos." + $0 })
        return filters
    }
}

extension ChannelInteractions
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += MembershipInteraction.filters().map({ "follow." + $0 })
        return filters
    }
}

extension ChannelMetadata
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ChannelConnections.filters().map({ "connections." + $0 })
        filters += ChannelInteractions.filters().map({ "interactions." + $0 })
        return filters
    }
}

extension ChannelPrivacy
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["view"]
        return filters
    }
}

extension Comment
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["resourceKey"]
        filters += ["uri"]
        filters += ["text"]
        filters += User.filters().map({ "user." + $0 })
        filters += CommentMetadata.filters().map({ "metadata." + $0 })
        return filters
    }
}

extension CommentConnections
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += QuantifiedConnection.filters().map({ "replies." + $0 })
        return filters
    }
}

extension CommentMetadata
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += CommentConnections.filters().map({ "connections." + $0 })
        return filters
    }
}

extension Connection
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["uri"]
        return filters
    }
}

extension Email
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["email"]
        return filters
    }
}

extension HLSFile
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["link"]
        filters += ["log"]
        return filters
    }
}

extension Interaction
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["uri"]
        return filters
    }
}

extension MembershipInteraction
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["uri"]
        filters += ["added"]
        return filters
    }
}

extension Pictures
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["sizes"]
        return filters
    }
}

extension Play
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["progressive"]
        filters += ["hls"]
        filters += ["status"]
        return filters
    }
}

extension Preferences
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += VideoPreferences.filters().map({ "videos." + $0 })
        return filters
    }
}

extension ProgressiveFile
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["width"]
        filters += ["height"]
        filters += ["link"]
        return filters
    }
}

extension QuantifiedConnection
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["uri"]
        filters += ["total"]
        return filters
    }
}

extension Size
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["width"]
        filters += ["height"]
        filters += ["link"]
        return filters
    }
}

extension Space
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["free"]
        filters += ["max"]
        filters += ["used"]
        return filters
    }
}

extension Stats
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["plays"]
        return filters
    }
}

extension UploadQuota
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += Space.filters().map({ "space." + $0 })
        return filters
    }
}

extension User
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["resourceKey"]
        filters += ["uri"]
        filters += ["name"]
        filters += ["location"]
        filters += ["bio"]
        filters += ["account"]
        filters += Pictures.filters().map({ "pictures." + $0 })
        filters += UserMetadata.filters().map({ "metadata." + $0 })
        filters += UserBadge.filters().map({ "badge." + $0 })
        filters += Preferences.filters().map({ "preferences." + $0 })
        filters += ["contentFilter"]
        filters += UploadQuota.filters().map({ "upload_quota." + $0 })
        filters += ["emails"]
        return filters
    }
}

extension UserBadge
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["type"]
        filters += ["text"]
        return filters
    }
}

extension UserConnections
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += QuantifiedConnection.filters().map({ "channels." + $0 })
        filters += QuantifiedConnection.filters().map({ "followers." + $0 })
        filters += QuantifiedConnection.filters().map({ "following." + $0 })
        filters += QuantifiedConnection.filters().map({ "likes." + $0 })
        filters += QuantifiedConnection.filters().map({ "moderated_channels." + $0 })
        filters += QuantifiedConnection.filters().map({ "videos." + $0 })
        filters += QuantifiedConnection.filters().map({ "shared." + $0 })
        return filters
    }
}

extension UserInteractions
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += MembershipInteraction.filters().map({ "follow." + $0 })
        filters += MembershipInteraction.filters().map({ "block." + $0 })
        filters += UserReportInteraction.filters().map({ "report." + $0 })
        return filters
    }
}

extension UserMetadata
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += UserConnections.filters().map({ "connections." + $0 })
        filters += UserInteractions.filters().map({ "interactions." + $0 })
        return filters
    }
}

extension UserReportInteraction
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["uri"]
        filters += ["reason"]
        return filters
    }
}

extension Video
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["resourceKey"]
        filters += ["uri"]
        filters += ["name"]
        filters += ["description"]
        filters += ["duration"]
        filters += ["width"]
        filters += ["height"]
        filters += VideoPrivacy.filters().map({ "privacy." + $0 })
        filters += Pictures.filters().map({ "pictures." + $0 })
        filters += Stats.filters().map({ "stats." + $0 })
        filters += VideoMetadata.filters().map({ "metadata." + $0 })
        filters += User.filters().map({ "user." + $0 })
        filters += ["status"]
        filters += VideoBadge.filters().map({ "badge." + $0 })
        return filters
    }
}

extension VideoBadge
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["type"]
        filters += Pictures.filters().map({ "pictures." + $0 })
        return filters
    }
}

extension VideoConnections
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += QuantifiedConnection.filters().map({ "comments." + $0 })
        filters += QuantifiedConnection.filters().map({ "likes." + $0 })
        filters += Connection.filters().map({ "related." + $0 })
        filters += Connection.filters().map({ "recommendations." + $0 })
        return filters
    }
}

extension VideoInteractions
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += MembershipInteraction.filters().map({ "watchlater." + $0 })
        filters += MembershipInteraction.filters().map({ "like." + $0 })
        filters += VideoReportInteraction.filters().map({ "report." + $0 })
        return filters
    }
}

extension VideoMetadata
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += VideoConnections.filters().map({ "connections." + $0 })
        filters += VideoInteractions.filters().map({ "interactions." + $0 })
        return filters
    }
}

extension VideoPreferences
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += VideoPrivacy.filters().map({ "privacy." + $0 })
        filters += ["password"]
        return filters
    }
}

extension VideoPrivacy
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["view"]
        filters += ["comments"]
        filters += ["embed"]
        filters += ["download"]
        filters += ["add"]
        return filters
    }
}

extension VideoReportInteraction
{
    public static func filters() -> [String]
    {
        var filters: [String] = []
        filters += ["uri"]
        filters += ["reason"]
        return filters
    }
}

