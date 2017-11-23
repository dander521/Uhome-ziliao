//
//  MCPaySelectedLotteryTableViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPaySelectedLotteryTableViewController.h"
#import "MCPaySelectedLotteryTableViewCell.h"
#import "MCPayListHeaderView.h"
#import "MCPayListFooterView.h"
#import "MCMMCPayListFooterView.h"
#import "MCMineCellModel.h"
#import "MCChaseNumberViewController.h"
#import "MCPaySelectedLotteryModel.h"
#import "MCMMCNewViewController.h"
#import "MCMMCPresentationController.h"
#import "MCMSPopView.h"
#import "MCBetModel.h"
#import "MCMineInfoModel.h"
#import "MCUserMoneyModel.h"
#import "ExceptionView.h"
#import "MCIssueModel.h"
#import "MCMaxbonusModel.h"
#import "MCGameRecordViewController.h"
#import "MCMainNavigationController.h"
#import "UIView+MCParentController.h"
#import "MCRandomUntits.h"
#import "MCPopAlertView.h"
#import "UIImage+Extension.h"
#import "MCPaySelectedLotteryPickView.h"

#define ApplicationNavigationBarBackGauge 7 //导航栏图片距屏幕边缘间距
@interface MCPaySelectedLotteryTableViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate,
MGBaseSwipeTableViewCellDelegate
//MCPaySelectedLotteryTableViewCellDelegate
>
/**view_header*/
@property(nonatomic, strong)MCPayListHeaderView *paySelectedLotteryHeaderView;
/**view_footer*/
@property(nonatomic, strong)MCPayListFooterView *paySelectedLotteryFooterView;
@property(nonatomic, strong)MCMMCPayListFooterView*mmc_paySelectedLotteryFooterView;
/**tableView*/
@property(nonatomic, strong)UITableView *tableView;
/**Section模型数组*/
@property(nonatomic, strong)NSMutableArray*sectionMarr;
/**dataSourceModel*/
@property(nonatomic, strong)MCPaySLBaseModel*dataSourceModel;

/**apiModel(投注接口)*/
@property(nonatomic, strong)MCBetModel *betModel;

@property(nonatomic, strong)MCUserMoneyModel *userMoneyModel;
@property(nonatomic, strong)MCIssueModel *issueModel;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)MCPaySelectedCellModel * ggPaySelectedCellModel;

@property(nonatomic, strong)UIButton * randomBtn;
//余额
@property(nonatomic, strong)UILabel * yuElab;
//期号

@end

@implementation MCPaySelectedLotteryTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [self setProperty];
    
    [self createUI];
    
    [self setRandom];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkData) name:@"MCloadIssueNumber" object:nil];
    [self checkData];
}
#pragma mark-
-(void) cancelTableEditClick: (id) sender{
    [_tableView setEditing: NO animated: YES];
}

-(NSArray *) createRightButtons: (int) number{
    number=1;
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[1] = {@" 删除 "};
    UIColor * colors[1] = {RGB(249,84,83)};
    for (int i = 0; i < number; ++i){
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            BOOL autoHide = i != 0;
            return autoHide; //Don't autohide in delete button to improve delete expansion animation
        }];
        [result addObject:button];
    }
    return result;
}



#if TEST_USE_MG_DELEGATE
-(nullable NSArray<UIView*>*) swipeTableCell:(nonnull MCPaySelectedLotteryTableViewCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
                               swipeSettings:(nonnull MGSwipeSettings*) swipeSettings expansionSettings:(nonnull MGSwipeExpansionSettings*) expansionSettings{
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    if (direction == MGSwipeDirectionLeftToRight) {
        return nil;
    }else {
        expansionSettings.buttonIndex = 1;
        expansionSettings.fillOnTrigger = YES;
        return [self createRightButtons:1];
    }
}
#endif

-(BOOL) swipeTableCell:(nonnull MCPaySelectedLotteryTableViewCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
        
        MCPaySelectedCellModel * dModel= self.dataSourceModel.dataSource[indexPath.section];
        [self.dataSourceModel  deleteDataSourceWithModel:dModel];
        self.dataSourceModel=[MCPaySLBaseModel sharedMCPaySLBaseModel];
        if ([_dataSourceModel.czName containsString:@"秒秒彩"]) {
            self.mmc_paySelectedLotteryFooterView.dataSource=self.dataSourceModel;
        }else{
           self.paySelectedLotteryFooterView.dataSource=self.dataSourceModel;
        }
        [self create_SectionMarr];
        
        return NO; //Don't autohide to improve delete expansion animation
    }
    
    return YES;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped accessory button");
}


