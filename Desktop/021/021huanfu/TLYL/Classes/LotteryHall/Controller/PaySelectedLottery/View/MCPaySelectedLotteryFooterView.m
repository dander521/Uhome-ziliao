//
//  MCPaySelectedLotteryFooterView.m
//  TLYL
//
//  Created by Canny on 2017/6/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPaySelectedLotteryFooterView.h"
#import "MCPickBottomButton.h"
#import "MCPaySelectedLotteryPickView.h"
#import "MCMSPopView.h"
#define WIDTH_Pay  80
#define WIDTH_ChaseNumber   90
#define WIDTH_Left   G_SCREENWIDTH-WIDTH_Pay-WIDTH_ChaseNumber

@interface MCPaySelectedLotteryFooterView ()
/*
 * 秒秒彩开奖次数选择器
 */
@property (nonatomic,strong)UIView * view_MMC;

@property(nonatomic,strong)UIButton * btn_lianKai;

/*
 * 其他彩种背景打底
 */
@property (nonatomic,strong)UIView * view_back;
/*
 * 左侧白色区域
 */
@property(nonatomic,strong)UIView * view_left;

/**共1000注 10000元*/
@property(nonatomic,strong)UILabel * lab_title;

/*
 * 追号
 */
@property(nonatomic,strong)MCPickBottomButton *btn_ChaseNumber;

/*
 * 付款
 */
@property(nonatomic,strong)MCPickBottomButton *btn_Pay;

/*
 * 立即开奖
 */
@property(nonatomic,strong)UIButton * btn_RunLottery;


@end

@implementation MCPaySelectedLotteryFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=RGB(241, 241, 241);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Notification_MCPaySelectedLottery_Count:) name:@"Notification_MCPaySelectedLottery_Count" object:nil];

    
    _view_back=[[UIView alloc]init];
    [self addSubview:_view_back];
    _view_left=[[UIView alloc]init];
    [_view_back addSubview:_view_left];
    
    /**共1000注 10000元*/
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.textColor=RGB(100, 100, 100);
    _lab_title.font=[UIFont systemFontOfSize:15];
    _lab_title.text =@"加载中";
    _lab_title.textAlignment=NSTextAlignmentCenter;
    [_view_left  addSubview:_lab_title];
  
    
    /*
     * 追号
     */
    _btn_ChaseNumber=[[MCPickBottomButton alloc]init];
    [_view_back addSubview:_btn_ChaseNumber];
    _btn_ChaseNumber.backgroundColor=RGB(80, 141, 207);
    [_btn_ChaseNumber setTitle:@"追号" forState:UIControlStateNormal];
    _btn_ChaseNumber.img_Width=22;
    _btn_ChaseNumber.img_Height=20;
    [_btn_ChaseNumber setImage:[UIImage imageNamed:@"tabbar_number_selected"] forState:UIControlStateNormal];
    _btn_ChaseNumber.tag = 1001;
    [_btn_ChaseNumber addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*
     * 付款
     */
    _btn_Pay=[[MCPickBottomButton alloc]init];
    [_view_back addSubview:_btn_Pay];
    _btn_Pay.backgroundColor=RGB(29, 131, 211);
    [_btn_Pay setTitle:@"付款" forState:UIControlStateNormal];
//    46 × 39
    _btn_Pay.img_Width=23;
    _btn_Pay.img_Height=19.5;
    [_btn_Pay setImage:[UIImage imageNamed:@"tabbar_payment_selected"] forState:UIControlStateNormal];
    _btn_Pay.tag = 1002;
    [_btn_Pay addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*
     * 立即开奖
     */
    _btn_RunLottery = [[UIButton alloc]init];
    [_view_back addSubview:_btn_RunLottery];
    [_btn_RunLottery setTitle:@"立即开奖" forState:UIControlStateNormal];
    [_btn_RunLottery setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn_RunLottery.backgroundColor=RGB(48, 127, 207);
    _btn_RunLottery.layer.cornerRadius=5;
    _btn_RunLottery.clipsToBounds=YES;
    [_btn_RunLottery addTarget:self action:@selector(action_RunLottery) forControlEvents:UIControlEventTouchUpInside];
    
    
    _view_MMC=[[UIView alloc]init];
    _view_MMC.backgroundColor=RGB(200, 200, 200);
    [self addSubview:_view_MMC];
    
    _btn_lianKai=[[UIButton alloc]init];
    [_btn_lianKai setImage:[UIImage imageNamed:@"goucai_gengduor_selected"] forState:UIControlStateNormal];
    [_view_MMC addSubview:_btn_lianKai];
    [_btn_lianKai addTarget:self action:@selector(action_LianKai:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_lianKai setTitle:@"连开 1 次" forState:UIControlStateNormal];
    _btn_lianKai.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _btn_lianKai.imageEdgeInsets = UIEdgeInsetsMake(0,150-50, 0, 0);
    _btn_lianKai.titleEdgeInsets = UIEdgeInsetsMake(0,-50, 0, 0);
    
    _lianKaiCount=1;
    [self layOutConstraints];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _btn_Pay.imageView.frame = CGRectMake(_btn_Pay.widht * 0.5- MC_REALVALUE(10), MC_REALVALUE(5), MC_REALVALUE(23), MC_REALVALUE(19.5));
}
-(void)bottomViewBtnClick:(MCPickBottomButton *)btn{
    if (self.block) {
        self.block(btn.tag);
    }
}

-(void)layOutConstraints{
    
    /*
     * 其他彩种背景打底
     */
    [_view_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(49);
    }];
    
    /*
     * 左侧白色区域
     */
    [_view_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view_back.mas_left).offset(0);
        make.top.equalTo(_view_back.mas_top).offset(0);
        make.bottom.equalTo(_view_back.mas_bottom);
        make.width.mas_equalTo(WIDTH_Left);
    }];
    
    
    /**共1000注 10000元*/
    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view_left.mas_left).offset(0);
        make.top.equalTo(_view_back.mas_top).offset(5);
        make.right.equalTo(_view_left.mas_right).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    
    
    /*
     * 追号
     */
    [_btn_ChaseNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_view_back);
        make.left.equalTo(_view_back.mas_left).offset(WIDTH_Left);
        make.width.mas_equalTo(WIDTH_ChaseNumber);
        
    }];
    
    
    /*
     * 付款
     */
    [_btn_Pay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_btn_ChaseNumber.mas_right);
        make.height.mas_equalTo(49);
        make.top.equalTo(_view_back.mas_top);
        make.width.mas_equalTo(WIDTH_Pay);
        
        
        
    }];
    
    /*
     * 立即开奖
     */
    [_btn_RunLottery mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_view_back.mas_left).offset(G_SCREENWIDTH-120);
        make.height.mas_equalTo(29);
        make.top.equalTo(_view_back.mas_top).offset(10);
        make.width.mas_equalTo(110);
        
        
    }];
    
    
    /*
     * 秒秒彩背景
     */
    [_view_MMC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    
    [_btn_lianKai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_view_MMC);
        make.left.equalTo(_view_MMC.mas_left).offset((G_SCREENWIDTH-150)/2.0);
        make.width.mas_equalTo(150);
    }];
    
}

