//
//  MyView.swift
//  EventDemo
//
//  Created by CoderDream on 2019/6/27.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class MyView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("摸我干啥？")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("哎呀，不要拽人家！")
        // 想让控件随着手指移动而移动，监听手指移动
        // 获取 UITouch 对象
        let touch = touches.first
        // 获取当前点的位置
        let curPoint = touch?.location(in: self)
        // 获取上一个点的位置
        let prePoint = touch?.previousLocation(in: self)
        // 获取它们x轴的偏移量，每次都是相对上一次
        let offsetX = curPoint!.x - (prePoint?.x)!
        let offsetY = curPoint!.y - (prePoint?.y)!
        self.transform = CGAffineTransform(translationX: offsetX, y: offsetY)        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("手放开还能继续玩耍！")
    }
    
    /*    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
