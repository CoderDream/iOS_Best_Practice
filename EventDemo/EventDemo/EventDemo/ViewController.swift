//
//  ViewController.swift
//  EventDemo
//
//  Created by CoderDream on 2019/6/27.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 创建自定义view
        let touchView = MyView.init(frame: CGRect(x: 100, y: 100, width: 250, height: 250))
        // 背景颜色
        touchView.backgroundColor = .red
        // 添加到父控件
        self.view.addSubview(touchView)
    }


}

