//
//  MCPopAlertView.m
//  MC弹出框封装
//
//  Created by MC on 2017/10/9.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCPopAlertView.h"
#import "MCRecordTool.h"

//弹框宽度
#define W_PopAlertView  310


@interface MCPopAlertView()
<
UITableViewDelegate,
UITableViewDataSource
>

//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UILabel *msgLbl;
//右边按钮
@property (nonatomic,retain) UIButton *rightBtn;
//左边按钮
@property (nonatomic,retain) UIButton *leftBtn;
//背景
@property(nonatomic ,retain)UIImageView * backImgV;
//内容背景
@property(nonatomic ,retain)UIView * contentView;
//内容图标
@property(nonatomic ,retain)UIImageView * contentImgV;
//充值金额
@property (nonatomic,retain) UILabel *czMoneyLbl;
//订单编号
@property (nonatomic,retain) UILabel *orderNumberLbl;

@property (nonatomic,assign)MCPopAlertType type;


/*
 * 日工资规则使用
 */
@property (nonatomic,retain)UITableView * tableView;
@property (nonatomic,retain)MCMyDayWagesThreeRdListDataModel *dayWagesThreeRdListDataModel;
@end

@implementation MCPopAlertView
-(CGFloat)Get_H_PopAlertView{
    if (_type==MCPopAlertTypeTZRequest_Success||_type==MCPopAlertTypeTZRequest_Faild) {
        return 236;
    }else if(_type==MCPopAlertTypeTZRequest_Confirm){
        return 211;
    }else if(_type==MCPopAlertTypeCZRequest_Confirm){
        return 226;
    }else if (_type==MCPopAlertTypeZhangBian_Record){
        return 281;
    }else if (_type==MCPopAlertTypeContractMgt_DayWageRules){
        return 423+17;
    }else if (_type==MCPopAlertTypeContractMgt_DayWageDeatil){
        return 319+17;
    }else if (_type==MCPopAlertTypeContractMgt_BonusRecordDeatil){
        return 319+17;
    }
    
    return 0;
}
-(CGFloat)Get_H_backImgV{
    if (_type==MCPopAlertTypeTZRequest_Success||_type==MCPopAlertTypeTZRequest_Faild) {
        return 219;
    }else if(_type==MCPopAlertTypeTZRequest_Confirm){
        return 194;
    }else if(_type==MCPopAlertTypeCZRequest_Confirm){
        return 209;
    }else if (_type==MCPopAlertTypeZhangBian_Record){
        return 264;
    }else if (_type==MCPopAlertTypeContractMgt_DayWageRules){
        return 423;
    }else if (_type==MCPopAlertTypeContractMgt_DayWageDeatil){
        return 319;
    }else if (_type==MCPopAlertTypeContractMgt_BonusRecordDeatil){
        return 319;
    }
    
    return 0;
}
-(CGFloat)Get_H_contentView{
    if (_type==MCPopAlertTypeTZRequest_Success||_type==MCPopAlertTypeTZRequest_Faild) {
        return 125;
    }else if(_type==MCPopAlertTypeTZRequest_Confirm){
        return 100;
    }else if(_type==MCPopAlertTypeCZRequest_Confirm){
        return 115;
    }else if (_type==MCPopAlertTypeZhangBian_Record){
        return 170;
    }else if (_type==MCPopAlertTypeContractMgt_DayWageRules){
        return 310;
    }else if (_type==MCPopAlertTypeContractMgt_DayWageDeatil){
        return 225;
    }else if (_type==MCPopAlertTypeContractMgt_BonusRecordDeatil){
        return 225;
    }
    
    return 0;
}

