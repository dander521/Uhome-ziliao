//
//  MCPasswordSettingViewController.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPasswordSettingViewController.h"
#import "MCSlideView.h"
#import "MCPasswordAPIModel.h"
#import "MCHasPayPwdModel.h"
#import "MCLoginViewController.h"
#import "MCGetMerchantInfoModel.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"

@interface MCPasswordSettingViewController ()
<
MCSlideDelegate
>
@property (nonatomic,strong)MCSlideView *segmentedView;
@property (nonatomic,strong)MCPasswordAPIModel * apiModel;
@property (nonatomic,strong)MCHasPayPwdModel * hasPayPwdModel;

@end

@implementation MCPasswordSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}
-(void)createUI{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
    
    self.view.backgroundColor=RGB(242, 242, 242);
    [self createSlide];
    
}

#pragma mark ================================创建Slide
-(void)createSlide{
    
    self.title = @"密码设置";
    NSArray *array = [NSArray arrayWithObjects:@"资金密码",@"登录密码",nil];
    _segmentedView = [MCSlideView segmentControlViewWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT-64)];
    
    _segmentedView.normalColor = RGB(64, 64, 64 );
    _segmentedView.selectedColor = RGB(64, 64, 64 );
    _segmentedView.SlideSelectedColor=RGB(54, 128, 221);
    
    _segmentedView.titleArray = array;
    _segmentedView.selectedTitleArray = array;
    _segmentedView.delegate=self;
    [self.view addSubview:_segmentedView];
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [_segmentedView.collectionView addGestureRecognizer:singleTapGesture];
    
    
    
}
#pragma mark - gesture actions
- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}
    

#pragma mark-MCSlideDelegate /修改登录密码/
-(void)modifyLoginPwdWithDictionary:(NSDictionary *)dic{
    NSLog(@"修改登录密码");
    
    __weak __typeof__ (self) wself = self;
    
    
    MCPasswordAPIModel * apiModel=[[MCPasswordAPIModel alloc]initWithType:ModifyLoginPwd];
    apiModel.LogPassword=dic[@"LogPassword"];
    apiModel.NewPassword=dic[@"NewPassword"];
    self.apiModel=apiModel;
    [BKIndicationView showInView:self.view];
    [apiModel refreashDataAndShow];


    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {

    };
    apiModel.callBackSuccessBlock = ^(id manager) {
        
        [wself successModifyLoginPwd];
    
    };
    
}

-(void)successModifyLoginPwd{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
        
        [[NSUserDefaults standardUserDefaults] setObject:@"logout" forKey:@"logout"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[MCGetMerchantInfoModel sharedMCGetMerchantInfoModel] clearData];
        [MCUserDefinedLotteryCategoriesViewController clearUserDefinedCZ];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MCRefreshMineDataUI];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[MCLoginViewController alloc] init]];
        
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark-MCSlideDelegate /修改资金密码/
-(void)modifyPayPwdWithDictionary:(NSDictionary *)dic{
    
    __weak __typeof__ (self) wself = self;

    NSLog(@"修改资金密码");
    MCPasswordAPIModel * apiModel=[[MCPasswordAPIModel alloc]initWithType:ModifyPayPwd];
    apiModel.LogPassword=dic[@"LogPassword"];
    apiModel.NewPassword=dic[@"NewPassword"];
    self.apiModel=apiModel;
    [BKIndicationView showInView:self.view];
    [apiModel refreashDataAndShow];

    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
    };
    
    apiModel.callBackSuccessBlock = ^(id manager) {
        
        [wself refreshData];
        [SVProgressHUD showInfoWithStatus:@"修改成功"];
        [wself.navigationController popToRootViewControllerAnimated:YES];
        
    };

}

-(void)refreshData{
    __weak __typeof(self)wself = self;


    MCHasPayPwdModel * hasPayPwdModel=[MCHasPayPwdModel sharedMCHasPayPwdModel];
    [hasPayPwdModel refreashDataAndShow];
    self.hasPayPwdModel=hasPayPwdModel;
    hasPayPwdModel.callBackSuccessBlock = ^(id manager) {
        wself.hasPayPwdModel.PayOutPassWord=[NSString stringWithFormat:@"%@",manager[@"PayOutPassWord"]];
        
    };
    
    
    
}


@end
