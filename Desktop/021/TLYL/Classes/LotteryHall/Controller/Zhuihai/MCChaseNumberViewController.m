//
//  MCChaseNumberViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCChaseNumberViewController.h"
#import "MCZhuihaoTableViewCell.h"
#import "MCPickBottomButton.h"
#import "MCZhuiHaoModel.h"
#import "MCPaySelectedLotteryHeaderView.h"
#import "MCBetModel.h"
#import "MCIssueModel.h"
#import "MCMaxbonusModel.h"
#import "MCPickNumberViewController.h"
#import "MCMainTabBarController.h"
#import "MCGameRecordViewController.h"
#import "MCUserMoneyModel.h"
#import "UIImage+Extension.h"
#import "MCZhuiTongCoverView.h"
#import "MCKefuViewController.h"

@interface MCChaseNumberViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

#pragma mark - property

/**segmentCotrol*/
@property(nonatomic,weak) UISegmentedControl *segmentCotrol;

/**下部滑动根view*/
@property(nonatomic,weak) UIScrollView *baseScrollView;

/**segmentCotrol下面的输入框和按钮的父控件*/
@property(nonatomic,weak) UIView *topFilterView;
/**数据源*/

@property(nonatomic,strong) NSMutableArray *selectedCheckBoxArray;

/**baseScrollView上的左边的tableview*/
@property (nonatomic,weak) UITableView *leftTableView;

/**baseScrollView上的中间的tableview*/
@property (nonatomic,weak) UITableView *middleTableView;

/**baseScrollView上的右边的tableview*/
@property (nonatomic,weak) UITableView *rightTableView;

/**当前cell的frame*/
@property (nonatomic,assign) CGRect currentRect;

/**底部view*/
@property (nonatomic,weak) UIView *bottomInfoView;

/**底部view中的著述*/
@property (nonatomic,weak) UILabel *middleZHUSHULabel;

/**底部view余额*/
@property (nonatomic,weak) UILabel *yuELabel;

/**被选中的cell*/
@property (nonatomic,strong) NSMutableArray *selectedArray;

/**倒计时*/
@property (nonatomic,weak) UIView *timerView;

/**同倍起始输入框*/
@property (nonatomic,weak) UITextField *startTF;

/**同倍追号输入框*/
@property (nonatomic,weak) UITextField *zhuitongTF;

/**翻倍起始输入框*/
@property (nonatomic,weak) UITextField *startFanBeiTF;

/**翻倍追号输入框*/
@property (nonatomic,weak) UITextField *zhuiFanBeiTF;

/**翻倍隔输入框*/

@property (nonatomic,weak) UITextField *geFanBeiTF;

/**翻倍倍输入框*/
@property (nonatomic,weak) UITextField *beiFanBeiTF;

/**利润率起始输入框*/
@property (nonatomic,weak) UITextField *liRunStartTF;

/**利润率追号输入框*/
@property (nonatomic,weak) UITextField *liRunZhuiTF;

/**利润率输入框*/
@property (nonatomic,weak) UITextField *liRunTF;

@property (nonatomic,assign) int index;
/**模型强引用*/
//追号页面-获取固定个数的期号
@property (nonatomic,strong) MCZhuiHaoModel *chaseIssuesModel;

@property (nonatomic,strong) MCIssueModel *issueModel;

@property (nonatomic,strong) MCBetModel *betModel;

@property (nonatomic,strong) MCUserMoneyModel * userMoneyModel;

/**消费金额*/
@property (nonatomic,assign) float needMoney;

@property (nonatomic,weak) UIView *topBtnView;

@property (nonatomic,weak) UIButton *lastBtn;

@property (nonatomic,weak) UIView *botView;

@property (nonatomic,assign) long count;

@property (nonatomic,assign) CGFloat singlePrice;

@property (nonatomic,assign) BOOL isStop;
@property (nonatomic,weak) UILabel *bottomLabel;
//是否追号成功
@property (nonatomic,assign) BOOL isSuccessed;
@property (nonatomic,weak) MCZhuiTongCoverView *cloverView;
@property (nonatomic,weak) UIButton *payBtn;
@end

@implementation MCChaseNumberViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isStop= YES;
    [self setUpUI];
    self.navigationItem.title = self.dataSourceModel.czName;
    self.view.backgroundColor = [UIColor whiteColor];
    [self reloadDataAndShowWithNum:10 andTableView:self.leftTableView];
    [self tongBeiPlanBtnClick];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    [self registerNotifacation];
    [self.selectedArray removeAllObjects];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.yuEHadChangedBlock) {
        self.yuEHadChangedBlock(self.yuELabel.text);
    }
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dealloc{
    
    NSLog(@"MCChaseNumberViewController -- dealloc");

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - setUpUI
- (void)setUpUI{
    [self setUpTimer];
    [self setUpSegmentControl];
    [self setUpBaseScorllView];
    [self setUpBottomView];
    [self setUpTopFilterView];
    [self setUpMiddleTabView];
    [self setDefaultValue];
    
}

#pragma mark-顶部倒计时
- (void)setUpTimer{
    MCPaySelectedLotteryHeaderView *timerView = [[MCPaySelectedLotteryHeaderView alloc] init];
    [self.view addSubview:timerView];
    timerView.valueLabel.text = self.dataSourceModel.balance;
    timerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, 40);
    timerView.IssueNumber=_IssueNumber;
    timerView.dataSource=_RemainTime;
    self.timerView = timerView;
    __weak MCPaySelectedLotteryHeaderView *weakTimerView = timerView;
    __weak typeof(self) weakSelf = self;
    timerView.timeISZeroBlock = ^{
            MCIssueModel *issueModel = [[MCIssueModel alloc] init];
            issueModel.lotteryNumber = [weakSelf.dataSourceModel.LotteryID intValue];
            [issueModel refreashDataAndShow];
            weakSelf.issueModel = issueModel;
            issueModel.callBackSuccessBlock = ^(id manager) {
                MCIssueModel *model = [MCIssueModel mj_objectWithKeyValues:manager];
                weakTimerView.IssueNumber=model.IssueNumber;
                weakTimerView.dataSource=model.RemainTime;
            };
        if (_isSuccessed) {
            return ;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的追号中有已经截止的期号，请重新选择" preferredStyle:UIAlertControllerStyleAlert];
        // 添加按钮
        __weak typeof(self) weakAlert = self;
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (weakAlert.lastBtn.tag == 1000) {
                [weakAlert tongBeiPlanBtnClick];
            } else if(weakAlert.lastBtn.tag == 1001){
                [weakAlert fanBeiPlanBtnClick];
            }else{
                [weakAlert liRuanPlanBtnClick];
            }
        }]];
  
       [self presentViewController:alert animated:YES completion:nil];
    };

}

#pragma mark-条件选择
- (void)setUpSegmentControl{
    NSArray *arr = nil;
      MCPaySelectedCellModel * model = self.dataSourceModel.dataSource.firstObject;
    if (self.dataSourceModel.dataSource.count > 1 || model.isCanProfitChase == NO ) {
       arr = @[@"同倍追号",@"翻倍追号"];
    } else {
       arr =  @[@"同倍追号",@"翻倍追号",@"利润率追号"];
    }
    //条件选择
    UIView *topBtnView = [[UIView alloc] init];
    long count = arr.count;
    self.count = count;
    [self.view addSubview:topBtnView];
    self.topBtnView = topBtnView;
    topBtnView.backgroundColor = RGB(231, 231, 231);
    topBtnView.frame = CGRectMake(0, 40, G_SCREENWIDTH, MC_REALVALUE(54));
    for (NSInteger i = 0; i<arr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [topBtnView addSubview:btn];
        btn.frame = CGRectMake(13 + i * 10 + i * (G_SCREENWIDTH - 26 - 20) / count, MC_REALVALUE(10), (G_SCREENWIDTH - 26 - 20) / count , MC_REALVALUE(34));
        if (i<=1) {
            [btn setImage:[UIImage imageNamed:@"fanbei"] forState:UIControlStateNormal];
        } else {
            [btn setImage:[UIImage imageNamed:@"lirun"] forState:UIControlStateNormal];
        }
        [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateSelected];
        btn.layer.cornerRadius = 3.0f;
        btn.clipsToBounds = YES;
        [btn setBackgroundImage:[UIImage createImageWithColor:RGB(144, 8, 215)] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage createImageWithColor:RGB(187, 187, 187)] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        btn.tag = i + 1000;
        [btn addTarget:self action:@selector(segmentContrlBtnClick:) forControlEvents:UIControlEventTouchDown];
        //默认 第一个
        if (i==0) {
            self.lastBtn=btn;
            btn.selected = YES;
        }
    }
    
}

- (void)segmentContrlBtnClick:(UIButton *)btn{
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        long index = btn.tag - 1000;
        self.botView.frame = CGRectMake(index * G_SCREENWIDTH / self.count , 43, G_SCREENWIDTH / self.count, 2);
    }];
    if (btn.tag == 1000) {
        self.zhuitongTF.text=@"1";
        [self tongBeiPlanBtnClick];
    } else if(btn.tag == 1001){
        self.zhuiFanBeiTF.text = @"10";
        [self fanBeiPlanBtnClick];
    }else{
        self.liRunZhuiTF.text=@"10";
        [self liRuanPlanBtnClick];
    }
    long index = btn.tag - 1000;
    [self.baseScrollView setContentOffset:CGPointMake(index * G_SCREENWIDTH, 0) animated:YES];
    
}


