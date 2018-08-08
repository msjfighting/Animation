//
//  UIView+Animation.h
//  Animation
//
//  Created by zlhj on 2018/8/2.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
- (void)animationWithKeyPath:(NSString *)keyPath repeatCount:(float)repeatCount time:(CFTimeInterval)time animationKey:(NSString *)animationKey fromValue:(float)fromValue toValue:(float)toValue;
@end
