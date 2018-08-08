//
//  UIView+Animation.m
//  Animation
//
//  Created by zlhj on 2018/8/2.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
- (void)createBaseAnimationWithKeyPath:(NSString *)keyPath repeatCount:(float)repeatCount time:(CFTimeInterval)time animationKey:(NSString *)animationKey fromValue:(float)fromValue toValue:(float)toValue{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.fromValue = [NSNumber numberWithFloat:fromValue];
    anim.toValue = [NSNumber numberWithFloat:toValue];
    anim.autoreverses = YES;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.repeatCount = repeatCount;
    anim.duration = time;
    [self.layer addAnimation:anim forKey:animationKey];
}

@end
