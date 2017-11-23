//
//  MCBaseLotteryHallViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBaseLotteryHallViewController.h"
#import "MCPullMenuViewController.h"
#import "MCPullMenuPresentationController.h"
#import "MCPickBottomButton.h"
#import "UIImage+Extension.h"
#import "MCMoneyPopView.h"
#import "MCMSPopView.h"
#import "NSString+Helper.h"
#import "MCWFExplainViewController.h"
#import "MCMoreNavView.h"
#import "MCGameRecordViewController.h"
#import "MCGetplayawardModel.h"
#import "MCMaxbonusModel.h"
#import "MCIssueModel.h"
#import "MCLotteryID.h"
#import "MCMaxbonusModel.h"
#import "MCUserMoneyModel.h"
#import "MCGetMerchantInfoModel.h"
#import "MCDataTool.h"
#import "MCMineInfoModel.h"
#import "MCHistoryIssueDetailAPIModel.h"
#import "MCChaseNumberViewController.h"
#import "MCPickNumberViewController.h"

@interface MCBaseLotteryHallViewController ()
<MCPullMenuDelegate>

#pragma mark - property
/**定时器*/
@property(nonatomic,strong) NSTimer *timer;

/**底部视图*/
@property (nonatomic,weak) UIView *bottomView;

@property (nonatomic,weak) UILabel *zhuLabel;

@property (nonatomic,weak) UILabel *botomLabel;
/**期号刷新*/
@property (nonatomic,weak) UIButton *btnRefreashIssueNumber;
/**期号string*/
@property (nonatomic,strong) NSString *lastString;


/**随机按钮状体*/
@property (nonatomic,assign) BOOL randomBtnSelected;
/**随机按钮*/
@property (nonatomic,weak) UIButton *randomBtn;

/**投注页右上角功能按钮*/
@property (nonatomic,weak)MCMoreNavView * moreNavView;
/**isShowMoreBtn 是否展示按钮*/
@property (nonatomic,assign)BOOL isShowMoreBtn;
/**playawardModel模型的强引用*/
@property (nonatomic,strong)MCGetplayawardModel *playawardModel;

@property (nonatomic,strong)MCMaxbonusModel *bonusModel;

@property (nonatomic,strong)MCIssueModel *issueModel;

@property (nonatomic,strong)MCGetMerchantInfoModel * getMerchantInfoModel;
//每次进入页面   余额都要刷新
@property (nonatomic,weak)UIButton *bonusDetailLabel;
//期号加载菊花
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
//追号完成后  余额进行刷新
@property (nonatomic, strong) MCUserMoneyModel * userMoneyModel;
@property (nonatomic,weak) UIImageView *bgImage;
@property (nonatomic,weak) UIView *cloverView;
@property (nonatomic,weak) UIView *cover;
//号码球个数

@end

@implementation MCBaseLotteryHallViewController


- (NSMutableArray *)boModelArray{
    if (_boModelArray == nil) {
        _boModelArray = [NSMutableArray array];
    }
    return _boModelArray;
}
-(UIActivityIndicatorView *)activityIndicator{
    
    if (!_activityIndicator) {

        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        //设置小菊花的frame
        _activityIndicator.frame= CGRectMake(G_SCREENWIDTH * 0.5 - MC_REALVALUE(20) - 60, 0, MC_REALVALUE(40), MC_REALVALUE(40));
        //设置小菊花颜色
//        _activityIndicator.color = RGB(100, 100, 100);
        //设置背景颜色
        _activityIndicator.backgroundColor = [UIColor clearColor];
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
        [_activityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    }
    return _activityIndicator;
}
#pragma mark - life cycle
- (void)viewDidLoad {

    [super viewDidLoad];

    [self setUpUI];
    //为导航栏添加右侧按钮(更多)
    [self addNavRightBtn];
    //底部按钮
    [self setUpBottomView];
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    userMoneyModel.isNeedLoad=NO;
    
    [self selectLotteryKindWithTag:[MCPullMenuViewController Get_DefaultDicWithID:self.lotteriesTypeModel.LotteryID and:self.palyCode]];
    
    [self loadData];

    [self jungeIsMMCType];
}

- (void)jungeIsMMCType{
     MCMaxbonusModel *model =  [MCMaxbonusModel shareInstance];
    if ([self.baseWFmodel.LotteryID isEqualToString:@"50"]) {
       //极限秒秒彩
        model.mmcType = MMCBET;
    } else {
        model.mmcType = OTHERBET;
    }

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer];
    [self.alertView hideStackWindow];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopTimer];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    if (userMoneyModel.isNeedLoad||userMoneyModel.LotteryMoney.length<1) {
        
        [userMoneyModel refreashDataAndShow];
        self.userMoneyModel=userMoneyModel;
        
        userMoneyModel.callBackSuccessBlock = ^(id manager) {
            weakSelf.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
            weakSelf.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
            [weakSelf.bonusDetailLabel setTitle:[NSString stringWithFormat:@"%@元",[MCMathUnits GetMoneyShowNum:manager[@"LotteryMoney"]]] forState:UIControlStateNormal];
           
        };
        
    }else{
        [weakSelf.bonusDetailLabel setTitle:[NSString stringWithFormat:@"%@元",[MCMathUnits GetMoneyShowNum:userMoneyModel.LotteryMoney]] forState:UIControlStateNormal];
    }
    [self registerNotifacation];
    [self loadIssueData:^(BOOL result) {
        if (!result) {
//            [self openFailedIssue];
        }
    }];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MerchantMaxRebate]) {
        
        MCGetMerchantInfoModel *model = [MCGetMerchantInfoModel sharedMCGetMerchantInfoModel];
        [model refreashDataAndShow];
        self.getMerchantInfoModel = model;
        model.callBackSuccessBlock = ^(id manager) {
            
            [self setBetListMarry];
            
        };
    }else{
        [self setBetListMarry];
    }
    
    if ([self isKindOfClass:[MCChaseNumberViewController class]]) {
        MCUserDefinedLotteryCategoriesModel *model = [MCUserDefinedLotteryCategoriesModel GetMCUserDefinedLotteryCategoriesModelWithCZID:self.baseWFmodel.LotteryID];
        MCPickNumberViewController *pickVc = [[MCPickNumberViewController alloc] init];
        pickVc.lotteriesTypeModel = model;
        pickVc.navigationItem.title = [MCLotteryID getLotteryCategoriesNameByID:self.baseWFmodel.LotteryID];
        [self.navigationController pushViewController:pickVc animated:YES];
    }
    //清空注单信息
    
    self.baseWFmodel.stakeNumber = 0;
    self.baseWFmodel.payMoney = 0;
}