#pragma mark-BaseScorllView
- (void)setUpBaseScorllView{
    UIScrollView *baseScrollView = [[UIScrollView alloc] init];
    baseScrollView.backgroundColor = RGB(231, 231, 231);
    [self.view addSubview:baseScrollView];
    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBtnView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    baseScrollView.scrollEnabled = NO;
    if (self.dataSourceModel.dataSource.count > 1) {
        baseScrollView.contentSize = CGSizeMake(G_SCREENWIDTH * 2, baseScrollView.heiht);
    } else {
        baseScrollView.contentSize = CGSizeMake(G_SCREENWIDTH * 3, baseScrollView.heiht);
    }
    baseScrollView.pagingEnabled = YES;
    baseScrollView.bounces = NO;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    self.baseScrollView = baseScrollView;
    self.baseScrollView.delegate = self;
}

#pragma mark-TopFilterView
- (void)setUpTopFilterView{
    
    [self setUpLeftFilterView];
    [self setUpTopMiddleFilterView];
    [self setUpRightFilterView];
    
    
    self.zhuitongTF.tag=1001;//同倍追号期数
    self.zhuiFanBeiTF.tag=1002;//翻倍追号期数
    self.beiFanBeiTF.tag=1003;//翻倍追号倍数
    self.liRunZhuiTF.tag=1004;//利润率追号期数
    self.liRunTF.tag=1005;//利润率 百分比
    
    self.startTF.tag=1006;//同倍追号 起始倍数
    self.startFanBeiTF.tag=1007;//翻倍追号 起始倍数
    self.liRunStartTF.tag=1008;//利润率追号 起始倍数
    
    [self.zhuitongTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.zhuiFanBeiTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.beiFanBeiTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.liRunZhuiTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.liRunTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.startTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.startFanBeiTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.liRunStartTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
}
#pragma mark-同倍选择框
- (void)setUpLeftFilterView{
    //left
    UIView *topFilterView = [[UIView alloc] init];
    [self.baseScrollView addSubview:topFilterView];
    self.topFilterView = topFilterView;
    topFilterView.layer.cornerRadius = 3;
    topFilterView.clipsToBounds = YES;
    
    topFilterView.backgroundColor = [UIColor whiteColor];
    [topFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseScrollView).offset(13);
        make.top.equalTo(self.baseScrollView).offset(3);
        make.height.equalTo(@(MC_REALVALUE(160)));
        make.width.equalTo(@(G_SCREENWIDTH - 26));
    }];
    
//    UILabel *startLabel = [[UILabel alloc] init];
//    [topFilterView addSubview:startLabel];
//    startLabel.text = @"快速选择";
//    startLabel.textColor = RGB(46, 46, 46);
//    startLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
//    [startLabel sizeToFit];
    CGFloat padding = MC_REALVALUE(20);
//    [startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(topFilterView.mas_left).offset(padding);
//        make.top.equalTo(topFilterView.mas_top).offset(MC_REALVALUE(24));
//        
//    }];
    
    UIView *startView = [[UIView alloc] init];
    [topFilterView addSubview:startView];
    [startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(80));
        make.top.equalTo(topFilterView.mas_top).offset(MC_REALVALUE(13));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.right.equalTo(topFilterView.mas_right).offset(MC_REALVALUE(-11));
    }];
    
    topFilterView.layer.cornerRadius = 3;
    topFilterView.clipsToBounds = YES;
    
    startView.layer.cornerRadius = 3;
    startView.clipsToBounds = YES;
//    NSArray *arr = @[@"2期",@"5期",@"10期",@"15期",@"20期"];
//    for (NSInteger i = 0; i<arr.count; i++) {
//        UIButton *btn = [[UIButton alloc] init];
//        [startView addSubview:btn];
//        [btn setTitle:arr[i] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
//        [btn setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
//        [btn setTitleColor:RGB(0, 0, 0) forState:UIControlStateSelected];
//        btn.frame = CGRectMake(i*(G_SCREENWIDTH - 26 - 19 - 48-14-11) * 0.2, 0, (G_SCREENWIDTH - 26 - 19 - 48-14-11) * 0.2, MC_REALVALUE(34));
//        btn.layer.borderWidth = 0.5;
//        btn.layer.borderColor = RGB(213, 213, 213).CGColor;
//        [btn setBackgroundImage:[UIImage createImageWithColor:RGB(144, 8, 215)] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
//        btn.tag = 1999 + i;
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    UILabel *custemLabel = [[UILabel alloc] init];
    [topFilterView addSubview:custemLabel];
    custemLabel.text = @"追号期数";
    custemLabel.textColor = RGB(46, 46, 46);
    custemLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [custemLabel sizeToFit];

    [custemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView.mas_left).offset(padding);
        make.top.equalTo(topFilterView.mas_top).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        
    }];
    
    UIView *custemView = [[UIView alloc] init];
    [topFilterView addSubview:custemView];
    [custemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView).offset(-MC_REALVALUE(11));
        make.top.equalTo(topFilterView).offset(MC_REALVALUE(11));
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(80));
        make.height.equalTo(@(MC_REALVALUE(34)));
        
    }];
    custemView.layer.cornerRadius = 4.0;
    custemView.layer.borderWidth = 0.5;
    custemView.layer.borderColor = RGB(213, 213, 213).CGColor;

    
    UITextField *startTF = [[UITextField alloc] init];
    startTF.delegate = self;
    startTF.layer.cornerRadius = 4.0f;
    self.startTF = startTF;
    startTF.textAlignment = NSTextAlignmentLeft;
    [custemView addSubview:startTF];
    startTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    startTF.layer.borderColor = RGB(213, 213, 213).CGColor;
    [startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startView.mas_left).offset(MC_REALVALUE(10));
        make.centerY.equalTo(custemLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-134));
    }];
    
    UILabel *custemTFLabel = [[UILabel alloc] init];
    custemTFLabel.text = @"期(最多可追120期)";
    custemTFLabel.font = [UIFont systemFontOfSize:12];
    [custemView addSubview:custemTFLabel];
    [custemTFLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(MC_REALVALUE(-22)));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(startTF);
    }];
    startTF.keyboardType = UIKeyboardTypeNumberPad;
    
    UILabel *zhuiLabel = [[UILabel alloc] init];
    [topFilterView addSubview:zhuiLabel];
    zhuiLabel.text = @"起始倍数";
    zhuiLabel.textColor = RGB(46, 46, 46);
    zhuiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    [zhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(custemLabel.mas_left);
        make.top.equalTo(self.startTF.mas_bottom).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
    }];
    
    UITextField *zhuiTF = [[UITextField alloc] init];
    zhuiTF.delegate = self;
    [topFilterView addSubview:zhuiTF];
    zhuiTF.layer.borderColor = RGB(213, 213, 213).CGColor;
    zhuiTF.layer.borderWidth = 0.5f;
    zhuiTF.textAlignment = NSTextAlignmentLeft;
    zhuiTF.layer.cornerRadius = 4.0f;
    zhuiTF.text = @"1";
    self.zhuitongTF = zhuiTF;
    [zhuiTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView.mas_right).offset(MC_REALVALUE(-100));
        make.centerY.equalTo(zhuiLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(135));
        
    }];
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingTop"];
    [zhuiTF setValue:[NSNumber numberWithInt:MC_REALVALUE(10)] forKey:@"paddingLeft"];
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingBottom"];
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingRight"];
    zhuiTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    UILabel *zhuihaoLabelB = [[UILabel alloc] init];
    [topFilterView addSubview:zhuihaoLabelB];
    zhuihaoLabelB.text = @"倍";
    zhuihaoLabelB.textAlignment = NSTextAlignmentLeft;
    zhuihaoLabelB.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhuihaoLabelB.textColor = RGB(46, 46, 46);
    [zhuihaoLabelB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-75));
        make.centerY.equalTo(zhuiTF.mas_centerY);
        make.height.equalTo(zhuiTF);
    }];
    UIButton *planBtn = [[UIButton alloc] init];
    [topFilterView addSubview:planBtn];
    planBtn.backgroundColor = RGB(144, 8, 215);
    [planBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView.mas_right).offset(-MC_REALVALUE(10));
        make.top.equalTo(zhuiTF.mas_bottom).offset(MC_REALVALUE(15));
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(40)));
    }];
    [planBtn setTitle:@"生成追号计划" forState:UIControlStateNormal];
    planBtn.layer.cornerRadius = 3.0f;
    planBtn.layer.masksToBounds = YES;
    [planBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    planBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(14)];
    [planBtn addTarget:self action:@selector(tongBeiPlanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addBtn = [[UIButton alloc] init];
    [topFilterView addSubview:addBtn];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"-"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(misBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(80));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@(MC_REALVALUE(50)));
        make.centerY.equalTo(zhuiLabel);
    }];
    
    UIButton *misBtn = [[UIButton alloc] init];
    [topFilterView addSubview:misBtn];
    [misBtn setBackgroundImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    [misBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [misBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@(MC_REALVALUE(50)));
        make.top.equalTo(addBtn);
    }];
}
- (void)btnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
}
- (void)addBtnClick{
   self.index = [self.zhuitongTF.text intValue];
   self.index ++;
   self.zhuitongTF.text = [NSString stringWithFormat:@"%d",self.index];
    [[NSNotificationCenter defaultCenter] postNotificationName:MCActionMultiple object:nil userInfo:@{@"multiple":self.zhuitongTF.text}];
}
- (void)misBtnClick{
    self.index = [self.zhuitongTF.text intValue];
    self.index --;
    if (self.index <= 1) {
        self.index = 1;
    }
    self.zhuitongTF.text = [NSString stringWithFormat:@"%d",self.index];
    [[NSNotificationCenter defaultCenter] postNotificationName:MCActionMultiple object:nil userInfo:@{@"multiple":self.zhuitongTF.text}];
}
-(void)addFanBtnClick{
    self.index = [self.zhuiFanBeiTF.text intValue];
    self.index ++;
    self.zhuiFanBeiTF.text = [NSString stringWithFormat:@"%d",self.index];
}
- (void)misFanBtnClick{
    self.index = [self.zhuiFanBeiTF.text intValue];
    self.index --;
    if (self.index <= 1) {
        self.index = 1;
    }
    self.zhuiFanBeiTF.text = [NSString stringWithFormat:@"%d",self.index];
}

