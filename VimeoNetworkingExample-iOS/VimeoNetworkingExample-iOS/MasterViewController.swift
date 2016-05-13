//
//  MasterViewController.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/17/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController
{
    var detailViewController: DetailViewController? = nil
    var videos: [VIMVideo] = []
    {
        didSet
        {
            self.tableView.reloadData()
        }
    }
    
    private var accountObservationToken: ObservationToken?
    private var authenticationButton: UIBarButtonItem?
    
    // MARK: - View Controller

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let split = self.splitViewController
        {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.setupAccountObservation()
        
        self.authenticationButton = UIBarButtonItem(title: nil, style: .Plain, target: self, action: #selector(didTapAuthenticationButton))
        self.updateAuthenticationButton()
        self.navigationItem.rightBarButtonItem = self.authenticationButton
    }

    override func viewWillAppear(animated: Bool)
    {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed

        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup
    
    private func setupAccountObservation()
    {
        self.accountObservationToken = Notification.AuthenticatedAccountDidChange.observe { [weak self] notification in
            
            guard let strongSelf = self else { return }
            
            let request: Request<[VIMVideo]>
            if VimeoClient.defaultClient.isAuthenticatedWithUser
            {
                request = Request<[VIMVideo]>(path: "/me/videos")
            }
            else
            {
                request = Request<[VIMVideo]>(path: "/channels/staffpicks/videos")
            }
            
            VimeoClient.defaultClient.request(request) { (result) in
                
                switch result
                {
                case .Success(let response):
                    strongSelf.videos = response.model
                case .Failure(let error):
                    let title = "Video Request Failed"
                    let message = "\(request.path) could not be loaded: \(error.localizedDescription)"
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(action)
                    strongSelf.presentViewController(alert, animated: true, completion: nil)
                }
            }
            
            strongSelf.navigationItem.title = request.path
            strongSelf.updateAuthenticationButton()
        }
    }
    
    private func updateAuthenticationButton()
    {
        if VimeoClient.defaultClient.isAuthenticatedWithUser
        {
            self.authenticationButton?.title = "Log Out"
        }
        else
        {
            self.authenticationButton?.title = "Log In"
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapAuthenticationButton()
    {
        let authenticationController = AuthenticationController(client: VimeoClient.defaultClient)
        if VimeoClient.defaultClient.isAuthenticatedWithUser
        {
            do
            {
                try authenticationController.logOut()
            }
            catch let error as NSError
            {
                
                let title = "Couldn't Log Out"
                let message = "Logging out failed: \(error.localizedDescription)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else
        {
            let URL = authenticationController.codeGrantAuthorizationURL()
            
            UIApplication.sharedApplication().openURL(URL)
        }
    }

    // MARK: - Segues

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        if segue.identifier == "showDetail"
//        {
//            if let indexPath = self.tableView.indexPathForSelectedRow
//            {
//                let object = videos[indexPath.row] as! NSDate
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.videos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let video = self.videos[indexPath.row]
        
        cell.textLabel!.text = video.name
        
        return cell
    }
}

