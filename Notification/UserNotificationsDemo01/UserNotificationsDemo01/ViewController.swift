//
//  ViewController.swift
//  UserNotificationsDemo01
//
//  Created by CoderDream on 2019/3/4.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        print("viewDidLoad begin")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        notification1()
        notification2()
        notification3()
        notification4()
        notification5()
        print("viewDidLoad end")
    }
    
    
    @IBAction func type1(_ sender: UIButton) {
        notification1()
    }
    
    @IBAction func type2(_ sender: UIButton) {
        notification2()
    }
    // 1，一段时间后触发（UNTimeIntervalNotificationTrigger）
    // 比如下面样例我们设置10秒钟后触发推送通知。
    // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    func notification1() {
        print("notification1 call")
        // 设置推送内容1
        let content = UNMutableNotificationContent()
        content.title = "hangge.com"
        content.body = "做最好的开发者知识平台"
        
        // 设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        
        //设置请求标识符
        let requestIdentifier = "com.hangge.testNotification1"
        
        //设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content, trigger: trigger)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    func notification2() {        
        print("notification2 call")
        // 设置推送内容2
        let content2 = UNMutableNotificationContent()
        content2.title = "hangge.com2"
        content2.subtitle = "航歌（二级标题）"
        content2.body = "做最好的开发者知识平台"
        content2.badge = 2
        
        // 设置通知触发器
        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        //设置请求标识符
        let requestIdentifier2 = "com.hangge.testNotification2"
        
        //设置一个通知请求
        let request2 = UNNotificationRequest(identifier: requestIdentifier2,
                                            content: content2, trigger: trigger2)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request2) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier2)")
            }
        }
    }
    
    // 2，指定日期时间触发（UNCalendarNotificationTrigger）
    //（1）下面代码我们设置2017年11月11日凌晨触发推送通知。
    func notification3() {
        // 设置推送内容2
        let content3 = UNMutableNotificationContent()
        content3.title = "hangge.com3"
        content3.subtitle = "指定日期时间触发3"
        content3.body = "做最好的开发者知识平台"
        content3.badge = 2
        
        // 设置通知触发器
        var components = DateComponents()
        components.year = 2019
        components.month = 03
        components.day = 06
        let trigger3 = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        //设置请求标识符
        let requestIdentifier3 = "com.hangge.testNotification3"
        
        //设置一个通知请求
        let request3 = UNNotificationRequest(identifier: requestIdentifier3,
                                            content: content3, trigger: trigger3)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request3) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier3)")
            }
        }
    }
    
    //（2）下面代码我们设置每周一上午8点都会触发推送通知。
    func notification4() {
        // 设置推送内容
        let content4 = UNMutableNotificationContent()
        content4.title = "hangge.com4"
        content4.subtitle = "指定日期时间触发（重复）4"
        content4.body = "做最好的开发者知识平台"
        content4.badge = 2
        
        // 设置通知触发器
        var components = DateComponents()
        // components.weekday = 2 //周一
        // components.hour = 8 //上午8点
        components.second = 30 //30秒
        let trigger4 = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        //设置请求标识符
        let requestIdentifier4 = "com.hangge.testNotification4"
        
        //设置一个通知请求
        let request4 = UNNotificationRequest(identifier: requestIdentifier4,
                                            content: content4, trigger: trigger4)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request4) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier4)")
            }
        }
    }

    // 3，根据位置触发（UNLocationNotificationTrigger）
    // 该触发器支持进入某地触发、离开某地触发、或者两种情况均触发。下面代码设置成当手机进入到指定点（纬度：52.10，经度：51.11）
    // 200 米范围内时会触发推送通知。（注意：这里我们需要 import CoreLocation 框架）
    func notification5() {
        // 设置推送内容2
        let content5 = UNMutableNotificationContent()
        content5.title = "hangge.com5"
        content5.subtitle = "根据位置触发5"
        content5.body = "做最好的开发者知识平台"
        content5.badge = 2
        
        // 设置通知触发器
        let coordinate = CLLocationCoordinate2D(latitude: 52.10, longitude: 51.11)
        let region = CLCircularRegion(center: coordinate, radius: 200, identifier: "center")
        region.notifyOnEntry = true  //进入此范围触发
        region.notifyOnExit = false  //离开此范围不触发
        let trigger5 = UNLocationNotificationTrigger(region: region, repeats: true)
        
        //设置请求标识符
        let requestIdentifier5 = "com.hangge.testNotification5"
        
        //设置一个通知请求
        let request5 = UNNotificationRequest(identifier: requestIdentifier5,
                                            content: content5, trigger: trigger5)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request5) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier5)")
            }
        }
    }

}