#pragma mark-设置列表返点数据
-(void)setBetListMarry{
    
    self.baseWFmodel.shangHuRebate = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMaxRebate];
    self.baseWFmodel.shangHuMinRebate = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
    self.baseWFmodel.XRebate = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantXRebate];
    self.baseWFmodel.Mode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode]];
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    int mode= [self.baseWFmodel.Mode intValue];
    [marr addObject:@"元  模式"];
    if ((mode&2) ==2 ) {
        [marr addObject:@"角  模式"];
    }
    if ((mode&1) ==1 ) {
        [marr addObject:@"分  模式"];
    }
    if ((mode&8) ==8 ) {
        [marr addObject:@"厘  模式"];
    }

    MCMSPopView * pView=[MCMSPopView alertInstance];
    pView.dataArray=marr;
    
    MCMineInfoModel * minInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    self.baseWFmodel.userRegisterRebate=minInfoModel.MyRebate;
    
    
    if (self.baseWFmodel.XRebate&&self.baseWFmodel.shangHuRebate&&self.baseWFmodel.userRegisterRebate&&self.baseWFmodel.czRebate&&self.baseWFmodel.czTZRebate&&self.baseWFmodel.shangHuMinRebate) {
        
        _betRebateArray=[MCDataTool GetShowBetRebateMarryWithModel:self.baseWFmodel];
        
        MCMoneyPopView * popView=[MCMoneyPopView alertInstance];
        
        popView.dataArray=_betRebateArray;
        
        MCShowBetModel * betModel=_betRebateArray[0];
        
        self.baseWFmodel.userSelectedRebate=betModel.BetRebate;
        self.baseWFmodel.showRebate=betModel.showRebate;
        
        
        [self.alertView.moneyBtn setTitle:betModel.showRebate forState:UIControlStateNormal];
        
    }
}
#pragma mark-修改了返点
-(void)setUserSelectedRebate:(NSNotification *)noti{
    
    NSDictionary *dic = noti.userInfo;
    MCShowBetModel * model = dic[@"MCShowBetModel"];
    self.baseWFmodel.userSelectedRebate=model.BetRebate;
    self.baseWFmodel.showRebate=model.showRebate;
    
    [self relayOutAlertViewData];
}

