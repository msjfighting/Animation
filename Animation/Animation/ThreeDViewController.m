//
//  ThreeDViewController.m
//  Animation
//
//  Created by zlhj on 2018/8/16.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "ThreeDViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ThreeDViewController ()
@property (nonatomic,strong) UIView * containView;
@property (nonatomic,strong) UIImageView * demoImageV;
@end

@implementation ThreeDViewController

- (void)viewDidLoad {
    self.demoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 200, 300)];
    self.demoImageV.image = [UIImage imageNamed:@"2.jpg"];
    [self.view addSubview:self.demoImageV];
    
    // x轴平移 y轴平移
    self.demoImageV.layer.transform = CATransform3DMakeTranslation(100, 100, 0);
//    x 轴为正值的时候,会在x轴方向上缩放 反之,则在缩放的基础上沿着竖直线翻转
    self.demoImageV.layer.transform = CATransform3DMakeScale(2, 1, 0.5);
//   逆时针旋转弧度(弧度 = π/180x角度)
    self.demoImageV.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1.0/12000;
//    是以一个已经形变的为基础 进行平移
//    self.demoImageV.layer.transform = CATransform3DTranslate(tran, 0, 0, 100);
//       是以一个已经形变的为基础 进行缩放
//    self.demoImageV.layer.transform = CATransform3DScale(tran, 2, 0.5, 1);
   //    是以一个已经形变的为基础 进行旋转
    self.demoImageV.layer.transform = CATransform3DRotate(tran, M_PI_4, 0, 1, 0);
    
    
}

- (void)threeDRotate{
    [super viewDidLoad];
    // 包含所有view的视图,用来做拖拽处理,和所有子视图的移动
    _containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _containView.center =  self.view.center;
    
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = 1/500;
    _containView.layer.transform = trans;
    
#pragma mark 底部背对着我们的视图
    [self.view addSubview:_containView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view1.backgroundColor = [UIColor purpleColor];
    [_containView addSubview:view1];
    
#pragma mark 右侧视图
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view2.backgroundColor = [UIColor yellowColor];
    // 因为旋转是根据锚点,也就是view2的中心点旋转的,所以现将视图往x轴和z轴各偏移(200/2)
    trans = CATransform3DTranslate(trans, 100, 0, 100);
    // 绕y轴旋转90度
    trans = CATransform3DRotate(trans, M_PI_2, 0, 1, 0);
    view2.layer.transform = trans;
    [_containView addSubview:view2];
#pragma mark 左侧视图 只需要将view2沿x轴移动 -100 沿z轴移动 100
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view3.backgroundColor = [UIColor blueColor];
    
    trans = CATransform3DMakeTranslation(-100, 0, 100);
    trans = CATransform3DRotate(trans, M_PI_2, 0, 1, 0);
    view3.layer.transform = trans;
    [_containView addSubview:view3];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view4.backgroundColor = [UIColor grayColor];
    [_containView addSubview:view4];
    
    trans = CATransform3DMakeTranslation(0, -100, 100);
    trans = CATransform3DRotate(trans, M_PI_2, 1, 0, 0);
    view4.layer.transform = trans;
    
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view5.backgroundColor = [UIColor blackColor];
    [_containView addSubview:view5];
    trans = CATransform3DMakeTranslation(0, 100, 100);
    trans = CATransform3DRotate(trans, M_PI_2, 1, 0, 0);
    view5.layer.transform = trans;
    
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view6.backgroundColor = [UIColor redColor];
    [_containView addSubview:view6];
    trans = CATransform3DMakeTranslation(0, 0, 200);
    view6.layer.transform = trans;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changeAngle:)];
    [_containView addGestureRecognizer:pan];
}
- (void)changeAngle:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:_containView];
    
    CGFloat angle = -M_PI_4 + point.x/30;
    CGFloat angle2 = -M_PI_4 - point.y/30;
    
    CATransform3D tran = CATransform3DIdentity;
    
    tran.m34 = -1/500;
    tran = CATransform3DRotate(tran, angle, 0, 1, 0);
    tran = CATransform3DRotate(tran, angle2, 1, 0, 0);
    //sublayerTransform 他能影响到它所有的直接图层,就是说可以一次性对这些图层的容器做变换,然后所有的子图层都集成这个变换方法
    _containView.layer.sublayerTransform = tran;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
