//
//  MCLotteryHallViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryHallViewController.h"
#import "MCPickNumberViewController.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"
#import "MCHomePageLotteryCategoriesView.h"
#import "MCHomePagePictrueCycleView.h"
#import "MCHomePageInfoCycleView.h"
#import "MCPickNumberViewController.h"
#import "MCLotteryID.h"
#import "MCCZTXView.h"
#import "MCUserDefinedLotteryCategoriesModel.h"
#import "MCWithdrawRecDeltailViewController.h"
#import "MCRechargeViewController.h"
#import "MCUserMoneyModel.h"
#import "MCMineInfoModel.h"
#import "MCHasPayPwdModel.h"
#import "MCDataTool.h"
#import "MCGetLotteryCustomModel.h"
#import "MCSetLotteryCustomModel.h"
#import "MCSystemNoticeDetailViewController.h"
#import "MCSystemNoticeViewController.h"
#import "UIView+MCParentController.h"
#import "MCKefuViewController.h"
#import "MCMineAddBankCardViewController.h"
#import "MCModifyPayPasswordViewController.h"
#import "MCGameRecordViewController.h"
#import "MCFavorableActivityViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MCGetSecurityStateModel.h"
#import "MCMSecureSettingViewController.h"

@interface MCLotteryHallViewController ()<MCHomePageLotteryCategoriesDelegate,UITableViewDataSource>
typedef void(^MCLotteryHallViewControllerCompeletion)(BOOL result, NSDictionary *data );
//自定义view
@property(nonatomic,weak)MCHomePageLotteryCategoriesView *lotteryView;
//money_model模型的强引用
@property(nonatomic,strong)MCUserMoneyModel * money_model;
//mineInfo_model模型的强引用
@property(nonatomic,strong)MCMineInfoModel *mineInfoModel;
//hasPayPwd_model模型的强引用
@property(nonatomic,strong)MCHasPayPwdModel *hasPayPwdModel;

@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)MCGetSecurityStateModel * getSecurityStateModel;

@end

@implementation MCLotteryHallViewController