#pragma mark-投注结果成功/失败
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title message:(NSString *)message leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle
{
    if (self == [super init]) {
        _type = type;
        [self createBackView];
        if (title) {
            [self createTitle:title];
        }
        if (message) {
            [self createMessage:message];
        }
        
        [self createRightBtn:rightTitle leftBtn:leftTitle];
        
        [self createContentWithType:type];
    }
    return self;
}
#pragma mark-充值确认
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle RechargeModel:(MCRechargeModel *)rechargeModel{
    if (self == [super init]) {
        _type=type;
        [self createBackView];
        
        if (title) {
            [self createTitle:title];
        }
        [self createRightBtn:rightTitle leftBtn:leftTitle];
        [self.alertView addSubview:self.contentView];
        
        self.czMoneyLbl= [self GetAdaptiveLable:CGRectMake(19, 20, 220, 16) AndText:[NSString stringWithFormat:@"充值金额：%@",rechargeModel.PayMoney] andFont:12 andBackColor:[UIColor clearColor] andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.czMoneyLbl];
        [self setAttributeWithRangeOfString:rechargeModel.PayMoney andStr:[NSString stringWithFormat:@"充值金额：%@",rechargeModel.PayMoney] andLab:self.czMoneyLbl andRangeColor:RGB(249,84,83) andRangeFont:12];
        
        self.orderNumberLbl= [self GetAdaptiveLable:CGRectMake(19, 40, 220, 40) AndText:[NSString stringWithFormat:@"订单编号：%@",rechargeModel.OrderID] andFont:12 andBackColor:[UIColor clearColor] andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.orderNumberLbl];
        self.orderNumberLbl.font=[UIFont systemFontOfSize:12];
        self.orderNumberLbl.numberOfLines=0;
        [self setAttributeWithRangeOfString:rechargeModel.OrderID andStr:[NSString stringWithFormat:@"订单编号：%@",rechargeModel.OrderID] andLab:self.orderNumberLbl andRangeColor:RGB(102,102,102) andRangeFont:12];
        UILabel * tipLbl= [self GetAdaptiveLable:CGRectMake(19, 85, 220, 14) AndText:@"即将前往充值渠道支付，完成后请刷新余额" andFont:10 andBackColor:[UIColor clearColor]  andTextColor:RGB(136,136,136) andTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:tipLbl];
    }
    return self;
}

#pragma mark-帐变明细
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle AccountRecordDetailDataModel:(MCUserAccountRecordDetailDataModel *)model{
    if (self == [super init]) {
        _type=type;
        [self createBackView];
        
        if (title) {
            [self createTitle:title];
        }
        [self createRightBtn:rightTitle leftBtn:leftTitle];
        [self.alertView addSubview:self.contentView];
        CGFloat H =25;
        CGFloat L =60;
      
        UIView * orderNum = [self GetAdaptiveLableLText:@"流水号：" L:L  Rect:CGRectMake(19, 10, 220, H) RText:model.OrderID andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:orderNum];
        
//        NSDictionary * Code_SourceDic=[MCRecordTool getCode_SourceDic];
        
        MCUserARecordModel * mmodel = [MCRecordTool getAccountType:model];
        
        UIView * jiaoYiLeiXing = [self GetAdaptiveLableLText:@"交易类型：" L:L  Rect:CGRectMake(19, 10+H, 220, H) RText:mmodel.name andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:jiaoYiLeiXing];
        
        UIView * jiaoYiJinE = [self GetAdaptiveLableLText:@"交易金额：" L:L  Rect:CGRectMake(19, 10+H*2, 220, H) RText:model.UseMoney andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(249,84,83) ];
        [self.contentView addSubview:jiaoYiJinE];
        
        UIView * YuE = [self GetAdaptiveLableLText:@"账户余额：" L:L  Rect:CGRectMake(19, 10+H*3, 220, H) RText:model.ThenBalance andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:YuE];
        
        UIView * Time = [self GetAdaptiveLableLText:@"账变时间：" L:L  Rect:CGRectMake(19, 10+H*4, 220, H) RText:model.InsertTime andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:Time];
        
        NSString * str_beizhu = [MCUserAccountRecordDetailDataModel getMarksDetail:model];
        UIView * BeiZhu = [self GetAdaptiveLableLText:@"备注信息：" L:L  Rect:CGRectMake(19, 10+H*5, 220, H) RText:str_beizhu andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:BeiZhu];
        
        
      
    }
    return self;
}

