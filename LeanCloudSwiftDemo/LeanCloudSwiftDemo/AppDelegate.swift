//
//  AppDelegate.swift
//  LeanCloudSwiftDemo
//
//  Created by CoderDream on 2019/2/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LCApplication.default.set(
            id:  "VOfCGionrepsdh1dly5lPlfX-9Nh9j0Va", /* Your app ID */
            key: "UPd3qOCfYcXB9pfr65KAXCSa" /* Your app key */
        )
        do {
            let post = LCObject(className: "Post")
            try post.set("words", value: "Hello World!")
            
            _ = post.save { result in
                switch result {
                case .success:
                    print("success")
                    break
                case .failure(let error):
                    print("error: \(error)")
                    break
                }
            }
        } catch {
            print("ERROR")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