-(void)checkData{
    __weak __typeof__ (self) wself = self;
    if ([self.baseWFmodel.LotteryID isEqualToString:@"50"]){
    //秒秒彩不调用倒计时
        [self create_SectionMarr];
        self.mmc_paySelectedLotteryFooterView.dataSource=self.dataSourceModel;
        _paySelectedLotteryHeaderView.issueNumberLab.hidden=YES;
        _paySelectedLotteryHeaderView.titleLabel.hidden=YES;
        

    }else{
        if (!_RemainTime||_IssueNumber==nil || [_IssueNumber isEqualToString:@""]) {
            self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;

                [wself getData];
                
            }];
            [self.exceptionView addAction:action];
            [self.exceptionView showInView:wself.view];
            
        }else{
            
            [self loadData];
            [self getData];
            
        }
    }
    
    //刷新余额
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [userMoneyModel refreashDataAndShow];
    self.userMoneyModel=userMoneyModel;
    userMoneyModel.callBackSuccessBlock = ^(id manager) {
        
        wself.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
        wself.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
        
        wself.dataSourceModel.balance=manager[@"LotteryMoney"];
        if ([_dataSourceModel.czName containsString:@"秒秒彩"]) {
            wself.mmc_paySelectedLotteryFooterView.dataSource=wself.dataSourceModel;
        }else{
            wself.paySelectedLotteryFooterView.dataSource=wself.dataSourceModel;
        }
    };
    
}

-(void)getData{
    MCIssueModel *issueModel = [[MCIssueModel alloc] init];
    issueModel.lotteryNumber = [_dataSourceModel.LotteryID intValue];
    [issueModel refreashDataAndShow];
    self.issueModel = issueModel;
    __weak typeof(self) weakSelf = self;
    issueModel.callBackSuccessBlock = ^(id manager) {
        MCIssueModel *model = [MCIssueModel mj_objectWithKeyValues:manager];
        weakSelf.RemainTime= model.RemainTime;
        weakSelf.IssueNumber=model.IssueNumber;
        [weakSelf loadData];
    };
    issueModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {

        [weakSelf checkData];
    };


}



#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    
    
    _sectionMarr= [[NSMutableArray alloc]init];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
    MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    _dataSourceModel=model;
    _ggPaySelectedCellModel = model.dataSource[0];
    self.title=_dataSourceModel.czName;
}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, MC_REALVALUE(28), MC_REALVALUE(28));
    [rightBtn addTarget:self action:@selector(emptyShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"Navigation_delete_selected"] forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -ApplicationNavigationBarBackGauge;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
}

#pragma mark-清空购彩篮
-(void)emptyShoppingCart{
    [_sectionMarr removeAllObjects];
    [_dataSourceModel removeDataSource];
    [_tableView reloadData];
    if ([_dataSourceModel.czName containsString:@"秒秒彩"]) {
        self.mmc_paySelectedLotteryFooterView.dataSource=self.dataSourceModel;
    }else{
        self.paySelectedLotteryFooterView.dataSource=self.dataSourceModel;
    }
}

#pragma mark==================createUI======================
-(void)createUI{
    
    [self createHeader];
    [self createFooterView];
    [self createTableView];

}

