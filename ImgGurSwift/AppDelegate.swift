//
//  AppDelegate.swift
//  ImgGurSwift
//
//  Created by Balaji on 08/05/16.
//  Copyright © 2016 Balaji. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authAttempts = 0;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        //extract code from url
        if let code = extractCodeFrom(URL: url) {
            UserSession().authenticateUser(code: code)
            return true
        }
        return false
    }
    
    func extractCodeFrom(URL url: NSURL) -> String? {
        let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        
        let queryItems = urlComponents?.queryItems?.filter({ (queryItem) -> Bool in
            queryItem.name == "code"
        })
        print(queryItems)
        guard queryItems?.count > 0, let code = queryItems![0].value else {
            let deniedAlert = UIAlertController(title: "Error",
                                                message: "Access was denied by Imgur",
                                                preferredStyle: .Alert)
            let tryAgainAction = UIAlertAction(title: "Try again", style: .Default, handler: { (action) in
                if self.authAttempts <= 3 {
                    APIManager.sharedInstance.authorizeApp()
                }
            })
            deniedAlert.addAction(tryAgainAction);
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            deniedAlert.addAction(cancelAction);
            return nil
        }
        return code
    }
}

