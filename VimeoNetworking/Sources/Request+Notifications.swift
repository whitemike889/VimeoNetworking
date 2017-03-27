//
//  Request+Notifications.swift
//  Pods
//
//  Created by Lim, Jennifer on 1/18/17.
//
//

public extension Request
{
    fileprivate static var Path: String { return "/me/notifications/subscriptions" }

    private typealias ParameterDictionary = [String: AnyObject]

    private static var SubscriptionsPathComponent: String { return "/subscriptions" }

    /// Retrieve the notification subscriptions.
    ///
    /// - Returns: subscriptionCollection
    public static func getNotificationSubscriptionRequest(notificationsURI: String) -> Request
    {
        let subscriptionsURI = notificationsURI.appending(SubscriptionsPathComponent)

        return Request(method: .GET, path: subscriptionsURI, parameters: nil)
    }

    /// Create a request that updates the push notification subscriptions
    ///
    /// - Parameter subscription: The subscription dictionary contains the boolean values for each of those: comment, credit, like, reply, follow, video_available that defines what the user is subscripted to.
    /// - Returns: The result of the .PATCH is a SubscriptionCollection
    public static func updateNotificationSubscriptionsRequest(subscription: VimeoClient.RequestParametersDictionary, notificationsURI: String) -> Request
    {
        let subscriptionsURI = notificationsURI.appending(SubscriptionsPathComponent)

        return Request(method: .PATCH, path: subscriptionsURI, parameters: subscription as AnyObject?)
    }

    public static func markNotificationAsNotNewRequest(notification: VIMNotification, notificationsURI: String) -> Request
    {
        guard let latestURI = notification.uri else
        {
            return Request(method: .PATCH, path: notificationsURI, parameters: nil)
        }

        let parameters = [
            "latest_notification_uri" : latestURI,
            "new" : "false"
        ]

        return Request(method: .PATCH, path: notificationsURI, parameters: parameters as AnyObject?)
    }

    public static func markNotificationsAsSeenRequest(notifications: [VIMNotification], notificationsURI: String) -> Request
    {
        var parameters: [ParameterDictionary] = []
        notifications.map { (notification: VIMNotification) -> Void in
            if let uri = notification.uri
            {
                parameters.append([
                    "seen": "true" as AnyObject,
                    "uri": uri as AnyObject]
                )
            }
        }

        return Request(method: .PATCH, path: notificationsURI, parameters: parameters as AnyObject?)
    }
}
