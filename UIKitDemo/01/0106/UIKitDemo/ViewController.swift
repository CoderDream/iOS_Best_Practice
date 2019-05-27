//
//  ViewController.swift
//  UIKitDemo
//
//  Created by CoderDream on 2019/5/27.
//  Copyright © 2019 CoderDream. All rights reserved.
//
// [UIKit框架（一） —— UIKit动力学和移动效果（一）](https://www.jianshu.com/p/e3922cac9cfe)
import UIKit

// 添加 UICollisionBehaviorDelegate 协议
class ViewController: UIViewController, UICollisionBehaviorDelegate {
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
        // 设置代理
        collision.collisionDelegate = self
        // 创建项目行为对象，将它与 square 关联
        let itemBehaviour = UIDynamicItemBehavior(items: [square])
        // 设置弹性值
        // 1.0 表示完全弹性碰撞，也就是说碰撞中没有能量或速度损失
        // 0.6 意味着每次反弹时方块都有速度损失，最后会停下来
        itemBehaviour.elasticity = 0.6
        // 设置物理引擎对象的弹性行为
        animator.addBehavior(itemBehaviour)
        var updateCount = 0
        collision.action = {
            // 每执行三次action，使用方形视图的当前center和transform向视图添加一个新的方形视图
            if updateCount % 3 == 0 {
                // 创建新的方形视图
                let outline = UIView(frame: self.square.bounds)
                // 设置变换，和红色方形一致
                outline.transform = self.square.transform
                // 设置中心点
                outline.center = self.square.center
                // 设置透明值
                outline.alpha = 0.5
                // 设置背景颜色
                outline.backgroundColor = UIColor.clear
                // 设置边框颜色
                outline.layer.borderColor = self.square.layer.presentation()?.backgroundColor
                // 设置边框宽度
                outline.layer.borderWidth = 1.0
                // 把新的方形视图添加到当前视图中
                self.view.addSubview(outline)
            }
            // 每执行一次 action，计数器加 1
            updateCount += 1
        }        
    }
    
    /// 实现碰撞行为代理方法
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occurred - \(String(describing: identifier))")
        // 将碰撞 item 的背景颜色更改为黄色，然后再将其淡化为灰色，每次碰到边界时，方块视图都会闪烁黄色
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellow
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = UIColor.gray
        }
    }
}
