## 项目0101

### 设置storyboard
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

### 项目0102  
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
### 项目0103
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

### 项目0104  
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

### 项目0105

```swift
// 添加 UICollisionBehaviorDelegate 协议
class ViewController: UIViewController, UICollisionBehaviorDelegate {
    ...    
    override func viewDidLoad() {
        ...
        // 设置代理
        collision.collisionDelegate = self
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
```

### 项目0106  
- 配置 item 属性  
```swift
// 添加 UICollisionBehaviorDelegate 协议
class ViewController: UIViewController, UICollisionBehaviorDelegate {
    ...    
    override func viewDidLoad() {
        ...
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
    ...
}
```

在上面的代码中你只改变了 item 的弹性；但是，该 item 的行为类具有许多可以在代码中操作的其他属性。它们如下：  
- elasticity - 弹性 —— 确定“弹性”碰撞的方式，即物品在碰撞中的弹性或“橡皮”状态。  
- friction - 摩擦力 —— 确定沿表面滑动时的运动阻力。  
- density - 密度 —— 当与尺寸size结合时，这将给出item的总质量。质量越大，加速或减速物体越难。  
- resistance - 阻力 —— 确定任何线性运动的阻力。这与摩擦力形成对比，摩擦力仅适用于滑动运动。  
- 角度阻力 - angularResistance —— 确定任何旋转运动的阻力。  
- 允许旋转 - allowsRotation —— 这是一个有趣的，不会模拟任何真实世界的物理属性。将此属性设置为NO时，无论发生任何旋转力，对象都不会旋转。 

### 项目0107 动态添加行为

下面在viewDidLoad上面添加以下属性：
```swift
var firstContact = false  
```

将以下代码添加到碰撞代理方法collisionBehavior(behavior:beganContactForItem:withBoundaryIdentifier:atPoint:)的末尾。
```swift
// 动态添加行为（下面的代码在整个碰撞期间只执行一次）
if !firstContact {
    // 设置标志位，以后不会再进入这个代码块
    firstContact = true
    // 创建方块
    let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
    // 设置背景颜色
    square.backgroundColor = UIColor.gray
    // 加入当前视图中
    view.addSubview(square)
    // 添加碰撞行为
    collision.addItem(square)
    // 添加重力行为
    gravity.addItem(square)
    // 创建虚拟弹簧效果
    let attach = UIAttachmentBehavior(item: collidingView, attachedTo: square)
    // 将弹簧效果添加到动画中
    animator.addBehavior(attach)
}
```


### 项目0108 用户交互

在最后一节中，只要用户点击屏幕，您就会添加另一种动态行为UISnapBehavior。 UISnapBehavior使一个对象跳转到指定的位置，具有类似弹簧的动画。
删除您在上一节中添加的代码：collisionBehavior（）中的firstContact属性和if语句。 在屏幕上只有一个方形视图，更容易看到UISnapBehavior的效果。
在viewDidLoad上方添加两个属性：
```swift
var square2: UIView!
var snap: UISnapBehavior!
```

这将跟踪您的方形视图，以便您可以从视图控制器中的其他位置访问它。 接下来你将使用snap对象。
在viewDidLoad中，从square的声明中删除let关键字，以便它使用new属性而不是局部变量：
square2 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
```swift
square2 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
// 设置背景颜色为黄色
square2.backgroundColor = UIColor.yellow
// 将方框添加到视图中
self.view.addSubview(square2)
```

最后，为touchesEnded添加一个实现，以便在用户触摸屏幕时创建并添加新的snap行为：
```swift
/// 触摸屏幕事件
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if snap != nil {
        print("remove")
        self.animator.removeBehavior(snap)
    }
    
    let touch = (touches as NSSet).anyObject() as! UITouch// touches.anyObject //.first
    //print("\(touch)")
    let location: CGPoint = touch.location(in: view)
    //print("\(location)")
    //print("\(String(describing: self.square2))")
    snap = UISnapBehavior(item: self.square2, snapTo: location)
    
    print("\(String(describing: snap))")
    self.animator.addBehavior(snap)
}
```