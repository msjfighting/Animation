//
//  HeartView.m
//  Animation
//
//  Created by zlhj on 2018/8/7.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "HeartView.h"

@implementation HeartView

-(void)drawRect:(CGRect)rect{
    CGFloat padding = 4.0;
    // 半径
    CGFloat curveRadius = (rect.size.width - 2*padding)/4.0;
    // 初始化
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置起点
    CGPoint tipLocation = CGPointMake(rect.size.width/2, rect.size.height - padding);
    // 以起始点为路径的起点
    [path moveToPoint:tipLocation];
    // 设置左圆的第二个点
    CGPoint topLeftCurveStart = CGPointMake(padding, rect.size.height/2.4);
    //设置控制点
    CGPoint control1 =CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius);
    // 添加三次贝塞尔曲线
    [path addQuadCurveToPoint:topLeftCurveStart controlPoint:control1];
   // 画圆
    [path addArcWithCenter:CGPointMake(topLeftCurveStart.x+curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    // (左圆的第二个点)
    CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
    // 画圆
    [path addArcWithCenter:CGPointMake(topRightCurveStart.x+curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    // 右上角控制点
    CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
    // 添加二次曲线
    [path addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y+curveRadius)];
   
    // 设置填充色
    [[UIColor redColor] setFill];
    // 填充
    [path fill];
    
    // 设置线宽
    path.lineWidth = 3;
    // 设置线断面类型
    path.lineCapStyle = kCGLineCapRound;
    // 设置链接类型
    path.lineJoinStyle = kCGLineJoinRound;
    // 设置画笔颜色
    [[UIColor redColor] set];
    [path stroke];
    
}
@end
