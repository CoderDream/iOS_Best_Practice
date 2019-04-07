//
//  ViewController.swift
//  AlertDemo01
//
//  Created by CoderDream on 2019/4/3.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Swift - 告警提示框（UIAlertController）的用法
    // http://www.hangge.com/blog/cache/detail_651.html
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: "保存或删除数据", message: "删除数据将不可恢复",
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "删除", style: .destructive, handler: nil)
        let archiveAction = UIAlertAction(title: "保存", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

