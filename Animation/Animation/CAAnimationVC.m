//
//  CAAnimationVC.m
//  Animation
//
//  Created by zlhj on 2018/8/2.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "CAAnimationVC.h"
#import "HeartView.h"
@interface CAAnimationVC ()

@end

@implementation CAAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    CABasicAnimation可看做是只有2个关键帧的CAKeyframeAnimation关键帧动画
    if (self.animationType == BaseAnimation) {
        CALayer *scaleLayer = [[CALayer alloc] init];
        scaleLayer.backgroundColor = [UIColor blueColor].CGColor;
        scaleLayer.frame = CGRectMake(60, 100, 50, 50);
        scaleLayer.cornerRadius = 10;
        [self.view.layer addSublayer:scaleLayer];
        // keypath:改变位置取position 透明度opacity 缩放transform.scale
        CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnim.toValue = [NSNumber numberWithFloat:1.5];
        scaleAnim.autoreverses = YES;
        scaleAnim.fillMode = kCAFillModeForwards;
        scaleAnim.removedOnCompletion = NO;
        scaleAnim.repeatCount = MAXFLOAT;
        scaleAnim.duration = 0.8;
        [scaleLayer addAnimation:scaleAnim forKey:@"scale"];
        
        
        CALayer *rotateLayer = [[CALayer alloc] init];
        rotateLayer.backgroundColor = [UIColor blueColor].CGColor;
        rotateLayer.frame = CGRectMake(60, 200, 50, 50);
        rotateLayer.cornerRadius = 10;
        [self.view.layer addSublayer:rotateLayer];
        
        CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
        rotateAnim.fromValue = [NSNumber numberWithFloat:0.0];
        rotateAnim.toValue = [NSNumber numberWithFloat:2*M_PI];
        rotateAnim.autoreverses = YES;
        rotateAnim.fillMode = kCAFillModeForwards;
        rotateAnim.removedOnCompletion = NO;
        rotateAnim.repeatCount = 1;
        rotateAnim.duration = 3;
        [rotateLayer addAnimation:rotateAnim forKey:@"rotate"];
        
        
        
    }else if(self.animationType == AnimationGroup){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60, 100, 50, 50)];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        // 缩放
        CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnim.toValue = [NSNumber numberWithFloat:2.0];
 // 绕x轴旋转
        CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
        rotateAnim.fromValue = [NSNumber numberWithFloat:0.0];
        rotateAnim.toValue = [NSNumber numberWithFloat:2*M_PI];
       // 沿y轴移动
        CABasicAnimation *animation1 =
        [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        // 起止点的设定
        animation1.toValue = [NSNumber numberWithFloat:200];; // 終点
        // 透明度
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
        animation.fromValue = [NSNumber numberWithFloat:1.0f];
        animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
        animation.autoreverses = YES;
        animation.duration = 2.0;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;

        animation.fillMode = kCAFillModeForwards;
    
//  动画缓冲
     /**
      kCAMediaTimingFunctionLinear//匀速的线性计时函数
      kCAMediaTimingFunctionEaseIn//缓慢加速，然后突然停止
      kCAMediaTimingFunctionEaseOut//全速开始，慢慢减速
      kCAMediaTimingFunctionEaseInEaseOut//慢慢加速再慢慢减速
      kCAMediaTimingFunctionDefault//也是慢慢加速再慢慢减速，但是它加速减速速度略慢
      */
        animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];///没有的话是均匀的动画。

        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 2.0;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.repeatCount = 2;
        group.animations = [NSArray arrayWithObjects:scaleAnim,rotateAnim,animation1,animation, nil];
        [view.layer addAnimation:group forKey:@"group"];
    }else if (self.animationType == BezierPath){
        
       
        
        
        
        
    }
}
@end
