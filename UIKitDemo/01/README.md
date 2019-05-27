新增一个 UIView，设置约束： 
- top: 50  
- Width: 50  
- Height: 50  
- Horizontally in Container: 0  

### 代码
- 设置 UIView  
```swift
// UIView 对象
@IBOutlet weak var square: UIView!
```

- 新建物理引擎和重力行为对象，并设置关联
```swift
class ViewController: UIViewController {
   
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
```

- 新建碰撞行为对象，并与物理引擎关联
```swift
class ViewController: UIViewController {
   
    ...
    // 碰撞行为对象
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        ...
        // 创建碰撞行为对象
        collision = UICollisionBehavior(items: [square])
        // 设置是否以参照视图的bounds为边界
        collision.translatesReferenceBoundsIntoBoundary = true
        // 设置物理引擎对象的碰撞行为
        animator.addBehavior(collision)
    }
}
```
- 新增障碍物   
```swift
class ViewController: UIViewController {
    ...    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 新增 UIView 对象
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 200, height: 20))
        // 设置背景颜色为红色
        barrier.backgroundColor = UIColor.red
        // 添加到当前视图中
        view.addSubview(barrier)
        ...
        // 创建碰撞行为对象
        collision = UICollisionBehavior(items: [square, barrier])
        ...
    }
}
```
这样设置有缺陷，障碍物可以移动，而且不会停下来。

- 修复缺陷  
```swift
class ViewController: UIViewController {
    ...
    override func viewDidLoad() {
        ...
        // 新增 UIView 对象（修改宽度，以便正方体可以碰到矩形后掉下来）
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 167, height: 20))
        ...
        // 创建碰撞行为对象
        //collision = UICollisionBehavior(items: [square, barrier])
        collision = UICollisionBehavior(items: [square])
        // 添加一个不可见的边界，它与障碍视图具有相同的frame
        collision.addBoundary(withIdentifier: "barrier" as NSString, for: UIBezierPath(rect: barrier.frame))
        ...
    }
}
```

- 记录下降方块视图的中心和变换属性   
```swift
class ViewController: UIViewController {
    ...
    override func viewDidLoad() {
        ...
        // action 属性
        collision.action = {
            // 记录下降方块视图的中心和变换属性
            print("\(NSCoder.string(for: self.square.transform)) \(NSCoder.string(for: self.square.center))")
        }
    }
}
```

- 控制台  
```
// 开始的坐标
[1, 0, 0, 1, 0, 0] {188, 233}
[1, 0, 0, 1, 0, 0] {188, 241}
[1, 0, 0, 1, 0, 0] {188, 249}
// 碰撞后的坐标
[0.99842119561220977, 0.05617042061695509, -0.05617042061695509, 0.99842119561220977, 0, 0] {189, 249}
[0.99371218051688803, 0.11196473682535833, -0.11196473682535833, 0.99371218051688803, 0, 0] {191, 248}
[0.9859211602132415, 0.16721084248270432, -0.16721084248270432, 0.9859211602132415, 0, 0] {193, 249}
[0.97501672599687772, 0.22213145663397041, -0.22213145663397041, 0.97501672599687772, 0, 0] {195, 249}
```