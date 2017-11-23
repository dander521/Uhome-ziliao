//
//  MCMMCNewViewController.m
//  TLYL
//
//  Created by MC on 2017/7/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMCNewViewController.h"
#import "UIView+MCParentController.h"
#import "MCPaySelectedLotteryTableViewController.h"
#import "MCBetModel.h"
#import "MCUserMoneyModel.h"
#import "MCMMCKaiJiangView.h"
#import "MCMMCSuccessView.h"
#import "MCMMCFaildView.h"
#import "MMCHeader.h"

@interface MCMMCNewViewController ()

@property (nonatomic,strong)NSTimer * timer;

@property (nonatomic,strong)MCMMCKaiJiangView * kaiJiangView;
@property (nonatomic,strong)MCMMCSuccessView * successView;
@property (nonatomic,strong)MCMMCFaildView  * faildView;
@property (nonatomic,assign)int allKaiJiangCount;

@property (nonatomic,strong)MCBetModel *betModel;

/*
 * 奖金的总和
 */
@property (nonatomic,assign)float  allBouns;
//当前开奖号码
@property (nonatomic,strong)NSString * DrawResult;

@end


@implementation MCMMCNewViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self  updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    
    [self setProperty];
    
    [self  createUI];
    
    [self loadData];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    _allBouns = 0;
    
}

-(void)setProperty{
    
    _allBouns=0;
    _allKaiJiangCount=_lianKaiCount;
    self.view.backgroundColor=[UIColor  clearColor];
   
}


-(void)createUI{
    __weak __typeof(self)wself = self;
    
    _kaiJiangView=[[MCMMCKaiJiangView alloc]init];
    [self.view addSubview:_kaiJiangView];
    _kaiJiangView.frame=CGRectMake(0,0,W_MMC_VIEW,H_MMC_VIEW);
#pragma mark-停止开奖
    _kaiJiangView.block = ^{
        [wself stopKaiJiang];
    };
    
    
    _successView= [[MCMMCSuccessView alloc]init];
    _successView.hidden=YES;
    _successView.frame=CGRectMake(0,0,W_MMC_VIEW,H_MMC_VIEW);
    [self.view addSubview:_successView];
#pragma mark-返回选号界面
    _successView.block = ^{
        [wself GobackToPickNumber];
    };
    
    
    _faildView= [[MCMMCFaildView alloc]init];
    _faildView.hidden=YES;
    _faildView.frame=CGRectMake(0,0,W_MMC_VIEW,H_MMC_VIEW);
    [self.view addSubview:_faildView];
#pragma mark-返回选号界面
    _faildView.block = ^{
        [wself GobackToPickNumber];
    };
}



#pragma mark-添加定时器
-(void)add_timer{
    _timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(timerAction_KaiJiang) userInfo:nil repeats:YES];
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    [currentRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];

}

-(void)timerAction_KaiJiang{
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        [marr addObject:[NSString stringWithFormat:@"%d",arc4random()%10]];
    }
    NSString * dataSource = [marr componentsJoinedByString:@","];
    _kaiJiangView.dataSource=dataSource;

}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
    
}

#pragma mark-更新高度
- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    
    self.preferredContentSize = CGSizeMake(300, 150);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadData{
    _kaiJiangView.lab_title.text=[NSString stringWithFormat:@"第 %.2d 次开奖",_allKaiJiangCount-_lianKaiCount+1];
    [self  add_timer];
    
    /*
     * 网络请求
     */
    __weak __typeof__ (self) wself = self;
    MCBetModel *betModel = [[MCBetModel alloc] initWithDic:_dic];
    self.betModel=betModel;
    [BKIndicationView showInView:self.view];
    [betModel refreashDataAndShow];
    
    betModel.callBackFailedBlock = ^(ApiBaseManager *manager, id errorCode) {
        [BKIndicationView dismiss];
        NSLog(@"errorCode-------------%@",errorCode);
        if ([errorCode isKindOfClass:[NSDictionary class]]) {
            NSString * code=[NSString stringWithFormat:@"%@",errorCode[@"code"]];
            if ([code isEqualToString:@"510"]) {
                [SVProgressHUD showInfoWithStatus:@"该彩种已经停售！"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"投注失败！"];
            }
        }
        
        [wself stopKaiJiang];
        
    };
    betModel.callBackSuccessBlock = ^(id manager) {
        [BKIndicationView dismiss];
        //        AwardMoney = 0;
        //        DrawResult = "3,8,2,3,8";
        //        Isaward = 0;
        //        IssueNumber = 20170810150536179;
        //        OrderID = BGIcwirZwQkPJLc;
        NSArray * arr=manager;
        [wself performSelector:@selector(ShowKaiJiang:) withObject:arr /*可传任意类型参数*/ afterDelay:2.0];
    };
    --_lianKaiCount;
    
}


-(void)ShowKaiJiang:(NSArray *)arr{
    
    for (NSDictionary *manager in arr) {
        if ([manager[@"Isaward"] intValue]==1) {
            
            _allBouns=_allBouns+[manager[@"AwardMoney"] floatValue];
            
        }
    }
    NSDictionary *manager=arr[0];
    
    NSLog(@"--haoMa-%@--",manager[@"DrawResult"]);
    _DrawResult=manager[@"DrawResult"];
    
    [_timer invalidate];
    _timer = nil;
    
    _kaiJiangView.dataSource=manager[@"DrawResult"];

    if (_lianKaiCount>0) {
        [self performSelector:@selector(loadData) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
    }else{
        [self performSelector:@selector(DelaybackToPickNumber) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        
    }
    
}
-(void)DelaybackToPickNumber{
    [self backToPickNumber];
}
#pragma mark-停止开奖
-(void)stopKaiJiang{
    _lianKaiCount=0;
    [_timer invalidate];
    _timer = nil;
    [self backToPickNumber];
}

-(void)backToPickNumber{
    
    
    if (_allBouns > 0) {
        
        _kaiJiangView.hidden=YES;
        _successView.hidden=NO;
        _successView.lab_title.text=[NSString stringWithFormat:@"恭喜中奖，奖金 %@ 元",GetRealFloatNum(_allBouns)];
        [_successView startTimer];
        _successView.dataSource=_DrawResult;
        
    }else{
        
        
        _kaiJiangView.hidden=YES;
        _faildView.hidden=NO;
        [_faildView startTimer];
        _faildView.dataSource=_DrawResult;
        
    }
    
    
    _lianKaiCount=0;
    [_timer invalidate];
    _timer = nil;
    
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    userMoneyModel.isNeedLoad=YES;
    
}

-(void)GobackToPickNumber{
    
    _lianKaiCount=0;
    [_timer invalidate];
    _timer = nil;
    [_successView stopTimer];
    [_faildView stopTimer];
    [self dismissViewControllerAnimated:NO completion:^{
        
        MCPaySelectedLotteryTableViewController * vc=(MCPaySelectedLotteryTableViewController*)[UIView MCcurrentViewController];
        [vc emptyShoppingCart];
        
        [vc.navigationController popViewControllerAnimated:YES];
        
    }];
    

}
@end




























