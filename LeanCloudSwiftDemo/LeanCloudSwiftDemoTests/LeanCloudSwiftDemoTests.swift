//
//  LeanCloudSwiftDemoTests.swift
//  LeanCloudSwiftDemoTests
//
//  Created by CoderDream on 2019/2/19.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
//import LeanCloud
@testable import LeanCloud

class LeanCloudSwiftDemoTests: BaseTestCase {

    override func setUp() {
        print("call setUp()")
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        LCApplication.default.set(
//            id:  "VOfCGionrepsdh1dly5lPlfX-9Nh9j0Va", /* Your app ID */
//            key: "UPd3qOCfYcXB9pfr65KAXCSa" /* Your app key */
//        )
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 数据存储（LeanStorage）是 LeanCloud 提供的核心功能之一。下面我们用一个简单的示例来说明它的基本用法。
    // 下面这段代码在创建了一个 Todo 类型的对象，并将它保存到云端：
    func testSaveTodo() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        do {
            let post = LCObject(className: "Post")
            try post.set("words", value: "Hello World, 2019!")
            
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
    
    // 如果你熟悉关系型数据库的话，需要注意 LeanStorage 的不同点。在 LeanStorage 里不需要事先建立表结构（schema），并且可以随时增加新的属性。
    // 通常这被称为无模式（schema-free）。例如，为上面的 Todo 类型新增一个表示地点的 location 属性，只需做如下变动：
    func testSaveTodoAddProperty() {
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
    
    func testCQLInsert() {
        // 3. 使用 CQL 语法保存对象
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
    
    
    // 4 获取对象
    // 每个被成功保存在云端的对象会有一个唯一的 Id 标识 objectId，因此获取对象的最基本的方法就是根据 objectId 来查询：
    func testQueryByGet() {
        let query = LCQuery(className: "Todo")
        let _ = query.get("405c696b6919a27c001aa668a3") { (result) in
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
    }
    
    // 除了使用 LCQuery，还可以采用在本地构建一个 LCObject 的方式，通过接口和 objectId 把数据从云端拉取到本地：
    func testQueryByFetch() {
        print("Begin")
        let object = LCObject(className: "Todo", objectId: "405c696b6919a27c001aa668a3")
        let _ = object.fetch { (result) in
            switch result {
            case .success:
                // handle object
                print("OK")
                print(String(describing: object.objectId?.stringValue))
                break
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
    }
    
    func testSaveAndGetResult() {
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
    
    func testQueryById() {
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
