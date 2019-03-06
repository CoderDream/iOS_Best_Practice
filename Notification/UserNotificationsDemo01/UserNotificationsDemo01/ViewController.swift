//
//  ViewController.swift
//  UserNotificationsDemo01
//
//  Created by CoderDream on 2019/3/4.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        print("viewDidLoad begin")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //设置推送内容
        let content = UNMutableNotificationContent()
        content.title = "hangge.com"
        content.body = "做最好的开发者知识平台"
        
        //设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        
        //设置请求标识符
        let requestIdentifier = "com.hangge.testNotification"
        
        //设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content, trigger: trigger)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
        print("viewDidLoad end")
    }


}

