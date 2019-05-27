新增一个 UIView，设置约束：

- top: 50
- Width: 50
- Height: 50
- Horizontally in Container: 0

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
