//
//  ElasticTableView.m
//  Animation
//
//  Created by zlhj on 2018/8/15.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "ElasticTableView.h"
#import "UIGestureRecognizer+Block.h"
@interface ElasticTableView ()
@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic,strong) NSArray * sectionArr;
@property (nonatomic,strong) NSMutableArray * sectionStatus;//记录每个section展开状态
@end

@implementation ElasticTableView
- (NSMutableArray *)sectionStatus{
    if (_sectionStatus == nil) {
        _sectionStatus = [NSMutableArray array];
    }
    return _sectionStatus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@[@"苹果",@"李子",@"桃",@"杏",@"葡萄"],@[@"生菜",@"油麦菜",@"花菜",@"菜心",@"苋菜"],@[@"基围虾",@"黑鱼",@"鱿鱼",@"带鱼"],@[@"大米",@"面",@"橄榄油",@"葵花油",@"玉米油"]];
    self.sectionArr = @[@"水果",@"蔬菜",@"水产",@"粮油"];
    for (int i = 0; i < self.sectionArr.count; i++) {
        [self.sectionStatus addObject:@"0"];
    }
   
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.sectionStatus objectAtIndex:indexPath.section] isEqualToString:@"0"]) {
        return 0;
    }else{
        return 50;
    }
}
//调整section头部的间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 444);
    sectionLabel.textColor = [UIColor orangeColor];
    sectionLabel.text = self.sectionArr[section];
    sectionLabel.textAlignment = NSTextAlignmentCenter;
    sectionLabel.userInteractionEnabled = YES;

    __weak typeof(self)weakSelf = self;
    [sectionLabel addGestureRecognizer:[UITapGestureRecognizer msj_gestureRecoginizerWithActionBlock:^(id gestureRecognizer) {
        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
        NSArray *arr = self.dataSource[section];
        for (int i = 0; i < arr.count; i ++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:section];
            [indexArray addObject:path];
        }
        //展开
        if ([[weakSelf.sectionStatus objectAtIndex:section] isEqualToString:@"0"]) {
            [weakSelf.sectionStatus setObject:@"1" atIndexedSubscript:section];
            [weakSelf.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
        } else {
            //收起
            [weakSelf.sectionStatus setObject:@"0" atIndexedSubscript:section];
            [weakSelf.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
        }
        //    NSRange range = NSMakeRange(section, 1);
        //    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        //    [_tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
    }]];
    return sectionLabel;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.layer.masksToBounds = YES;
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}




@end
