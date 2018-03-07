// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Activity
{
    public static func ==(lhs: Activity, rhs: Activity) -> Bool
    {
        guard lhs.clip == rhs.clip else { return false }
        guard lhs.type == rhs.type else { return false }
        guard lhs.time == rhs.time else { return false }
        guard lhs.user == rhs.user else { return false }
        return true
    }
}

extension Category
{
    public static func ==(lhs: Category, rhs: Category) -> Bool
    {
        guard lhs.resourceKey == rhs.resourceKey else { return false }
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.name == rhs.name else { return false }
        guard lhs.pictures == rhs.pictures else { return false }
        guard lhs.metadata == rhs.metadata else { return false }
        return true
    }
}

extension CategoryConnections
{
    public static func ==(lhs: CategoryConnections, rhs: CategoryConnections) -> Bool
    {
        guard lhs.users == rhs.users else { return false }
        guard lhs.videos == rhs.videos else { return false }
        return true
    }
}

extension CategoryInteractions
{
    public static func ==(lhs: CategoryInteractions, rhs: CategoryInteractions) -> Bool
    {
        guard lhs.follow == rhs.follow else { return false }
        return true
    }
}

extension CategoryMetadata
{
    public static func ==(lhs: CategoryMetadata, rhs: CategoryMetadata) -> Bool
    {
        guard lhs.connections == rhs.connections else { return false }
        guard lhs.interactions == rhs.interactions else { return false }
        return true
    }
}

extension Channel
{
    public static func ==(lhs: Channel, rhs: Channel) -> Bool
    {
        guard lhs.resourceKey == rhs.resourceKey else { return false }
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.name == rhs.name else { return false }
        guard lhs.description == rhs.description else { return false }
        guard lhs.privacy == rhs.privacy else { return false }
        guard lhs.pictures == rhs.pictures else { return false }
        guard lhs.metadata == rhs.metadata else { return false }
        guard lhs.user == rhs.user else { return false }
        return true
    }
}

extension ChannelConnections
{
    public static func ==(lhs: ChannelConnections, rhs: ChannelConnections) -> Bool
    {
        guard lhs.users == rhs.users else { return false }
        guard lhs.videos == rhs.videos else { return false }
        return true
    }
}

extension ChannelInteractions
{
    public static func ==(lhs: ChannelInteractions, rhs: ChannelInteractions) -> Bool
    {
        guard lhs.follow == rhs.follow else { return false }
        return true
    }
}

extension ChannelMetadata
{
    public static func ==(lhs: ChannelMetadata, rhs: ChannelMetadata) -> Bool
    {
        guard lhs.connections == rhs.connections else { return false }
        guard lhs.interactions == rhs.interactions else { return false }
        return true
    }
}

extension ChannelPrivacy
{
    public static func ==(lhs: ChannelPrivacy, rhs: ChannelPrivacy) -> Bool
    {
        guard lhs.view == rhs.view else { return false }
        return true
    }
}

extension Comment
{
    public static func ==(lhs: Comment, rhs: Comment) -> Bool
    {
        guard lhs.resourceKey == rhs.resourceKey else { return false }
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.text == rhs.text else { return false }
        guard lhs.user == rhs.user else { return false }
        guard lhs.metadata == rhs.metadata else { return false }
        return true
    }
}

extension CommentConnections
{
    public static func ==(lhs: CommentConnections, rhs: CommentConnections) -> Bool
    {
        guard lhs.replies == rhs.replies else { return false }
        return true
    }
}

extension CommentMetadata
{
    public static func ==(lhs: CommentMetadata, rhs: CommentMetadata) -> Bool
    {
        guard lhs.connections == rhs.connections else { return false }
        return true
    }
}

extension Connection
{
    public static func ==(lhs: Connection, rhs: Connection) -> Bool
    {
        guard lhs.uri == rhs.uri else { return false }
        return true
    }
}

extension Email
{
    public static func ==(lhs: Email, rhs: Email) -> Bool
    {
        guard lhs.email == rhs.email else { return false }
        return true
    }
}

