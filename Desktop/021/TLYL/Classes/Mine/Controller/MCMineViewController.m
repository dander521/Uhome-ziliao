//
//  MCMineViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineViewController.h"
#import "MCMineHeaderView.h"
#import "MCMineTableviewCell.h"
#import "MCMineCellModel.h"
#import "MCSettingViewController.h"
#import "MCMineTitleModel.h"
#import "MCRechargeViewController.h"
#import "MCTopUpRecordViewController.h"
#import "MCWithdrawRecordViewController.h"
#import "MCGameRecordViewController.h"
#import "MCWithdrawRecDeltailViewController.h"
#import "UIImage+Extension.h"
#import "MCMineInfoModel.h"
#import "MCUserMoneyModel.h"
#import "MCHasPayPwdModel.h"
#import "MCMineAddBankCardViewController.h"
#import "MCModifyPayPasswordViewController.h"
#import "UINavigationBar+Awesome.h"
#import "MCLoginViewController.h"
#import "MCLoginOutModel.h"
#import "MCGetMerchantInfoModel.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"
#import "MCZhuihaoRecordViewController.h"
#import "MCTeamMgTabbarController.h"
#import "MCZhuihaoRecordViewController.h"
#import "MCZhangBianRecordViewController.h"
#import "MCPersonReportViewController.h"
#import "MCzhongJiangRecoredViewController.h"
#import "MCQiPaizhuanzhangViewController.h"
#import "MCQiPaiReportViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MCKaiHuCenterViewController.h"
#import "MCContractMgTabbarController.h"
#import "MCModifyUserImgVViewController.h"
#import "MCPersonInformationViewController.h"
#import "MCMailCenterViewController.h"
#import "MCEmailCountModel.h"
#import "MCGetSecurityStateModel.h"
#import "MCMSecureSettingViewController.h"
#import "MCNewActivityViewController.h"

#define MInAlpha   0.01
#define NAVCOLOR   RGB(144,8,215);
#define NAVBAR_CHANGE_POINT 10
@interface MCMineViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MCMineHeaderViewDelegate,
MCMineCellDelegate,
UINavigationControllerDelegate
>
typedef void(^MCMineViewControllerCompeletion)(BOOL result, NSDictionary *data );

/**headerView*/
@property (nonatomic,strong)MCMineHeaderView * headerView;
/**tableView*/
@property(nonatomic, strong)UITableView *tableView;
/**sectionMarr*/
@property(nonatomic, strong)NSMutableArray*sectionMarr;
@property (nonatomic,weak) UIButton * newsBtn;
/*
 * Api数据模型
 */
/**获取用户详情*/
@property (nonatomic,strong) MCMineInfoModel *mineInfoModel;
/**查询用户余额及冻结金额*/
@property (nonatomic,strong) MCUserMoneyModel *userMoneyModel;
/**查询用户是否已设置资金密码*/
@property (nonatomic,strong) MCHasPayPwdModel *hasPayPwdModel;
@property (nonatomic,strong) MCGetMerchantInfoModel * getMerchantInfoModel;
@property (nonatomic,strong) MCLoginOutModel  * loginOutModel;
//查询是否已设置密保问题
@property (nonatomic,strong) MCGetSecurityStateModel * getSecurityStateModel;
@property (nonatomic,strong) MCEmailCountModel *countModel;

@property (nonatomic, strong) UIView *navBgView;

@property (nonatomic, weak) UILabel *redNewsLabel;


@end

@implementation MCMineViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"账户";
    [self setProperty];
    
    [self createUI];
    
    [self createSectionMarr];
    
    [self requestForUI];
    [self refreshData_HasPayPwd];
    [self refreshData_UserMoney];
    
}

