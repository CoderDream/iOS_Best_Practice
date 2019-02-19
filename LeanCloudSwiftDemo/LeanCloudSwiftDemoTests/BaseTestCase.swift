//
//  BaseTestCase.swift
//  LeanCloudSwiftDemoTests
//
//  Created by CoderDream on 2019/2/19.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
@testable import LeanCloud

class TestObject: LCObject {
    @objc dynamic var numberField: LCNumber?
    @objc dynamic var booleanField: LCBool?
    @objc dynamic var stringField: LCString?
    @objc dynamic var arrayField: LCArray?
    @objc dynamic var dictionaryField: LCDictionary?
    @objc dynamic var objectField: LCObject?
    @objc dynamic var relationField: LCRelation?
    @objc dynamic var geoPointField: LCGeoPoint?
    @objc dynamic var dataField: LCData?
    @objc dynamic var dateField: LCDate?
    @objc dynamic var nullField: LCNull?
    @objc dynamic var fileField: LCFile?
}

class BaseTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        TestObject.register()
        
        LCApplication.default.logLevel = .debug
        
        LCApplication.default.set(
            id:  "VOfCGionrepsdh1dly5lPlfX-9Nh9j0Va", /* Your app ID */
            key: "UPd3qOCfYcXB9pfr65KAXCSa" /* Your app key */
        )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func busywait(interval: TimeInterval = 0.1, untilTrue: () -> Bool) -> Void {
        while !untilTrue() {
            let due = Date(timeIntervalSinceNow: interval)
            RunLoop.current.run(mode: .default, before: due)
        }
    }
    
}
