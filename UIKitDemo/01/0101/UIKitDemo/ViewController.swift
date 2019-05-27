//
//  ViewController.swift
//  UIKitDemo
//
//  Created by CoderDream on 2019/5/27.
//  Copyright © 2019 CoderDream. All rights reserved.
//
// [UIKit框架（一） —— UIKit动力学和移动效果（一）](https://www.jianshu.com/p/e3922cac9cfe)
import UIKit

class ViewController: UIViewController {
    // UIView 对象
    @IBOutlet weak var square: UIView!
    // UIKit物理引擎
    var animator: UIDynamicAnimator!
    // 重力行为对象
    var gravity: UIGravityBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建物理引擎对象
        animator = UIDynamicAnimator(referenceView: view)
        // 创建重力行为对象
        gravity = UIGravityBehavior(items: [square])
        // 设置物理引擎对象的重力行为
        animator.addBehavior(gravity)
    }
}