- (void)setNavBar{

    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, G_SCREENWIDTH-100, 64)];
    [self.navigationController.navigationBar addSubview:navBgView];
    self.navBgView = navBgView;
    navBgView.backgroundColor = [UIColor clearColor];
    
    
    UILabel * labTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 7, G_SCREENWIDTH-200, 30)];
    labTitle.text=@"我的账户";
    labTitle.font=[UIFont systemFontOfSize:18];
    labTitle.textColor=[UIColor whiteColor];
    labTitle.textAlignment=NSTextAlignmentCenter;
    
    UIButton * settingBtn=[[UIButton alloc]init];
    [settingBtn setImage:[UIImage imageNamed:@"Gear"] forState:UIControlStateNormal];
    settingBtn.frame=CGRectMake(G_SCREENWIDTH-100-18-22, 11, 22, 22);
    [settingBtn addTarget:self action:@selector(goToSettingViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * newsBtn=[[UIButton alloc]init];
    [newsBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
    newsBtn.frame=CGRectMake(G_SCREENWIDTH-100-18-22-18-22, 11, 22, 22);
    [newsBtn addTarget:self action:@selector(goToNewsViewController) forControlEvents:UIControlEventTouchUpInside];
    self.newsBtn = newsBtn;
    
    UILabel *redNewsLabel = [[UILabel alloc] init];
    [newsBtn addSubview:redNewsLabel];
    self.redNewsLabel = redNewsLabel;
    redNewsLabel.hidden = YES;
    redNewsLabel.textAlignment = NSTextAlignmentCenter;
    redNewsLabel.layer.cornerRadius = MC_REALVALUE(6);
    redNewsLabel.clipsToBounds = YES;
    redNewsLabel.backgroundColor = [UIColor redColor];
    redNewsLabel.textColor = [UIColor whiteColor];
    redNewsLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
    [redNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newsBtn.mas_right).offset(MC_REALVALUE(-5));
        make.height.width.equalTo(@(MC_REALVALUE(12)));
        make.bottom.equalTo(newsBtn.mas_top).offset(MC_REALVALUE(5));
    }];
    
#pragma mark 这部是关键
    [navBgView addSubview:labTitle];
    [navBgView addSubview:settingBtn];
    [navBgView addSubview:newsBtn];
    
    
}

#pragma mark-@protocol UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    UIColor * color = NAVCOLOR;
    CGFloat offsetY = scrollView.contentOffset.y ;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        if (alpha<MInAlpha) {
            alpha=MInAlpha;
        }
#pragma mark HaveHiddenAnimation
        //begin
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        //end
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        
    } else if(offsetY < 0 ){
#pragma mark HaveHiddenAnimation
        //begin
                [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
        //end
        
        
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:MInAlpha]];
    }else{
#pragma mark HaveHiddenAnimation
        //begin
                [self.navigationController setNavigationBarHidden:NO animated:YES];
        //end
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:MInAlpha]];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString * K_RefreshMineDataUI =[[NSUserDefaults standardUserDefaults] objectForKey:MCRefreshMineDataUI];
    if ([K_RefreshMineDataUI isEqualToString:@"1"]) {
        [self requestForUI];
    }
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.navigationController.automaticallyAdjustsScrollViewInsets=NO;
        
    }
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    /*
     * 每次进入这个页面   都重新刷新
     */
    NSString  *Token= [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    if (Token.length<1) {
    }else{
        [self refreshData_EmailCount];
    }
    
    //设置当前控制器显示的title
//    self.title = @" ";
    //设置tab显示的title
    
    
    //在下级页面有的需要隐藏当行栏-->所以在这显示出来
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.delegate = self;
    //取消导航栏最下面的那一条线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
#pragma mark HaveHiddenAnimation ->当有隐藏和消失的动画时需要加这个(如无此效果,可全局搜索前面的英文定义进行删除,begin-->end ,不影响效果)
    //begin
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white_7"] forBarMetrics:UIBarMetricsDefault];
    //end
    [self setNavBar];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MCPaySLBaseModel * dataSourceModel=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    [dataSourceModel removeDataSource];
    
#pragma mark 这块我也不明白为什么取消了代理就好使了....
    self.tableView.delegate = nil;
    
    [self.navigationController.navigationBar lt_reset];
    [self.navBgView removeFromSuperview];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

#pragma mark==================setProperty======================
-(void)setProperty{
    //    Command选中点击进去发现，automaticallyAdjustsScrollViewInsets这个属性已经过期了
    //    而且是用了新属性contentInsetAdjustmentBehavior来代替。
    //    因此，要做个版本判断：
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.navigationController.automaticallyAdjustsScrollViewInsets=NO;
        
    }
    self.view.backgroundColor=RGB(231, 231, 231);
    _sectionMarr= [[NSMutableArray alloc]init];
}

