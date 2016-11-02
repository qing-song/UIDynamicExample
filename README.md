## UIKit动力学（UIKit Dynamics）

> UIDynamic是从iOS 7开始引入的一种新技术，隶属于UIKit框架可以认为是一种物理引擎，能模拟和仿真现实生活中的物理现象。如：重力、悬挂、弹性碰撞等现象。

## 物理行为容器

### UIDynamicAnimator
> 它可以让物理仿真元素执行物理行为。
``` python
（1）UIDynamicAnimator的常见方法
　　- (void)addBehavior:(UIDynamicBehavior *)behavior;  　　//添加1个物理仿真行为
　　- (void)removeBehavior:(UIDynamicBehavior *)behavior;　　//移除1个物理仿真行为

　　- (void)removeAllBehaviors;  　　//移除之前添加过的所有物理仿真行为
（2）UIDynamicAnimator的常见属性
　　@property (nonatomic, readonly) UIView* referenceView;  //参照视图 
　　@property (nonatomic, readonly, copy) NSArray* behaviors;//添加到物理仿真器中的所有物理仿真行为
　　@property (nonatomic, readonly, getter = isRunning) BOOL running;//是否正在进行物理仿真
　　@property (nonatomic, assign) id <UIDynamicAnimatorDelegate> delegate;//代理对象（能监听物理仿真器的仿真过程，比如开始和结束）
```

## 物理行为

### UIGravityBehavior：重力行为

``` python
// 添加到重力行为中的所有物理仿真元素
@property (nonatomic, readonly, copy) NSArray* items;
// 重力方向（是一个二维向量）
@property (readwrite, nonatomic) CGVector gravityDirection;
// 重力方向（是一个角度，以x轴正方向为0°，顺时针正数，逆时针负数）
@property (readwrite, nonatomic) CGFloat angle;
// 量级（用来控制加速度，1.0代表加速度是1000 points /second²） 重力加速度越大，碰撞越厉害
@property (readwrite, nonatomic) CGFloat magnitude;
```

### UICollisionBehavior：碰撞行为

```python
// 是否以参照视图的bounds为边界
@property (nonatomic, readwrite) BOOL translatesReferenceBoundsIntoBoundary;
// 设置参照视图的bounds为边界，并且设置内边距
- (void)setTranslatesReferenceBoundsIntoBoundaryWithInsets:(UIEdgeInsets)insets;
// 碰撞模式（分为3种，元素碰撞、边界碰撞、全体碰撞)
@property (nonatomic, readwrite) UICollisionBehaviorMode collisionMode;
// 代理对象（可以监听元素的碰撞过程）
@property (nonatomic, assign, readwrite) id <UICollisionBehaviorDelegate> collisionDelegate;
```

### UISnapBehavior：捕捉行为
```python
// 用于减幅、减震（取值范围是0.0 ~ 1.0，值越大，震动幅度越小）
@property (nonatomic, assign) CGFloat damping;
```

### UIPushBehavior：推动行为
```python
// UIPushBehavior :推动效果
typedef NS_ENUM(NSInteger, UIPushBehaviorMode) {
 UIPushBehaviorModeContinuous,// 持续的力
 UIPushBehaviorModeInstantaneous// 瞬间的力
 } NS_ENUM_AVAILABLE_IOS(7_0);
 @property (nonatomic, readonly) UIPushBehaviorMode mode; //推动效果的样式
 @property (nonatomic, readwrite) BOOL active; //是否激活
 @property (readwrite, nonatomic) CGFloat angle; //推动角度
 // A continuous force vector with a magnitude of 1.0, applied to a 100 point x 100 point view whose density value is 1.0, results in view acceleration of 100 points per s^2
@property (readwrite, nonatomic) CGFloat magnitude; //推动力量
 @property (readwrite, nonatomic) CGVector pushDirection; //推动的方向
```

### UIAttachmentBehavior：附着行为
```python
//UIAttachmentBehavior：附着效果
 //吸附着一个视图 或者一个点  （也可以多个连接）

 //附着效果 一个视图与一个锚点或者另一个视图相连接的情况
 //附着行为描述的是两点之间的连接情况，可以模拟刚性或者弹性连接
 //在多个物体间设定多个UIAttachmentBehavior，可以模拟多物体连接

 typedef NS_ENUM(NSInteger, UIAttachmentBehaviorType) {
 UIAttachmentBehaviorTypeItems, //吸附一个元素
 UIAttachmentBehaviorTypeAnchor //吸附一个点
 } NS_ENUM_AVAILABLE_IOS(7_0);
 //设置吸附效果的样式
 @property (readonly, nonatomic) UIAttachmentBehaviorType attachedBehaviorType;

 @property (readwrite, nonatomic) CGPoint anchorPoint;//锚点

 @property (readwrite, nonatomic) CGFloat length;//距离 与锚点的距离
 @property (readwrite, nonatomic) CGFloat damping; // 1: critical damping  //跳跃度
 @property (readwrite, nonatomic) CGFloat frequency; // in Hertz   幅度
```
### UIDynamicItemBehavior：动力元素行为
```python
// 属性设置碰撞弹性系数。范围（0.0-1.0）
@property (readwrite, nonatomic) CGFloat elasticity;  
// 设置摩擦系数
@property (readwrite, nonatomic) CGFloat friction; // 0 being no friction between objects slide along each other
// 设置相对密度
@property (readwrite, nonatomic) CGFloat density; // 1 by default
设置线性阻力系数。（0--CGFLOAT_MAX）
@property (readwrite, nonatomic) CGFloat resistance; 
// 设置角度阻力系数。（0--CGFLOAT_MAX）
@property (readwrite, nonatomic) CGFloat angularResistance; 

```
