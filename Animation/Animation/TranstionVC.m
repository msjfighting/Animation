//
//  TranstionVC.m
//  Animation
//
//  Created by zlhj on 2018/8/8.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "TranstionVC.h"

@interface TranstionVC ()
@property (nonatomic, retain) UIImageView * imageView;
@end

@implementation TranstionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    [self.view addSubview:_imageView];
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}
- (void)changeImage{
    [UIView transitionWithView:_imageView duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
        self->_imageView.image = [UIImage imageNamed:@"2.jpg"];
    } completion:nil];
}



@end
