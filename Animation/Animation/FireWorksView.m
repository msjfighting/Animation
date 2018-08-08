//
//  FireWorksView.m
//  Animation
//
//  Created by zlhj on 2018/8/8.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "FireWorksView.h"
@interface  FireWorksView ()
@property (nonatomic,strong) CAEmitterLayer * explosionLayer;//粒子发射器
@property (nonatomic,strong) CAEmitterCell * explosionCell;// 粒子
@end
@implementation FireWorksView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.clipsToBounds = NO;
    self.userInteractionEnabled = NO;
    /**
     爆炸效果
     **/
    // 粒子
    _explosionCell = [CAEmitterCell emitterCell];
    _explosionCell.name = @"explosion";
    _explosionCell.alphaRange = 0.2f;// 透明度改变的范围
    _explosionCell.alphaSpeed = -1.0f;// 透明度改变的速度
    _explosionCell.lifetime = 0.7f; // 粒子的生命周期
    _explosionCell.lifetimeRange = 0.3f; // 生命周期范围
    _explosionCell.birthRate = 0.f;// 粒子产生的系数
    _explosionCell.velocity = 40.0f; //粒子的速度
    _explosionCell.velocityRange = 10.0f; //速度范围
    
    
    
    _explosionLayer = [CAEmitterLayer layer];
    _explosionLayer.name = @"emitterLayer";
    _explosionLayer.emitterShape = kCAEmitterLayerCircle; // 发射的形状
    _explosionLayer.emitterMode = kCAEmitterLayerOutline; // 发射的模式
    _explosionLayer.emitterSize = CGSizeMake(25.f, 0.f);// 发射源的大小
    _explosionLayer.emitterCells = @[_explosionCell];
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst; // 渲染模式
    _explosionLayer.masksToBounds = NO;
    
    
    [self.layer addSublayer:_explosionLayer];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.explosionLayer.emitterPosition = center;// 发射的位置
}
- (void)animate{
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.2*NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        self.explosionLayer.beginTime = CACurrentMediaTime();
        // 爆炸效果
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"emitterCells.explosion.birthRate"];
        animation.fromValue = @0;
        animation.toValue = @500;
        [self.explosionLayer addAnimation:animation forKey:nil];
    });
}
- (void)setParticleImage:(UIImage *)particleImage{
    _particleImage = particleImage;
    self.explosionCell.contents = (id)[particleImage CGImage];
}
- (void)setParticleScale:(CGFloat)particleScale{
    _particleScale = particleScale;
    self.explosionCell.scale = particleScale;
}
- (void)setParcleScaleRange:(CGFloat)parcleScaleRange{
    _parcleScaleRange = parcleScaleRange;
    self.explosionCell.scaleRange = parcleScaleRange;
}
@end