#pragma mark-日工资规则
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle  MyDayWagesThreeRdListDataModel:(MCMyDayWagesThreeRdListDataModel *)model{
    if (self == [super init]) {
        _type=type;
        [self createBackView];
        
        if (title) {
            [self createTitle:title];
        }
        [self createRightBtn:rightTitle leftBtn:leftTitle];
        [self.alertView addSubview:self.contentView];
        //日工资标准            销量        活跃人数
        CGFloat K1= 0.46 ,K2=0.2,K3=0.34,W=260;
        UILabel * dayRule= [self GetAdaptiveLable:CGRectMake(0, 15, W*K1, 16) AndText:@"日工资标准"andFont:12 andBackColor:[UIColor clearColor] andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:dayRule];

        UILabel * DaySales= [self GetAdaptiveLable:CGRectMake(W*K1, 15, W*K2, 16) AndText:@"销量"andFont:12 andBackColor:[UIColor clearColor] andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:DaySales];
        
        UILabel * ActiveNumber= [self GetAdaptiveLable:CGRectMake(260-W*K3, 15, W*K3, 16) AndText:@"活跃人数"andFont:12 andBackColor:[UIColor clearColor] andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:ActiveNumber];
        
        [self.contentView addSubview:self.tableView];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.frame=CGRectMake(0, 35, 260, 270);
        _dayWagesThreeRdListDataModel = model;
        [self.tableView reloadData];

        
        UILabel * tip= [self GetAdaptiveLable:CGRectMake(25, 44+[self Get_H_contentView]+8, 260, 16) AndText:@"当日投注量大于2000元为活跃用户"andFont:12 andBackColor:[UIColor clearColor] andTextColor:RGB(181,181,181) andTextAlignment:NSTextAlignmentCenter];
        [self.alertView addSubview:tip];
        
        CGFloat T =34+10+[self Get_H_contentView]+20;
        self.leftBtn.frame = CGRectMake((310-126)/2.0,T+15,126,34);
        
    }
    return self;
}

#pragma mark-日工资详情
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle  DaywagesThreeRdRecordDetailDataModel:(MCGetDaywagesThreeRdRecordDetailDataModel *)model{
    
    if (self == [super init]) {
        _type=type;
        [self createBackView];
        
        if (title) {
            [self createTitle:title];
        }
        [self createRightBtn:rightTitle leftBtn:leftTitle];
        [self.alertView addSubview:self.contentView];
//        发放类型：
//        投注总额：
//        活跃人数：
//        工资标准：
//        工资金额：
//        发放时间：
        
        
        CGFloat H =33;
        CGFloat L =60;
        CGFloat T =15;
        
        
        UIView * faFangLeiXing = [self GetAdaptiveLableLText:@"发放类型：" L:L  Rect:CGRectMake(19, T, 220, H) RText:[MCGetDaywagesThreeRdRecordDetailDataModel GetFaFangType:model.DetailSource] andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:faFangLeiXing];
        
        UIView * tZJinE = [self GetAdaptiveLableLText:@"投注总额：" L:L  Rect:CGRectMake(19, T+H, 220, H) RText:model.SalesVolume andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:tZJinE];
        
        UIView * ActivePersonNum = [self GetAdaptiveLableLText:@"活跃人数：" L:L  Rect:CGRectMake(19, T+H*2, 220, H) RText:model.ActivePersonNum andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:ActivePersonNum];
        
        NSString * sDayWagesRatio=[NSString stringWithFormat:@"%@日工资",[MCContractMgtTool getPercentNumber:model.DayWagesRatio]];
        UIView * DayWagesRatio = [self GetAdaptiveLableLText:@"日工资标准：" L:L  Rect:CGRectMake(19, T+H*3, 220, H) RText:sDayWagesRatio andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:DayWagesRatio];
        //契约管理-日工资契约：工资记录中人工扣除日工资和发给下级的 日工资值均显示负值
        NSString * mcFaFangLeiXing = [MCGetDaywagesThreeRdRecordDetailDataModel GetFaFangType:model.DetailSource];
        NSString * sDayWagesAmount = model.DayWagesAmount;
        if ([mcFaFangLeiXing isEqualToString:@"人工扣除日工资"]||[mcFaFangLeiXing isEqualToString:@"发给下级的日工资"]) {
            sDayWagesAmount = [NSString stringWithFormat:@"-%@",sDayWagesAmount];
        }
        UIView * DayWagesAmount = [self GetAdaptiveLableLText:@"日工资金额：" L:L  Rect:CGRectMake(19, T+H*4, 220, H) RText:sDayWagesAmount andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(249,84,83) ];
        [self.contentView addSubview:DayWagesAmount];
        
        UIView * Time = [self GetAdaptiveLableLText:@"发放时间：" L:L  Rect:CGRectMake(19, T+H*5, 220, H) RText:model.CreateTime andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:Time];

    }
    return self;
}

