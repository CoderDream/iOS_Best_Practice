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
        
        let alertController = UIAlertController(title: "系统提示",
                                                message: "您确定要离开hangge.com吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