- (void)loadIssueData:(Compelete)compeletion{
   
    self.bgImage.hidden = NO;
    if ([self.baseWFmodel.LotteryID isEqualToString:@"50"]){
        self.bgImage.hidden = YES;
        self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        return;//秒秒彩不调用倒计时
    }else{
    self.baseTableView.contentInset = UIEdgeInsetsMake(40, 0, 20, 0);
    [self.btnDaojishi addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    MCIssueModel *issueModel = [[MCIssueModel alloc] init];
    issueModel.lotteryNumber = [self.lotteriesTypeModel.LotteryID intValue];
    [issueModel refreashDataAndShow];
    self.issueModel = issueModel;
    __weak typeof(self) weakSelf = self;
    issueModel.callBackSuccessBlock = ^(id manager) {
 
        MCIssueModel *model = [MCIssueModel mj_objectWithKeyValues:manager];
        weakSelf.time= model.RemainTime;
        weakSelf.IssueNumber=model.IssueNumber;
        weakSelf.btnRefreashIssueNumber.hidden=YES;

        if (weakSelf.IssueNumber.length>0) {
            weakSelf.lastString = [NSString stringWithFormat:@"距%@期截止:",model.IssueNumber];
            [weakSelf setUpTimer];
            compeletion(YES);
        }else{

            [weakSelf.activityIndicator stopAnimating];
            weakSelf.btnDaojishi.text = [NSString stringWithFormat:@"获取期号失败"];
            weakSelf.btnRefreashIssueNumber.hidden=NO;
            compeletion(NO);
            
        }
    
        
    };
    
    issueModel.callBackFailedBlock=^(id manager, NSString *errorCode){
        weakSelf.btnRefreashIssueNumber.hidden=NO;
        compeletion(NO);
        
    };
    
    }
}
-(void)openFailedIssue{}
- (void)dealloc{
    NSLog(@"MCBaseLotteryHallViewController---------dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SetUpUI
- (void)addNavRightBtn {
   
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, MC_REALVALUE(20), MC_REALVALUE(20));
    [rightBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
    UIImageView *bgtopView = [[UIImageView alloc] init];
    [self.view addSubview:bgtopView];
    bgtopView.frame = CGRectMake(30, MC_REALVALUE(55), G_SCREENWIDTH - 60, 40);
    bgtopView.layer.cornerRadius = MC_REALVALUE(20);
    bgtopView.clipsToBounds = YES;
    self.bgImage = bgtopView;
//    bgtopView.backgroundColor=RGB(144, 8, 216);
    bgtopView.image = [UIImage imageNamed:@"touzhu-timeibg"];
    /*
     * 倒计时栏
     */
    UIImageView *btnDaojishiImg = [[UIImageView alloc] init];
    [bgtopView addSubview:btnDaojishiImg];
    btnDaojishiImg.image = [UIImage imageNamed:@"touzhu-time-icon"];
    [btnDaojishiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgtopView).offset(MC_REALVALUE(5));
        make.left.equalTo(@(MC_REALVALUE(10)));
        make.height.equalTo(@(MC_REALVALUE(23)));
        make.width.equalTo(@(MC_REALVALUE(20)));
    }];
    UILabel *btnDaojishi = [[UILabel alloc] init];
    [bgtopView addSubview:btnDaojishi];
    btnDaojishi.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(12)];
    [btnDaojishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnDaojishiImg);
        make.left.equalTo(bgtopView.mas_left).offset(MC_REALVALUE(40));
        make.right.equalTo(bgtopView);
        make.height.equalTo(@(MC_REALVALUE(40)));
    }];
    btnDaojishi.textAlignment = NSTextAlignmentLeft;
    self.btnDaojishi = btnDaojishi;
    btnDaojishi.textColor = [UIColor whiteColor];


    UIButton * btnRefreashIssueNumber =[[UIButton alloc]init];
    [btnRefreashIssueNumber setTitle:@"点击刷新" forState:UIControlStateNormal];
    btnRefreashIssueNumber.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btnRefreashIssueNumber setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btnDaojishi addSubview:btnRefreashIssueNumber];
    _btnRefreashIssueNumber=btnRefreashIssueNumber;
    _btnRefreashIssueNumber.hidden=YES;
    [_btnRefreashIssueNumber addTarget:self
                                action:@selector(loadIssueData:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    CGFloat padding = MC_REALVALUE(10);
    
    /*
     * 距离024期截止:
     */
//    [timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(btnDaojishi.mas_left).offset(padding);
//        make.centerY.equalTo(btnDaojishi.mas_centerY);
//    }];
    //点击刷新
//    [_btnRefreashIssueNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(timerLabel.mas_right).offset(padding);
//        make.centerY.equalTo(btnDaojishi.mas_centerY);
//    }];
    
//    [timerDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(timerLabel.mas_right).offset(padding);
//        make.centerY.equalTo(btnDaojishi.mas_centerY);
//    }];
//    
    
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 44)];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    
    float LeftScaleFactor=494/750.0;
    
    /*
     *  玩法名称
     */
    UIButton *btnPCatergy = [[UIButton alloc] init];
    [topView addSubview:btnPCatergy];
    btnPCatergy.frame = CGRectMake(0, 0, G_SCREENWIDTH/3, HEIGHTKAIJIANGHAO);
    [btnPCatergy setImage:[UIImage imageNamed:@"touzhu-xiala"] forState:UIControlStateNormal];
    [btnPCatergy setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    btnPCatergy.titleEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 0);
    btnPCatergy.imageEdgeInsets = UIEdgeInsetsMake(0,G_SCREENWIDTH/3 - 20, 0, 0);
    [btnPCatergy setTitle:@"下拉按钮" forState:UIControlStateNormal];
    btnPCatergy.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    btnPCatergy.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnPCatergy addTarget:self action:@selector(btnPCatergyClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnPCatergy = btnPCatergy;
    
    
    UIView * view_line=[[UIView alloc]init];
    view_line.backgroundColor=RGB(239, 239, 239);
    [btnPCatergy addSubview:view_line];
    view_line.frame=CGRectMake(G_SCREENWIDTH*LeftScaleFactor-1, 0, 1, HEIGHTKAIJIANGHAO);
    
    UIButton *bonusLabel = [[UIButton alloc] initWithFrame:CGRectMake(G_SCREENWIDTH / 3, 0, 50, 40)];
    [bonusLabel setTitle:@"余额:" forState:UIControlStateNormal];
    [topView addSubview:bonusLabel];
    [bonusLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bonusLabel.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [bonusLabel setImage:[UIImage imageNamed:@"touzhu-yue-icon"] forState:UIControlStateNormal];
//    CGFloat w =  [@"余额:" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(14)]} context:nil].size.width;
    
    UIButton *bonusDetailLabel = [[UIButton alloc] initWithFrame:CGRectMake(G_SCREENWIDTH / 3 + 50, 0, G_SCREENWIDTH/3 - 50, 40)];
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [bonusDetailLabel setTitle:[NSString stringWithFormat:@"%@元",[MCMathUnits GetMoneyShowNum:userMoneyModel.LotteryMoney]] forState:UIControlStateNormal];
//    bonusDetailLabel.text = [NSString stringWithFormat:@"%@元",[MCMathUnits GetMoneyShowNum:userMoneyModel.LotteryMoney]];
    [bonusDetailLabel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [topView addSubview:bonusDetailLabel];
    bonusDetailLabel.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    _bonusDetailLabel=bonusDetailLabel;
    [bonusDetailLabel addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     * 近期开奖
     */
    UIButton *btnKaiJiang = [[UIButton alloc] init];
    [topView addSubview:btnKaiJiang];
    btnKaiJiang.frame = CGRectMake(G_SCREENWIDTH*LeftScaleFactor, 0, G_SCREENWIDTH*(1-LeftScaleFactor), HEIGHTKAIJIANGHAO);
    btnKaiJiang.backgroundColor = RGB(255, 255, 255);
    [btnKaiJiang setImage:[UIImage imageNamed:@"touzhu-lishi-icon"] forState:UIControlStateNormal];
    [btnKaiJiang setTitleColor:RGB(144, 8, 215) forState:UIControlStateNormal];
    [btnKaiJiang setTitle:@"历史开奖" forState:UIControlStateNormal];
    btnKaiJiang.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    btnKaiJiang.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnKaiJiang addTarget:self action:@selector(btnKaiJiangClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnKaiJiang = btnKaiJiang;
    
}

- (void)tap{
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"余额：%@元",[MCMathUnits GetMoneyShowNum:[MCUserMoneyModel sharedMCUserMoneyModel].LotteryMoney]]];
}
- (void)tapcover{
    [self.cover removeFromSuperview];
    self.alertView.isShowMSPop=NO;
//    self.alertView.isShowMoneyPop=NO;
    MCMSPopView * pView=[MCMSPopView alertInstance];
    [pView hideModelWindow];
    MCMoneyPopView * p1View=[MCMoneyPopView alertInstance];
    [p1View hideModelWindow];
}

- (UIView *)cover{
    if (_cover == nil) {
        UIView *cover = [[UIView alloc] initWithFrame:self.view.bounds];
        cover.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
        [self.view addSubview:cover];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapcover)]];

        self.cover = cover;
    }
    return _cover;
}
- (void)setUpBottomView{
    
    MCAlertView *alertView = [MCAlertView alertInstance];
    [self.view addSubview:alertView];
    self.alertView = alertView;
    __weak typeof(self) weakself = self;
    alertView.fandianBlock = ^{
        [weakself cover];
        
    };
    alertView.moshiBlock = ^{
        [weakself cover];
    };
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    self.bottomView.frame = CGRectMake(0, G_SCREENHEIGHT- 49 -64 - 10, G_SCREENWIDTH, 49 + MC_REALVALUE(30));
    UIImageView *imgV = [[UIImageView alloc] init];
    [bottomView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bottomView);
        make.right.equalTo(bottomView);
        make.height.equalTo(@(49));
    }];

    imgV.image = [UIImage imageNamed:@"touzhu-dikuang"];
    imgV.userInteractionEnabled = YES;
    UIButton *addBtn = [[UIButton alloc] init];
    [imgV addSubview:addBtn];
    [addBtn setTitle:@"添加注单" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(14)];
    addBtn.tag = 1997;
    [addBtn addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgV);
        make.top.bottom.equalTo(imgV);
        make.width.equalTo(@(MC_REALVALUE(90)));
    }];
    
    UIButton *buyBtn = [[UIButton alloc] init];
    [imgV addSubview:buyBtn];
    [buyBtn setTitle:@"注单结算" forState:UIControlStateNormal];
    buyBtn.tag = 1996;
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV);
        make.top.bottom.equalTo(imgV);
        make.width.equalTo(@(MC_REALVALUE(90)));
    }];
    [buyBtn addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *botomLabel = [[UILabel alloc] init];
    botomLabel.backgroundColor = RGB(126, 1, 191);
    [bottomView addSubview:botomLabel];
    botomLabel.frame = CGRectMake(0, 39, G_SCREENWIDTH, 20);
    botomLabel.textAlignment = NSTextAlignmentCenter;
    botomLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.botomLabel = botomLabel;
    botomLabel.textColor = RGB(231, 184, 254);
    
//    /*
//     * 机选
//     */
//    MCPickBottomButton *randomBtn = [[MCPickBottomButton alloc] init];
//    [bottomView addSubview:randomBtn];
//    [randomBtn setTitle:@"机选" forState:UIControlStateNormal];
//    [randomBtn setImage:[UIImage imageNamed:@"随机"] forState:UIControlStateNormal];
//    [randomBtn setImage:[UIImage imageNamed:@"random_enabel"] forState:UIControlStateDisabled];
//    self.randomBtn = randomBtn;
//    randomBtn.backgroundColor=RGB(255, 255, 255);
//    [randomBtn setTitleColor:RGB(83, 142, 202) forState:UIControlStateNormal];
//    [randomBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateDisabled];
//    
//    randomBtn.tag = 1999;
//    [randomBtn addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    /*
//     * 清空
//     */
//    MCPickBottomButton *delAllBtn = [[MCPickBottomButton alloc] init];
//    [bottomView addSubview:delAllBtn];
//    delAllBtn.tag = 1998;
//    delAllBtn.backgroundColor=RGB(255, 255, 255);
//    [delAllBtn setTitleColor:RGB(83, 142, 202) forState:UIControlStateNormal];
//    [delAllBtn setTitle:@"清空" forState:UIControlStateNormal];
//    [delAllBtn setImage:[UIImage imageNamed:@"清空"] forState:UIControlStateNormal];
//    [delAllBtn addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    /*
//     * 分隔线
//     */
//    UIView * view_line=[[UIView alloc]init];
//    [bottomView addSubview:view_line];
//    view_line.backgroundColor=RGB(239, 239, 239);
//    
//    /*
//     * 添加号码
//     */
//    MCPickBottomButton *addBtn = [[MCPickBottomButton alloc] init];
//    addBtn.tag = 1997;
//    self.addToShoppingCarBtn = addBtn;
//    [bottomView addSubview:addBtn];
//    addBtn.backgroundColor=RGB(77, 140, 210);
//    [addBtn setTitle:@"添加号码" forState:UIControlStateNormal];
//    [addBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
//    [addBtn addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *addItemCountLabel = [[UILabel alloc] init];
    addItemCountLabel.text = @"99+";
    [imgV addSubview:addItemCountLabel];
    addItemCountLabel.backgroundColor = RGB(249, 83, 85);
    addItemCountLabel.layer.cornerRadius = MC_REALVALUE(10);
    addItemCountLabel.layer.masksToBounds = YES;
    addItemCountLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(9)];
    
    addItemCountLabel.textAlignment = NSTextAlignmentCenter;
    addItemCountLabel.hidden = YES;
    addItemCountLabel.textColor = [UIColor whiteColor];
    self.addItemLabel = addItemCountLabel;
    
    
    
    UILabel *zhuLabel = [[UILabel alloc] init];
    zhuLabel.textColor = [UIColor whiteColor];
    zhuLabel.textAlignment = NSTextAlignmentCenter;

    zhuLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhuLabel.textAlignment = NSTextAlignmentCenter;

    [imgV addSubview:zhuLabel];
    zhuLabel.textAlignment = NSTextAlignmentCenter;
    [zhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyBtn.mas_top).offset(MC_REALVALUE(5));
        make.left.equalTo(buyBtn.mas_right);
        make.right.equalTo(addBtn.mas_left);
        make.height.equalTo(@(29));
    }];
    self.zhuLabel = zhuLabel;


    [addItemCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buyBtn.mas_right).offset(-MC_REALVALUE(8));
        make.top.equalTo(buyBtn.mas_top).offset(MC_REALVALUE(5));
        make.height.equalTo(@(MC_REALVALUE(20)));
        make.width.equalTo(@(MC_REALVALUE(20)));
    }];

    

    /*
     * 投注页右上角功能按钮
     */
    UIView *clover = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:clover];
    self.cloverView = clover;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView)];
    [clover addGestureRecognizer:tap];
    clover.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
    clover.hidden = YES;
    MCMoreNavView * moreNavView=[[MCMoreNavView alloc]init];
    [clover addSubview:moreNavView];
    moreNavView.frame=CGRectMake(G_SCREENWIDTH-WIDTH_MCMoreNav, 0, WIDTH_MCMoreNav, 0);
    _moreNavView=moreNavView;
    [_moreNavView.btn_PlayRecord addTarget:self action:@selector(action_PlayRecord) forControlEvents:UIControlEventTouchUpInside];
    [_moreNavView.btn_WFexplain addTarget:self action:@selector(action_WFexplain) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)tapCoverView{
    self.cloverView.hidden = YES;
}
#pragma mark - registerNotifacation
- (void)registerNotifacation{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBorardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mcStackeUnitsGetBallWF:) name:@"MCSTAKEUNITS_GETBALL_WF" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideStackWindowss) name:@"MCSTAKEUNITS_HIDEN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ballBtnClick) name:@"BALL_BTN_CLICK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action_YuanJiaoFen:) name:MCActionYuanJiaoFen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action_Multiple:) name:MCActionMultiple object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUserSelectedRebate:) name:McSelectedBetRebate object:nil];
    
}
- (void)hideStackWindowss{
    if (self.alertView.hidden == YES) {
        return;
    } else {
        if (self.isDanShi) {
            return;
        }
        [self.alertView hideStackWindow];
    }
    
}
#pragma mark-点击小球调用
- (void)ballBtnClick{
    self.randomBtnSelected = NO;
    //延迟调用的原因：self.baseWFmodel里面小球的选中信息没有及时更新过来，导致显示注数不对
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.05];
}

