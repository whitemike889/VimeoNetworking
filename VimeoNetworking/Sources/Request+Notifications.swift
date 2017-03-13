//
//  Request+Notifications.swift
//  Pods
//
//  Created by Lim, Jennifer on 1/18/17.
//
//

public extension Request
{
    private typealias ParameterDictionary = [String: AnyObject]
    
    private static var Path: String { return "/me/notifications" }
    
    private static var SubscriptionsPath: String { return Path.stringByAppendingString("/subscriptions") }
    
    /// Retrieve the notification subscriptions.
    ///
    /// - Returns: subscriptionCollection
    public static func getNotificationSubscription() -> Request
    {
        return Request(method: .GET, path: SubscriptionsPath, parameters: nil)
    }
    
    /// Create a request that updates the push notification subscriptions
    ///
    /// - Parameter subscription: The subscription dictionary contains the boolean values for each of those: comment, credit, like, reply, follow, video_available that defines what the user is subscripted to.
    /// - Returns: The result of the .PATCH is a SubscriptionCollection
    public static func updateNotificationSubscriptions(subscription: VimeoClient.RequestParametersDictionary) -> Request
    {
        return Request(method: .PATCH, path: SubscriptionsPath, parameters: subscription)
    }
    
    public static func markNotificationAsNotNewRequest(notification: VIMNotification) -> Request
    {
        guard let uri = notification.uri else
        {
            return Request(method: .PATCH, path: Path, parameters: nil)
        }
        
        let parameters = [
            "latest_notification_uri" : uri,
            "new" : "false"
        ]

        return Request(method: .PATCH, path: Path, parameters: parameters)
    }
    
    public static func markNotificationsAsSeenRequest(notifications: [VIMNotification]) -> Request
    {
        var parameters: [ParameterDictionary] = []
        notifications.map { (notification: VIMNotification) -> Void in
            if let uri = notification.uri
            {
                parameters.append([
                    "seen": "true",
                    "uri": uri]
                )
            }
        }
        
        return Request(method: .PATCH, path: Path, parameters: parameters)
    }
}
