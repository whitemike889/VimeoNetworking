//
//  Request+Notifications.swift
//  VimeoNetworking
//
//  Created by Lim, Jennifer on 1/18/17.
//  Copyright © 2016 Vimeo. All rights reserved.
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

public extension Request
{
    private static var Path: String { return "/me/notifications/subscriptions" }
    
    private static var SubscriptionsPathComponent: String { return "/subscriptions" }

    // MARK: - Notifications API

    /// Handle Mutliple Devices: Create a request that set the device as active to receive Notifications. This request should be made only once: When the app first launch. The purpose of the request is to notify the server side, this device should receive push notifications.
    ///
    /// - Parameter deviceToken: The token that is stored in `SMKNotificationsCenter`
    public static func setDeviceAsActiveToReceiveNotifications(forNotificationsURI notificationsURI: String, deviceToken: String) -> Request
    {
        let subscriptionsURI = Request.subscriptionsURI(forNotificationsURI: notificationsURI, deviceToken: deviceToken)

        return Request(method: .PUT, path: subscriptionsURI, parameters: nil)
    }

    /// Retrieve the notification subscriptions.
    ///
    /// - Returns: subscriptionCollection
    public static func getNotificationSubscriptionRequest(forNotificationsURI notificationsURI: String, deviceToken: String) -> Request
    {
        let subscriptionsURI = Request.subscriptionsURI(forNotificationsURI: notificationsURI, deviceToken: deviceToken)

        return Request(method: .GET, path: subscriptionsURI, parameters: nil)
    }

    /// Create a request that updates the push notification subscriptions
    ///
    /// - Parameter subscription: The subscription dictionary contains the boolean values for each of those: comment, credit, like, reply, follow, video_available that defines what the user is subscripted to.
    /// - Returns: The result of the .PATCH is a SubscriptionCollection
    public static func updateNotificationSubscriptionsRequest(withSubscription subscription: VimeoClient.RequestParametersDictionary, notificationsURI: String, deviceToken: String) -> Request
    {
        let subscriptionsURI = Request.subscriptionsURI(forNotificationsURI: notificationsURI, deviceToken: deviceToken)

        return Request(method: .PATCH, path: subscriptionsURI, parameters: subscription)
    }

    // MARK: - Helper

    private static func subscriptionsURI(forNotificationsURI notificationsURI: String, deviceToken: String) -> String
    {
        return notificationsURI + "/\(deviceToken)" + SubscriptionsPathComponent
    }
    
    public static func markNotificationAsNotNewRequest(forNotification notification: VIMNotification, notificationsURI: String) -> Request
    {
        guard let latestURI = notification.uri else
        {
            return Request(method: .PATCH, path: notificationsURI, parameters: nil)
        }

        let parameters = [
            "latest_notification_uri" : latestURI,
            "new" : "false"
        ]

        return Request(method: .PATCH, path: notificationsURI, parameters: parameters)
    }

    public static func markNotificationsAsSeenRequest(forNotifications notifications: [VIMNotification], notificationsURI: String) -> Request
    {
        var parameters: [VimeoClient.RequestParametersDictionary] = []
        let _ = notifications.map { (notification: VIMNotification) -> Void in
            if let uri = notification.uri
            {
                parameters.append([
                    "seen": "true",
                    "uri": uri]
                )
            }
        }

        return Request(method: .PATCH, path: notificationsURI, parameters: parameters)
    }
}