#pragma mark==================createUI======================
-(void)createUI{

    _headerView=[[MCMineHeaderView alloc]init];
    _headerView.delegate=self;
    _headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, [MCMineHeaderView computeHeight:nil]);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreashData];
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    
    
}
#pragma mark-下拉刷新
-(void)refreashData{
    
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.8];
    [self requestForUI];
    [self refreshData_UserMoney];
    [self refreshData_HasPayPwd];
    [self refreshData_EmailCount];
    
}
-(void)delayMethod{
    [self.tableView.mj_header endRefreshing];
}

#pragma mark==================loadData======================
-(void)createSectionMarr{
    
    [_sectionMarr removeAllObjects];
    
    CellModel* model =[[CellModel alloc]init];
    model.reuseIdentifier = [NSString stringWithFormat:@"%@",NSStringFromClass([MCMineTableviewCell class])];
    model.className=NSStringFromClass([MCMineTableviewCell class]);
    model.height = [MCMineTableviewCell computeHeight:nil];
    model.selectionStyle=UITableViewCellSelectionStyleNone;
    model.accessoryType=UITableViewCellAccessoryNone;
    /*
     * 传递参数
     */
    model.userInfo = nil;
    
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
    model0.headerhHeight=0.0001;
    model0.footerHeight=10;
    [_sectionMarr addObject:model0];
    [_tableView reloadData];
  
}

-(void)refreshData_UserMoney{
    __weak __typeof(self)wself = self;
    MCUserMoneyModel *userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    self.userMoneyModel=userMoneyModel;
    if (userMoneyModel.FreezeMoney&&userMoneyModel.LotteryMoney) {
        //可用余额
        [wself.headerView setAccountBalance:userMoneyModel.LotteryMoney];
        //冻结金额
        [wself.headerView setFrozenAccount:userMoneyModel.FreezeMoney];
    }
    [userMoneyModel refreashDataAndShow];
    userMoneyModel.callBackSuccessBlock = ^(id manager) {
        [BKIndicationView dismiss];
        //可用余额
        [wself.headerView setAccountBalance:manager[@"LotteryMoney"]];
        wself.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
        //冻结金额
        [wself.headerView setFrozenAccount:manager[@"FreezeMoney"]];
        wself.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
    };
    userMoneyModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [BKIndicationView dismiss];
    };
}

-(void)refreshData_HasPayPwd{
    __weak __typeof(self)wself = self;
    MCHasPayPwdModel * hasPayPwdModel=[MCHasPayPwdModel sharedMCHasPayPwdModel];
    [hasPayPwdModel refreashDataAndShow];
    self.hasPayPwdModel=hasPayPwdModel;
    hasPayPwdModel.callBackSuccessBlock = ^(id manager) {
        wself.hasPayPwdModel.PayOutPassWord=[NSString stringWithFormat:@"%@",manager[@"PayOutPassWord"]];
    };
}