#pragma mark-life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"天利娱乐";
    [self setUpUI];
    [self loadDefaultCZList];
    [self GetSecurityState:^(BOOL result, NSDictionary *data) {
    }];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDefaultCZList) name:@"MCloadDefaultCZList" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    NSString  *Token= [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    if (Token.length<1) {
    }else{
       [self reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [BKIndicationView dismiss];
}
#pragma mark-setUpUI
- (void)setUpUI{
    
    
    UITableView *tab = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tab];
    self.tab = tab;
    tab.dataSource= self;
    tab.rowHeight = G_SCREENHEIGHT - 64 ;
    tab.contentInset = UIEdgeInsetsMake(0, 0, MC_REALVALUE(120), 0);
    tab.backgroundColor = RGB(239, 239, 239);

    CGFloat naviHeight = 0;
    //轮播高度
    CGFloat picCycleHeight = MC_REALVALUE(110);
    //3S广告
    CGFloat PageInfoCycleHeight = MC_REALVALUE(30);
    //充值提现
    CGFloat cztxViewHeight = MC_REALVALUE(100);

    /*
     * 九宫格  彩种
     */
    MCHomePageLotteryCategoriesView *lotteryView = [[MCHomePageLotteryCategoriesView alloc] initWithFrame:CGRectMake(0, naviHeight + picCycleHeight + PageInfoCycleHeight + cztxViewHeight +0.5, G_SCREENWIDTH, G_SCREENHEIGHT -(naviHeight + picCycleHeight + PageInfoCycleHeight + cztxViewHeight) - 49)];
    
    lotteryView.delegate=self;
    _lotteryView=lotteryView;
    __weak MCLotteryHallViewController *weakSelf = self;
    lotteryView.collectionViewDidSelectedCallBack = ^(MCUserDefinedLotteryCategoriesModel *model){
        
        if ([model.SaleState intValue]==1) {
            MCPickNumberViewController *pickVC =  [[MCPickNumberViewController alloc] init];
            pickVC.lotteriesTypeModel = model;
            [weakSelf.navigationController pushViewController:pickVC animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"该彩种已停售！"];
            return ;
        }
        
    };
    [tab addSubview:lotteryView];
    
    self.tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadDefaultCZList];
    }];
    
    /*
     * 轮播
     */
    MCHomePagePictrueCycleView *picView = [[MCHomePagePictrueCycleView alloc] initWithFrame:CGRectMake(0, naviHeight, G_SCREENWIDTH, picCycleHeight)];
    [tab addSubview:picView];
    
    /*
     * 3S广告通知栏
     */
    MCHomePageInfoCycleView *infoView = [[MCHomePageInfoCycleView alloc] initWithFrame:CGRectMake(0, picCycleHeight + naviHeight + MC_REALVALUE(100), G_SCREENWIDTH, PageInfoCycleHeight)];
    [tab addSubview:infoView];
    infoView.systemNoticeClickBlock = ^(MCSystemNoticeListModel *model) {
        
//        self.tabBarController.selectedIndex = 2;
        
        [UIView animateWithDuration:0.001 animations:^{
            
            MCSystemNoticeViewController * vc=[[MCSystemNoticeViewController alloc]init];
            [[UIView MCcurrentViewController].navigationController pushViewController:vc animated:NO];
            
        } completion:^(BOOL finished) {
                    MCSystemNoticeDetailViewController * vc=[[MCSystemNoticeDetailViewController alloc]init];
                    vc.NewsID=model.MerchantNews_ID;
                    [[UIView MCcurrentViewController].navigationController pushViewController:vc animated:NO];
        }];

        
    };
    
    
    /*
     * 充值 提现 栏
     */
    MCCZTXView *cztxView = [[MCCZTXView alloc] initWithFrame:CGRectMake(0, picCycleHeight + naviHeight, G_SCREENWIDTH, cztxViewHeight)];
    
    cztxView.tixianBtnClickBlock = ^{
        
        if ([self.mineInfoModel.UserType intValue] ==1) {
            [SVProgressHUD showInfoWithStatus:@"试玩账号不能提款!"];
            return;
        }
        BOOL hasCard = [self.mineInfoModel.BankCardNumber length]>1?YES:NO;
        BOOL hasPassword = [self.hasPayPwdModel.PayOutPassWord intValue]==1?YES:NO;
        
        /*
         * 情况一： 无资金密码  无默认银行卡
         */
        if (!hasCard&&!hasPassword) {
            [SVProgressHUD showInfoWithStatus:@"请先完善银行卡！"];
            //先绑卡-》设置资金密码-》退回我的
            MCMineAddBankCardViewController * vc=[[MCMineAddBankCardViewController alloc]init];
            vc.type=NOPasswordAndNOCard;
            self.navigationController.navigationBarHidden=NO;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            //情况二： 有资金密码  无默认银行卡
        }else if (hasPassword&&!hasCard){
            
            //先绑卡-》退回我的
            MCMineAddBankCardViewController * vc=[[MCMineAddBankCardViewController alloc]init];
            vc.type=HasPasswordAndNOCard;
            self.navigationController.navigationBarHidden=NO;
            [self.navigationController pushViewController:vc animated:YES];
            
            //情况三： 无资金密码  有默认银行卡
        }else if (!hasPassword&&hasCard){
            MCGetSecurityStateModel * getSecurityStateModel = [MCGetSecurityStateModel sharedMCGetSecurityStateModel];
            if (getSecurityStateModel.hadSecurityState.length>0) {
                if ([getSecurityStateModel.hadSecurityState integerValue]==1) {
                    //设置资金密码-》退回我的
                    [SVProgressHUD showInfoWithStatus:@"请先设置资金密码！"];
                    MCModifyPayPasswordViewController * vc =[[MCModifyPayPasswordViewController alloc]init];
                    self.navigationController.navigationBarHidden=NO;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    //设置密保
                    [SVProgressHUD showInfoWithStatus:@"请先设置密保！"];
                    MCMSecureSettingViewController *svc=[[MCMSecureSettingViewController alloc]init];
                    svc.Type = MCMSecureSettingType_FirstSet;
                    self.navigationController.navigationBarHidden=NO;
                    [self.navigationController pushViewController:svc animated:YES];
                }
            }else{
                __weak __typeof(self)wself = self;
                [self GetSecurityState:^(BOOL result, NSDictionary *data) {
                    wself.getSecurityStateModel.hadSecurityState=data[@"Result"];
                    if ([wself.getSecurityStateModel.hadSecurityState integerValue]==1) {
                        //设置资金密码-》退回我的
                        [SVProgressHUD showInfoWithStatus:@"请先设置资金密码！"];
                        MCModifyPayPasswordViewController * vc =[[MCModifyPayPasswordViewController alloc]init];
                        self.navigationController.navigationBarHidden=NO;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"加载失败！"];
                    }
                }];
            }
            
            //情况四： 有资金密码  有默认银行卡
        }else{
            
            MCWithdrawRecDeltailViewController * vc=[[MCWithdrawRecDeltailViewController alloc]init];
            self.navigationController.navigationBarHidden=NO;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    };
    [self.tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"1"];
    cztxView.chongzhiBtnClickBlock = ^{
        if ([self.mineInfoModel.UserType intValue] ==1) {
            [SVProgressHUD showInfoWithStatus:@"试玩账号不能充值!"];
            return;
        }
        MCRechargeViewController * vc = [[MCRechargeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    cztxView.gameBtnClickBlock = ^{
        MCGameRecordViewController * vc=[[MCGameRecordViewController alloc]init];
    
        [self.navigationController pushViewController:vc animated:YES];
    };
    cztxView.activityBtnClickBlock = ^{
        MCFavorableActivityViewController * vc=[[MCFavorableActivityViewController alloc]init];

        [self.navigationController pushViewController:vc animated:YES];
    };
    [tab addSubview:cztxView];
    
    
    /*
     * 客服按钮
     */
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"home-icon-land"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, MC_REALVALUE(30), MC_REALVALUE(30));
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn addTarget:self action:@selector(contactCustomerServiceBtnClick:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"天利娱乐 © 2017 Copyright";
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor =RGB(136,136,136);
    label.font = [UIFont systemFontOfSize:9.0];
    [tab addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.lotteryView.mas_bottom).offset(10);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    return cell;
}
-(void)loadDefaultCZList{
    
    __weak typeof(self) weakSelf = self;
    
    MCUserDefinedLotteryCategoriesViewController * vc=[[MCUserDefinedLotteryCategoriesViewController alloc]init];
    [vc GetLotteryCustomArray:^(BOOL result, NSMutableArray *defaultCZArray) {
        
        [weakSelf.tab.mj_header endRefreshing];
        if (result) {
            [weakSelf.lotteryView relayOutUI];
        }
    }];
}
- (void)reloadData{

    
    __weak __typeof(self)wself = self;

    MCUserMoneyModel * money_model=[MCUserMoneyModel sharedMCUserMoneyModel];
    [money_model refreashDataAndShow];
    self.money_model=money_model;
    money_model.callBackSuccessBlock = ^(id manager) {
  
        wself.money_model.FreezeMoney=manager[@"FreezeMoney"];
        wself.money_model.LotteryMoney=manager[@"LotteryMoney"];
    };
    
    MCMineInfoModel *mineInfo_model = [MCMineInfoModel sharedMCMineInfoModel];
    self.mineInfoModel = mineInfo_model;
    [mineInfo_model refreashDataAndShow];
    mineInfo_model.callBackSuccessBlock = ^(id manager) {
      
        wself.mineInfoModel=[MCMineInfoModel mj_objectWithKeyValues:manager];
        [[NSUserDefaults standardUserDefaults] setObject:wself.mineInfoModel.DrawBeginTime forKey:@"DrawBeginTime"];
        [[NSUserDefaults standardUserDefaults] setObject:wself.mineInfoModel.DrawEndTime forKey:@"DrawEndTime"];
    };
    
    MCHasPayPwdModel * hasPayPwd_model=[MCHasPayPwdModel sharedMCHasPayPwdModel];
    [hasPayPwd_model refreashDataAndShow];
    self.hasPayPwdModel=hasPayPwd_model;
    hasPayPwd_model.callBackSuccessBlock = ^(id manager) {
       
        wself.hasPayPwdModel.PayOutPassWord=[NSString stringWithFormat:@"%@",manager[@"PayOutPassWord"]];
    };
    
    
}

-(void)GetSecurityState:(MCLotteryHallViewControllerCompeletion)Compeletion{
    __weak __typeof(self)wself = self;
    MCGetSecurityStateModel * getSecurityStateModel = [MCGetSecurityStateModel sharedMCGetSecurityStateModel];
    _getSecurityStateModel=getSecurityStateModel;
    [getSecurityStateModel refreashDataAndShow];
    getSecurityStateModel.callBackSuccessBlock = ^(id manager) {
        wself.getSecurityStateModel.hadSecurityState=manager[@"Result"];
        Compeletion(YES,manager);
    };
    getSecurityStateModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        wself.getSecurityStateModel.hadSecurityState=nil;
        Compeletion(YES,nil);
    };
}

#pragma mark-touch event
- (void)contactCustomerServiceBtnClick:(UIButton *)btn{
  MCKefuViewController *vc =  [[MCKefuViewController alloc] init];
    vc.title = @"联系客服";
    [self.navigationController pushViewController:vc animated:YES];

}
/*
 * 跳转自定义彩种
 */
#pragma mark-MCHomePageLotteryCategoriesDelegate
-(void)SetUserDefinedLotteryCategories{
    MCUserDefinedLotteryCategoriesViewController * vc = [[MCUserDefinedLotteryCategoriesViewController alloc]init];
    __weak MCLotteryHallViewController * weakSelf = self;
    vc.block=^(NSMutableArray<MCUserDefinedLotteryCategoriesModel *> *marr){
        
        [weakSelf.lotteryView relayOutUI];
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark-加载用户自定义彩种
//-(void)loadDefaultCZList{
//    
//    __weak typeof(self) weakSelf = self;
//    
//    MCUserDefinedLotteryCategoriesViewController * vc=[[MCUserDefinedLotteryCategoriesViewController alloc]init];
//    [vc GetLotteryCustomArray:^(BOOL result, NSMutableArray *defaultCZArray) {
//        if (result) {
//            [weakSelf.lotteryView.collectionView relayOutUI];
//        }
//    }];
//    
//}

    
@end