- (void)addLiRunBtnClick{
    self.index = [self.liRunStartTF.text intValue];
    self.index ++;
    self.liRunStartTF.text = [NSString stringWithFormat:@"%d",self.index];
}
- (void)misLiRunBtnClick{
    self.index = [self.liRunStartTF.text intValue];
    self.index --;
    if (self.index <= 1) {
        self.index = 1;
    }
    self.liRunStartTF.text = [NSString stringWithFormat:@"%d",self.index];
}
#pragma mark-翻倍选择框
- (void)setUpTopMiddleFilterView{
    //Middle
    
    UIView *topFilterView = [[UIView alloc] init];
    [self.baseScrollView addSubview:topFilterView];
    [topFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseScrollView).offset(3);
        make.height.equalTo(@(MC_REALVALUE(205)));
        make.width.equalTo(@(G_SCREENWIDTH - 26));
        make.left.equalTo(@(G_SCREENWIDTH + 13));
    }];

    CGFloat padding = MC_REALVALUE(13);
        topFilterView.layer.cornerRadius = 3;
        topFilterView.clipsToBounds = YES;
        topFilterView.backgroundColor = [UIColor whiteColor];

        UILabel *zhuiLabel = [[UILabel alloc] init];
        [topFilterView addSubview:zhuiLabel];
        zhuiLabel.text = @"起始倍数";
        zhuiLabel.textColor = RGB(46, 46, 46);
        zhuiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        
        [zhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topFilterView.mas_left).mas_offset(MC_REALVALUE(19));
            make.top.equalTo(self.topFilterView.mas_top).offset(MC_REALVALUE(10));
            make.height.equalTo(@(MC_REALVALUE(34)));
        }];
        
        UITextField *zhuiTF = [[UITextField alloc] init];
        zhuiTF.delegate = self;
        [topFilterView addSubview:zhuiTF];
        zhuiTF.layer.borderColor = RGB(213, 213, 213).CGColor;
        zhuiTF.layer.borderWidth = 0.5f;
        zhuiTF.textAlignment = NSTextAlignmentLeft;
        zhuiTF.layer.cornerRadius = 4.0f;
        zhuiTF.text = @"1";
        self.startFanBeiTF = zhuiTF;
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingTop"];
    [zhuiTF setValue:[NSNumber numberWithInt:MC_REALVALUE(10)] forKey:@"paddingLeft"];
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingBottom"];
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingRight"];
    zhuiTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        [zhuiTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topFilterView.mas_right).offset(MC_REALVALUE(-77));
            make.centerY.equalTo(zhuiLabel);
            make.height.equalTo(@(MC_REALVALUE(34)));
            make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(146));
            
        }];
    UIButton *addBtn = [[UIButton alloc] init];
    [topFilterView addSubview:addBtn];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"-"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(misBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(80));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@(MC_REALVALUE(50)));
        make.centerY.equalTo(zhuiLabel);
    }];
    
    UIButton *misBtn = [[UIButton alloc] init];
    [topFilterView addSubview:misBtn];
    [misBtn setBackgroundImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    [misBtn addTarget:self action:@selector(addFanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [misBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@(MC_REALVALUE(50)));
        make.top.equalTo(addBtn);
    }];
        UILabel *zhuihaoLabelB = [[UILabel alloc] init];
        [topFilterView addSubview:zhuihaoLabelB];
        zhuihaoLabelB.text = @"倍";
        zhuihaoLabelB.textAlignment = NSTextAlignmentLeft;
        zhuihaoLabelB.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        zhuihaoLabelB.textColor = RGB(46, 46, 46);
        [zhuihaoLabelB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topFilterView).offset(MC_REALVALUE(-62));
            make.centerY.equalTo(zhuiTF.mas_centerY);
            make.height.equalTo(zhuiTF);
        }];

    
    UILabel *custemLabel = [[UILabel alloc] init];
    [topFilterView addSubview:custemLabel];
    custemLabel.text = @"追号期数";
    custemLabel.textColor = RGB(46, 46, 46);
    custemLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [custemLabel sizeToFit];
    [custemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(19));
        make.top.equalTo(zhuiLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        
    }];
    
    UITextField *startTF = [[UITextField alloc] init];
    startTF.delegate = self;
    startTF.layer.cornerRadius = 4.0f;
    self.zhuiFanBeiTF = startTF;
    startTF.textAlignment = NSTextAlignmentLeft;
    [topFilterView addSubview:startTF];
    
    startTF.layer.borderColor = RGB(213, 213, 213).CGColor;
    startTF.layer.borderWidth = 0.5f;
    [startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(80));
        make.centerY.equalTo(custemLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-11));
    }];
    [startTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingTop"];
    [startTF setValue:[NSNumber numberWithInt:MC_REALVALUE(10)] forKey:@"paddingLeft"];
    [startTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingBottom"];
    [startTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingRight"];
    startTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    UILabel *custemTFLabel = [[UILabel alloc] init];
    custemTFLabel.text = @"期(最多可追120期)";
    custemTFLabel.font = [UIFont systemFontOfSize:12];
    [topFilterView addSubview:custemTFLabel];
    [custemTFLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(MC_REALVALUE(-22)));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(startTF);
    }];
    startTF.keyboardType = UIKeyboardTypeNumberPad;

    UILabel *beiLabel = [[UILabel alloc] init];
    [topFilterView addSubview:beiLabel];
    beiLabel.text = @"倍";

    beiLabel.textColor = RGB(46, 46, 46);
    beiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [beiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView).offset(-20);
        make.top.equalTo(custemLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
    }];
    
    UITextField *beiTF = [[UITextField alloc] init];
    self.beiFanBeiTF = beiTF;
    beiTF.layer.cornerRadius = 4.0f;
    [topFilterView addSubview:beiTF];
    beiTF.textAlignment = NSTextAlignmentCenter;
    beiTF.keyboardType = UIKeyboardTypeNumberPad;
    beiTF.layer.borderColor = RGB(213, 213, 213).CGColor;
    beiTF.layer.borderWidth = 0.5f;
    
    [beiTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(beiLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.right.equalTo(beiLabel.mas_left).offset(-5);
        make.width.equalTo(@(MC_REALVALUE(75)));
        
    }];
        UILabel *XLabel = [[UILabel alloc] init];
        [topFilterView addSubview:XLabel];
        XLabel.text = @"倍数X";
        XLabel.textColor = RGB(46, 46, 46);
        XLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        [XLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(beiTF.mas_left).offset(-MC_REALVALUE(5));
            make.centerY.equalTo(beiLabel);
            make.height.equalTo(@(MC_REALVALUE(34)));
            
        }];

    
    UILabel *qiLabel = [[UILabel alloc] init];
    [topFilterView addSubview:qiLabel];
    qiLabel.text = @"期，";
    qiLabel.textColor = RGB(46, 46, 46);
    qiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [qiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(XLabel.mas_left).offset(-MC_REALVALUE(0));
        make.centerY.equalTo(beiLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        
    }];
    UITextField *geTF = [[UITextField alloc] init];
    geTF.layer.cornerRadius = 4.0f;
    [topFilterView addSubview:geTF];
    self.geFanBeiTF = geTF;
    geTF.layer.borderColor = RGB(213, 213, 213).CGColor;
    geTF.layer.borderWidth = 0.5f;
    [geTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(XLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.right.equalTo(qiLabel.mas_left).offset(-MC_REALVALUE(0));
        make.width.equalTo(@(MC_REALVALUE(75)));
        
    }];
    beiTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    geTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    geTF.textAlignment = NSTextAlignmentCenter;
    geTF.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *geLabel = [[UILabel alloc] init];
    [topFilterView addSubview:geLabel];
    geLabel.text = @"隔";
    geLabel.textColor = RGB(46, 46, 46);
    geLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [geLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(geTF.mas_left).offset(-MC_REALVALUE(5));
        make.centerY.equalTo(beiLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        
    }];
    UILabel *zhuiBeiLabel = [[UILabel alloc] init];
    zhuiBeiLabel.text = @"追号倍数";
    zhuiBeiLabel.textColor = RGB(46, 46, 46);
    zhuiBeiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [topFilterView addSubview:zhuiBeiLabel];
    [zhuiBeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(19));
        make.centerY.equalTo(beiLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        
    }];
    UIButton *planBtn = [[UIButton alloc] init];
    [topFilterView addSubview:planBtn];
    planBtn.backgroundColor = RGB(144, 8, 215);
    [planBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView.mas_right).offset(-MC_REALVALUE(10));
        make.top.equalTo(geTF.mas_bottom).offset(MC_REALVALUE(15));
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(40)));
    }];
    [planBtn setTitle:@"生成追号计划" forState:UIControlStateNormal];
    planBtn.layer.cornerRadius = 3.0f;
    planBtn.layer.masksToBounds = YES;
    [planBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    planBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(14)];
    [planBtn addTarget:self action:@selector(fanBeiPlanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark-利润率选择框
- (void)setUpRightFilterView{
    //Right
    UIView *topFilterView = [[UIView alloc] init];
    [self.baseScrollView addSubview:topFilterView];
    [topFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseScrollView).offset(3);
        make.height.equalTo(@(MC_REALVALUE(205)));
        make.width.equalTo(@(G_SCREENWIDTH - 26));
        make.left.equalTo(@(G_SCREENWIDTH *2 + 13));
    }];
    
    CGFloat padding = MC_REALVALUE(13);
    topFilterView.layer.cornerRadius = 3;
    topFilterView.clipsToBounds = YES;
    topFilterView.backgroundColor = [UIColor whiteColor];

    UILabel *zhuiLabel = [[UILabel alloc] init];
    [topFilterView addSubview:zhuiLabel];
    zhuiLabel.text = @"起始倍数";
    zhuiLabel.textColor = RGB(46, 46, 46);
    zhuiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    [zhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView.mas_left).mas_offset(MC_REALVALUE(19));
        make.top.equalTo(self.topFilterView.mas_top).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
    }];
    
    UITextField *startTF = [[UITextField alloc] init];
    startTF.delegate = self;
    [topFilterView addSubview:startTF];
    startTF.layer.borderColor = RGB(213, 213, 213).CGColor;
    startTF.layer.borderWidth = 0.5f;
    startTF.textAlignment = NSTextAlignmentLeft;
    startTF.layer.cornerRadius = 4.0f;
    startTF.text = @"1";
    self.liRunStartTF = startTF;
    [startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView.mas_right).offset(MC_REALVALUE(-77));
        make.centerY.equalTo(zhuiLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(136));
        
    }];
    [startTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingTop"];
    [startTF setValue:[NSNumber numberWithInt:MC_REALVALUE(10)] forKey:@"paddingLeft"];
    [startTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingBottom"];
    [startTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingRight"];
    startTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    UIButton *addBtn = [[UIButton alloc] init];
    [topFilterView addSubview:addBtn];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"-"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(misLiRunBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(80));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@(MC_REALVALUE(50)));
        make.centerY.equalTo(zhuiLabel);
    }];
    
    UIButton *misBtn = [[UIButton alloc] init];
    [topFilterView addSubview:misBtn];
    [misBtn setBackgroundImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    [misBtn addTarget:self action:@selector(addLiRunBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [misBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@(MC_REALVALUE(50)));
        make.top.equalTo(addBtn);
    }];
    UILabel *zhuihaoLabelB = [[UILabel alloc] init];
    [startTF addSubview:zhuihaoLabelB];
    zhuihaoLabelB.text = @"倍";
    zhuihaoLabelB.textAlignment = NSTextAlignmentLeft;
    zhuihaoLabelB.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhuihaoLabelB.textColor = RGB(46, 46, 46);
    [zhuihaoLabelB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-62));
        make.centerY.equalTo(startTF.mas_centerY);
        make.height.equalTo(startTF);
    }];

    UILabel *persentLabel = [[UILabel alloc] init];
    [topFilterView addSubview:persentLabel];
    persentLabel.text = @"追号期数";
    persentLabel.textColor = RGB(46, 46, 46);
    persentLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [persentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(19));
        make.top.equalTo(zhuiLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        
    }];

    UITextField *zhuiDITF = [[UITextField alloc] init];
    [topFilterView addSubview:zhuiDITF];
    self.liRunZhuiTF = zhuiDITF;
    zhuiDITF.layer.cornerRadius = 3.0f;
    zhuiDITF.keyboardType = UIKeyboardTypeNumberPad;
    zhuiDITF.layer.borderColor = RGB(213, 213, 213).CGColor;
    zhuiDITF.layer.borderWidth = 0.5f;
    zhuiDITF.textAlignment = NSTextAlignmentLeft;
    [zhuiDITF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(persentLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.right.equalTo(topFilterView).offset(MC_REALVALUE(-11));
        make.left.equalTo(topFilterView.mas_left).offset(MC_REALVALUE(80));
        
    }];
    [zhuiDITF setValue:[NSNumber numberWithInt:0] forKey:@"paddingTop"];
    [zhuiDITF setValue:[NSNumber numberWithInt:MC_REALVALUE(10)] forKey:@"paddingLeft"];
    [zhuiDITF setValue:[NSNumber numberWithInt:0] forKey:@"paddingBottom"];
    [zhuiDITF setValue:[NSNumber numberWithInt:0] forKey:@"paddingRight"];
    zhuiDITF.keyboardType = UIKeyboardTypeNumberPad;
    
