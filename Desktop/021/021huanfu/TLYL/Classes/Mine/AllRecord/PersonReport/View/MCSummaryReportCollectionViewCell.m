//
//  MCSummaryReportCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSummaryReportCollectionViewCell.h"
#import "UIView+MCParentController.h"
#import <MJRefresh/MJRefresh.h>
#import "MCRecordTool.h"
#import "MCSummaryReportTableViewCell.h"
#import "MCPersonReportViewController.h"

@interface MCSummaryReportCollectionViewCell()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation MCSummaryReportCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.backgroundColor=RGB(231,231,231);
    
    [self setProperty];
    
    [self createUI];
    
    MCPersonReportViewController * vc = (MCPersonReportViewController *)[UIView MCcurrentViewController];
    _Rmodel.ReportComm = vc.Rmodel.ReportComm;
    [_tableView reloadData];
    
}


#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.backgroundColor=RGB(231, 231, 231);
    if (!_Rmodel) {
        MCPersonReportViewController * vc = (MCPersonReportViewController *)[UIView MCcurrentViewController];
        _Rmodel=vc.Rmodel;
    }
}

#pragma mark==================createUI======================
-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.layer.cornerRadius=5;
    _tableView.clipsToBounds=YES;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreashData];
    }];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    
    
}

#pragma mark-下拉刷新
- (void)refreashData{
    
    MCPersonReportViewController * vc = (MCPersonReportViewController *)[UIView MCcurrentViewController];
//    _Rmodel.ReportComm = vc.Rmodel.ReportComm;
//    [_tableView reloadData];
    [vc refreashData];

}


#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_Rmodel.ReportComm.count>0) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MCSummaryReportTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCSummaryReportTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCSummaryReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCSummaryReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_Rmodel.ReportComm.count>0) {
        cell.dataSource=_Rmodel.ReportComm[0];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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




















