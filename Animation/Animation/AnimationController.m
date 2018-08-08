//
//  AnimationController.m
//  Animation
//
//  Created by zlhj on 2018/8/2.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "AnimationController.h"
#import "HeartView.h"
#import "PraiseButton.h"
static NSString * const reuseIdentifier = @"Cell";
@interface AnimationController ()
@property (nonatomic,strong) NSArray * dataArr;
@property (nonatomic,strong) UIView * animationView;
@property (nonatomic,copy) NSString * animKey;
@property (nonatomic, strong) PraiseButton *praiseButton;
@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"结束动画" style:UIBarButtonItemStyleDone target:self action:@selector(stop)];
     self.dataArr = @[@"抖动",@"轨迹",@"点赞动图"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)stop{
      [self.animationView.layer removeAnimationForKey:self.animKey];
      [self.animationView removeFromSuperview];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
 
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        self.animationView = [[UIView alloc] init];
        self.animationView.frame = CGRectMake(ScreenWidth/2 - 50, (ScreenHeight -64)/2 - 50, 100, 100);
        self.animationView.backgroundColor = [UIColor redColor];
        self.animationView = self.animationView;
        [self.view addSubview:self.animationView];
        [self.tableView bringSubviewToFront:self.animationView];
        /**
         values  许多值组成的数组用来进行动画的,只有在path = nil的时候才有用
         path  可以指定一个路径,让动画沿着这个指定的路径执行
         cacluationMode 计算模式
         kCAAnimationLinear 默认值
         kCAAnimationDiscrete 离散的,不进行插值计算,所有关键帧直接逐个进行显示
         kCAAnimationPaced 节奏动画自动计算动画的运动时间,使得动画均匀进行,而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和timingFunctions无效;
         */
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
        // 拿到动画的key
        anim.keyPath = @"transform.rotation";
        // 动画时间
        anim.duration = .2;
        // 重复的次数
        anim.repeatCount = MAXFLOAT;// 无限重复
        // 设置抖动数值
        anim.values = @[@(ANGLE_TO_RADIAN(-5)),@(ANGLE_TO_RADIAN(5)),@(ANGLE_TO_RADIAN(-5))];
        // 保持最后的状态 默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
        anim.removedOnCompletion = NO;
        // 动画的填充模式
        /**
         kCAFillModeRemoved 默认值,动画结束后,layer会恢复到之前的状态(了以理解为动画执行完成后移除)
         kCAFillModeForwards 动画结束后,layer会一直保持着动画最后的状态
         kCAFillModeBackwards
         kCAFillModeForwards是在动画开始之后layer迅速进入指定位置开始执行动画并在removedOnCompletion = NO的前提下会停在动画结束的最后位置，
         而kCAFillModeBackwards则是在动画开始之前迅速进入指定状态并在动画开始后执行动画，动画结束后迅速返回到layer的本身位置
         */
        anim.fillMode = kCAFillModeForwards;
        self.animKey = @"shake";
        [self.animationView.layer addAnimation:anim forKey:self.animKey];
    }
    if (indexPath.row == 1) {
        
        HeartView *view = [[HeartView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [self.view addSubview:view];
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation1.duration = .3;
        animation1.repeatCount = MAXFLOAT;
        animation1.toValue = [NSNumber numberWithFloat:1.1];; // 終点
        animation1.removedOnCompletion = NO;
        animation1.fillMode = kCAFillModeForwards;
        animation1.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];//没有的话是均匀的动画。
        [view.layer addAnimation:animation1 forKey:@"heart"];
        [self.tableView bringSubviewToFront:view];
    }
    if (indexPath.row == 2) {
        self.praiseButton.center = self.view.center;
        [self.view addSubview:self.praiseButton];
        [self.tableView bringSubviewToFront:self.praiseButton];
    }
}
- (PraiseButton *)praiseButton {
    if (!_praiseButton) {
        _praiseButton = [[PraiseButton alloc] init];
        _praiseButton.frame = CGRectMake(0.f, 0.f, 60.f, 60.f);
        _praiseButton.particleImage = [UIImage imageNamed:@"sparkle"];
        _praiseButton.particleScale = 0.05f;
        _praiseButton.particleScaleRange = 0.02f;
        [_praiseButton addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
        [_praiseButton setImage:[UIImage imageNamed:@"praise_default@3x"] forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"praise_select@3x"] forState:UIControlStateSelected];
    }
    return _praiseButton;
}
- (void)praiseAction:(PraiseButton *)button {
    if (button.selected) {
        [button popInsideWithDuration:0.4f];
    }
    else {
        [button popOutsideWithDuration:0.5f];
        [button animate];
    }
    button.selected = !button.selected;
}

@end
