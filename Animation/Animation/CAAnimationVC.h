//
//  CAAnimationVC.h
//  Animation
//
//  Created by zlhj on 2018/8/2.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,AnimationType)

{
    BaseAnimation,
    
    AnimationGroup,
    BezierPath
    
};
@interface CAAnimationVC : UIViewController
@property (nonatomic,assign) AnimationType  animationType;
@end
