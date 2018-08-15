//
//  ViewController.m
//  Animation
//
//  Created by zlhj on 2018/8/1.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "ViewController.h"
#import "DragCollectionVC.h"
#import "AnimationController.h"
#import "CAAnimationVC.h"
#import "TranstionVC.h"
#import "ElasticTableView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSArray * dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"基础动画(CABaseAnimation)",@"关键帧动画(CAKeyframeAnimation)",@"组动画(CAAnimationGroup)",@"过渡动画(CATransition)",@"collectionview拖拽并抖动",@"tableview的收缩"];
    [self.view addSubview:self.tableview];
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
   return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CAAnimationVC *vc = [[CAAnimationVC alloc] init];
        vc.animationType = BaseAnimation;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        AnimationController *anim = [[AnimationController alloc] init];
        [self.navigationController pushViewController:anim animated:YES];
    }
    if (indexPath.row == 2) {
        CAAnimationVC *vc = [[CAAnimationVC alloc] init];
        vc.animationType = AnimationGroup;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3) {
        TranstionVC *vc = [[TranstionVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        DragCollectionVC *vc = [[DragCollectionVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 5) {
        ElasticTableView *vc = [[ElasticTableView alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