zhuiDITF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    UILabel *custemTFLabel = [[UILabel alloc] init];
    custemTFLabel.text = @"期(最多可追120期)";
    custemTFLabel.font = [UIFont systemFontOfSize:12];
    [zhuiDITF addSubview:custemTFLabel];
    custemTFLabel.textColor = RGB(46, 46, 46);
    [custemTFLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(zhuiDITF).offset(MC_REALVALUE(-15));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(zhuiDITF);
    }];


    UILabel *zhuiDiLabel = [[UILabel alloc] init];
    [topFilterView addSubview:zhuiDiLabel];
    zhuiDiLabel.text = @"最低收益";
    zhuiDiLabel.textColor = RGB(46, 46, 46);
    zhuiDiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [zhuiDiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(persentLabel.mas_left);
        make.top.equalTo(persentLabel.mas_bottom).offset(MC_REALVALUE(11));
        make.height.equalTo(@(MC_REALVALUE(34)));
    }];
    
    UITextField *zhuiTF = [[UITextField alloc] init];
    zhuiTF.textAlignment = NSTextAlignmentLeft;
    zhuiTF.layer.cornerRadius = 4.0f;
    [topFilterView addSubview:zhuiTF];
    zhuiTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhuiTF.layer.borderColor = RGB(213, 213, 213).CGColor;
    zhuiTF.layer.borderWidth = 0.5f;
    [zhuiTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(zhuiDiLabel);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.left.equalTo(zhuiDITF);
        make.right.equalTo(topFilterView.mas_right).offset(MC_REALVALUE(-10));
        
    }];
    
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingTop"];
    [zhuiTF setValue:[NSNumber numberWithInt:MC_REALVALUE(10)] forKey:@"paddingLeft"];
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingBottom"];
    [zhuiTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingRight"];
    self.liRunTF = zhuiTF;
    
    UILabel *baifenLabel = [[UILabel alloc] init];
    [topFilterView addSubview:baifenLabel];
    baifenLabel.text = @"%";
    baifenLabel.textColor = RGB(46, 46, 46);
    baifenLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [baifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zhuiTF.mas_centerY);
        make.right.equalTo(zhuiTF.mas_right).offset(MC_REALVALUE(-18));
        make.height.equalTo(zhuiTF);
        
    }];
    zhuiTF.keyboardType = UIKeyboardTypeNumberPad;
    
    
  
    UIButton *planBtn = [[UIButton alloc] init];
    [topFilterView addSubview:planBtn];
    planBtn.backgroundColor = RGB(144, 8, 215);
    [planBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topFilterView.mas_right).offset(-MC_REALVALUE(10));
        make.top.equalTo(zhuiTF.mas_bottom).offset(MC_REALVALUE(15));
        make.left.equalTo(topFilterView).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(40)));
    }];
    [planBtn setTitle:@"生成追号计划" forState:UIControlStateNormal];
    planBtn.layer.cornerRadius = 3.0f;
    planBtn.layer.masksToBounds = YES;
    [planBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    planBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(14)];
    [planBtn addTarget:self action:@selector(liRuanPlanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
 
}

-(void)textFieldDidChange:(UITextField *)textField{

    
    if ([textField.text isEqualToString:@"0"]) {
        textField.text=@"";
    }
//    self.zhuitongTF.tag=1001;//同倍追号期数
//    self.zhuiFanBeiTF.tag=1002;//翻倍追号期数
//    self.beiFanBeiTF.tag=1003;//翻倍追号倍数
//    self.liRunZhuiTF.tag=1004;//利润率追号期数
//    self.liRunTF.tag=1005;//利润率 百分比
//
//    self.startTF.tag=1006;//同倍追号 起始倍数
//    self.startFanBeiTF.tag=1007;//翻倍追号 起始倍数
//    self.liRunStartTF.tag=1008;//利润率追号 起始倍数
    if (textField.tag==1006||textField.tag==1002||textField.tag==1004) {
        if (textField.text.length>3) {
            textField.text=@"120";
        }
        if ([textField.text intValue]>120) {
            textField.text=@"120";
        }
    }
//    else if(textField.tag==1006||textField.tag==1007||textField.tag==1008){
//    }
    else{
            
        if (textField.text.length>4) {
            textField.text=@"9999";
        }
        if ([textField.text intValue]>9999) {
            textField.text=@"9999";
        }
    }
    
}
/**
 *
 *MiddleTabView
 *
 **/
- (void)setUpMiddleTabView{
    
    [self setUpLeftMiddleView];
    [self setUpMiddleMiddeleView];
    [self setUPMiddleRightView];
}
#pragma mark-同倍TabView
- (void)setUpLeftMiddleView{
    UIView *middleView = [[UIView alloc] init];
    [self.baseScrollView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topFilterView.mas_bottom).offset(MC_REALVALUE(10));
        make.left.equalTo(self.topFilterView.mas_left);
        make.width.equalTo(@(G_SCREENWIDTH - 26));
        make.bottom.equalTo(self.view.mas_bottom).offset(-MC_REALVALUE(90));
    }];
    middleView.backgroundColor = [UIColor whiteColor];
    middleView.layer.cornerRadius = 3;
    middleView.clipsToBounds = YES;
    NSArray *arr = @[@"",@"期号",@"倍数",@"追号金额"];
    for (NSInteger i = 0; i< 4; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        [middleView addSubview:btn];
        [btn setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        if (i == 0) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"zhxz"] forState:UIControlStateNormal];