-(void)delayMethod{
    MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
}
- (void)keyBorardWillShow:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    CGRect rect = [dic[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];

    self.alertView.frame = CGRectMake(0, G_SCREENHEIGHT - rect.size.height - 49 - 60 -64, G_SCREENWIDTH, 49 + 60);
    self.bottomView.frame = CGRectMake(0, G_SCREENHEIGHT- rect.size.height -64 - 49  -10, G_SCREENWIDTH, 49);
    [self.alertView popViewHidden];
}

- (void)keyBoardWillHide:(NSNotification *)noti{

    self.alertView.frame = CGRectMake(0, G_SCREENHEIGHT - 49 - 60 -64, G_SCREENWIDTH, 49 + 60);
    self.bottomView.frame = CGRectMake(0, G_SCREENHEIGHT- 49 -64 - 10, G_SCREENWIDTH, 49 + MC_REALVALUE(30));

}
#pragma mark-修改了注数
- (void)mcStackeUnitsGetBallWF:(NSNotification *)noti{
    //    NSLog(@"%p",self);
    NSDictionary *dic = noti.userInfo;
    MCBallPropertyModel * model = dic[@"ballModel"];
    
    MCBallPropertyModel * model1 = dic[@"danshiModel"];
    if (model1 == nil) {
        if (model.stakeNumber >=1) {
            [self.alertView showStackWindow];
        }else{
            if (self.isDanShi) {
            }else{
                [self.alertView hideStackWindow];
            }
        }
        
        self.baseWFmodel.stakeNumber=model.stakeNumber;
        [self relayOutAlertViewData];
        
    } else {
        if (model1.stakeNumber>=1) {
            [self.alertView showStackWindow];
        }else{
            if (self.isDanShi) {
            }else{
                [self.alertView hideStackWindow];
            }
        }
        
        
        self.baseWFmodel.stakeNumber=model1.stakeNumber;
        [self relayOutAlertViewData];
    }
    
    
    
}
#pragma mark-修改了元角分
- (void)action_YuanJiaoFen:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    NSString * type= dic[@"type"];
    
    if ([type isEqualToString:@"元  模式"]) {
        self.baseWFmodel.yuanJiaoFen=1;
    }else if ([type isEqualToString:@"角  模式"]){
        self.baseWFmodel.yuanJiaoFen=0.1;
    }else if ([type isEqualToString:@"分  模式"]){
        self.baseWFmodel.yuanJiaoFen=0.01;
    }else if ([type isEqualToString:@"厘  模式"]){
        self.baseWFmodel.yuanJiaoFen=0.001;
    }
    [self relayOutAlertViewData];
    
}

