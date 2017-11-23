//
//  MCNewActivityViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNewActivityViewController.h"
#import "MCNewActivityTableViewCell.h"
#import "MCNewActivityDetailViewController.h"

@interface MCNewActivityViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MCNewActivityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"优惠活动";
    self.view.backgroundColor = RGB(231, 231, 231);
    [self setUpUI];
}
#pragma mark -- setUpUI
-(void)setUpUI{
        self.automaticallyAdjustsScrollViewInsets = NO;
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13)+64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT - 64) style:UITableViewStylePlain];
        [self.view addSubview:tab];
        tab.backgroundColor = RGB(231, 231, 231);
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tab registerNib:[UINib nibWithNibName:@"MCNewActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        tab.delegate = self;
        tab.dataSource = self;
        tab.rowHeight = 130;
}
#pragma mark -- tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCNewActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    __weak typeof(self) weakSelf = self;
    cell.btnClick = ^{
        MCNewActivityDetailViewController *vc = [[MCNewActivityDetailViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}
@end