-(void)refreshData_EmailCount{
    __weak __typeof(self)wself = self;
    MCEmailCountModel *countModel=[[MCEmailCountModel alloc] init];
    self.countModel = countModel;
    [countModel refreashDataAndShow];
    countModel.callBackSuccessBlock = ^(id manager) {

        if ([manager[@"Count"] intValue] >0) {
            wself.redNewsLabel.hidden = NO;
            wself.redNewsLabel.text =[NSString stringWithFormat:@"%d",[manager[@"Count"] intValue]];
            if ([manager[@"Count"] intValue] >9) {
                
                [wself.redNewsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(wself.newsBtn.mas_right).offset(MC_REALVALUE(-5));
                    make.height.equalTo(@(MC_REALVALUE(12)));
                    make.width.equalTo(@(MC_REALVALUE(22)));
                    make.bottom.equalTo(wself.newsBtn.mas_top).offset(MC_REALVALUE(5));
                }];
                
            }
            if ([manager[@"Count"] intValue] >99) {
                [wself.redNewsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(wself.newsBtn.mas_right).offset(MC_REALVALUE(-5));
                    make.height.equalTo(@(MC_REALVALUE(12)));
                    make.width.equalTo(@(MC_REALVALUE(33)));
                    make.bottom.equalTo(wself.newsBtn.mas_top).offset(MC_REALVALUE(5));
                }];
                wself.redNewsLabel.text =@"99+";
            }
        }
    };
}

#pragma mark-http【获取商户信息  用户信息-》这两个接口用来构建UI】
-(void)requestForUI{

    __weak __typeof(self)wself = self;
    MCGetMerchantInfoModel *model = [MCGetMerchantInfoModel sharedMCGetMerchantInfoModel];
    
    [model refreashDataAndShow];
    self.getMerchantInfoModel = model;
    model.callBackFailedBlock = ^(id manager, NSString *errorCode) {
    };
    model.callBackSuccessBlock = ^(id manager) {
        [wself.tableView reloadData];
        wself.headerView.dataSource=wself.mineInfoModel;
    };
    
    MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    self.mineInfoModel = mineInfoModel;
    if (mineInfoModel.UserRealName) {
        wself.headerView.dataSource=wself.mineInfoModel;
    }
    [mineInfoModel refreashDataAndShow];
    mineInfoModel.callBackSuccessBlock = ^(id manager) {
        wself.mineInfoModel=[MCMineInfoModel mj_objectWithKeyValues:manager];
        wself.headerView.dataSource=wself.mineInfoModel;
        [wself.tableView reloadData];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:MCRefreshMineDataUI];
    };
    [self GetSecurityState:^(BOOL result, NSDictionary *data) {
    }];
    
}

