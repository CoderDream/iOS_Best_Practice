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
    // 碰撞行为对象
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建物理引擎对象
        animator = UIDynamicAnimator(referenceView: view)
        // 创建重力行为对象
        gravity = UIGravityBehavior(items: [square])
        // 设置物理引擎对象的重力行为
        animator.addBehavior(gravity)
        // 创建碰撞行为对象
        collision = UICollisionBehavior(items: [square])
        // 设置是否以参照视图的bounds为边界
        collision.translatesReferenceBoundsIntoBoundary = true
        // 设置物理引擎对象的碰撞行为
        animator.addBehavior(collision)
    }
}