//            btn.frame = CGRectMake(15, 2, 15, 15);
            
        }else{
        btn.frame = CGRectMake(40 + (i - 1)* (G_SCREENWIDTH - 66) /3, 0, (G_SCREENWIDTH - 66) /3, MC_REALVALUE(20));

        }
    }
    UITableView *middleTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    middleTabView.estimatedRowHeight = 2;
    [middleView addSubview:middleTabView];
    [middleTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(MC_REALVALUE(31)));
        make.left.equalTo(middleView.mas_left);
        make.width.equalTo(@(G_SCREENWIDTH -26));
        make.bottom.equalTo(self.view.mas_bottom).offset(-MC_REALVALUE(49));
    }];
    middleTabView.delegate = self;
    middleTabView.dataSource = self;
    middleTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    middleTabView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    middleTabView.rowHeight = MC_REALVALUE(33);
    [middleTabView registerNib:[UINib nibWithNibName:NSStringFromClass([MCZhuihaoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"zhuihaocell"];
    self.leftTableView = middleTabView;
}

#pragma mark-翻倍TabView
- (void)setUpMiddleMiddeleView{

    UIView *middleView = [[UIView alloc] init];
    [self.baseScrollView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topFilterView.mas_bottom).offset(MC_REALVALUE(50));
        make.left.equalTo(self.baseScrollView.mas_left).offset(G_SCREENWIDTH + 13);
        make.width.equalTo(@(G_SCREENWIDTH -26 ));
        make.bottom.equalTo(self.view.mas_bottom).offset(-MC_REALVALUE(90));
    }];
    middleView.backgroundColor = [UIColor whiteColor];
    middleView.layer.cornerRadius = 3;
    middleView.clipsToBounds = YES;
    NSArray *arr = @[@"",@"期号",@"倍数",@"追号金额"];
    for (NSInteger i = 0; i< 4; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        [middleView addSubview:btn];
        [btn setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        if (i == 0) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"zhxz"] forState:UIControlStateNormal];
//            btn.frame = CGRectMake(15, 2, 15, 15);
            
        }else{
            btn.frame = CGRectMake(40 + (i - 1)* (G_SCREENWIDTH - 66) /3, 0, (G_SCREENWIDTH - 66) /3, MC_REALVALUE(20));
            
        }
    }
    UITableView *middleTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [middleView addSubview:middleTabView];

    [middleTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(MC_REALVALUE(31)));
        make.left.equalTo(middleView);
        make.width.equalTo(@(G_SCREENWIDTH - 26));
        make.bottom.equalTo(middleView);
    }];
    middleTabView.delegate = self;
    middleTabView.dataSource = self;
    middleTabView.rowHeight = MC_REALVALUE(33);
    middleTabView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    middleTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [middleTabView registerNib:[UINib nibWithNibName:NSStringFromClass([MCZhuihaoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"zhuihaocell_middleTableView"];
    self.middleTableView = middleTabView;
 
}

#pragma mark-利润率TabView
- (void)setUPMiddleRightView{
    
    UIView *middleView = [[UIView alloc] init];
    [self.baseScrollView addSubview:middleView];
    middleView.backgroundColor = [UIColor whiteColor];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topFilterView.mas_bottom).offset(MC_REALVALUE(50));
        make.left.equalTo(self.baseScrollView.mas_left).offset(2*G_SCREENWIDTH + 13);
        make.width.equalTo(@(G_SCREENWIDTH -26));
        make.bottom.equalTo(self.view.mas_bottom).offset(-MC_REALVALUE(90));
    }];
    middleView.backgroundColor = [UIColor whiteColor];
    middleView.layer.cornerRadius = 3;
    middleView.clipsToBounds = YES;
    NSArray *arr = @[@"",@"期号",@"倍数",@"追号金额"];
    for (NSInteger i = 0; i< 4; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        [middleView addSubview:btn];
        [btn setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        if (i == 0) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"zhxz"] forState:UIControlStateNormal];
//            btn.frame = CGRectMake(15, 2, 15, 15);
            
        }else{
            btn.frame = CGRectMake(40 + (i - 1)* (G_SCREENWIDTH - 66) /3, 0, (G_SCREENWIDTH - 66) /3, MC_REALVALUE(20));
            
        }
    }
 
    UITableView *middleTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [middleView addSubview:middleTabView];
    [middleTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(MC_REALVALUE(31)));
        make.left.equalTo(middleView);
        make.width.equalTo(@(G_SCREENWIDTH -26));
        make.bottom.equalTo(middleView);
    }];
    middleTabView.delegate = self;
    middleTabView.dataSource = self;
    middleTabView.rowHeight = MC_REALVALUE(33);
    middleTabView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    middleTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [middleTabView registerNib:[UINib nibWithNibName:NSStringFromClass([MCZhuihaoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"zhuihaocell"];
    self.rightTableView = middleTabView;

}
/**
 *
 *MiddleTabView
 *
 **/
#pragma mark-底部金额
- (void)setUpBottomView{
    
    UIView *bottomInfoView = [[UIView alloc] init];
    [self.view addSubview:bottomInfoView];
    [bottomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(MC_REALVALUE(81)));
    }];
    
    UIView *lineInfoView = [[UIView alloc] init];
    lineInfoView.backgroundColor = RGB(46, 46, 46);
    [self.view addSubview:lineInfoView];
    [lineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(MC_REALVALUE(0.5)));
    }];
    
    bottomInfoView.backgroundColor = RGB(255, 255, 255);
    self.bottomInfoView = bottomInfoView;
    
    UIButton *stopBtn =  [[UIButton alloc] init];
    [bottomInfoView addSubview:stopBtn];
    stopBtn.backgroundColor = RGB(144, 8, 215);
    stopBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomInfoView).offset(MC_REALVALUE(-18));
        make.top.equalTo(bottomInfoView).offset(MC_REALVALUE(6));
        make.width.equalTo(@(MC_REALVALUE(68)));
        make.height.equalTo(@(MC_REALVALUE(20)));
    }];
    stopBtn.layer.cornerRadius = MC_REALVALUE(10);
    stopBtn.clipsToBounds = YES;
    [stopBtn setTitle:@"中奖停追" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn sizeToFit];
 
    UILabel *bottomLabel = [[UILabel alloc] init];
    self.bottomLabel = bottomLabel;
    bottomLabel.textAlignment = NSTextAlignmentLeft;
    bottomLabel.text = @"正在加载";
    bottomLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [bottomInfoView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomInfoView).offset(MC_REALVALUE(18));
        make.top.equalTo(bottomInfoView);
        make.height.equalTo(@(MC_REALVALUE(31)));
    }];
    
    UIButton *payBtn = [[UIButton alloc] init];
    [bottomInfoView addSubview:payBtn];
    payBtn.layer.cornerRadius = 4.0;
    payBtn.clipsToBounds = YES;
    payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(16)];
    payBtn.backgroundColor = RGB(144, 8, 215);
    [payBtn setTitle:@"立即追号" forState:UIControlStateNormal];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(bottomInfoView).offset(MC_REALVALUE(-2));
        make.left.equalTo(bottomInfoView).offset(MC_REALVALUE(2));
        make.height.equalTo(@(MC_REALVALUE(50)));
    }];
    self.payBtn = payBtn;
    UILabel *middleZHUSHULabel = [[UILabel alloc] init];
    middleZHUSHULabel.textColor = RGB(68, 68, 68);
    self.middleZHUSHULabel = middleZHUSHULabel;
    middleZHUSHULabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    middleZHUSHULabel.textAlignment = NSTextAlignmentCenter;
    [bottomInfoView addSubview:middleZHUSHULabel];
    [middleZHUSHULabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(MC_REALVALUE(6)));
        make.centerX.equalTo(bottomInfoView);
        make.left.equalTo(stopBtn.mas_right);
        make.right.equalTo(payBtn.mas_left);
    }];
    
    UILabel *yuELabel = [[UILabel alloc] init];
    [bottomInfoView addSubview:yuELabel];
    self.yuELabel = yuELabel;
    yuELabel.textColor = RGB(68, 68, 68);
    yuELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    yuELabel.textAlignment = NSTextAlignmentCenter;
    [yuELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomInfoView);
        make.bottom.equalTo(bottomInfoView).offset(-MC_REALVALUE(6));
        make.left.equalTo(stopBtn.mas_right);
        make.right.equalTo(payBtn.mas_left);
        
    }];

    self.middleZHUSHULabel.text = [NSString stringWithFormat:@"共%d注%d元",0,0];
    self.yuELabel.text = [NSString stringWithFormat:@"余额：%@元",GetRealSNum(self.dataSourceModel.balance)];
    [payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchDown];

}

