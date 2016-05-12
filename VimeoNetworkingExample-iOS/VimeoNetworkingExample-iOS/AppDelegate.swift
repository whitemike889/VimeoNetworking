//
//  AppDelegate.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/17/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import UIKit

import VimeoNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate
{
    var window: UIWindow?
    
    let appConfiguration = AppConfiguration(clientKey: "YOUR_CLIENT_KEY_HERE", clientSecret: "YOUR_CLIENT_SECRET_HERE", scopes: [.Public, .Private, .Create, .Edit, .Delete, .Interact, .Upload])
    
    var authenticationController: AuthenticationController?
    var client: VimeoClient?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        splitViewController.delegate = self
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        
        
        
        let client = VimeoClient(appConfiguration: self.appConfiguration)
        self.client = client
        
        let authenticationController = AuthenticationController(client: client)
        self.authenticationController = authenticationController
        
        let loadedAccount: VIMAccount?
        do
        {
            loadedAccount = try authenticationController.loadSavedAccount()
        }
        catch let error
        {
            loadedAccount = nil
            print("error loading account \(error)")
        }
        
        if loadedAccount == nil
        {
            authenticationController.clientCredentialsGrant { result in
                
                switch result
                {
                case .Success(let account):
                    print("authenticated successfully: \(account)")
                case .Failure(let error):
                    print("failure authenticating: \(error)")
                }
            }
        }
        
        return true
    }
    
    // MARK: - URLs
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool
    {
        self.authenticationController?.codeGrant(responseURL: url) { result in
            
            switch result
            {
            case .Success(let account):
                print("authenticated successfully: \(account)")
            case .Failure(let error):
                print("failure authenticating: \(error)")
            }
        }
        
        return true
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool
    {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}

