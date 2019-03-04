//
//  ViewController.swift
//  UILocalNotificationDemo
//
//  Created by CoderDream on 2019/3/4.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 发送通知消息
        scheduleNotification(itemID: 12345)
        // 清除所有本地推送
        //UIApplication.shared.cancelAllLocalNotifications()
        print("Done")
    }

    // 发送通知消息
    func scheduleNotification(itemID : Int) {
        // 如果已存在该通知消息，则先取消
        cancelNotification(itemID: itemID)
        
        // 创建 UILocalNotification 来进行本地消息通知
        let localNotification = UILocalNotification()
        // 推送时间（设置为 30 秒以后）
        localNotification.fireDate = Date(timeIntervalSinceNow: 30)
        // 时区
        localNotification.timeZone = NSTimeZone.default
        // 推送内容
        localNotification.alertBody = "来自本地的消息"
        // 声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        // 额外信息
        localNotification.userInfo = ["ItemID" : itemID]
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    // 取消通知消息
    func cancelNotification(itemID : Int) {
        // 通过 itemID 获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(itemID: itemID)
        if existingNotification != nil {
            // 如果 existingNotification 不为 nil，就取消消息推送
            UIApplication.shared.cancelLocalNotification(existingNotification!)
        }
    }
    
    // 通过遍历所有的消息推送，通过 itemID 的对比，返回 UILocalNotification
    func notificationForThisItem(itemID : Int) -> UILocalNotification? {
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String : Int]
            let number = info["ItemID"]
            if number != nil && number == itemID {
                return notification as UILocalNotification
            }
        }
        
        return nil
    }

}

