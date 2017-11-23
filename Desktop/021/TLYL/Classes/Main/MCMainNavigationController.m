//
//  MCMainNavigationController.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMainNavigationController.h"
#import "MCPaySelectedLotteryTableViewController.h"
#import "MCMSPopView.h"
#import "MCMoneyPopView.h"
#import "MCPickNumberViewController.h"
#import "MCPaySelectedLotteryModel.h"
#import "MCBaseSelectedView.h"
#import "MCRechargeViewController.h"
#import "MCMineAddBankCardViewController.h"
#import "MCModifyPayPasswordViewController.h"
#import "MCWithdrawRecDeltailViewController.h"
#import "MCMineInfoModel.h"
#import "MCHasPayPwdModel.h"
#import "MCLoginOutModel.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"
#import "MCGetMerchantInfoModel.h"
#import "MCLoginViewController.h"
#import "MCSystemNoticeViewController.h"
#import "MCGameRecordViewController.h"
#import "UIView+MCParentController.h"
#import "MCPopAlertView.h"
#import "MCModifyUserImgVViewController.h"
#import "MCPersonInformationViewController.h"
#import "MCQiPaizhuanzhangViewController.h"
#import "MCGetSecurityStateModel.h"
#import "MCMSecureSettingViewController.h"
#import "MCTeamMgTabbarController.h"
#import "MCNewActivityViewController.h"
#import "MCHelpCenterViewController.h"

@interface MCMainNavigationController ()
typedef void(^MCMainNavigationControllerCompeletion)(BOOL result, NSDictionary *data );

@property (nonatomic,weak) UIView *coverView;
@property (nonatomic,weak) UIImageView * screenImgV;
@property (nonatomic,weak) MCBaseSelectedView *selectedView;
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong)MCLoginOutModel  * loginOutModel;
@property (nonatomic,strong)MCGetSecurityStateModel * getSecurityStateModel;
@end

@implementation MCMainNavigationController
- (UIView *)coverView{
    if (_coverView == nil) {
        UIView *coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:coverView];
        coverView.backgroundColor = [RGB(35, 16, 51) colorWithAlphaComponent:1];
        MCBaseSelectedView *selectedView =[[MCBaseSelectedView alloc]init];
        [coverView addSubview:selectedView];
        UIImageView * screenImgV=[[UIImageView alloc]init];
        screenImgV.frame=CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);
        screenImgV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
        [screenImgV addGestureRecognizer:tap];
        _screenImgV=screenImgV;
        [coverView addSubview:_screenImgV];
        selectedView.frame=CGRectMake(0, 0, G_SCREENWIDTH, 300);
        selectedView.block = ^(NSInteger type) {
            [self MCBaseSelectedViewActionHandlerWithType:type];
        };
        _selectedView=selectedView;
        _coverView = coverView;
    }
    return _coverView;
}

