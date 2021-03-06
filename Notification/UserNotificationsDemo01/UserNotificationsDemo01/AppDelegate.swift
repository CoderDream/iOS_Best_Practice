//
//  AppDelegate.swift
//  UserNotificationsDemo01
//
//  Created by CoderDream on 2019/3/4.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 请求通知权限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (accepted, error) in
            if !accepted {
                print("用户不允许消息通知")
            } else {
                print("用户允许消息通知")
            }
        }
        
        UNUserNotificationCenter.current().getNotificationSettings {
            settings in
            switch settings.authorizationStatus {
            case .authorized:
                return
            case .notDetermined:
                //请求授权
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .sound, .badge]) {
                        (accepted, error) in
                        if !accepted {
                            print("用户不允许消息通知。")
                        }
                }
            case .denied:
                DispatchQueue.main.async(execute: { () -> Void in
                    let alertController = UIAlertController(title: "消息推送已关闭",
                                                            message: "想要及时获取消息。点击“设置”，开启通知。",
                                                            preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
                    
                    let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
                        (action) -> Void in
                        let url = URL(string: UIApplication.openSettingsURLString)
                        if let url = url, UIApplication.shared.canOpenURL(url) {
                            if #available(iOS 10, *) {
                                UIApplication.shared.open(url, options: [:],
                                                          completionHandler: {
                                                            (success) in
                                })
                            } else {
                                UIApplication.shared.openURL(url)
                            }
                        }
                    })
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(settingsAction)
                    
                    //self.present(alertController, animated: true, completion: nil)
                })
            case .provisional:
                print("provisional")
            }
        }
        f1()
        
        return true
    }
    
    
    func f1() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            var message = "是否允许通知："
            switch settings.authorizationStatus {
            case .authorized:
                message.append("允许")
            case .notDetermined:
                message.append("未确定")
            case .denied:
                message.append("不允许")
            case .provisional:
                print("provisional")
            }
            
            message.append("\n声音：")
            switch settings.soundSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n应用图标标记：")
            switch settings.badgeSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n在锁定屏幕上显示：")
            switch settings.lockScreenSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n在历史记录中显示：")
            switch settings.notificationCenterSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n横幅显示：")
            switch settings.alertSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n显示预览：")
            switch settings.showPreviewsSetting{
            case .always:
                message.append("始终（默认）")
            case .whenAuthenticated:
                message.append("解锁时")
            case .never:
                message.append("从不")
            }
            
            
            print(message)
        }
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