#pragma mark-分红记录详情
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle  MCGetDividentsListDeatailDataModel:(MCGetDividentsListDeatailDataModel *)model{
    if (self == [super init]) {
        _type=type;
        [self createBackView];
        
        if (title) {
            [self createTitle:title];
        }
        [self createRightBtn:rightTitle leftBtn:leftTitle];
        [self.alertView addSubview:self.contentView];
      
//        投注总额：
//        盈亏总额：
//        活跃人数：
//        分红比例：
//        分红金额：
//        分红时间：
        
        CGFloat H =33;
        CGFloat L =60;
        CGFloat T =15;
    
        
        UIView * tzMoney = [self GetAdaptiveLableLText:@"投注总额：" L:L  Rect:CGRectMake(19, T, 220, H) RText:model.TotalBatMoney andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:tzMoney];
        
        UIView * yinKuiMoney = [self GetAdaptiveLableLText:@"盈亏总额：" L:L  Rect:CGRectMake(19, T+H, 220, H) RText:model.TotalProfitLossMoney andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:yinKuiMoney];
        
        UIView * ActivePersonNum = [self GetAdaptiveLableLText:@"活跃人数：" L:L  Rect:CGRectMake(19, T+H*2, 220, H) RText:model.ActivePersonNum andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:ActivePersonNum];
        
        NSString * sBonusRatio=[NSString stringWithFormat:@"%@",[MCContractMgtTool getPercentNumber:model.DividendRatio]];
        UIView * BonusRatio = [self GetAdaptiveLableLText:@"分红比例：" L:L  Rect:CGRectMake(19, T+H*3, 220, H) RText:sBonusRatio andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:BonusRatio];
        
        UIView * DividentMoney = [self GetAdaptiveLableLText:@"分红金额：" L:L  Rect:CGRectMake(19, T+H*4, 220, H) RText:model.DividentMoney andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(249,84,83) ];
        [self.contentView addSubview:DividentMoney];
        
        UIView * Time = [self GetAdaptiveLableLText:@"分红时间：" L:L  Rect:CGRectMake(19, T+H*5, 220, H) RText:model.CreateTime andFont:12 andLTextColor:RGB(46,46,46) andRTextColor:RGB(102,102,102) ];
        [self.contentView addSubview:Time];

    }
    return self;
}
-(void)setAttributeWithRangeOfString:(NSString *)rangeStr andStr:(NSString *)str andLab:(UILabel *)lab andRangeColor:(UIColor*)rangeColor andRangeFont:(CGFloat)rangeFont{
    if (rangeStr.length>0&&str.length>0) {
        NSRange range = [str rangeOfString:rangeStr];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = 3; //设置行间距
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        //设置字间距 NSKernAttributeName:@1.5f
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.1
                              };
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:dic];
        // 修改富文本中的不同文字的样式
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:rangeFont] range:NSMakeRange(range.location, range.length)];
        
        // 设置颜色
        [attributeStr addAttribute:NSForegroundColorAttributeName value:rangeColor range:NSMakeRange(range.location, range.length)];
    
        lab.attributedText=attributeStr;
    }
}

-(void)createBackView{
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.backgroundColor = [UIColor clearColor];
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.opaque = NO;
    [self addSubview:dimmingView];
    dimmingView.alpha = 0.5f;

    self.alertView = [[UIView alloc] init];
    self.alertView.backgroundColor = [UIColor clearColor];
    self.alertView.layer.cornerRadius = 5.0;
    
    self.alertView.frame = CGRectMake(0, 0, W_PopAlertView, [self Get_H_PopAlertView]);
    self.alertView.layer.position = self.center;
    [self addSubview:self.alertView];
    
    _backImgV=[[UIImageView alloc]init];
    [self.alertView addSubview:_backImgV];
    _backImgV.frame=CGRectMake(0, [self Get_H_PopAlertView]-[self Get_H_backImgV], W_PopAlertView, [self Get_H_backImgV]);
    UIImage * image = [UIImage imageNamed:@"touzhu-beijing"];
    
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    _backImgV.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
}


-(void)createTitle:(NSString *)title{
    
    CGFloat titleW = 180;
    CGFloat titleH = 34;
    
    self.titleLbl = [self GetAdaptiveLable:CGRectMake((W_PopAlertView-titleW)/2, 0, titleW, titleH) AndText:title andFont:15 andBackColor:RGB(144,8,215) andTextColor:[UIColor whiteColor] andTextAlignment:NSTextAlignmentCenter];
    self.titleLbl.layer.cornerRadius=17;
    [self.alertView addSubview:self.titleLbl];
    
}