#pragma mark-setDefaultValue
- (void)setDefaultValue{
    self.startTF.text = @"10";
    self.zhuitongTF.text = @"1";//
    self.geFanBeiTF.text = @"1";
    self.zhuiFanBeiTF.text = @"10";//
    self.beiFanBeiTF.text = @"2";
    self.startFanBeiTF.text = @"1";
    self.liRunStartTF.text = @"1";
    self.liRunZhuiTF.text = @"10";//
    self.liRunTF.text = @"50";
    [self tongBeiPlanBtnClick];
}


- (void)reloadDataAndShowWithNum:(int) num andTableView:(UITableView *)tableview{
 
    MCZhuiHaoModel *model = [[MCZhuiHaoModel alloc] init];
    model.LotteryCode = [self.dataSourceModel.LotteryID intValue];
    model.Num = num;
    self.chaseIssuesModel = model;
    [model refreashDataAndShow];
    CGFloat singlePrice = 0;
    singlePrice=[_dataSourceModel.zhuihaoMoney doubleValue];
    model.callBackSuccessBlock = ^(id manager) {
        /*
         *  和数据库进行比较
         */
        NSArray *arr = [MCZhuiHaoModel mj_objectArrayWithKeyValuesArray:manager];
        NSInteger count=0;
        if (arr.count>=self.selectedCheckBoxArray.count) {
            count=self.selectedCheckBoxArray.count;
        } else {
            count=arr.count;
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"当前最多只能追%ld期！",(long)count]];
        }
        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        if (self.leftTableView == tableview) {
//            self.startTF.text = [NSString stringWithFormat:@"%ld",(long)count];
            self.startTF.text = [NSString stringWithFormat:@"%ld",(long)count];
#pragma mark --------FIX ME!!!!!!!!!!!!!!!!!!!
            self.bottomLabel.attributedText =  [self attrStringWithTotal:[self.zhuitongTF.text intValue] *count SinglePrice:singlePrice Number:number AndArr:arr];
        } else if(self.middleTableView == tableview){
//            self.startFanBeiTF.text = [NSString stringWithFormat:@"%ld",(long)count];
            self.zhuiFanBeiTF.text = [NSString stringWithFormat:@"%ld",(long)count];
            float total = 0;
            for (NSInteger i = 0; i<self.selectedCheckBoxArray.count; i++) {
                  MCZhuiHaoModel *model = self.selectedCheckBoxArray[i];
                total = total + [model.beishu intValue];
            }
            self.bottomLabel.attributedText =  [self attrStringWithTotal:total SinglePrice:singlePrice Number:number AndArr:arr];
        }else{
            float total = 0;
            for (NSInteger i = 0; i<self.selectedCheckBoxArray.count; i++) {
                MCZhuiHaoModel *model = self.selectedCheckBoxArray[i];
                total = total + [model.beishu intValue];
            }
//            self.startTF.text = [NSString stringWithFormat:@"%ld",(long)count];
            self.zhuiFanBeiTF.text = [NSString stringWithFormat:@"%ld",(long)count];
            self.bottomLabel.attributedText =  [self attrStringWithTotal:total SinglePrice:singlePrice Number:number AndArr:arr];
        }

        NSMutableArray * marr=[[NSMutableArray alloc]init];
        for (NSInteger i = 0; i<count; i++) {
            MCZhuiHaoModel *model = self.selectedCheckBoxArray[i];
            MCZhuiHaoModel *model1 = arr[i];
            model.typeValue = singlePrice;
//            model.selected = YES;
            model.IssueNumber = model1.IssueNumber;
            [marr addObject:model];
        }
        self.selectedCheckBoxArray=marr;
        [self.selectedArray removeAllObjects];
        [self.selectedArray  addObjectsFromArray:marr];
        [tableview reloadData];
    };
    model.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        
    };
    
}