-(void)setRandom{
    /*
     * 看是否支持机选
     */
    if ([_ggPaySelectedCellModel.isMachineSelectEnabled isEqualToString:@"0"]) {
        self.randomBtn.enabled = NO;
        [self.randomBtn setBackgroundImage:[UIImage createImageWithColor:RGB(204, 204, 204)] forState:UIControlStateNormal];
    } else {
        self.randomBtn.enabled = YES;
    }
    
}
#pragma mark-创建头部
-(void)createHeader{
    _paySelectedLotteryHeaderView=[[MCPayListHeaderView alloc]init];
    __weak typeof(self) weakSelf = self;
    _paySelectedLotteryHeaderView.timeISZeroBlock = ^{
        [weakSelf getData];
    };
    [self.view addSubview:_paySelectedLotteryHeaderView];
    _paySelectedLotteryHeaderView.frame=CGRectMake(0, 0, G_SCREENWIDTH, [MCPayListHeaderView computeHeight:nil]);
    
    UIButton * xuanhaoBtn=[[UIButton alloc]init];
    xuanhaoBtn.frame=CGRectMake(10, 50, (G_SCREENWIDTH-40)/3.0, 34);
    [self setBtn:xuanhaoBtn withTitle:@" 手动选号" andImgV:@"PaySelected_SDong" andColor:RGB(255, 169, 47)];
    xuanhaoBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [xuanhaoBtn addTarget:self action:@selector(xuanhaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * randomBtn=[[UIButton alloc]init];
    randomBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    randomBtn.frame=CGRectMake(10+(G_SCREENWIDTH-40)/3.0+10, 50, (G_SCREENWIDTH-40)/3.0, 34);
    [self setBtn:randomBtn withTitle:@" 随选一注" andImgV:@"PaySelected_JXuan" andColor:RGB(255, 169, 47)];
    [randomBtn addTarget:self action:@selector(randomClick) forControlEvents:UIControlEventTouchUpInside];
    self.randomBtn=randomBtn;
    
    UIButton * zhuihaoBtn=[[UIButton alloc]init];
    zhuihaoBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    zhuihaoBtn.frame=CGRectMake(10+2*(G_SCREENWIDTH-40)/3.0+20, 50, (G_SCREENWIDTH-40)/3.0, 34);
    if ([_dataSourceModel.czName containsString:@"秒秒彩"]) {
        [self setBtn:zhuihaoBtn withTitle:@" 添加追号" andImgV:@"PaySelected_tjhm" andColor:RGB(204,204,204)];
        zhuihaoBtn.enabled=NO;
    }else{
        [self setBtn:zhuihaoBtn withTitle:@" 添加追号" andImgV:@"PaySelected_tjhm" andColor:RGB(255, 169, 47)];
        zhuihaoBtn.enabled=YES;
        [zhuihaoBtn addTarget:self action:@selector(zhuihaoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)setBtn:(UIButton*)btn withTitle:(NSString *)title andImgV:(NSString *)image andColor:(UIColor *)color {

    //    [btn setBackgroundImage:[UIImage createImageWithColor:color] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage createImageWithColor:RGB(204,204,204)] forState:UIControlStateSelected];
//    [btn setTitleColor:RGB(136,136,136) forState:UIControlStateSelected];
    [btn setTitleColor:RGB(255,255,255) forState:UIControlStateNormal];
    btn.layer.cornerRadius=5;
    btn.clipsToBounds=YES;
    [self.view addSubview:btn];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    
    // 设置背景图片在默认状态与高亮状态之间切换的图片
    [btn setBackgroundImage:[UIImage createImageWithColor:color] forState: UIControlStateNormal];
    // 设置背景图片在选中状态与高亮状态之间切换的图片
    [btn setBackgroundImage:[UIImage createImageWithColor:RGB(204,204,204)] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    
    
}
#pragma mark-手动选号
-(void)xuanhaoClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-机选
-(void)randomClick{
    
    NSMutableArray *arr = [MCRandomUntits Get_RandomArrWithModel:_ggPaySelectedCellModel.WFModel];

    
    MCBasePWFModel * WFModel = _ggPaySelectedCellModel.WFModel;
    
    NSMutableArray <MCBaseSelectedModel *>*baseSelectedModel=[[NSMutableArray alloc]init];
    
    int i=0;
    for (NSArray * temp in arr) {
        if (temp.count>0) {
            MCBaseSelectedModel * bsModel=[[MCBaseSelectedModel alloc]init];
            bsModel.index=i;
            NSMutableArray * marr=[NSMutableArray arrayWithArray:temp];
            bsModel.selectedArray=marr;
            [baseSelectedModel addObject:bsModel];
        }
        i++;
    }

    WFModel.baseSelectedModel=baseSelectedModel;
    //随机选择最大的返点
    if (self.betRebateArray.count>0) {
        MCShowBetModel* betModel = self.betRebateArray[0];
        WFModel.userSelectedRebate=betModel.BetRebate;
        WFModel.showRebate = betModel.showRebate;
    }
    
    
    
    //注数计算
    MCBallPropertyModel *bModel= [MCStakeUntits  GetBallPropertyWithWFModel:WFModel];
    WFModel.stakeNumber=bModel.stakeNumber;
    
    //倍数
    WFModel.multiple = 1;
    
    //元角分模式
    WFModel.yuanJiaoFen=1;
    
    //消费
   WFModel.payMoney=WFModel.stakeNumber*2*WFModel.yuanJiaoFen*WFModel.multiple;
    
    
    if (WFModel.maxAwardAmount&&WFModel.minAwardAmount) {
    }else if (self.baseWFmodel.maxAwardAmount){
        
        MCMoneyModel * MaxModel= MCGetBouns(WFModel.maxAwardAmount, WFModel.userSelectedRebate, WFModel.yuanJiaoFen, WFModel.multiple, WFModel.payMoney);
        WFModel.bonus=[MaxModel.bouns floatValue];
        WFModel.yinli=[MaxModel.yinli floatValue];
        WFModel.profitChaseAwardAmount=GetRealFloatNum((WFModel.bonus/WFModel.multiple));
    }
    /*
     * 添加机选
     */
    MCPaySLBaseModel * jiXuanmodel=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    [jiXuanmodel addDataSourceWithModel:WFModel];
    
    _dataSourceModel=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    
    [self loadData];
    
}

#pragma mark-追号
-(void)zhuihaoClick{
    __weak typeof(self) weakSelf = self;
    if (_dataSourceModel.dataSource.count<1) {
        [SVProgressHUD showErrorWithStatus:@"至少选择一注！"];
        return ;
    }
    if ([self.dataSourceModel.payMoney floatValue]>[self.dataSourceModel.balance floatValue]) {
        [SVProgressHUD showInfoWithStatus:@"余额不足!"];
        return;
    }
    
    for (MCPaySelectedCellModel * model in _dataSourceModel.dataSource) {
        if (!model.BetRebate) {
            [SVProgressHUD showInfoWithStatus:@"返点为空，请返回重新选择！"];
            return;
        }
    }
    
    MCChaseNumberViewController *chsaseNumberController = [[MCChaseNumberViewController alloc] init];
    chsaseNumberController.dataSourceModel = self.dataSourceModel;
    chsaseNumberController.RemainTime=self.paySelectedLotteryHeaderView.dataSource;
    chsaseNumberController.IssueNumber=self.IssueNumber;
    chsaseNumberController.boModelArray=self.boModelArray;
    chsaseNumberController.baseWFmodel=self.baseWFmodel;
    chsaseNumberController.yuEHadChangedBlock = ^(NSString *yue) {
        [weakSelf refreashUserMoney];
    };
    [self.navigationController pushViewController:chsaseNumberController animated:YES];
}

-(void)createTableView{
//    CZType type=[_dataSourceModel.czName  rangeOfString:@"秒秒彩"].location !=NSNotFound?MCMMC:MCOther;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_paySelectedLotteryHeaderView.mas_bottom).offset(10+34+10);
        make.right.equalTo(self.view).offset(-10);
        make.left.equalTo(self.view).offset(10);
        if ([_dataSourceModel.czName containsString:@"秒秒彩"]) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-[MCMMCPayListFooterView computeHeight:nil]);
        }else{
           make.bottom.equalTo(self.view.mas_bottom).offset(-[MCPayListFooterView computeHeight:nil]);
        }
        
    }];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePopView:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:singleTapGesture];
}
-(void)createFooterView{
    __weak typeof(self) weakSelf = self;
    
    //秒秒彩
    if ([_dataSourceModel.czName containsString:@"秒秒彩"]) {
        _mmc_paySelectedLotteryFooterView=[[MCMMCPayListFooterView alloc]init];
        [self.view addSubview:_mmc_paySelectedLotteryFooterView];
        _mmc_paySelectedLotteryFooterView.frame=CGRectMake(0, G_SCREENHEIGHT-[MCMMCPayListFooterView computeHeight:nil]-64, G_SCREENHEIGHT, [MCMMCPayListFooterView computeHeight:nil]);
        _mmc_paySelectedLotteryFooterView.block = ^(NSInteger t) {
    #pragma mark-【秒秒彩】点击清空
            if (t==1001) {
                
                [weakSelf emptyShoppingCart];
                
    #pragma mark-【秒秒彩】点击立即开奖
            }else if (t==1002){
                
                [weakSelf goToRunLotteryImmediately];
            }
            
        };
        
     
    //非秒秒彩
    }else{
        _paySelectedLotteryFooterView=[[MCPayListFooterView alloc]init];
        [self.view addSubview:_paySelectedLotteryFooterView];
        
        _paySelectedLotteryFooterView.frame=CGRectMake(0, G_SCREENHEIGHT-[MCPayListFooterView computeHeight:nil]-64, G_SCREENHEIGHT, [MCPayListFooterView computeHeight:nil]);
        
        _paySelectedLotteryFooterView.block=^(NSInteger t){
#pragma mark-【非秒秒彩】点击清空
            if (t==1001) {
                
                [weakSelf emptyShoppingCart];
                
#pragma mark-【非秒秒彩】点击付款
            }else if(t==1002){
                if (weakSelf.dataSourceModel.dataSource.count<1) {
                    [SVProgressHUD showErrorWithStatus:@"至少选择一注！"];
                    return;
                }
                
                if ([weakSelf.dataSourceModel.payMoney floatValue]<0.001) {
                    [SVProgressHUD showErrorWithStatus:@"付款金额必须大于0！"];
                    return;
                }
                
                if ([weakSelf.dataSourceModel.payMoney floatValue]>[self.dataSourceModel.balance floatValue]) {
                    [SVProgressHUD showInfoWithStatus:@"余额不足!"];
                    return;
                }
                int mode = (int)[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode];
                NSString *maxstr = @"";
                if ((mode & 128) == 128) {//单期功能
                    for (MCMaxbonusModel *model in weakSelf.boModelArray) {
                        if ([model.Sign isEqualToString:@"1"]) {
                            //                            continue;
                        }
                        
                        NSString *lotName =  [MCLotteryID getLotteryCategoriesTypeNameByID:weakSelf.baseWFmodel.LotteryID];
                        if ([lotName isEqualToString:@"ssc"] &&[model.SingleStageCode isEqualToString:@"1001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"esf"] &&[model.SingleStageCode isEqualToString:@"2001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"sd"] &&[model.SingleStageCode isEqualToString:@"3001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"pls"] &&[model.SingleStageCode isEqualToString:@"4001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"plw"] &&[model.SingleStageCode isEqualToString:@"5001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"ssl"] &&[model.SingleStageCode isEqualToString:@"6001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"kl8"] &&[model.SingleStageCode isEqualToString:@"7001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"pks"] &&[model.SingleStageCode isEqualToString:@"8001"]) {
                            maxstr = model.MaxAmt;
                        }
                        else if ([lotName isEqualToString:@"k3"] &&[model.SingleStageCode isEqualToString:@"9001"]) {
                            maxstr = model.MaxAmt;
                        }else{
                            continue ;
                        }
                        
                        
                    }
                }
                NSString * tip;
                if (maxstr.length>1) {
                    tip =[NSString stringWithFormat:@"该彩种单期最高奖金为%@元\n您共投%@注，共%@元，请确认",GetRealSNum(maxstr ),_dataSourceModel.stakeNumber,GetRealSNum(weakSelf.dataSourceModel.payMoney)];
                }else{
                    tip=[NSString stringWithFormat:@"您共投%@注，共%@元，请确认",_dataSourceModel.stakeNumber,GetRealSNum(weakSelf.dataSourceModel.payMoney)];
                }
                
                MCPopAlertView *mcAlertView = [[MCPopAlertView alloc] initWithType:MCPopAlertTypeTZRequest_Confirm Title:@"投注确认" message:tip leftBtn:@"确认投注" rightBtn:@"取消返回"];
                
                mcAlertView.resultIndex = ^(NSInteger index){
                    if (index==1) {
                        [weakSelf lottery_bet];
                    }
                };
                [mcAlertView showXLAlertView];

            }
        };
    }

}
#pragma mark-投注
-(void)lottery_bet{
    NSMutableArray * betMarr=[[NSMutableArray alloc]init];
    __weak __typeof__ (self) wself = self;
    
    for (MCPaySelectedCellModel * model in _dataSourceModel.dataSource) {
        if (!model.BetRebate) {
            [SVProgressHUD showInfoWithStatus:@"返点为空，请返回重新选择！"];
            return;
        }
        NSDictionary * betDic = @{
                                  @"BetContent":model.tz_haoMa,//投注内容
                                  @"BetCount":model.stakeNumber,//投注注数
                                  @"PlayCode":model.PlayCode,//玩法编码
                                  @"IssueNumber":self.IssueNumber,//投注期号
                                  @"BetRebate":model.BetRebate,//投注返点
                                  @"BetMoney":model.payMoney,//投注金额
                                  @"BetMultiple":model.multiple,//投注倍数
                                  @"BetMode":model.BetMode//玩法模式
                                  };
        [betMarr addObject:betDic];
    }
    NSDictionary * dic =@{
                          @"UserBetInfo":@{
                                  @"LotteryCode":_dataSourceModel.LotteryID,//彩种编码
                                  @"Bet":betMarr
                                          }
                          };
    
    MCBetModel *betModel = [[MCBetModel alloc] initWithDic:dic];
    self.betModel=betModel;
    [BKIndicationView showInView:self.view];
    [betModel refreashDataAndShow];
    betModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
//        if ([errorCode isKindOfClass:[NSDictionary class]]) {
//            if ([errorCode[@"code"] isEqualToString:@"510"]) {
//                [SVProgressHUD showInfoWithStatus:@"该彩种已经停售！"];
//                return ;
//            }
//        }
        [wself betFaildToDo];
    };
    betModel.callBackSuccessBlock = ^(id manager) {
        //投注成功
        [wself betSuccessToDo];
    };
}

#pragma mark-投注【失败】后要做的事情
-(void)betFaildToDo{
    MCPopAlertView *mcAlertView = [[MCPopAlertView alloc] initWithType:MCPopAlertTypeTZRequest_Faild Title:@"投注确认" message:@"投注失败" leftBtn:@"重新投注" rightBtn:@"在线客服"];
    mcAlertView.resultIndex = ^(NSInteger index){
#pragma mark-重新投注
        if (index==1) {
            [self lottery_bet];
#pragma mark-在线客服
        }else if(index==2){
            [SVProgressHUD showInfoWithStatus: @"功能完善中..."];
        }
    };
}
#pragma mark-投注【成功】后要做的事情
-(void)betSuccessToDo{
    //1.清空购彩蓝
    _dataSourceModel.balance=[NSString stringWithFormat:@"%@",GetRealFloatNum([_dataSourceModel.balance doubleValue]-[_dataSourceModel.payMoney doubleValue])];
    [self emptyShoppingCart];
    //2.刷新余额
    [self refreashUserMoney];

    MCPopAlertView *mcAlertView = [[MCPopAlertView alloc] initWithType:MCPopAlertTypeTZRequest_Success Title:@"投注确认" message:@"投注成功" leftBtn:@"继续投注" rightBtn:@"查看记录"];
    
    mcAlertView.resultIndex = ^(NSInteger index){
        //回调---处理一系列动作x
#pragma mark-查看记录
        if (index==2) {
            
            //获得视图控制器堆栈数组
            NSArray *currentControllers = self.navigationController.viewControllers;
            //基于堆栈数组实例化新的数组
            NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
            int count = (int)newControllers.count;
            
            [newControllers removeObjectAtIndex:(count-1)];
            
            MCGameRecordViewController * vc = [[MCGameRecordViewController alloc]init];
            
            UIViewController * pVC=[newControllers lastObject];
            
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            
            [UIView animateWithDuration:0.001 animations:^{
                //为堆栈重新赋值
                [self.navigationController setViewControllers:newControllers animated:NO];
            } completion:^(BOOL finished) {
                [pVC.navigationController pushViewController:vc animated:YES];
            }];
            
            
#pragma mark-继续投注
        }else if (index==1){
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    };
    [mcAlertView showXLAlertView];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma mark-查看记录
    if (buttonIndex==0) {
        
        //获得视图控制器堆栈数组
        NSArray *currentControllers = self.navigationController.viewControllers;
        //基于堆栈数组实例化新的数组
        NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
        int count = (int)newControllers.count;
        
        [newControllers removeObjectAtIndex:(count-1)];
        
        MCGameRecordViewController * vc = [[MCGameRecordViewController alloc]init];

        UIViewController * pVC=[newControllers lastObject];
    
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        [UIView animateWithDuration:0.001 animations:^{
            //为堆栈重新赋值
            [self.navigationController setViewControllers:newControllers animated:NO];
        } completion:^(BOOL finished) {
            [pVC.navigationController pushViewController:vc animated:YES];
        }];

        
#pragma mark-继续投注
    }else if (buttonIndex==1){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


#pragma mark - gesture actions
- (void)closePopView:(UITapGestureRecognizer *)recognizer {
    
    MCMSPopView *popView = [MCMSPopView alertInstance];
    
    [popView hideModelWindow];
    
}

#pragma mark==================loadData======================
-(void)loadData{

    [self create_SectionMarr];
    if ([_dataSourceModel.czName containsString:@"秒秒彩"]) {
        self.mmc_paySelectedLotteryFooterView.dataSource=self.dataSourceModel;
    }else{
        self.paySelectedLotteryFooterView.dataSource=self.dataSourceModel;
        _paySelectedLotteryHeaderView.IssueNumber=_IssueNumber;
        _paySelectedLotteryHeaderView.dataSource=_RemainTime;
    }
    
}

-(void)create_SectionMarr{
    [_sectionMarr removeAllObjects];

    for(int i=0 ;i<_dataSourceModel.dataSource.count; i++){
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCPaySelectedLotteryTableViewCell class]);
        model.className=NSStringFromClass([MCPaySelectedLotteryTableViewCell class]);
        model.height = [MCPaySelectedLotteryTableViewCell computeHeight:nil];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = _dataSourceModel.dataSource[i];
        
        SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
        model0.headerhHeight=0.0001;
        model0.footerHeight=10;
        [_sectionMarr addObject:model0];
    }
    
    [_tableView reloadData];
}
#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.headerhHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    if ([cm.className isEqualToString:NSStringFromClass([MCPaySelectedLotteryTableViewCell class])]) {
        
        MCPaySelectedLotteryTableViewCell *ex_cell=(MCPaySelectedLotteryTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        ex_cell.accessoryType = UITableViewCellAccessoryNone;
        ex_cell.delegate = self;
        ex_cell.allowsMultipleSwipe = NO;
        ex_cell.layer.cornerRadius = 5;
        ex_cell.clipsToBounds = YES;
        
#if !TEST_USE_MG_DELEGATE
        
        ex_cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
        ex_cell.rightExpansion.buttonIndex = 1;
        ex_cell.rightExpansion.buttonIndex = -1;
        ex_cell.rightExpansion.fillOnTrigger = YES;
        ex_cell.rightButtons = [self createRightButtons:1];
#endif
        
    }
    return cell;
}

#pragma mark-MCPaySelectedLotteryFooterDelegate-立即开奖
-(void)goToRunLotteryImmediately{

    if ([self.dataSourceModel.payMoney floatValue]*_mmc_paySelectedLotteryFooterView.lianKaiCount<0.0001) {
        [SVProgressHUD showInfoWithStatus:@"付款金额必须大于0元！"];
        return;
    }
    
    if ([self.dataSourceModel.payMoney floatValue]>[self.dataSourceModel.balance floatValue]) {
        [SVProgressHUD showInfoWithStatus:@"余额不足!"];
        return;
    }
    
    MCMSPopView *popView = [MCMSPopView alertInstance];
    [popView hideModelWindow];
    
    NSMutableArray * betMarr=[[NSMutableArray alloc]init];
    
    NSString * BetRebate=@"";
    
    for (MCPaySelectedCellModel * model in _dataSourceModel.dataSource) {
        if (model.BetRebate) {
            BetRebate=model.BetRebate;
        }
        NSDictionary * betDic = @{
                                  @"BetContent":model.tz_haoMa,//投注内容
                                  @"BetCount":model.stakeNumber,//投注注数
                                  @"PlayCode":model.PlayCode,//玩法编码
                                  @"BetRebate":BetRebate,//投注返点
                                  @"BetMoney":model.payMoney,//投注金额
                                  @"BetMultiple":model.multiple,//投注倍数
                                  @"BetMode":model.BetMode//玩法模式
                                  };
        
        [betMarr addObject:betDic];
        
    }
    
    NSDictionary * dic =@{
                          @"UserBetInfo":@{
                                  @"LotteryCode":_dataSourceModel.LotteryID,//彩种编码
                                  @"Bet":betMarr
                                  }
                          
                          };
    
    NSString * tip=[NSString stringWithFormat:@"您选择了%d注,共%@元,请确认",[self.dataSourceModel.stakeNumber intValue],GetRealFloatNum([self.dataSourceModel.payMoney floatValue]*_mmc_paySelectedLotteryFooterView.lianKaiCount)];
    
    MCPopAlertView *mcAlertView = [[MCPopAlertView alloc] initWithType:MCPopAlertTypeTZRequest_Confirm Title:@"投注确认" message:tip leftBtn:@"确认投注" rightBtn:@"取消返回"];
    __weak typeof(self) weakSelf = self;
    mcAlertView.resultIndex = ^(NSInteger index){
        //回调---处理一系列动作x
        if (index==1) {
            MCMMCNewViewController *VC = [[MCMMCNewViewController alloc]init];
            VC.dic=dic;
            VC.lianKaiCount=_mmc_paySelectedLotteryFooterView.lianKaiCount;
            MCMMCPresentationController *PC = [[MCMMCPresentationController alloc] initWithPresentedViewController:VC presentingViewController:self];
            VC.transitioningDelegate = PC;
            [weakSelf presentViewController:VC animated:YES completion:NULL];
        }

    };
    [mcAlertView showXLAlertView];


}



//刷新账户
-(void)refreashUserMoney{
    __weak __typeof__ (self) wself = self;
    [BKIndicationView showInView:self.view];
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [userMoneyModel refreashDataAndShow];
    self.userMoneyModel=userMoneyModel;
    userMoneyModel.callBackSuccessBlock = ^(id manager) {
        [BKIndicationView dismiss];
        wself.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
        wself.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
        wself.dataSourceModel.balance=manager[@"LotteryMoney"];
        [wself.paySelectedLotteryHeaderView setYuE:manager[@"LotteryMoney"]];
    };
    userMoneyModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [BKIndicationView dismiss];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MCMSPopView *popView = [MCMSPopView alertInstance];
    [popView.dataArray removeAllObjects];
    popView.dataArray=nil;
    [popView hideModelWindow];
    [_paySelectedLotteryHeaderView stopTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)alertSucPopViewControllerAnimated{
    [self.navigationController popViewControllerAnimated:NO];
}
@end

















