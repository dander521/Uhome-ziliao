//
//  MCLotteryRecordViewController.m
//  TLYL
//
//  Created by MC on 2017/7/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryRecordViewController.h"
#import "UIView+MCParentController.h"
#import "MCLotteryDrawDetailsViewController.h"
#import "MCHistoryIssueDetailAPIModel.h"
#import "ExceptionView.h"
#import "MCMmcIssueDetailAPIModel.h"
#import "MCDataTool.h"
#import "MCUserDefinedLotteryCategoriesModel.h"

#define HEIGHT_MENU 350
@interface MCLotteryRecordViewController ()
<
MCLotteryRecordDelegate
>
@property (nonatomic,strong)MCHistoryIssueDetailAPIModel *historyIssueDetailAPIModel;
@property (nonatomic,strong)ExceptionView * exceptionView;
@property (nonatomic,strong) MCMmcIssueDetailAPIModel  * mmcIssueDetailAPIModel;

@property (nonatomic,strong)MCUserDefinedLotteryCategoriesModel * model;//
@end

@implementation MCLotteryRecordViewController
//singleton_m(MCLotteryRecordViewController)
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
    NSDictionary * dicCZ=dic[_LotteryCode];
    _model = [MCUserDefinedLotteryCategoriesModel mj_objectWithKeyValues: dicCZ ];
    
    [self createUI];
    
    [self  updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
-(void)createUI{
    
    _view_Record=[[MCLotteryRecordView alloc]initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, HEIGHT_MENU) andModel:self.model];
    _view_Record.delegate=self;
    _view_Record.LotteryCode = self.LotteryCode;
    _view_Record.model = self.model;
    [self.view addSubview:_view_Record];
    
}

-(void)loadData{
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    self.view_Record.upView.backgroundColor=RGB(251, 251, 251);
    MCHistoryIssueDetailAPIModel * historyIssueDetailAPIModel=[MCHistoryIssueDetailAPIModel sharedMCHistoryIssueDetailAPIModel];
//
//    if (historyIssueDetailAPIModel.isNeedUpdate) {
//        
//    }else{
        __weak __typeof(self)wself = self;

        if ([self.LotteryCode isEqualToString:@"50"]) {
            
            MCMmcIssueDetailAPIModel  * mmcIssueDetailAPIModel =[MCMmcIssueDetailAPIModel sharedMCMmcIssueDetailAPIModel];
            mmcIssueDetailAPIModel.LotteryCode=self.LotteryCode;
            mmcIssueDetailAPIModel.Page=1;
            self.mmcIssueDetailAPIModel=mmcIssueDetailAPIModel;
            [BKIndicationView showInView:self.view Point:CGPointMake(G_SCREENWIDTH/2.0, 200)];
            [mmcIssueDetailAPIModel refreashDataAndShow];
            mmcIssueDetailAPIModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
                [BKIndicationView dismissWithCenter:CGPointMake(G_SCREENWIDTH/2.0, 200)];
                wself.historyIssueDetailAPIModel.isNeedUpdate=NO;
                wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
                wself.exceptionView.heightH=310;
                
                ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                    [wself.exceptionView dismiss];
                    wself.exceptionView = nil;
                    [wself loadData];
                }];
                [wself.exceptionView addAction:action];
                [wself.exceptionView showInView:wself.view_Record];
                wself.exceptionView.frame=CGRectMake(0, 0, G_SCREENWIDTH-20, 310);
                wself.exceptionView.center=wself.view_Record.center;
                wself.view_Record.upView.backgroundColor=RGB(255, 255, 255);
            };
            mmcIssueDetailAPIModel.callBackSuccessBlock = ^(id manager) {

                [BKIndicationView dismissWithCenter:CGPointMake(G_SCREENWIDTH/2.0, 200)];
                wself.historyIssueDetailAPIModel.isNeedUpdate=YES;
                NSArray *arr=manager;
                if (arr.count<1) {
                    //无数据展示
                    wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
                    wself.exceptionView.heightH=310;
                    [wself.exceptionView showInView:wself.view_Record];
                    wself.exceptionView.frame=CGRectMake(0, 0, G_SCREENWIDTH-20, 310);
                    wself.exceptionView.center=wself.view_Record.center;
                    wself.view_Record.upView.backgroundColor=RGB(255, 255, 255);
                }else{
                    wself.view_Record.dataSource=manager;
                }
            };
        }else{
            historyIssueDetailAPIModel.LotteryCode=self.LotteryCode;
            historyIssueDetailAPIModel.Page=1;
            self.historyIssueDetailAPIModel=historyIssueDetailAPIModel;
            [BKIndicationView showInView:self.view Point:CGPointMake(G_SCREENWIDTH/2.0, 200)];
            [historyIssueDetailAPIModel refreashDataAndShow];
            historyIssueDetailAPIModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
                [BKIndicationView dismissWithCenter:CGPointMake(G_SCREENWIDTH/2.0, 200)];
                wself.historyIssueDetailAPIModel.isNeedUpdate=NO;
                wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
                wself.exceptionView.heightH=310;
                ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                    [wself.exceptionView dismiss];
                    wself.exceptionView = nil;
                    [wself loadData];
                }];
                [wself.exceptionView addAction:action];
                [wself.exceptionView showInView:wself.view_Record];
                wself.exceptionView.frame=CGRectMake(0, 0, G_SCREENWIDTH-20, 310);
                wself.exceptionView.center=wself.view_Record.center;
                wself.view_Record.upView.backgroundColor=RGB(255, 255, 255);
            };
            historyIssueDetailAPIModel.callBackSuccessBlock = ^(id manager) {
                
                [BKIndicationView dismissWithCenter:CGPointMake(G_SCREENWIDTH/2.0, 200)];
                wself.historyIssueDetailAPIModel.isNeedUpdate=YES;
                NSArray *arr=manager;
                if (arr.count<1) {
                    //无数据展示
                    wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
                    [wself.exceptionView showInView:wself.view_Record];
                    wself.exceptionView.frame=CGRectMake(0, 0, G_SCREENWIDTH-20, 310);
                    wself.exceptionView.center=wself.view_Record.center;
                    wself.view_Record.upView.backgroundColor=RGB(255, 255, 255);
                }else{
                    wself.view_Record.dataSource=manager;
                }
            };
        }
        
        
//    }
}


- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
    
}
/*
 *  查看完整期号
 */
-(void)MCLookAllLotteryRecord{
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        
            MCLotteryDrawDetailsViewController * vc = [[MCLotteryDrawDetailsViewController alloc]init];
            vc.fromClass=NSStringFromClass([[UIView MCcurrentViewController] class]);
            vc.LotteryCode=self.LotteryCode;
            [[UIView MCcurrentViewController].navigationController pushViewController:vc animated:YES];
        
    }];
    
    
}
/*
 * 开奖走势
 */
-(void)MCLookKaiJiangZouShi{
    [SVProgressHUD showInfoWithStatus:@"功能完善中...."];
}

#pragma mark-更新高度
- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    
    self.preferredContentSize = CGSizeMake(G_SCREENWIDTH, HEIGHT_MENU);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
