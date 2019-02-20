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
        
        // mothod0901()
        //testSetArray()
        // mothod1001_deleteObject()
        mothod1101_deleteObject()
        return true
    }
    
    private func mothod0101() {
        do {
            let post = LCObject(className: "Post")
            try post.set("words", value: "Hello World!")
            
            _ = post.save { result in
                switch result {
                case .success:
                    print("success save post")
                    break
                case .failure(let error):
                    print("error: \(error)")
                    break
                }
            }
        } catch {
            print("ERROR")
        }
    }
    
    private func mothod0201() {
        do {
            // 2.
            let todo = LCObject(className: "Todo")
            
            try todo.set("title", value: "工程师周会")
            try todo.set("content", value: "每周工程师会议，周一下午 2 点")
            
            // 设置 location 的值为「会议室」
            try todo.set("location", value: "会议室")
            
            _ = todo.save { result in
                switch result {
                case .success:
                    print("success save todo")
                    break
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print("ERROR")
        }
    }
    
    private func mothod0301() {
        // 3.             使用 CQL 语法保存对象
        // LeanStorage 提供了类似 SQL 语法中的 Insert 方式保存一个对象，例如保存一个 TodoFolder 对象可以使用下面的代码：
        // 执行 CQL 语句实现新增一个 TodoFolder 对象
        _ = LCCQLClient.execute("insert into TodoFolder(name, priority) values('工作', 1)") { result in
            switch result {
            case .success(let value):
                let todoFolder = value.objects.first
                // Expression implicitly coerced from 'LCObject?' to 'Any'
                print("ok")
                // Optional(<LeanCloud.LCObject: 0x280e20820>)
                print(todoFolder)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mothod0401() {
        // 4 获取对象
        // 每个被成功保存在云端的对象会有一个唯一的 Id 标识 objectId，因此获取对象的最基本的方法就是根据 objectId 来查询：
        
        let query = LCQuery(className: "Todo")
        let _ = query.get("5c696b6919a27c001aa668a3") { (result) in
            switch result {
            case .success(object: let object):
                // handle object
                print(String(describing: object.objectId?.stringValue))
                break
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
        // 除了使用 LCQuery，还可以采用在本地构建一个 LCObject 的方式，通过接口和 objectId 把数据从云端拉取到本地：
        let object = LCObject(className: "Todo", objectId: "5c6aa2b419a27c001aa6af36")
        let _ = object.fetch { (result) in
            switch result {
            case .success:
                // handle object
                print(String(describing: object.objectId?.stringValue))
                break
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
    }
    
    private func mothod0501() {
        do {
            // 5. 获取 objectId
            // 每一次对象存储成功之后，云端都会返回 objectId，它是一个全局唯一的属性。
            let todo2 = LCObject(className: "Todo2")
            try todo2.set("title", value: "meeting")
            try todo2.set("content", value: "monday,14:00")
            try todo2.set("location", value: "room")
            let _ = todo2.save { (result) in
                switch result {
                case .success:
                    // handle object
                    print(String(describing: todo2.objectId?.stringValue))
                    break
                case .failure(error: let error):
                    // handle error
                    print(error)
                    break
                }
            }
        } catch {
            print("ERROR")
        }
    }
    
    private func mothod0601() {
        // 6 访问对象的属性
        //访问 Todo 的属性的方式为：
        let query2 = LCQuery(className: "Todo")
        let _ = query2.get("5c6aa7df19a27c001aa6afcb") { (result) in
            switch result {
            case .success(object: let object):
                // get value by string key
                let title = object.get("title")
                // get property
                let objectId = object.objectId
                let updatedAt = object.updatedAt
                let createdAt = object.createdAt
                
                print(String(describing: title?.stringValue))
                print(String(describing: objectId?.stringValue))
                print(String(describing: updatedAt?.stringValue))
                print(String(describing: createdAt?.stringValue))
                
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
    }
    
    private func mothod0701() {
        do {
            let todo3 = LCObject(className: "Todo", objectId: "5c6aa7df19a27c001aa6afcb")
            try todo3.set("content", value: "wednesday,15:30")
            let _ = todo3.save { (result) in
                switch result {
                case .success:
                    // handle success
                    print("content update success")
                    break
                case .failure(error: let error):
                    // handle error
                    print(error)
                    break
                }
            }
        } catch {
            print("ERROR")
        }
    }
    
    // 使用 CQL 语法更新对象
    // LeanStorage 提供了类似 SQL 语法中的 Update 方式更新一个对象，例如更新一个 TodoFolder 对象可以使用下面的代码：
    private func mothod0801() {
        _ = LCCQLClient.execute("update TodoFolder set name='家庭' where objectId='5c6aa56819a27c001aa6af8f'") { result in
            switch result {
            case .success:
                print("TodoFolder name update success")
                break // 更新成功
            case .failure(let error):
                print(error)
            }
        }
    }

    // 更新计数器
    // 这是原子操作（Atomic Operation）的一种。 为了存储一个整型的数据，LeanStorage 提供对任何数字字段进行原子增加（或者减少）的功能。比如一条微博，我们需要记录有多少人喜欢或者转发了它，但可能很多次喜欢都是同时发生的。如果在每个客户端都直接把它们读到的计数值增加之后再写回去，那么极容易引发冲突和覆盖，导致最终结果不准。此时就需要使用这类原子操作来实现计数器。
    // 假如，现在增加一个记录查看 Todo 次数的功能，一些与他人共享的 Todo 如果不用原子操作的接口，很有可能会造成统计数据不准确，可以使用如下代码实现这个需求：
    private func mothod0901() {
        do {
            let todo = LCObject(className: "Todo", objectId: "5c6a2c4d19a27c001aa686d4")
            
            // 递增 views 属性，保存时，服务端会保证原子性
            try todo.increase("views", by: 1)
            
            _ = todo.save { result in
                switch result {
                case .success:
                    print("Todo update views success")
                    break // 更新成功
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print("ERROR")
        }
    }
    
//    删除对象
//    假如某一个 Todo 完成了，用户想要删除这个 Todo 对象，可以如下操作：
    private func mothod1001_deleteObject() {
        let todo = LCObject(className: "Todo", objectId: "155c6aad6f19a27c001aa6b065")
        
        // 调用实例方法删除对象
        _ = todo.delete { result in
            switch result {
            case .success:
                print("Todo Object delete success")
                break // 删除成功
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    更新数组
//    更新数组也是原子操作。使用以下方法可以方便地维护数组类型的数据：
//    append(String, element: LCType)
//    将指定对象附加到数组末尾。
//    append(String, element: LCType, unique: Bool)
//    将指定对象附加到数组末尾，并且可以设置一个 unique 的 bool 值表示只是确保唯一，不会重复添加
//    append(String, elements: [LCType])
//    将指定对象数组附加到数组末尾。
//    append(String, elements: [LCType], unique: Bool)
//    将指定对象附加到数组末尾，并且可以设置一个 unique 的 bool 值表示只是确保唯一，不会重复添加
//    remove(String, element: LCType)
//    从数组字段中删除指定的对象。
//    remove(String, elements: [LCType])
//    从数组字段中删除指定的对象数组。
//    例如，Todo 对象有一个提醒时间 reminders 字段，是一个数组，代表这个日程会在哪些时间点提醒用户。比如有个拖延症患者把闹钟设为早上的 7:10、7:20、7:30：
    func dateWithString(string: String) -> LCDate {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        
        let date = LCDate(dateFormatter.date(from: string)!)
        
        return date
    }
    
    private func testSetArray() {
        do {
            let todo = LCObject(className: "Todo")
            
            let reminder1 = dateWithString(string: "2015-11-11 07:10:00")
            let reminder2 = dateWithString(string: "2015-11-11 07:20:00")
            let reminder3 = dateWithString(string: "2015-11-11 07:30:00")
            
            try todo.set("reminders", value: [reminder1, reminder2, reminder3])
            
            // 同步地保存，为了示例的简洁，故意忽略了错误检查
            _ = todo.save()
            
            // 新增一个闹钟时间
            let reminder4 = dateWithString(string: "2015-11-11 07:40:00")
            
            // 使用 append 方法添加
            try todo.append("reminders", element: reminder4, unique: true)
            
            _ = todo.save { result in
                switch result {
                case .success:
                    print("reminders append success")
                    break // 更新成功
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print("ERROR")
        }
    }
    
//    使用 CQL 语法删除对象
//    LeanStorage 提供了类似 SQL 语法中的 Delete 方式删除一个对象，例如删除一个 Todo 对象可以使用下面的代码：
    private func mothod1101_deleteObject() {
        // 执行 CQL 语句实现删除一个 Todo 对象
        _ = LCCQLClient.execute("delete from Todo where objectId='155c6aad6f19a27c001aa6b065'") { result in
            switch result {
            case .success:
                print("Todo Object delete success")
                break // 删除成功
            case .failure(let error):
                print(error)
            }
        }
    }

    //
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