#pragma mark-修改了倍数
- (void)action_Multiple:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    NSString * multiple= dic[@"multiple"];
    self.baseWFmodel.multiple=[multiple intValue];
    [self relayOutAlertViewData];
}

#pragma mark-刷新弹框数据
-(void)relayOutAlertViewData{
    [self.cover removeFromSuperview];
    self.baseWFmodel.payMoney=self.baseWFmodel.stakeNumber*2*self.baseWFmodel.yuanJiaoFen*self.baseWFmodel.multiple;
//    zhuLabel
    self.zhuLabel.text = [NSString stringWithFormat:@"%d注，%@元",self.baseWFmodel.stakeNumber,GetRealFloatNum(self.baseWFmodel.payMoney)];
//    self.alertView.titleSelectedInfoLabel.text = [NSString stringWithFormat:@"已选%d注,共%@元",self.baseWFmodel.stakeNumber,GetRealFloatNum(self.baseWFmodel.payMoney)];
    
    
    if (self.baseWFmodel.maxAwardAmount&&self.baseWFmodel.minAwardAmount) {
        
        MCMoneyModel * MaxModel= MCGetBouns(self.baseWFmodel.maxAwardAmount, self.baseWFmodel.userSelectedRebate, self.baseWFmodel.yuanJiaoFen, self.baseWFmodel.multiple, self.baseWFmodel.payMoney);

        MCMoneyModel * MinModel= MCGetBouns(self.baseWFmodel.minAwardAmount, self.baseWFmodel.userSelectedRebate, self.baseWFmodel.yuanJiaoFen, self.baseWFmodel.multiple, self.baseWFmodel.payMoney);
 
        self.botomLabel.text = [NSString stringWithFormat:@"若中奖，奖金%@~%@元,可盈利%@~%@元",MinModel.bouns,MaxModel.bouns,MinModel.yinli,MaxModel.yinli];
        
        
        
    }else if (self.baseWFmodel.maxAwardAmount){
        
        MCMoneyModel * MaxModel= MCGetBouns(self.baseWFmodel.maxAwardAmount, self.baseWFmodel.userSelectedRebate, self.baseWFmodel.yuanJiaoFen, self.baseWFmodel.multiple, self.baseWFmodel.payMoney);
        self.baseWFmodel.bonus=[MaxModel.bouns floatValue];

        self.baseWFmodel.yinli=[MaxModel.yinli floatValue];
        
        self.botomLabel.text = [NSString stringWithFormat:@"若中奖，奖金%@元,可盈利%@元",MaxModel.bouns,MaxModel.yinli];
        
        self.baseWFmodel.profitChaseAwardAmount=GetRealFloatNum((self.baseWFmodel.bonus/self.baseWFmodel.multiple));

    }else{//无数据
        self.botomLabel.text = [NSString stringWithFormat:@"若中奖，奖金--元,可盈利--元"];
    }
    if (self.baseWFmodel.stakeNumber == 0) {
        self.botomLabel.text = [NSString stringWithFormat:@"若中奖，奖金0元,可盈利0元"];
    }
}

