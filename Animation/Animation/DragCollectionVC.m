//
//  DragCollectionVC.m
//  Animation
//
//  Created by zlhj on 2018/8/1.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "DragCollectionVC.h"

@interface DragCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * collectionView;
/** 之前选中cell的NSIndexPath*/
@property (nonatomic,strong) NSIndexPath  * oldIndexPath;
/**单元格的截图*/
@property (nonatomic,strong) UIView * snapshotView;
@property (nonatomic,strong) NSIndexPath  * moveIndexPath;
@property (nonatomic,strong) NSMutableArray * dataArr;
@end

@implementation DragCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.dataArr = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < 16; index ++) {
        CGFloat hue = (arc4random()%256/256.0); //0.0 到 1.0
        CGFloat saturation = (arc4random()%128/256.0)+0.5; //0.5 到 1.0
        CGFloat brightness = (arc4random()%128/256.0)+0.5; //0.5 到 1.0
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.5];
        [self.dataArr addObject:color];
    }
    
}
- (void)longTop:(UILongPressGestureRecognizer *)longTop{
    if (iOS9) {
        [self actionBefore9:longTop];
    }else{
        [self action:longTop];
    }
}
- (void)actionBefore9:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint point = [longPress locationInView:self.collectionView];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
            self.oldIndexPath = indexPath;
            if (indexPath == nil) {
                break;
            }
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            // 使用系统的截图功能,得到cell的截图视图
            UIView *snapshotView = [cell snapshotViewAfterScreenUpdates:NO];
            snapshotView.frame = cell.frame;
            self.snapshotView = snapshotView;
            [self.view addSubview:self.snapshotView];
            // 截图后隐藏当前cell
            cell.hidden = YES;
            
            CGPoint currentPoint = [longPress locationInView:self.collectionView];
            [UIView animateWithDuration:0.25 animations:^{
                snapshotView.transform = CGAffineTransformMakeScale(2.0, 2.0);
                snapshotView.center = currentPoint;
            }];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            // 截图视图位置随着手指位置移动
            CGPoint currentPoint = [longPress locationInView:self.collectionView];
            self.snapshotView.center = currentPoint;
            // 计算截图视图和哪个可见cell相交
            for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
                // 当前隐藏的cell就不需要交换了,直接continue
                if ([self.collectionView indexPathForCell:cell] == self.oldIndexPath) {
                    continue;
                }
                CGFloat space = sqrtf(pow(self.snapshotView.center.x - cell.center.x,2) +pow(self.snapshotView.center.y - cell.center.y, 2));
                // 如果相交一半就移动
                if (space <= self.snapshotView.bounds.size.width / 2) {
                    self.moveIndexPath = [self.collectionView indexPathForCell:cell];
                    // 移动 会调用willMoveToIndexPath方法更新数据源
                    [self.collectionView moveItemAtIndexPath:self.oldIndexPath toIndexPath:self.moveIndexPath];
                    // 设置移动后的起始indexPath
                    self.oldIndexPath = self.moveIndexPath;
                    break;
                }
            }
        }
            break;
        default:
        {
           
            
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.oldIndexPath];
            self.collectionView.userInteractionEnabled = NO;
            // 给截图视图一个动画移动到隐藏cell的新位置
            [UIView animateWithDuration:0.25 animations:^{
                self.snapshotView.center = cell.center;
                self.snapshotView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                //  移除截图视图 显示隐藏的cell并开始交互
                [self.snapshotView removeFromSuperview];
                cell.hidden = NO;
                self.collectionView.userInteractionEnabled = YES;
            }];
        }
            break;
    }
}
- (void)action:(UILongPressGestureRecognizer *)longPress{
    // 获取此次点击的坐标,根据坐标获取cell相对应的indexPath
    CGPoint point = [longPress locationInView:self.collectionView];
    NSIndexPath *indePath = [self.collectionView indexPathForItemAtPoint:point];
    self.oldIndexPath = indePath;
  // 根据长按手势的状态进行处理
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            // 当没有点击到cell的时候不进行处理
            if (!indePath) {
                break;
            }
            // 开始移动
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indePath];
            [self.view bringSubviewToFront:cell];
            // ios9方法 移动cell
            if (@available(iOS 9.0, *)) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indePath];
            }
        }
            break;
        
        case UIGestureRecognizerStateChanged:
            // 移动过程中更新位置坐标
            if (@available(iOS 9.0, *)) {
                [self.collectionView updateInteractiveMovementTargetPosition:point];

            }
            break;
        
        case UIGestureRecognizerStateEnded:
            // 停止移动
            if (@available(iOS 9.0, *)) {
                [self.collectionView endInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
            break;
        default:
            // 取消移动
            if (@available(iOS 9.0, *)) {
                [self.collectionView cancelInteractiveMovement];
            }
            break;
    }
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc] init];
        lay.itemSize = CGSizeMake((ScreenWidth - 40)/3, (ScreenWidth - 40)/3);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight -64) collectionViewLayout:lay];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
         [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        UILongPressGestureRecognizer *longTop = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTop:)];
        [_collectionView addGestureRecognizer:longTop];
    }
    return _collectionView;
}

- (void)addShark:(UICollectionViewCell *)cell{
    CAKeyframeAnimation *keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-3/180.0*M_PI),@(3/180.0*M_PI),@(-3/18.0*M_PI)];
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = MAXFLOAT;
    [cell.layer addAnimation:keyAnimaion forKey:@"cellShake"];
}
- (void)stopShake:(UICollectionViewCell *)cell{
    [cell.layer removeAnimationForKey:@"cellShake"];
}
#pragma mark <UICollectionViewDataSource>
#pragma mark iOS9以后拖拽移动的方法
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
/**
 sourceIndexPath 原数据 indexPath
 destinationIndexPath 移动到目标数据的 indexPath
 */
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    id color = self.dataArr[sourceIndexPath.row];
    [self.dataArr removeObject:color];
    [self.dataArr insertObject:color atIndex:destinationIndexPath.row];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.dataArr[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