-(void)GetSecurityState:(MCMineViewControllerCompeletion)Compeletion{
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MCMineTableviewCell computeHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    if ([cm.className isEqualToString:NSStringFromClass([MCMineTableviewCell class])]) {
        MCMineTableviewCell *ex_cell=(MCMineTableviewCell *)cell;
        ex_cell.delegate=self;
        ex_cell.dataSource=cm.userInfo;
        [ex_cell refreashCellListUI];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark==================MCMineHeaderViewDelegate======================
/*
 * 跳转设置界面
 */
-(void)goToSettingViewController{
    
    MCSettingViewController * vc=[[MCSettingViewController alloc]init];
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
 * 跳转消息界面
 */
-(void)goToNewsViewController{
    
    MCMailCenterViewController *mailCenterVC = [[MCMailCenterViewController alloc] init];
    [self.navigationController pushViewController:mailCenterVC animated:YES];
    
}


/*
 * 跳转充值界面
 */
-(void)goToRechargeViewController{
    
    if ([self.mineInfoModel.UserType intValue] ==1) {
        [SVProgressHUD showInfoWithStatus:@"试玩账号不能充值!"];
        return;
    }
    
    MCRechargeViewController * vc = [[MCRechargeViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark-跳转提现
-(void)goToWithdrawViewController{
    
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
    
}
#pragma mark-  /退出登录/
-(void)performLogOut{
    __weak __typeof__ (self) wself = self;
    
    MCCancelPopView * popView=[MCCancelPopView InitPopViewWithTitle:@"确定要退出登录吗？" sureTitle:@"确定" andCancelTitle:@"取消"];
    [popView show];
    popView.block = ^(NSInteger type) {
        if (type==1) {
            [wself requestLoginOut];
        }
    };

}

-(void)requestLoginOut{
    MCLoginOutModel  * loginOutModel =[[MCLoginOutModel alloc]init];
    [loginOutModel refreashDataAndShow];
    self.loginOutModel=loginOutModel;
    loginOutModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [[NSUserDefaults standardUserDefaults] setObject:@"logout" forKey:@"logout"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[MCGetMerchantInfoModel sharedMCGetMerchantInfoModel] clearData];
        [MCUserDefinedLotteryCategoriesViewController clearUserDefinedCZ];
        MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
        mineInfoModel = nil;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MCRefreshMineDataUI];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[MCLoginViewController alloc] init]];
    };
    loginOutModel.callBackSuccessBlock = ^(id manager) {
        [[NSUserDefaults standardUserDefaults] setObject:@"logout" forKey:@"logout"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[MCGetMerchantInfoModel sharedMCGetMerchantInfoModel] clearData];
        [MCUserDefinedLotteryCategoriesViewController clearUserDefinedCZ];
        MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
        mineInfoModel = nil;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MCRefreshMineDataUI];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[MCLoginViewController alloc] init]];
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
 * 跳转界面
 */
-(void)goToViewControllerWithType:(NSString *)type{
    UIViewController * vc = nil;
    __weak __typeof(self)wself = self;
    if ([type isEqualToString:@"充值"]) {
        
        [self goToRechargeViewController];
        return;
        
    }else if([type isEqualToString:@"提款"]){
        
        [self goToWithdrawViewController];
        return;
    }else if([type isEqualToString:@"转账"]){
        vc  = [[MCQiPaizhuanzhangViewController alloc] init];

        
    }else if([type isEqualToString:@"投注记录"]){
        vc  = [[MCGameRecordViewController alloc] init];
        
    }else if([type isEqualToString:@"追号记录"]){
        
        vc  = [[MCZhuihaoRecordViewController alloc] init];
        
    }else if([type isEqualToString:@"帐变记录"]){
        
        vc  = [[MCZhangBianRecordViewController alloc] init];
    }else if([type isEqualToString:@"中奖记录"]){
        vc  = [[MCzhongJiangRecoredViewController alloc] init];
    }else if([type isEqualToString:@"修改头像"]){
        MCModifyUserImgVViewController *ivc  = [[MCModifyUserImgVViewController alloc] init];
        ivc.userImgBlock = ^{
            wself.mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
            wself.headerView.dataSource=wself.mineInfoModel;
        };
        self.navigationController.navigationBarHidden=NO;
        [self.navigationController pushViewController:ivc animated:YES];
        return;
    }else if([type isEqualToString:@"修改昵称"]){
        vc  = [[MCPersonInformationViewController alloc] init];
    }
    
    
    if (vc == nil) {
        [SVProgressHUD showInfoWithStatus: @"功能完善中..."];
        return;
    }
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark-MCMineCellDelegate  /点击Cell跳转/
-(void)cellDidSelectWithType:(NSString *)type{
    
    UIViewController * vc = nil;
    if ([type isEqualToString:@"资金明细"]) {
        
        vc = [[MCTopUpRecordViewController alloc] init];
        
    }else if ([type isEqualToString:@"优惠活动"]){
        vc = [[MCNewActivityViewController alloc] init];
        
    }else if ([type isEqualToString:@"精准开户"]){
         vc = [[MCKaiHuCenterViewController alloc] init];
        
    }else if ([type isEqualToString:@"代理管理"]){
         MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
        if (mineInfoModel.IsAgent==NO) {
            [SVProgressHUD showInfoWithStatus:@"你不是代理用户,没有权限操作此功能!"];
            return;
        }
       vc  = [[MCTeamMgTabbarController alloc] init];
        
    }else if ([type isEqualToString:@"契约管理"]){
        vc = [[MCContractMgTabbarController alloc]init];
        
    }else if ([type isEqualToString:@"我的报表"]){
        
        vc  = [[MCPersonReportViewController alloc] init];
    }else if ([type isEqualToString:@"棋牌报表"]){
        
        vc  = [[MCQiPaiReportViewController alloc] init];
    }
    if (vc == nil) {
        [SVProgressHUD showInfoWithStatus: @"功能完善中..."];
        return;
    }
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end











































