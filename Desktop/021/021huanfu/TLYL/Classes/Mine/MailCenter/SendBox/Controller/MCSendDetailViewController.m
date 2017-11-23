//
//  MCSendDetailViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSendDetailViewController.h"
#import "MCSendDetailModel.h"
#import "MCChaKanPersonViewController.h"

@interface MCSendDetailViewController ()
@property (nonatomic,strong) MCSendDetailModel *sendModel;
@end

@implementation MCSendDetailViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.btn setTitle:@"查看所有收件人" forState:UIControlStateNormal];
    self.shouLabel.text = @"收件人:";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}
#pragma mark --发送请求
-(void)loadData{
 
  
    __weak typeof(self) weakself = self;
    MCSendDetailModel *sendModel = [[MCSendDetailModel alloc] init];
    self.sendModel = sendModel;
    sendModel.ID = self.ID;
    [sendModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    sendModel.callBackSuccessBlock = ^(NSDictionary *manager) {
        MCSendDetailModel *model = [MCSendDetailModel mj_objectWithKeyValues:manager];
        weakself.titleContentLabel.text = model.Title;
        if (model.SendPersonLevel == 2) {
             weakself.shouContentLabel.text = @"下级";
        } else if(model.SendPersonLevel == 1){
             weakself.shouContentLabel.text = @"上级";
            weakself.btn.hidden = YES;
        }
       
        weakself.dateLabel.text = model.SendDateTime;
        [BKIndicationView showInView:self.view];
        [weakself.contentWeb loadHTMLString:model.Content baseURL:nil];
    };
    
    sendModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [SVProgressHUD dismiss];
    };
    
}

- (void)btnClick{
    MCChaKanPersonViewController *vc = [[MCChaKanPersonViewController alloc] init];
    vc.Sendid =[NSString stringWithFormat:@"%d",self.ID];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