- (NSAttributedString *)attrStringWithTotal:(CGFloat)total SinglePrice:(CGFloat)singlePrice Number:(NSArray *)number AndArr:(NSArray *)arr{

    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%ld期，%@注，%.3f元",arr.count,self.dataSourceModel.stakeNumber,total*singlePrice]];
    NSString *str = [[attributeString string] componentsSeparatedByString:@"期"][0];
    for (long i = str.length; i < attributeString.length; i ++) {
        NSString *a = [[attributeString string] substringWithRange:NSMakeRange(i, 1)];
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:RGB(249, 84, 83),NSFontAttributeName:[UIFont systemFontOfSize:12],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}
#pragma mark - touch event

//同倍追号
- (void)tongBeiPlanBtnClick{

    
    [self.view endEditing:YES];
    if ([self.startTF.text intValue]>=120) {
        self.startTF.text = @"120";
    }
    if ([self.startTF.text intValue]==0) {
        self.startTF.text = @"1";
    }
    if ([self.zhuitongTF.text intValue]==0) {
        self.zhuitongTF.text = @"1";
    }
    if ([self.zhuitongTF.text intValue]>=9999) {
        self.zhuitongTF.text = @"9999";
    }
    int count = [self.startTF.text intValue];

    if (count == 0) {
    
        [self.selectedCheckBoxArray removeAllObjects];
        
    }
   
    [self.selectedArray removeAllObjects];
    [self.selectedCheckBoxArray removeAllObjects];

    for (NSInteger i = 0; i< count; i++) {
        
        MCZhuiHaoModel *model = [[MCZhuiHaoModel alloc] init];
        model.title = [NSString stringWithFormat:@"%ld",i];
        model.selected = YES;
        model.beishu = self.zhuitongTF.text;
        [self.selectedCheckBoxArray addObject:model];
        
    }
    
    [self reloadDataAndShowWithNum:[self.startTF.text intValue] andTableView:self.leftTableView];
   
}


//翻倍追号
- (void)fanBeiPlanBtnClick{

    if ([self.startFanBeiTF.text intValue]==0) {
        self.startFanBeiTF.text = @"1";
    }
    if ([self.zhuiFanBeiTF.text intValue]==0) {
        self.zhuiFanBeiTF.text = @"1";
    }
    if ([self.geFanBeiTF.text intValue]==0) {
        self.geFanBeiTF.text = @"1";
    }
    if ([self.beiFanBeiTF.text intValue]==0) {
        self.beiFanBeiTF.text = @"1";
    }
    [self.view endEditing:YES];
    if ([self.beiFanBeiTF.text intValue]>=9999) {
        self.beiFanBeiTF.text = @"9999";
    }
    if ([self.startFanBeiTF.text intValue]>=9999) {
        self.startFanBeiTF.text = @"9999";
    }
    if ([self.zhuiFanBeiTF.text intValue]>=9999) {
        self.zhuiFanBeiTF.text = @"9999";
    }
    if ([self.geFanBeiTF.text intValue]>=9999) {
        self.geFanBeiTF.text = @"9999";
    }
    int count = [self.zhuiFanBeiTF.text intValue];
    if (count>=120) {
        count = 120;
        self.zhuiFanBeiTF.text = @"120";
    }
    if (count == 0) {
        [self.selectedCheckBoxArray removeAllObjects];
    }
    [self.selectedArray removeAllObjects];
    [self.selectedCheckBoxArray removeAllObjects];
    int j = 1;
    NSInteger Maxi=1;
    for (NSInteger i = 0; i< count; i++) {
    
        MCZhuiHaoModel *model = [[MCZhuiHaoModel alloc] init];
        model.title = [NSString stringWithFormat:@"%ld",(long)i];
        model.selected = YES;
        
        if (i<[self.geFanBeiTF.text intValue]) {
            
            model.beishu = self.startFanBeiTF.text;
            
        }else{
            
            if (i==[self.geFanBeiTF.text intValue]) {
                
                j = 1;
                
            } else {
                
                if([self.geFanBeiTF.text intValue] !=0){
                    
                    if ((i)%(([self.geFanBeiTF.text intValue ]))== 0) {
                        
                        j*=[self.beiFanBeiTF.text intValue];
                        
                    }
                }
            }
            int beishu=1;
            if (Maxi>1) {
                beishu=9999;
            }else{
                beishu = j* [self.startFanBeiTF.text intValue] * [self.beiFanBeiTF.text intValue];
                if (beishu > 9999) {
                    beishu=9999;
                    Maxi=i;
                }
            }
            
            model.beishu=[NSString stringWithFormat:@"%d",beishu];
        }
        
        [self.selectedCheckBoxArray addObject:model];
        
    }
    if (self.selectedCheckBoxArray.count < [self.zhuiFanBeiTF.text intValue]) {
        [SVProgressHUD showErrorWithStatus:@"您设置的利润率过高，无法达到您的预期目标值，请重新修改参数设置"];
        self.middleZHUSHULabel.text =@"共0注0元";
        
    }
    [self reloadDataAndShowWithNum:[self.zhuiFanBeiTF.text intValue] andTableView:self.middleTableView];
  
}


//利润率追号
- (void)liRuanPlanBtnClick{

    if ([self.liRunTF.text intValue]==0) {
        self.liRunTF.text = @"1";
    }
    if ([self.liRunZhuiTF.text intValue]==0) {
        self.liRunZhuiTF.text = @"1";
    }
    if ([self.liRunStartTF.text intValue]==0) {
        self.liRunStartTF.text = @"1";
    }
  
    [self.view endEditing:YES];
    if ([self.liRunTF.text intValue]>=9999) {
        self.liRunTF.text = @"9999";
    }
    if ([self.liRunStartTF.text intValue]>=9999) {
        self.liRunStartTF.text = @"9999";
    }
    int count = [self.liRunZhuiTF.text intValue];
    if (count>=120) {
        count = 120;
        self.liRunZhuiTF.text = @"120";
    }
    if (count == 0) {
        [self.selectedCheckBoxArray removeAllObjects];
    }
    [self.selectedArray removeAllObjects];
    [self.selectedCheckBoxArray removeAllObjects];

    
    if ([self.liRunStartTF.text intValue]>9999) {
        [SVProgressHUD showErrorWithStatus:@"倍数不能超过9999"];
        return;
    }
    if ([self.liRunTF.text intValue]>99999) {
        [SVProgressHUD showErrorWithStatus:@"利润率不能超过99999"];
        return;
    }
    // 单倍金额 80
    CGFloat nTotalMoney = 0;
    CGFloat lastnTotalMoney = 0;
    
    MCPaySelectedCellModel * model = self.dataSourceModel.dataSource.firstObject;
    MCPaySLBaseModel *dataSourceModel = self.dataSourceModel;
    
    double signalMoney = [dataSourceModel.zhuihaoMoney doubleValue];
//    float signalMoney = [model.payMoney floatValue] / [model.stakeNumber floatValue];
    CGFloat beiShuValue = 0.0 ;

    for (NSInteger i = 0; i<[self.liRunZhuiTF.text intValue]; i++) {
        
        int max;
        if (i==0) {
            nTotalMoney = signalMoney;
            lastnTotalMoney = signalMoney;
            beiShuValue = [self.liRunStartTF.text intValue];
            max=beiShuValue;
        }else{
            
            lastnTotalMoney = nTotalMoney;
            
            
            beiShuValue =
            ceilf((([self.liRunTF.text floatValue] /100.0 + 1) * nTotalMoney)
                  /
                  ( [model.profitChaseAwardAmount floatValue] - (([self.liRunTF.text floatValue] /100.0 + 1) * signalMoney)));
            max = MAX(beiShuValue, [self.liRunStartTF.text intValue]);
            beiShuValue=max;
            
            nTotalMoney = nTotalMoney + beiShuValue*signalMoney;

        }
        int shouYiValue = ([model.profitChaseAwardAmount floatValue] * [self.liRunStartTF.text intValue] - [model.payMoney floatValue]
                           /
                           [model.multiple intValue])/(signalMoney);
        
        if (shouYiValue*100<[self.liRunTF.text intValue]) {
            
            [SVProgressHUD showErrorWithStatus:@"您设置的利润率过高，无法达到您的预期目标值，请重新修改参数设置"];
            self.middleZHUSHULabel.text =@"共0注0元";
            [self.selectedCheckBoxArray removeAllObjects];
            [self.rightTableView reloadData];
            return;
            
        }
        if (max>9999) {
            
            [SVProgressHUD showErrorWithStatus:@"您设置的利润率过高，无法达到您的预期目标值，请重新修改参数设置"];
            self.middleZHUSHULabel.text =@"共0注0元";
            break;
            
        }
        
        MCZhuiHaoModel *model = [[MCZhuiHaoModel alloc] init];
        model.title = [NSString stringWithFormat:@"%ld",(long)i];
        model.beishu = [NSString stringWithFormat:@"%d",max];
        model.selected = YES;
        [self.selectedCheckBoxArray addObject:model];
        
    }
    [self reloadDataAndShowWithNum:[self.liRunZhuiTF.text intValue] andTableView:self.rightTableView];
 
    
}
- (void)stopBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        //开启
        self.isStop= NO;
        btn.backgroundColor = RGB(255, 168, 0);
    } else{
        //关闭
        self.isStop= YES;
        btn.backgroundColor = RGB(144, 8, 215);
    }
}
- (void)payBtnClick{
    
    if (self.selectedArray.count<1) {
        [SVProgressHUD showInfoWithStatus:@"至少选择1期!"];
        return;
    }
    for(MCZhuiHaoModel *model in self.selectedCheckBoxArray) {
        if (([model.beishu intValue] * self.singlePrice+0.001) <0.02) {
            [SVProgressHUD showInfoWithStatus:@"每单最少投注0.02元!"];
            return;
        }
    }
   _firstResbanderZhuiHaoView = YES;
   NSString *maxstr = [self getSingleQiNotiInfo];
   NSString *str=@"";
    if (maxstr.length>1) {
        str=[NSString stringWithFormat:@"该彩种单期最高奖金为%@元\n您共追%lu期，共%@元，请确认！",GetRealSNum(maxstr),(unsigned long)self.selectedArray.count,GetRealFloatNum(self.needMoney)];
    }else{
        str=[NSString stringWithFormat:@"您共追%lu期，共%@元，请确认！",(unsigned long)self.selectedArray.count,GetRealFloatNum(self.needMoney)];
    }
    MCZhuiTongCoverView *coverView = [[MCZhuiTongCoverView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64) title:@"追号确认" confirm:@"确认追号" cancel:@"取消返回"];
    coverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
    [self.navigationController.view addSubview:coverView];
    coverView.notiInfo = str;
    [coverView show];
    __weak typeof(self) weakSelf = self;
    __weak MCZhuiTongCoverView *weakClo = coverView;

    coverView.coverViewBlock = ^{
        weakSelf.payBtn.enabled = NO;
        weakSelf.payBtn.backgroundColor = RGB(188, 188, 188);
        [weakClo hidden];
        [self singleQiNotiInfo];
        MCBetModel *betModel = [self requestData];
        [BKIndicationView showInView:self.view];
       
//        betModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
//        weakSelf.payBtn.enabled = YES;
//        weakSelf.payBtn.backgroundColor = RGB(144, 8, 215);
//        if ([errorCode isEqualToString:@"510"]) {
//            [SVProgressHUD showInfoWithStatus:@"该彩种已经停售！"];
//        }
//        };

        betModel.callBackSuccessBlock = ^(ApiBaseManager* manager) {
        weakSelf.payBtn.enabled = YES;
        weakSelf.payBtn.backgroundColor = RGB(144, 8, 215);
        [weakSelf refreashUserMoney];
            
        _isSuccessed=YES;
         //追号成功   清空购彩蓝
        MCPaySLBaseModel * dataSourceModel=[MCPaySLBaseModel sharedMCPaySLBaseModel];
        [dataSourceModel removeDataSource];
        weakSelf.dataSourceModel.balance = [NSString stringWithFormat:@"%.3f",[weakSelf.dataSourceModel.balance floatValue]- weakSelf.needMoney];
        weakSelf.yuELabel.text = [NSString stringWithFormat:@"余额：%@元",GetRealSNum(weakSelf.dataSourceModel.balance)];
        MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
        userMoneyModel.isNeedLoad=YES;
            MCZhuiTongCoverView *coverView = [[MCZhuiTongCoverView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64) title:@"投注确认" confirm:@"继续投注" cancel:@"查看记录"];
            coverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
            [self.navigationController.view addSubview:coverView];
                __weak MCZhuiTongCoverView *weakClo = coverView;
                coverView.coverViewBlock = ^{
                    [weakClo hidden];
                    NSArray *currentControllers = self.navigationController.viewControllers;
                    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
                    int count = (int)newControllers.count;
                    [newControllers removeObjectAtIndex:(count-1)];//3
                    [newControllers removeObjectAtIndex:(count-2)];//2
                    [self.navigationController setViewControllers:newControllers animated:YES];

                    };
            coverView.cancelBlock = ^{
                MCGameRecordViewController * vc1 = [[MCGameRecordViewController alloc]init];
                [self.navigationController pushViewController:vc1 animated:YES];

            };
            coverView.notiInfo = @"投注成功";
            coverView.iconImage = [UIImage imageNamed:@"MCPopAlertTypeTZRequest_Success"];
            
            [coverView show];

     
    };
    betModel.callBackFailedBlock = ^(id manager, id errorCode) {
        weakSelf.payBtn.enabled = YES;
        weakSelf.payBtn.backgroundColor = RGB(144, 8, 215);
        if ([errorCode[@"code"] intValue] == 510) {
            [SVProgressHUD showInfoWithStatus:@"该彩种已经停售！"];
            return ;
        }
        MCZhuiTongCoverView *coverView = [[MCZhuiTongCoverView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64) title:@"投注确认" confirm:@"重新投注" cancel:@"在线客服"];
        coverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        [self.navigationController.view addSubview:coverView];
        __weak MCZhuiTongCoverView *weakClo = coverView;
        coverView.coverViewBlock = ^{
            
            [weakClo hidden];
        };
        coverView.cancelBlock = ^{
            MCKefuViewController * vc1 = [[MCKefuViewController alloc]init];
            [self presentViewController:vc1 animated:YES completion:nil];
            
        };
        coverView.notiInfo = @"投注失败";
        coverView.iconImage = [UIImage imageNamed:@"MCPopAlertTypeTZRequest_Faild"];
        
        [coverView show];
        };
    };
}
#pragma mark -- custem method
- (NSString *)getSingleQiNotiInfo{
    int mode = (int)[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode];
    NSString *maxstr = @"";
    if ((mode & 128) == 128) {//单期功能
        for (MCMaxbonusModel *model in self.boModelArray) {
            if ([model.Sign isEqualToString:@"1"]) {
                //                            continue;
            }
            
            NSString *lotName =  [MCLotteryID getLotteryCategoriesTypeNameByID:self.baseWFmodel.LotteryID];
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
    return maxstr;
}

- (void)singleQiNotiInfo{

    
    int mode = (int)[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode];
    
    if ((mode & 128) == 128) {//单期功能
        for (MCMaxbonusModel *model in self.boModelArray) {
            if ([model.Sign isEqualToString:@"1"]) {
                continue;
            }
            NSString *maxstr = @"";
            
            NSString *lotName =  [MCLotteryID getLotteryCategoriesTypeNameByID:self.baseWFmodel.LotteryID];
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
                // return ;
            }
            
            NSString *strinfo = [NSString stringWithFormat:@"该彩种单期最高奖金为%@元",maxstr];
//            [SVProgressHUD showInfoWithStatus:strinfo];
            
        }
    }
}


- (MCBetModel *)requestData{

    NSMutableDictionary *issueList = [NSMutableDictionary dictionary];
    for (MCZhuiHaoModel *model in self.selectedArray) {
        
        [issueList setObject:model.beishu forKey:model.IssueNumber];
    }
    if (self.selectedArray.count>0) {
        MCZhuiHaoModel *model=self.selectedArray[0];
        self.IssueNumber=model.IssueNumber;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (MCPaySelectedCellModel *modelTemp in self.dataSourceModel.dataSource) {
        if (modelTemp.payMoney != nil&&modelTemp.haoMa != nil&&modelTemp.stakeNumber != nil&&modelTemp.PlayCode != nil&&modelTemp.IssueNumber != nil&&modelTemp.BetRebate != nil&&modelTemp.multiple != nil&&modelTemp.BetMode != nil) {
            
            NSString * BetMode=@"";
            if (self.isStop) {
                //开启
                BetMode=[NSString stringWithFormat:@"%d",[modelTemp.BetMode intValue] + 2];
                
                //关闭
            } else{
                BetMode= [NSString stringWithFormat:@"%d",([modelTemp.BetMode intValue]+4)];
                
            }
            NSDictionary *dic =  @{
                                   @"BetMoney":modelTemp.payMoney,
                                   @"BetContent":modelTemp.tz_haoMa,
                                   @"BetCount":modelTemp.stakeNumber,
                                   @"PlayCode":modelTemp.PlayCode,
                                   @"IssueNumber":self.IssueNumber,
                                   @"BetRebate":modelTemp.BetRebate,
                                   @"BetMultiple":modelTemp.multiple,
                                   @"BetMode":BetMode
                                   };
            
           
            [arr addObject:dic];
        }
        
    }
    
    NSDictionary *dicP = @{
                           @"LotteryCode":self.dataSourceModel.LotteryID,
                           @"Bet":arr,
                           @"IssueNumber":self.IssueNumber
                           };
    
    NSDictionary *dic = @{
                          @"IssueList":issueList,
                          @"UserBetInfo":dicP
                          };
    MCBetModel *betModel = [[MCBetModel alloc] initWithDic:dic];
    self.betModel = betModel;
    [betModel refreashDataAndShow];
    return betModel;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}
#pragma mark - registerNotifacation
- (void)registerNotifacation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    CGRect rect = [dic[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        if (self.baseScrollView.contentOffset.x == 0) {
            self.leftTableView.contentOffset = CGPointMake(0, self.currentRect.origin.y);
            self.leftTableView.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0);
        } else if(self.baseScrollView.contentOffset.x == G_SCREENWIDTH){
            self.middleTableView.contentOffset = CGPointMake(0, self.currentRect.origin.y);
            self.middleTableView.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0);
        }else{
            self.rightTableView.contentOffset = CGPointMake(0, self.currentRect.origin.y);
            self.rightTableView.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0);
        }
    }];
    
}

