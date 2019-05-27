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
        // 新增 UIView 对象（修改宽度，以便正方体可以碰到矩形后掉下来）
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 167, height: 20))
        // 设置背景颜色为红色
        barrier.backgroundColor = UIColor.red
        // 添加到当前视图中
        view.addSubview(barrier)
        // 创建物理引擎对象
        animator = UIDynamicAnimator(referenceView: view)
        // 创建重力行为对象
        gravity = UIGravityBehavior(items: [square])
        // 设置物理引擎对象的重力行为
        animator.addBehavior(gravity)
        // 创建碰撞行为对象
        //collision = UICollisionBehavior(items: [square, barrier])
        collision = UICollisionBehavior(items: [square])
        // 添加一个不可见的边界，它与障碍视图具有相同的frame
        collision.addBoundary(withIdentifier: "barrier" as NSString, for: UIBezierPath(rect: barrier.frame))
        // 设置是否以参照视图的bounds为边界
        collision.translatesReferenceBoundsIntoBoundary = true
        // 设置物理引擎对象的碰撞行为
        animator.addBehavior(collision)
        // action 属性
        collision.action = {
            // 记录下降方块视图的中心和变换属性
            print("\(NSCoder.string(for: self.square.transform)) \(NSCoder.string(for: self.square.center))")
        }
    }
}

// 开始的坐标
//[1, 0, 0, 1, 0, 0] {188, 233}
//[1, 0, 0, 1, 0, 0] {188, 241}
//[1, 0, 0, 1, 0, 0] {188, 249}
// 碰撞后的坐标
//[0.99842119561220977, 0.05617042061695509, -0.05617042061695509, 0.99842119561220977, 0, 0] {189, 249}
//[0.99371218051688803, 0.11196473682535833, -0.11196473682535833, 0.99371218051688803, 0, 0] {191, 248}
//[0.9859211602132415, 0.16721084248270432, -0.16721084248270432, 0.9859211602132415, 0, 0] {193, 249}
//[0.97501672599687772, 0.22213145663397041, -0.22213145663397041, 0.97501672599687772, 0, 0] {195, 249}
