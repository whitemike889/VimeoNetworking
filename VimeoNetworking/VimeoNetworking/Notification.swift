//
//  Notification.swift
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/25/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public class ObservationToken
{
    private let observer: NSObjectProtocol
    
    private init(observer: NSObjectProtocol)
    {
        self.observer = observer
    }
    
    public func stopObserving()
    {
        print("deregistering observer: \(self.observer)")
        Notification.NotificationCenter.removeObserver(self.observer, name: nil, object: nil)
    }
    
    deinit
    {
        print("observation token deinit")
        self.stopObserving()
    }
}

public enum Notification: String
{
    case ClientDidReceiveServiceUnavailableError
    case ClientDidReceiveInvalidTokenError
    
    case ReachabilityDidChange
    
    case AuthenticatedAccountDidChange
    case AuthenticatedAccountDidRefresh
    
    // MARK: -
    
    private static let NotificationCenter = NSNotificationCenter.defaultCenter()
    
    // MARK: -
    
    public func post(object object: AnyObject?)
    {
        dispatch_async(dispatch_get_main_queue())
        {
            self.dynamicType.NotificationCenter.postNotificationName(self.rawValue, object: object)
        }
    }
    
    @warn_unused_result(message = "Token must be strongly stored, observation is removed on token deinit")
    public func observe(observationBlock: (NSNotification) -> Void) -> ObservationToken
    {
        let observer = self.dynamicType.NotificationCenter.addObserverForName(self.rawValue, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: observationBlock)
        
        print("registered observer: \(observer)")
        
        return ObservationToken(observer: observer)
    }
}