#pragma mark - timer
- (void)setUpTimer{
    [self stopTimer];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setTImerLabelInfo) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop ] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)setTImerLabelInfo{
    [self.activityIndicator stopAnimating];
    if (self.time == 0) {
        [self loadIssueData:^(BOOL result) {
            if (!result) {
                [self openFailedIssue];
            }
        }];
        MCHistoryIssueDetailAPIModel *historyIssueDetailAPIModel=[MCHistoryIssueDetailAPIModel sharedMCHistoryIssueDetailAPIModel];
        historyIssueDetailAPIModel.isNeedUpdate=NO;
        
    }
    
    self.time --;
    NSString *hour = [NSString stringWithFormat:@"%.2d",self.time /3600];
    NSString *min = [NSString stringWithFormat:@"%.2d",(self.time - [hour intValue]*3600)/60];
    NSString *sec = [NSString stringWithFormat:@"%.2d",self.time%60];
    NSString *str  = [NSString stringWithFormat:@"%@:%@:%@ ",hour,min,sec];
    if (self.IssueNumber.length>8&&[MCMathUnits isNeedCut:self.baseWFmodel.LotteryID]&&[self.baseWFmodel.LotteryID isEqualToString:@"50"]) {
        self.btnDaojishi.text = [NSString stringWithFormat:@"%@期 截止投注时间 %@",[self.IssueNumber substringFromIndex:8],str];
    }else{
        self.btnDaojishi.text = [NSString stringWithFormat:@"%@期 截止投注时间 %@",self.IssueNumber,str];
    }
}

- (void)stopTimer{
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [self.timer invalidate];
    
    self.timer = nil;
    
}