-(void)createMessage:(NSString *)message{
    self.msgLbl = [self GetAdaptiveLable:CGRectMake(0,125,W_PopAlertView, 40) AndText:message andFont:14 andBackColor:[UIColor clearColor] andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    self.msgLbl.numberOfLines=0;
}

-(void)createRightBtn:(NSString *)rightTitle leftBtn:(NSString *)leftTitle{

    CGFloat L =25,T =34+10+[self Get_H_contentView]+10,W =126,H =34;
    
    if(rightTitle.length<1&&leftTitle.length>0){
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.leftBtn.frame = CGRectMake((310-126)/2.0,T,W,H);
        self.leftBtn.backgroundColor=RGB(144,8,215);
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.leftBtn.tag = 1;
        [self.leftBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.clipsToBounds=YES;
        self.leftBtn.layer.cornerRadius=4;
        [self.alertView addSubview:self.leftBtn];
        
    }else{
        if (leftTitle) {
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.leftBtn.frame = CGRectMake(L,T,W,H);
            self.leftBtn.backgroundColor=RGB(144,8,215);
            [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.leftBtn.tag = 1;
            [self.leftBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            self.leftBtn.clipsToBounds=YES;
            self.leftBtn.layer.cornerRadius=4;
            [self.alertView addSubview:self.leftBtn];
        }
        
        if (rightTitle) {
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.rightBtn.frame = CGRectMake(L+W+9,T,W,H);
            self.rightBtn.backgroundColor=RGB(255,168,0);
            [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn.tag = 2;
            [self.rightBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            self.rightBtn.clipsToBounds=YES;
            self.rightBtn.layer.cornerRadius=4;
            [self.alertView addSubview:self.rightBtn];
            
        }
    }
}


-(void)createContentWithType:(MCPopAlertType)type{
    
    if (type == MCPopAlertTypeTZRequest_Success) {
        
        [self.alertView addSubview:self.contentView];
        [self.alertView addSubview:self.contentImgV];
        self.contentImgV.image=[UIImage imageNamed:@"MCPopAlertTypeTZRequest_Success"];
        self.msgLbl.textColor=RGB(35,198,46);
        
    }else if (type == MCPopAlertTypeTZRequest_Faild){
        
        [self.alertView addSubview:self.contentView];
        [self.alertView addSubview:self.contentImgV];
        self.contentImgV.image=[UIImage imageNamed:@"MCPopAlertTypeTZRequest_Faild"];
        self.msgLbl.textColor=RGB(249,84,83);
        
    }else if (type == MCPopAlertTypeTZRequest_Confirm){
        
        [self.alertView addSubview:self.contentView];
        self.msgLbl.center=self.contentView.center;
        
    }
    [self.alertView addSubview:self.msgLbl];
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView=[[UIView alloc]init];
        _contentView.backgroundColor=RGB(251,251,251);
        _contentView.frame=CGRectMake(25, 44, 260, [self Get_H_contentView]);
        _contentView.layer.cornerRadius=3;
        _contentView.clipsToBounds=YES;
    }
    return _contentView;
}
-(UIImageView *)contentImgV{
    if (!_contentImgV) {
        _contentImgV=[[UIImageView alloc]init];
        _contentImgV.frame=CGRectMake(130, 71, 50, 50);
    }
    return _contentImgV;
}
#pragma mark - 弹出 -
- (void)showXLAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 回调 -设置只有2  -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{
    if (self.resultIndex) {
        self.resultIndex(sender.tag);
    }
    [self removeFromSuperview];
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andFont:(CGFloat)font andBackColor:(UIColor*)backColor andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment;
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.text = contentStr;
    contentLbl.textAlignment = textAlignment;
    contentLbl.font = [UIFont systemFontOfSize:font];
    contentLbl.textColor=textColor;
    contentLbl.backgroundColor=backColor;
    contentLbl.clipsToBounds=YES;
    
    return contentLbl;
}

-(UIView *)GetAdaptiveLableLText:(NSString *)L_text L:(CGFloat)L Rect:(CGRect)rect RText:(NSString *)R_text andFont:(CGFloat)font andLTextColor:(UIColor *)L_textColor andRTextColor:(UIColor *)R_textColor ;
{
    UIView * back = [[UIView alloc]initWithFrame:rect];
    UILabel * L_Lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, L+10, rect.size.height)];
    L_Lab.text = L_text;
    L_Lab.textAlignment = NSTextAlignmentLeft;
    L_Lab.font = [UIFont systemFontOfSize:font];
    L_Lab.textColor=L_textColor;
    [back addSubview:L_Lab];
    
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(L+5, 0, rect.size.width-L-5, rect.size.height)];
    contentLbl.text = R_text;
    contentLbl.textAlignment = NSTextAlignmentLeft;
    contentLbl.font = [UIFont systemFontOfSize:font];
    contentLbl.textColor=R_textColor;
    [back addSubview:contentLbl];
    
    if ([R_text containsString:@"%日工资"]&&[L_text containsString:@"工资标准："]) {
        NSString * str = R_text;
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSForegroundColorAttributeName value:RGB(255,168,0) range:NSMakeRange(0, str.length-3)];
        contentLbl.attributedText=attri;
    }else if (_type==MCPopAlertTypeContractMgt_BonusRecordDeatil&&[L_text containsString:@"分红比例"]){
        NSString * str = R_text;
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSForegroundColorAttributeName value:RGB(255,168,0) range:NSMakeRange(0, str.length)];
        contentLbl.attributedText=attri;
    }
    
    return back;
}