-(void)MCBaseSelectedViewActionHandlerWithType:(NSInteger)tag{
    UIViewController *vc = nil;
//    NSLog(@"%lu",self.tabBarController.selectedIndex);
    __weak __typeof(self)wself = self;
    if (tag==1001) {//充值
        [self coverViewClick];
        MCRechargeViewController * VC =[[MCRechargeViewController alloc]init];
        [self pushViewController:VC animated:YES];
    }else if(tag==1002){//提款
        [self coverViewClick];
        [self goToWithdrawViewController];
    }else if(tag==1003){//转账
        [self coverViewClick];
        MCQiPaizhuanzhangViewController * VC =[[MCQiPaizhuanzhangViewController alloc]init];
        [self pushViewController:VC animated:YES];
        
    }else if(tag==2000){//购彩大厅
        [self coverViewClick];
        self.tabBarController.selectedIndex = 1;
    }else if(tag==2001){//优惠活动
        [self coverViewClick];
         vc = [[MCNewActivityViewController alloc] init];
        [self pushViewController:vc animated:YES];
    }else if(tag==2002){//会员中心
 
        MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
        if (mineInfoModel.IsAgent==NO) {
            [SVProgressHUD showInfoWithStatus:@"你不是代理用户,没有权限操作此功能!"];
            return;
        }
        [self coverViewClick];
        vc  = [[MCTeamMgTabbarController alloc] init];
        [self pushViewController:vc animated:YES];

    }else if(tag==2003){//系统公告

        [self coverViewClick];
        MCSystemNoticeViewController * vc=[[MCSystemNoticeViewController alloc]init];
        [self pushViewController:vc animated:YES];

    }else if (tag==2004){//开奖公告

        [self coverViewClick];
        self.tabBarController.selectedIndex = 2;
        
    }else if (tag==2005){//游戏记录

        [self coverViewClick];
        if (self.tabBarController.selectedIndex==3) {
            MCGameRecordViewController * vc=[[MCGameRecordViewController alloc]init];
            [self pushViewController:vc animated:YES];
        }else{
            self.tabBarController.selectedIndex = 3;
            [UIView animateWithDuration:0.001 animations:^{
            } completion:^(BOOL finished) {
                MCGameRecordViewController * vc=[[MCGameRecordViewController alloc]init];
                [[UIView MCcurrentViewController].navigationController pushViewController:vc animated:NO];
            }];
            
        }
        
        
        
    }else if(tag==2006){//彩票走势
 
        [SVProgressHUD showInfoWithStatus: @"功能完善中..."];
    }else if (tag==2007){//使用帮助
        [self coverViewClick];
        MCHelpCenterViewController * hVc= [[MCHelpCenterViewController alloc]init];
        [self pushViewController:hVc animated:YES];

    }else if (tag==2008){//在线客服

         [SVProgressHUD showInfoWithStatus: @"功能完善中..."];
    }else if (tag==2009){//修改头像
        [self coverViewClick];
        MCModifyUserImgVViewController *ivc  = [[MCModifyUserImgVViewController alloc] init];
        ivc.userImgBlock = ^{
            [wself.selectedView refreashImgVIcon];
        };
        [self pushViewController:ivc animated:YES];

    }else if (tag==2010){//修改昵称
        [self coverViewClick];
        MCPersonInformationViewController * VC =[[MCPersonInformationViewController alloc]init];
        [self pushViewController:VC animated:YES];

    }else if (tag==3000){//退出登录
        [self coverViewClick];
        [self performLogOut];
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


/*
 * 跳转提现
 */
-(void)goToWithdrawViewController{
    MCMineInfoModel * mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    MCHasPayPwdModel *hasPayPwdModel = [MCHasPayPwdModel sharedMCHasPayPwdModel];
    if ([mineInfoModel.UserType intValue] ==1) {
        [SVProgressHUD showInfoWithStatus:@"试玩账号不能提款!"];
        return;
    }
    BOOL hasCard = [mineInfoModel.BankCardNumber length]>1?YES:NO;
    BOOL hasPassword = [hasPayPwdModel.PayOutPassWord intValue]==1?YES:NO;
    
    /*
     * 情况一： 无资金密码  无默认银行卡
     */
    if (!hasCard&&!hasPassword) {
        [SVProgressHUD showInfoWithStatus:@"请先完善银行卡！"];
        //先绑卡-》设置资金密码-》退回我的
        [self coverViewClick];
        MCMineAddBankCardViewController * vc=[[MCMineAddBankCardViewController alloc]init];
        vc.type=NOPasswordAndNOCard;
        self.navigationBarHidden=NO;
        [self pushViewController:vc animated:YES];
        
        //情况二： 有资金密码  无默认银行卡
    }else if (hasPassword&&!hasCard){
        
        //先绑卡-》退回我的
        [self coverViewClick];
        MCMineAddBankCardViewController * vc=[[MCMineAddBankCardViewController alloc]init];
        vc.type=HasPasswordAndNOCard;
        self.navigationBarHidden=NO;
        [self pushViewController:vc animated:YES];
        
        //情况三： 无资金密码  有默认银行卡
    }else if (!hasPassword&&hasCard){
        MCGetSecurityStateModel * getSecurityStateModel = [MCGetSecurityStateModel sharedMCGetSecurityStateModel];
        if (getSecurityStateModel.hadSecurityState.length>0) {
            if ([getSecurityStateModel.hadSecurityState integerValue]==1) {
                //设置资金密码-》退回我的
                
                [SVProgressHUD showInfoWithStatus:@"请先设置资金密码！"];
                [self coverViewClick];
                MCModifyPayPasswordViewController * vc =[[MCModifyPayPasswordViewController alloc]init];
                self.navigationBarHidden=NO;
                [self pushViewController:vc animated:YES];
            }else{
                //设置密保
                [self coverViewClick];
                [SVProgressHUD showInfoWithStatus:@"请先设置密保！"];
                MCMSecureSettingViewController *svc=[[MCMSecureSettingViewController alloc]init];
                svc.Type = MCMSecureSettingType_FirstSet;
                self.navigationBarHidden=NO;
                [self pushViewController:svc animated:YES];
            }
        }else{
            __weak __typeof(self)wself = self;
            [self GetSecurityState:^(BOOL result, NSDictionary *data) {
                wself.getSecurityStateModel.hadSecurityState=data[@"Result"];
                if ([wself.getSecurityStateModel.hadSecurityState integerValue]==1) {
                    //设置资金密码-》退回我的
                    [self coverViewClick];
                    [SVProgressHUD showInfoWithStatus:@"请先设置资金密码！"];
                    MCModifyPayPasswordViewController * vc =[[MCModifyPayPasswordViewController alloc]init];
                    self.navigationBarHidden=NO;
                    [self pushViewController:vc animated:YES];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"加载失败！"];
                }
            }];
        }
        
        //情况四： 有资金密码  有默认银行卡
    }else{
        [self coverViewClick];
        MCWithdrawRecDeltailViewController * vc=[[MCWithdrawRecDeltailViewController alloc]init];
        self.navigationBarHidden=NO;
        [self pushViewController:vc animated:YES];
    }
    
}

-(void)GetSecurityState:(MCMainNavigationControllerCompeletion)Compeletion{
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

+(void)load{

  UINavigationBar *bar =[UINavigationBar appearance];
    bar.barTintColor = MC_ColorWithAlpha(144, 8, 215, 1);
    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:MC_REALVALUE(18)]};
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.navigationController.navigationBarHidden=NO;
    viewController.navigationController.navigationBar.translucent = NO;
    MCMoneyPopView *popView = [MCMoneyPopView alertInstance];
    [popView hideModelWindow];
    MCMSPopView *popView1 = [MCMSPopView alertInstance];
    [popView1 hideModelWindow];
    if (self.childViewControllers.count == 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"home-icon-more"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"home-icon-more"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(80, 44);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(personInfoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    } else {
        
    }
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"图层-6"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"图层-6"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        if ([viewController isKindOfClass:[MCPickNumberViewController class]]) {
            [button addTarget:self action:@selector(popBackToViewController) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        }
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}
- (void)personInfoBtnClick:(UIButton *)btn{

    _isOpen=!_isOpen;
    if (_isOpen) {
        self.coverView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat K=1.0*(G_SCREENWIDTH-40.0)/G_SCREENWIDTH;
            _screenImgV.frame=CGRectMake(20, 305, G_SCREENWIDTH-40, G_SCREENHEIGHT*K);
            self.screenImgV.image=[self getSnapshotImage];
            [self.selectedView reloadData];
            [self.selectedView refreashImgVIcon];
        } completion:^(BOOL finished) {
            self.tabBarController.tabBar.hidden = YES;
        }];
       
    } else {
        
        self.tabBarController.tabBar.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _screenImgV.frame=CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);
        } completion:^(BOOL finished) {
            self.coverView.hidden = YES;
        }];
    }
}
- (void)coverViewClick{
    _isOpen=NO;
    self.tabBarController.tabBar.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _screenImgV.frame=CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
    }];
}
- (void)popBackToViewController{
    
    MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    if (model.dataSource.count == 0) {
        [self popViewControllerAnimated:YES];
        return;
    }
    MCPopAlertView *mcAlertView = [[MCPopAlertView alloc] initWithType:MCPopAlertTypeTZRequest_Confirm Title:@"提示" message:@"返回将清空已选号码，确定返回吗？" leftBtn:@"确定" rightBtn:@"取消"];
    
    mcAlertView.resultIndex = ^(NSInteger index){
        if (index==1) {
            /*
             * 清空购彩蓝
             */
            
            [model removeDataSource];
            
            [self popViewControllerAnimated:YES];
        }
    };
    [mcAlertView showXLAlertView];
 
}

-(UIImage *)captureImageFromViewLow:(UIView *)orgView {
    //获取指定View的图片
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [orgView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)getSnapshotImage{
    return [self captureImageFromViewLow:self.view];
}

@end