#pragma mark-投注页右上角功能按钮
- (void)moreBtnClick:(UIButton *)btn{
    
    if (_isShowMoreBtn) {
        _isShowMoreBtn=NO;
    }else{
        _isShowMoreBtn=YES;
    }

    
//    [UIView animateWithDuration:0 animations:^{
    
        if (_isShowMoreBtn) {

            self.cloverView.hidden = NO;
             _moreNavView.frame=CGRectMake(G_SCREENWIDTH-WIDTH_MCMoreNav, 0, WIDTH_MCMoreNav, HEIGHT_MCMoreNav);
        }else{
  
            self.cloverView.hidden = YES;
             _moreNavView.frame=CGRectMake(G_SCREENWIDTH-WIDTH_MCMoreNav, 0, WIDTH_MCMoreNav, 0);
        }
//    } completion:^(BOOL finished) {
//        
//    }];
//    
}
#pragma mark-跳转游戏记录
-(void)action_PlayRecord{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _moreNavView.frame=CGRectMake(G_SCREENWIDTH-WIDTH_MCMoreNav, 0, WIDTH_MCMoreNav, 0);
        
    } completion:^(BOOL finished) {
        _isShowMoreBtn=NO;
        self.cloverView.hidden = YES;
        MCGameRecordViewController * vc = [[MCGameRecordViewController alloc]init];

        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

#pragma mark-跳转玩法说明
-(void)action_WFexplain{
    [UIView animateWithDuration:0.2 animations:^{
        
        _moreNavView.frame=CGRectMake(G_SCREENWIDTH-WIDTH_MCMoreNav, 0, WIDTH_MCMoreNav, 0);
        
    } completion:^(BOOL finished) {
        _isShowMoreBtn=NO;
        self.cloverView.hidden = YES;
        MCWFExplainViewController * vc = [[MCWFExplainViewController alloc]init];
        vc.baseWFmodel=self.baseWFmodel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
   
}


/** 玩法*/
- (void)btnPCatergyClick:(UIButton *)btn{

    MCPullMenuViewController *VC = [[MCPullMenuViewController alloc]init];
    VC.delegate=self;
    /*
     * 传入彩种ID
     */
    VC.lotteriesTypeModel = self.lotteriesTypeModel;//山东11选5
    MCPullMenuPresentationController *PC = [[MCPullMenuPresentationController alloc] initWithPresentedViewController:VC presentingViewController:self];
    PC.type=MCPullMenuCZListType;
    PC.isShowFaildIssue=self.isShowFaildIssue;
    VC.transitioningDelegate = PC;
    [self presentViewController:VC animated:YES completion:NULL];
}
/** 近期开奖*/
-(void)btnKaiJiangClick:(UIButton *)btn{
    [self KaiJiangClick];
}

-(void)selectLotteryKindWithTag:(MCBasePWFModel*)baseWFmodel{

    

    self.baseWFmodel = baseWFmodel;
    
    
    /**圆角分模式*/
    self.baseWFmodel.yuanJiaoFen=1;
    /**奖金*/
    self.baseWFmodel.bonus=0;
    /**倍数*/
    self.baseWFmodel.multiple=1;
    /**金额*/
    self.baseWFmodel.payMoney=0;
    /**注数*/
    self.baseWFmodel.stakeNumber=0;
    /**盈利*/
    self.baseWFmodel.yinli=0;
    [self.alertView.msBtn setTitle:@"元  模式" forState:UIControlStateNormal];
    self.alertView.btTF.text=@"1";
    [self.alertView.moneyBtn setTitle:@"1982.0.0" forState:UIControlStateNormal];
    /**彩种ID*/
    self.baseWFmodel.LotteryID=self.lotteriesTypeModel.LotteryID;
    self.baseWFmodel.czRebate=self.lotteriesTypeModel.MaxRebate;
    self.baseWFmodel.czTZRebate=self.lotteriesTypeModel.BetRebate;
    self.baseWFmodel.SaleState=self.lotteriesTypeModel.SaleState;
    /**彩种名称*/
    self.baseWFmodel.czName=self.lotteriesTypeModel.name;
    self.lotteriesTypeModel.playOnlyNum=self.baseWFmodel.playOnlyNum;
    self.lotteriesTypeModel.typeId=self.baseWFmodel.typeId;
    
    [self setWFPlayAward];
    
    [self setBetListMarry];
    if ([self.baseWFmodel.filterCriteria isEqualToString:@"2"]) {
        self.isDanShi = YES;
        [self.alertView showStackWindow];
    }else{
        self.isDanShi = NO;
        if (self.isDanShi) {
        }else{
            [self.alertView hideStackWindow];
        }
        
    }
    
    
    if ([baseWFmodel.isMachineSelectEnabled isEqualToString:@"0"]) {
        self.randomBtn.enabled = NO;
    } else {
        self.randomBtn.enabled = YES;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@_%@",baseWFmodel.typeName,baseWFmodel.name];
    [self.btnPCatergy setTitle:str forState:UIControlStateNormal];
    CGFloat L=[NSString getWidthWithTitle:str font:MC_REALVALUE(14)]/2.0+G_SCREENWIDTH*3/10.0+8;
//    self.btnPCatergy.imageEdgeInsets = UIEdgeInsetsMake(0,L, 0, 0);
    
    if (baseWFmodel == nil) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_LOTTERY_WF_ERJIWF" object:nil userInfo:@{@"baseModel":baseWFmodel}];
    
    if (_baseTableView) {
        [_baseTableView reloadData];
    }
    //延迟0.1秒是为了让Cell初始化完成
    [self performSelector:@selector(MC_PICKNUMBERVC_INIT) withObject:nil afterDelay:0.1];
    


}

- (void)loadData{
    
    self.baseWFmodel.maxAwardAmount=nil;
    self.baseWFmodel.minAwardAmount=nil;
    
        MCMaxbonusModel *bonusModel = [[MCMaxbonusModel alloc] init];
        bonusModel.lotteryNumber = [self.lotteriesTypeModel.LotteryID intValue];
        self.bonusModel = bonusModel;
        [bonusModel refreashDataAndShow];
    
    
        MCGetplayawardModel *playawardModel = [[MCGetplayawardModel alloc] init];
        playawardModel.lotteryNumber = [self.lotteriesTypeModel.LotteryID intValue];
        [playawardModel refreashDataAndShow];
        self.playawardModel = playawardModel;
        __block NSMutableArray *boModelArray = nil;
        __weak __typeof(self)wself = self;
//        dispatch_group_t group = dispatch_group_create();
//        dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        dispatch_group_async(group, quene, ^{
    
        bonusModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
//              NSLog(@"complete task 1");
            
//               dispatch_semaphore_signal(semaphore);
        };
        bonusModel.callBackSuccessBlock = ^(id manager) {
            [wself.boModelArray removeAllObjects];
            boModelArray = [MCMaxbonusModel mj_objectArrayWithKeyValuesArray:manager];
            
          
            wself.boModelArray = boModelArray;
//              NSLog(@"complete task 1");
//              dispatch_semaphore_signal(semaphore);
        };
    
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//      });
    
//        dispatch_group_async(group, quene, ^{
    
            playawardModel.callBackSuccessBlock = ^(id manager){
    
                wself.playModelArray = [MCGetplayawardModel mj_objectArrayWithKeyValuesArray:manager];

//                dispatch_semaphore_signal(semaphore);
    
                [wself setWFPlayAward];
                

            };
            playawardModel.callBackFailedBlock = ^( id manager, NSString *errorCode) {

//                
//                dispatch_semaphore_signal(semaphore);
            };
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//       });
    
    
//        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            NSLog(@"完成了网络请求，不管网络请求失败了还是成功了。");
//
//        });
 
    
    
    
    
}
#pragma mark-设置玩法奖金
-(void)setWFPlayAward{
    for (MCGetplayawardModel * model in self.playModelArray) {
        if ([model.PlayCode isEqualToString:[NSString stringWithFormat:@"%@%@",self.baseWFmodel.LotteryID,self.baseWFmodel.methodId]]) {
            
            NSDictionary *dic1= model.AwardLevelInfo[0];
            if (model.AwardLevelInfo.count>1) {
            
                self.baseWFmodel.maxAwardAmount=[self getMaxandMinWithArr:model.AwardLevelInfo][@"MAX"];
                self.baseWFmodel.minAwardAmount=[self getMaxandMinWithArr:model.AwardLevelInfo][@"MIN"];
            
            }else{
                self.baseWFmodel.maxAwardAmount=dic1[@"AwardAmount"];
                self.baseWFmodel.minAwardAmount=nil;
            }
        }
    }
    [self relayOutAlertViewData];
}

-(NSDictionary *)getMaxandMinWithArr:(NSArray *)arr{

    float max=[arr[0][@"AwardAmount"] floatValue];
    float min=[arr[0][@"AwardAmount"] floatValue];
    
    for (NSDictionary *temp in arr) {

        if (max<[temp[@"AwardAmount"] floatValue]) {
            max=[temp[@"AwardAmount"] floatValue];
        }
        if (min>[temp[@"AwardAmount"] floatValue]) {
            min=[temp[@"AwardAmount"] floatValue];
        }
    }
    
    NSDictionary * dic=@{
                         @"MAX":GetRealFloatNum(max),
                         @"MIN":GetRealFloatNum(min)
                         };
    
    return dic;
    
}

- (void)modifyJsonFile{
//// 拿到本地json文件中的一段内容
//   NSMutableDictionary *dic = [MCLotteryID getWFIDByLotteryCategoriesID:@"1243" groupName:@"0"];
//    //增加一个字段
//    [dic setValue:@"2222" forKey:@"111"];
//    //拿到该文件
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LotteryJSON_WFHelper" ofType:@"json"];
//    
////    [dic writeToFile:<#(nonnull NSString *)#> atomically:<#(BOOL)#>]
//    //
//   NSFileManager *manager = [NSFileManager defaultManager];
////    [manager conte]
}
/** 历史*/
- (void)btnHistroyClick:(MCPickBottomButton *)btn{

}

- (void)bottomViewBtnClick:(MCPickBottomButton *)btn{
    
    if (btn.tag == 1999) {//机选
        [self randomBtnClick];
    }else if (btn.tag == 1998) {//清空
        [self clearAllButtonClick];
        if (self.isDanShi) {
        }else{
            [self.alertView hideStackWindow];
        }
        
    }else if (btn.tag == 1997) {//添加号码
        [self addNumberToShoppingCar:YES];
    }else if (btn.tag == 1996) {//去投注
        [self payTheSelectedNumbers];
    }
}

/**需要被覆盖的方法*/

#pragma mark - 需要被覆盖的方法
- (void)setUpUI{
    
}
- (void)randomBtnClick{
    self.randomBtnSelected = YES;
    
}

- (void)clearAllButtonClick{
    
}

- (void)addNumberToShoppingCar:(BOOL)isShow{
    
}

- (void)payTheSelectedNumbers{
    
}

//Push到菜种选择列表  将下拉弹回 ->在子类重写
-(void)pullLotteryRecordViewToTop{
    
}
-(void)MC_PICKNUMBERVC_INIT{
    
}

#pragma mark - getter and setter

- (NSMutableArray *)selectedCardArray{
    if (_selectedCardArray == nil) {
        _selectedCardArray = [NSMutableArray array];
    }
    return _selectedCardArray;
}
@end
