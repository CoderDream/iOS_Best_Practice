//
//  ViewController.swift
//  FileDemo
//  [Swift之FileManager的操作](https://blog.csdn.net/u011146511/article/details/79362028)
//  Created by CoderDream on 2019/6/26.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    private let manager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var str = ""
        // str = f1()
        //file:///var/mobile/Containers/Data/Application/4601D64C-BD3B-4534-931F-93541F0B3831/Documents/
        
//        str = f2()
//        label.text = str
        // contentsOfPath: Optional([])
        
        _ = f0301()
        
        str = f0103()
        label.text = str
        // contentsOfPath: Optional([])

    }
    
    /// (1）首先我们获取用户文档目录路径01
    func f0101() -> String {
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0] as URL
        print(url)
        return url.description
    }
    
    /// (2）对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
    func f0102() -> String {
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0] as URL
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: url.path)
        print("contentsOfPath: \(String(describing: contentsOfPath))")
        return String(describing: contentsOfPath)
    }
    
    /// 3）类似上面的，对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
    func f0103() -> String {
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0] as URL
        let contentsOfURL = try? manager.contentsOfDirectory(at: url,
                                                             includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        print("contentsOfPath: \(String(describing: contentsOfURL))")
        return String(describing: contentsOfURL)
    }
    
    
    //3，创建文件夹
    //方式1：
    /// 3）类似上面的，对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
    func f0301() -> String {
        let myDirectory:String = NSHomeDirectory() + "/Documents/myFolder/Files"
        let fileManager = FileManager.default
        //withIntermediateDirectories为ture表示路径中间如果有不存在的文件夹都会创建
        try! fileManager.createDirectory(atPath: myDirectory, withIntermediateDirectories: true, attributes: nil)
        print("Create Folder")
        return ""
    }
    
}