-(void)relayOutWithType:(CZType)type{
    if (type==MCMMC) {
        _btn_ChaseNumber.hidden=YES;
        _btn_Pay.hidden=YES;
        
        _view_MMC.hidden=NO;
        _btn_RunLottery.hidden=NO;
    }else{
        _btn_ChaseNumber.hidden=NO;
        _btn_Pay.hidden=NO;
        
        _view_MMC.hidden=YES;
        _btn_RunLottery.hidden=YES;
    }
}

/**
 *
 * 连开次数选择
 **/
- (void)action_LianKai:(UIButton *)btn{
    MCPaySelectedLotteryPickView *picker = [[MCPaySelectedLotteryPickView alloc]init];
    picker.dataSource =@[@"1",@"5",@"10",@"15",@"20",@"30",@"40",@"50"];
    [picker show];

//    MCMSPopView *popView = [MCMSPopView alertInstance];
//    //    popView.dataArray=nil;
//    [popView.dataArray removeAllObjects];
//    popView.dataArray=[NSMutableArray arrayWithArray:@[@"1",@"5",@"10",@"15",@"20",@"30",@"40",@"50"]];
//    popView.frame = CGRectMake(_btn_lianKai.left, G_SCREENHEIGHT- 79-90,  _btn_lianKai.widht, 90);
//    __weak MCPaySelectedLotteryFooterView *weakSelf = self;
//    popView.MSSelectRowBlock = ^(NSString *type){
//        
//        [weakSelf.btn_lianKai setTitle:[NSString stringWithFormat:@"连开 %@ 次",type] forState:UIControlStateNormal];
//        weakSelf.lianKaiCount=[type intValue];
//        
//        _lab_title.text=[NSString stringWithFormat:@"共%@注 %@元",_dataSource.stakeNumber,GetRealFloatNum([_dataSource.payMoney floatValue] * weakSelf.lianKaiCount) ];
//        
//    };
//
//    [popView showModelWindow];
}

-(void)Notification_MCPaySelectedLottery_Count:(NSNotification *)notification
{
    NSString * type=notification.object;
    [self.btn_lianKai setTitle:[NSString stringWithFormat:@"连开 %@ 次",type] forState:UIControlStateNormal];
    self.lianKaiCount=[type intValue];
    
    _lab_title.text=[NSString stringWithFormat:@"共%@注 %@元",_dataSource.stakeNumber,GetRealFloatNum([_dataSource.payMoney floatValue] * self.lianKaiCount) ];
}

-(void)setDataSource:(MCPaySLBaseModel*)dataSource{
    _dataSource=dataSource;
    _lab_title.text=[NSString stringWithFormat:@"共%@注 %@元",_dataSource.stakeNumber,GetRealSNum(_dataSource.payMoney)];
}
#pragma mark-立即开奖
-(void)action_RunLottery{
    if ([self.delegate respondsToSelector:@selector(goToRunLotteryImmediately)]) {
        [self.delegate goToRunLotteryImmediately];
    }
}

+(CGFloat)computeHeight:(CZType)type{
    
    if (type==MCMMC) {
        return 49+30;
    }else{
        return 81;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



