- (void)keyBoardWillHide:(NSNotification *)noti{
    
    self.leftTableView.contentOffset = CGPointMake(0, 0);
    self.leftTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UITableviewDelegate And DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectedCheckBoxArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MCZhuihaoTableViewCell *cell;
    if (tableView ==_middleTableView) {
       cell = [tableView dequeueReusableCellWithIdentifier:@"zhuihaocell_middleTableView"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"zhuihaocell"];
    }

    cell.textFiledDidBecomeFisrtR = ^(NSString *str,CGRect rect){
        self.currentRect = rect;
    };
    
    cell.textFiledDidSelected = ^(MCZhuiHaoModel *model,NSString *lastTimeCount){
        [self relayOutData];
        NSLog(@"%lu----\n %@",(unsigned long)self.selectedArray.count,self.selectedArray);
    };
    
    //选择该期号
    cell.checkBoxDidSelected= ^(MCZhuiHaoModel *model, NSString *last){
        for (MCZhuiHaoModel *Smodel in self.selectedCheckBoxArray) {
            if ([Smodel.IssueNumber isEqualToString:model.IssueNumber]) {
                Smodel.selected=YES;
            }
        }
        if (model.selected == YES && ![self.selectedArray containsObject:model]) {
            [self.selectedArray addObject:model];
        }
        [self relayOutData];
    };
    
    //取消该期号
    cell.checkBoxDidUnSelected= ^(MCZhuiHaoModel *model, NSString *last){
        
        for (MCZhuiHaoModel *Smodel in self.selectedCheckBoxArray) {
            if ([Smodel.IssueNumber isEqualToString:model.IssueNumber] ) {
                Smodel.selected=NO;
            }
        }
        if(model.selected == NO && [self.selectedArray containsObject:model]){
            [self.selectedArray removeObject:model];
        }

        [self relayOutData];
        
    };
    
     NSString *titleStr = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
     cell.title = titleStr;
    if (self.selectedCheckBoxArray.count != 0 && indexPath.row < self.selectedCheckBoxArray.count) {
         cell.dataSource = self.selectedCheckBoxArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)relayOutData{
    //追号期数
    self.startTF.text = [NSString stringWithFormat:@"%ld",(long)self.selectedArray.count];
    self.zhuiFanBeiTF.text = [NSString stringWithFormat:@"%ld",(long)self.selectedArray.count];
    self.liRunZhuiTF.text = [NSString stringWithFormat:@"%ld",(long)self.selectedArray.count];
    
    int count = 0;
    for (MCZhuiHaoModel *model in self.selectedArray) {
        if (model.selected == YES) {
            count += [model.beishu intValue];
        }
        
    }
    
    CGFloat singlePrice = 0.0;
    singlePrice= [_dataSourceModel.zhuihaoMoney doubleValue];
    //底部金额
    self.middleZHUSHULabel.text = [NSString stringWithFormat:@"共%@注%@元",self.dataSourceModel.stakeNumber,GetRealFloatNum(count * singlePrice)];
    
    
    self.singlePrice = singlePrice;
    self.needMoney=count * singlePrice;
    self.yuELabel.text = [NSString stringWithFormat:@"余额：%@元",GetRealSNum(self.dataSourceModel.balance)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = RGB(252, 247, 254);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = RGB(255, 255, 255);


}
#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{

  
}

//刷新账户
-(void)refreashUserMoney{
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [userMoneyModel refreashDataAndShow];
    self.userMoneyModel=userMoneyModel;
    userMoneyModel.callBackSuccessBlock = ^(id manager) {
        
        self.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
        self.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
        self.dataSourceModel.balance=manager[@"LotteryMoney"];
        self.yuELabel.text = [NSString stringWithFormat:@"余额：%@元",GetRealSNum(self.dataSourceModel.balance)];
    };
}



#pragma mark - getter and setter 

//- (MCZhuiTongCoverView *)cloverView{
//    if (_cloverView == nil) {
//        MCZhuiTongCoverView *cloverView = [[MCZhuiTongCoverView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
//        cloverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
//        [self.navigationController.view addSubview:cloverView];
//        _cloverView = cloverView;
//        __weak MCZhuiTongCoverView *weakClo = cloverView;
//        cloverView.coverViewBlock = ^{
//            [weakClo hidden];
//        };
//    }
//    return _cloverView;
//}

- (NSMutableArray *)selectedCheckBoxArray{
    if (_selectedCheckBoxArray == nil) {
        _selectedCheckBoxArray = [NSMutableArray array];
    }
    
    return _selectedCheckBoxArray;
}


- (NSMutableArray *)selectedArray{
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}





@end