extension HLSFile
{
    public static func ==(lhs: HLSFile, rhs: HLSFile) -> Bool
    {
        guard lhs.link == rhs.link else { return false }
        guard lhs.log == rhs.log else { return false }
        return true
    }
}

extension Interaction
{
    public static func ==(lhs: Interaction, rhs: Interaction) -> Bool
    {
        guard lhs.uri == rhs.uri else { return false }
        return true
    }
}

extension MembershipInteraction
{
    public static func ==(lhs: MembershipInteraction, rhs: MembershipInteraction) -> Bool
    {
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.added == rhs.added else { return false }
        return true
    }
}

extension Pictures
{
    public static func ==(lhs: Pictures, rhs: Pictures) -> Bool
    {
        guard lhs.sizes == rhs.sizes else { return false }
        return true
    }
}

extension Play
{
    public static func ==(lhs: Play, rhs: Play) -> Bool
    {
        guard lhs.progressive == rhs.progressive else { return false }
        guard lhs.hls == rhs.hls else { return false }
        guard lhs.status == rhs.status else { return false }
        return true
    }
}

extension Preferences
{
    public static func ==(lhs: Preferences, rhs: Preferences) -> Bool
    {
        guard lhs.videos == rhs.videos else { return false }
        return true
    }
}

extension ProgressiveFile
{
    public static func ==(lhs: ProgressiveFile, rhs: ProgressiveFile) -> Bool
    {
        guard lhs.width == rhs.width else { return false }
        guard lhs.height == rhs.height else { return false }
        guard lhs.link == rhs.link else { return false }
        return true
    }
}

extension QuantifiedConnection
{
    public static func ==(lhs: QuantifiedConnection, rhs: QuantifiedConnection) -> Bool
    {
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.total == rhs.total else { return false }
        return true
    }
}

extension Size
{
    public static func ==(lhs: Size, rhs: Size) -> Bool
    {
        guard lhs.width == rhs.width else { return false }
        guard lhs.height == rhs.height else { return false }
        guard lhs.link == rhs.link else { return false }
        return true
    }
}

extension Space
{
    public static func ==(lhs: Space, rhs: Space) -> Bool
    {
        guard lhs.free == rhs.free else { return false }
        guard lhs.max == rhs.max else { return false }
        guard lhs.used == rhs.used else { return false }
        return true
    }
}

extension Stats
{
    public static func ==(lhs: Stats, rhs: Stats) -> Bool
    {
        guard lhs.plays == rhs.plays else { return false }
        return true
    }
}

extension UploadQuota
{
    public static func ==(lhs: UploadQuota, rhs: UploadQuota) -> Bool
    {
        guard lhs.space == rhs.space else { return false }
        return true
    }
}

extension User
{
    public static func ==(lhs: User, rhs: User) -> Bool
    {
        guard lhs.resourceKey == rhs.resourceKey else { return false }
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.name == rhs.name else { return false }
        guard lhs.location == rhs.location else { return false }
        guard lhs.bio == rhs.bio else { return false }
        guard lhs.account == rhs.account else { return false }
        guard lhs.pictures == rhs.pictures else { return false }
        guard lhs.metadata == rhs.metadata else { return false }
        guard lhs.badge == rhs.badge else { return false }
        guard lhs.preferences == rhs.preferences else { return false }
        guard lhs.contentFilter == rhs.contentFilter else { return false }
        guard lhs.uploadQuota == rhs.uploadQuota else { return false }
        guard lhs.emails == rhs.emails else { return false }
        return true
    }
}

extension UserBadge
{
    public static func ==(lhs: UserBadge, rhs: UserBadge) -> Bool
    {
        guard lhs.type == rhs.type else { return false }
        guard lhs.text == rhs.text else { return false }
        return true
    }
}

extension UserConnections
{
    public static func ==(lhs: UserConnections, rhs: UserConnections) -> Bool
    {
        guard lhs.channels == rhs.channels else { return false }
        guard lhs.followers == rhs.followers else { return false }
        guard lhs.following == rhs.following else { return false }
        guard lhs.likes == rhs.likes else { return false }
        guard lhs.moderatedChannels == rhs.moderatedChannels else { return false }
        guard lhs.videos == rhs.videos else { return false }
        guard lhs.shared == rhs.shared else { return false }
        return true
    }
}