#pragma mark----get/set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //最大值=自己的标准
    
    if (_dayWagesThreeRdListDataModel.InitDayWagesRules.count > 0) {
        
        MCMyDayWagesThreeRdDayRuleDataModel * myModel = _dayWagesThreeRdListDataModel.Before_DayWagesRules[0];
        int i = 0;
        for (MCMyDayWagesThreeRdDayRuleDataModel *  model in _dayWagesThreeRdListDataModel.InitDayWagesRules) {
            if ([model.DayWagesProportion isEqualToString:myModel.DayWagesProportion]) {
                return i+1;
            }
            i++;
        }
        
        return _dayWagesThreeRdListDataModel.InitDayWagesRules.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MCDayWageContractRulesTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCDayWageContractRulesTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCDayWageContractRulesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCDayWageContractRulesTableViewCell
                 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_dayWagesThreeRdListDataModel.InitDayWagesRules.count>indexPath.row) {
        cell.dataSource=_dayWagesThreeRdListDataModel.InitDayWagesRules[indexPath.row];

    }
    
    return cell;
}

@end
















@interface MCDayWageContractRulesTableViewCell()

@property (nonatomic,strong) UILabel * DayWagesProportion ;//日工资标准（数据）
@property (nonatomic,strong) UILabel * DaySales;//销量
@property (nonatomic,strong) UILabel * ActiveNumber;// 活跃人数

@end

@implementation MCDayWageContractRulesTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *baseView = [[UIView alloc] init];
    [self addSubview:baseView];
    baseView.backgroundColor = [UIColor clearColor];
    baseView.frame=CGRectMake(0, 0,260, 30);
    CGFloat K1= 0.46 ,K2=0.2,K3=0.34,W=260;
    
    
    //日工资标准：1.1%        0        ：0
    _DayWagesProportion = [[UILabel alloc] init];
    _DayWagesProportion.font=[UIFont systemFontOfSize:10];
    _DayWagesProportion.textColor=RGB(249,84,83);
    _DayWagesProportion.textAlignment=NSTextAlignmentCenter;
    [baseView addSubview:self.DayWagesProportion];
    _DayWagesProportion.text = @"加载中...";
    _DayWagesProportion.frame =CGRectMake(0, 15, W*K1, 16);
    
    _DaySales = [[UILabel alloc] init];
    [baseView addSubview:_DaySales];
    _DaySales.font=[UIFont systemFontOfSize:10];
    _DaySales.textColor=RGB(249,84,83);
    _DaySales.textAlignment=NSTextAlignmentCenter;
    _DaySales.text = @"加载中...";
    _DaySales.frame = CGRectMake(W*K1, 15, W*K2, 16);
    
    
    _ActiveNumber = [[UILabel alloc] init];
    [baseView addSubview:_ActiveNumber];
    _ActiveNumber.font=[UIFont systemFontOfSize:10];
    _ActiveNumber.textColor=RGB(249,84,83);
    _ActiveNumber.textAlignment=NSTextAlignmentCenter;
    _ActiveNumber.text = @"加载中...";
    _ActiveNumber.frame = CGRectMake(260-W*K3, 15, W*K3, 16);

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDataSource:(MCMyDayWagesThreeRdDayRuleDataModel *)dataSource{
    _dataSource = dataSource;
    _DayWagesProportion.text = [NSString stringWithFormat:@"%@的日工资",[MCContractMgtTool getPercentNumber:dataSource.DayWagesProportion]];
    _DaySales.text = [NSString stringWithFormat:@"%@",dataSource.DaySales];
    _ActiveNumber.text = [NSString stringWithFormat:@"%@",dataSource.ActiveNumber];
    
}

+(CGFloat)computeHeight:(id)info{
    return 30;
}

@end



































