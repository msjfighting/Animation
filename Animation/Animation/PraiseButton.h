//
//  PraiseButton.h
//  Animation
//
//  Created by zlhj on 2018/8/8.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PraiseButton : UIButton
@property (nonatomic, strong) UIImage *particleImage;
@property (nonatomic, assign) CGFloat particleScale;
@property (nonatomic, assign) CGFloat particleScaleRange;
- (void)animate;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;
@end