extension UserInteractions
{
    public static func ==(lhs: UserInteractions, rhs: UserInteractions) -> Bool
    {
        guard lhs.follow == rhs.follow else { return false }
        guard lhs.block == rhs.block else { return false }
        guard lhs.report == rhs.report else { return false }
        return true
    }
}

extension UserMetadata
{
    public static func ==(lhs: UserMetadata, rhs: UserMetadata) -> Bool
    {
        guard lhs.connections == rhs.connections else { return false }
        guard lhs.interactions == rhs.interactions else { return false }
        return true
    }
}

extension UserReportInteraction
{
    public static func ==(lhs: UserReportInteraction, rhs: UserReportInteraction) -> Bool
    {
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.reason == rhs.reason else { return false }
        return true
    }
}

extension Video
{
    public static func ==(lhs: Video, rhs: Video) -> Bool
    {
        guard lhs.resourceKey == rhs.resourceKey else { return false }
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.name == rhs.name else { return false }
        guard lhs.description == rhs.description else { return false }
        guard lhs.duration == rhs.duration else { return false }
        guard lhs.width == rhs.width else { return false }
        guard lhs.height == rhs.height else { return false }
        guard lhs.privacy == rhs.privacy else { return false }
        guard lhs.pictures == rhs.pictures else { return false }
        guard lhs.stats == rhs.stats else { return false }
        guard lhs.metadata == rhs.metadata else { return false }
        guard lhs.user == rhs.user else { return false }
        guard lhs.status == rhs.status else { return false }
        guard lhs.badge == rhs.badge else { return false }
        return true
    }
}

extension VideoBadge
{
    public static func ==(lhs: VideoBadge, rhs: VideoBadge) -> Bool
    {
        guard lhs.type == rhs.type else { return false }
        guard lhs.pictures == rhs.pictures else { return false }
        return true
    }
}

extension VideoConnections
{
    public static func ==(lhs: VideoConnections, rhs: VideoConnections) -> Bool
    {
        guard lhs.comments == rhs.comments else { return false }
        guard lhs.likes == rhs.likes else { return false }
        guard lhs.related == rhs.related else { return false }
        guard lhs.recommendations == rhs.recommendations else { return false }
        return true
    }
}

extension VideoInteractions
{
    public static func ==(lhs: VideoInteractions, rhs: VideoInteractions) -> Bool
    {
        guard lhs.watchLater == rhs.watchLater else { return false }
        guard lhs.like == rhs.like else { return false }
        guard lhs.report == rhs.report else { return false }
        return true
    }
}

extension VideoMetadata
{
    public static func ==(lhs: VideoMetadata, rhs: VideoMetadata) -> Bool
    {
        guard lhs.connections == rhs.connections else { return false }
        guard lhs.interactions == rhs.interactions else { return false }
        return true
    }
}

extension VideoPreferences
{
    public static func ==(lhs: VideoPreferences, rhs: VideoPreferences) -> Bool
    {
        guard lhs.privacy == rhs.privacy else { return false }
        guard lhs.password == rhs.password else { return false }
        return true
    }
}

extension VideoPrivacy
{
    public static func ==(lhs: VideoPrivacy, rhs: VideoPrivacy) -> Bool
    {
        guard lhs.view == rhs.view else { return false }
        guard lhs.comments == rhs.comments else { return false }
        guard lhs.embed == rhs.embed else { return false }
        guard lhs.download == rhs.download else { return false }
        guard lhs.add == rhs.add else { return false }
        return true
    }
}

extension VideoReportInteraction
{
    public static func ==(lhs: VideoReportInteraction, rhs: VideoReportInteraction) -> Bool
    {
        guard lhs.uri == rhs.uri else { return false }
        guard lhs.reason == rhs.reason else { return false }
        return true
    }
}

