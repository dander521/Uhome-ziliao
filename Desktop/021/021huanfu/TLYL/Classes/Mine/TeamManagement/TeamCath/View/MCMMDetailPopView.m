
//
//  MCMMDetailPopView.m
//  TLYL
//
//  Created by miaocai on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMDetailPopView.h"
#import "MCGroupPaymentModel.h"
#define dicBankCode @{ @"5":@"16",@"8":@"17",@"9":@"19",@"14":@"20",@"15":@"21",@"16":@"22",@"18":@"23",@"19":@"24",@"20":@"25",@"21":@"26",@"22":@"27",@"23":@"28",@"24":@"29",@"25":@"30",@"26":@"31",@"32":@"32",@"33":@"33",@"34":@"34",@"35":@"35",@"36":@"36",@"37":@"37",@"38":@"38",@"39":@"39",@"40":@"40",@"41":@"41",@"42":@"42",@"43":@"43",@"44":@"44",@"45":@"45",@"47":@"47",@"48":@"48",@"50":@"50",@"51":@"51",@"52":@"52",@"53":@"53",@"54":@"54",@"55":@"55",@"57":@"57",@"58":@"58",@"59":@"59",@"60":@"60",@"61":@"61",@"62":@"62",@"63":@"63",@"64":@"64",@"65":@"65",@"66":@"66",@"67":@"67",@"68":@"68",@"69":@"69",@"70":@"70",@"6":@"151",@"12":@"152",@"11":@"153",@"10":@"154",@"13":@"155",@"17":@"156",@"157":@"157",@"71":@"71",@"72":@"72",@"73":@"73",@"74":@"74",@"75":@"75",@"76":@"76",@"77":@"77",@"78":@"78",@"79":@"79",@"80":@"80",@"81":@"81",@"82":@"82",@"83":@"83",@"84":@"84",@"85":@"85",@"86":@"86",@"87":@"87",@"88":@"88",@"89":@"89",@"90":@"90",@"91":@"91",@"92":@"92",@"93":@"93",@"94":@"94",@"95":@"95",@"96":@"96",@"97":@"97",@"98":@"98",@"99":@"99",@"100":@"100"}

@interface MCMMDetailPopView()

@property (nonatomic,weak) UILabel *dingDanNumberLabel;
@property (nonatomic,weak) UILabel *dingDanDetailLabel;
@property (nonatomic,weak) UILabel *jinELabel;
@property (nonatomic,weak) UILabel *jinEDetailLabel;
@property (nonatomic,weak) UILabel *dateLabel;
@property (nonatomic,weak) UILabel *dateDetailLabel;
@property (nonatomic,weak) UILabel *statusLabel;
@property (nonatomic,weak) UILabel *statusDetailLabel;
@property (nonatomic,weak) UILabel *jiaoyiStatusLabelDetail;
@property (nonatomic,weak) UILabel *jiaoyiStatusLabel;
@property (nonatomic,weak) UILabel *yuELabel;
@property (nonatomic,weak) UILabel *yuEDetailLabel;
// 名字
@property (nonatomic,weak) UILabel *label;



@end
@implementation MCMMDetailPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.frame = CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64);
        self.backgroundColor =  [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
         [self setUpUI];
    }
    return self;
}



- (void)setUpUI{
    UIView *popView = [[UIView alloc] init];
    popView.frame = CGRectMake(MC_REALVALUE(33), (G_SCREENHEIGHT - MC_REALVALUE(349 + 17 + 64 + 49))*0.5, G_SCREENWIDTH - MC_REALVALUE(66), MC_REALVALUE(349 + 17));
    popView.backgroundColor = [UIColor clearColor];
    [self addSubview:popView];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(17), popView.widht, popView.heiht - MC_REALVALUE(17))];
    UIImage *image = [UIImage imageNamed:@"touzhu-beijing"];
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
    bgView.image = newImage;
    [popView addSubview:bgView];
    //    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    bgView.userInteractionEnabled = YES;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((popView.widht - MC_REALVALUE(180))*0.5, 0, MC_REALVALUE(180), MC_REALVALUE(34))];
    label.backgroundColor = RGB(144, 8, 215);
    label.text = @"xxxxx";
    label.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = MC_REALVALUE(17);
    label.clipsToBounds = YES;
    [popView addSubview:label];
    self.label = label;
    UIView *middleView = [[UIView alloc] init];
    [bgView addSubview:middleView];
    middleView.backgroundColor = RGB(251, 251, 251);
    middleView.layer.borderWidth = 0.5;
    middleView.layer.borderColor = RGB(220, 220, 200).CGColor;
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(popView).offset(MC_REALVALUE(25));
        make.right.equalTo(popView).offset(MC_REALVALUE(-25));
        make.top.equalTo(popView).offset(MC_REALVALUE(44));
        make.bottom.equalTo(popView).offset(MC_REALVALUE(-67));
    }];
    
    
    UIButton *continueBtn = [[UIButton alloc] init];
    [bgView addSubview:continueBtn];
    continueBtn.backgroundColor = RGB(144, 8, 215);
    [continueBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    continueBtn.layer.cornerRadius = 4;
    continueBtn.clipsToBounds = YES;
    [continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(10));
        make.width.equalTo(@(MC_REALVALUE(126)));
    }];

    
    UILabel *dingDanLabel = [[UILabel alloc] init];
    [middleView addSubview:dingDanLabel];
    self.dingDanNumberLabel = dingDanLabel;
    dingDanLabel.text = @"订单编号：";
    dingDanLabel.textColor = RGB(46, 46, 46);
    dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    UILabel *dingDanDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:dingDanDetailLabel];
    dingDanDetailLabel.textColor = RGB(46, 46, 46);
    dingDanDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.dingDanDetailLabel = dingDanDetailLabel;
    dingDanDetailLabel.numberOfLines = 0;
    
    UILabel *jiaoyiStatusLabel = [[UILabel alloc] init];
    [middleView addSubview:jiaoyiStatusLabel];
    self.jiaoyiStatusLabel = jiaoyiStatusLabel;
    jiaoyiStatusLabel.text = @"交易类型：";
    jiaoyiStatusLabel.textColor = RGB(46, 46, 46);
    jiaoyiStatusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    UILabel *statusLabelDetail = [[UILabel alloc] init];
    [middleView addSubview:statusLabelDetail];
    statusLabelDetail.textColor = RGB(46, 46, 46);
    statusLabelDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jiaoyiStatusLabelDetail = statusLabelDetail;
    
    
    UILabel *jinELabel = [[UILabel alloc] init];
    [middleView addSubview:jinELabel];
    jinELabel.text = @"账变金额：";
    jinELabel.textColor = RGB(46, 46, 46);
    jinELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jinELabel = jinELabel;
    
    
    UILabel *jinEDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:jinEDetailLabel];
    jinEDetailLabel.textColor = RGB(249, 84, 83);
    jinEDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jinEDetailLabel = jinEDetailLabel;
    
    UILabel *yuELabel = [[UILabel alloc] init];
    [middleView addSubview:yuELabel];
    yuELabel.text = @"当前余额：";
    yuELabel.textColor = RGB(46, 46, 46);
    yuELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.yuELabel = yuELabel;
    
    
    UILabel *yuEDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:yuEDetailLabel];
    yuEDetailLabel.textColor = RGB(249, 84, 83);
    yuEDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.yuEDetailLabel = yuEDetailLabel;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    [middleView addSubview:dateLabel];
    dateLabel.textColor = RGB(46, 46, 46);
    dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    dateLabel.text = @"交易时间：";
    self.dateLabel = dateLabel;
    
    UILabel *dateDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:dateDetailLabel];
    dateDetailLabel.textColor = RGB(46, 46, 46);
    dateDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.dateDetailLabel = dateDetailLabel;
    
    
    UILabel *statusLabel = [[UILabel alloc] init];
    [middleView addSubview:statusLabel];
    statusLabel.textColor = RGB(46, 46, 46);
    statusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    statusLabel.text = @"备注信息：";
    self.statusLabel = statusLabel;
    
    UILabel *statusDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:statusDetailLabel];
    statusDetailLabel.textColor = RGB(46, 46, 46);
    statusDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.statusDetailLabel = statusDetailLabel;
    
   
    [self.dingDanNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView).offset(MC_REALVALUE(43));
        make.left.equalTo(middleView).offset(MC_REALVALUE(16));
        
    }];
    [self.dingDanDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel.mas_right);
        make.right.equalTo(middleView);
        make.top.equalTo(self.dingDanNumberLabel);
    }];
    [self.jiaoyiStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dingDanNumberLabel.mas_bottom).offset(MC_REALVALUE(15));
        make.left.equalTo(self.dingDanNumberLabel);
        
    }];
    [self.jiaoyiStatusLabelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jiaoyiStatusLabel.mas_right);
        make.top.equalTo(self.jiaoyiStatusLabel);
    }];
    
    
    [self.jinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jiaoyiStatusLabel.mas_bottom).offset(MC_REALVALUE(15));
        
        
    }];
    [self.jinEDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jinELabel.mas_right);
        make.top.equalTo(self.jinELabel);
    }];
    
    [self.yuELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jinELabel.mas_bottom).offset(MC_REALVALUE(15));
        
        
    }];
    [self.yuEDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right);
        make.top.equalTo(self.yuELabel);
    }];
    
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.yuELabel.mas_bottom).offset(MC_REALVALUE(15));
        
    }];
    [self.dateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right);
        make.top.equalTo(self.dateLabel);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(MC_REALVALUE(15));
        
    }];
    [self.statusDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right);
        make.top.equalTo(self.statusLabel);
    }];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidden];
}

- (void)continueBtnClick{
    
    if (self.cancelBtnBlock) {
        self.cancelBtnBlock();
    }
}

- (void)show{
    self.hidden = NO;
    self.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)hidden{
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)setDataSource:(MCTeamCModel *)dataSource{
    _dataSource = dataSource;
    self.label.text = [NSString stringWithFormat:@"%@账变记录",dataSource.UserName];
    self.dingDanDetailLabel.text = dataSource.OrderID;
    self.jinEDetailLabel.text = [NSString stringWithFormat:@"%@",dataSource.UseMoney];
    self.yuEDetailLabel.text = [NSString stringWithFormat:@"%@",dataSource.ThenBalance];
    self.dateDetailLabel.text = dataSource.InsertTime;
    self.jiaoyiStatusLabelDetail.text = [self getJiaoyiType:dataSource.DetailsSource and:dataSource.RechargeType];
    self.statusDetailLabel.text = [self getInfoType:dataSource.Marks and:dataSource.DetailsSource];
    
}
- (NSString *)getInfoType:(NSString *)Marks and:(int)DetailsSource{
        if(DetailsSource==1){
           
            return [NSString stringWithFormat:@"购买%@",[MCLotteryID getLotteryCategoriesNameByID:Marks]];  //此时 Marks 为彩种ID，可依此转换为彩种名称
        }else if(DetailsSource==10){
            return @"用户撤单";
        }else if(DetailsSource==11){
            return @"管理员撤单";
        }else if(DetailsSource==12){
            return @"追号中奖撤单";
        }else if(DetailsSource==13){
            return @"系统撤单";
        }else if(DetailsSource==20){
            return [NSString stringWithFormat:@"%@出票",[MCLotteryID getLotteryCategoriesNameByID:Marks]];   //此时 Marks 为彩种ID，可依此转换为彩种名称
        }else if(DetailsSource==30){
            return @"自身投注返点";
        }else if(DetailsSource==40){
            return [NSString stringWithFormat:@"%@向上级返点",Marks];
        }else if(DetailsSource==50){
            return @"系统派奖";
        }else if(DetailsSource==60){
            return @"管理员撤奖";
        }else if(DetailsSource==70){
            return @"申请提款，扣除余额";
        }else if(DetailsSource==90){
            return @"提款拒绝，返还账户";
        }else if(DetailsSource==100){
            return @"用户提款";
        }else if(DetailsSource==110){
            return @"用户提款";
        }else if(DetailsSource==120){
            return @"用户提款";
        }else if(DetailsSource==140){
            return @"申请充值";
        }else if(DetailsSource==150 || DetailsSource==8  || DetailsSource==14 || DetailsSource==15){
            return @"用户充值";
        }else if(DetailsSource==170){
            return @"钱包中心转入彩票";
        }else if(DetailsSource==180){
            return @"彩票转入钱包中心";
        }else if(DetailsSource==190){
            return [NSString stringWithFormat:@"给%@",Marks];;
        }else if(DetailsSource==200){
            if([Marks containsString:@"]"]){
               //判断 Marks 中是否含有']' 这个字符
                return [NSString stringWithFormat:@"来自上级的%@", [Marks componentsSeparatedByString:@"]"][1]];  //如果有']'，则按']'切分为数组，获取下标为1的值.
            }else{
                return [NSString stringWithFormat:@"来自上级%@", Marks];  //如果没有']'，则直接返回 <‘来自上级’ + Marks> 拼接起来的字符串.
            }
        }else if(DetailsSource==210){
            return @"系统分红";
        }else if(DetailsSource==220){
            return @"开户送礼";
        }else if(DetailsSource==230){
            return @"充值送礼";
        }else if(DetailsSource==231){
            return [NSString stringWithFormat:@"%@的充值佣金", Marks];
        }else if(DetailsSource==240){
            return @"投注送礼";
        }else if(DetailsSource==241){
            return [NSString stringWithFormat:@"%@的投注佣金", Marks];
        }else if(DetailsSource==251){
            return @"满就送";
        }else if(DetailsSource==252){
            return @"亏损补贴";
        }else if(DetailsSource==253){
            return [NSString stringWithFormat:@"%@的亏损佣金", Marks];
        }else if(DetailsSource==254){
            return [NSString stringWithFormat:@"%@的满就送佣金", Marks];
        }else if(DetailsSource==255){
            return @"消费拿红包";
        }else if(DetailsSource==256){
            return @"土豪签到";
        }else if(DetailsSource==257){
            return @"转盘活动";
        }else if(DetailsSource==261){  //按比例发放日工资
            return Marks;
        }else if(DetailsSource==262){  //按阶梯发放日工资
            return Marks;
        }else if(DetailsSource==263){  //来自上级的日工资
            return Marks;
        }else if(DetailsSource==264){  //发给下级的日工资
            return Marks;
        }else if(DetailsSource==265){  //人工添加日工资
            return Marks;
        }else if(DetailsSource==266){  //人工扣除日工资
            return Marks;
        }else if(DetailsSource==267){  //来自系统的分红
            return @"来自系统的分红";
        }else if(DetailsSource==268){  //来自上级的分红
            return @"来自上级的分红";
        }else if(DetailsSource==290){  //从彩票向棋牌转账
            return Marks;
        }else if(DetailsSource==300){  //从棋牌向彩票转账
            return Marks;
        }else if(DetailsSource==301){  //消费日工资
            return @"消费日工资";
        }else if(DetailsSource==302){  //亏损日工资
            return @"亏损日工资";
        }else{
            return Marks;
        }
    
    
}
- (NSString *)getJiaoyiType:(int)DetailsSource and:(int)RechargeType {
    NSString *temp = @"";
        switch(DetailsSource) {
            case 1:
            
                return @"投注";
            
                break;
            case 10:
            case 11:
            case 12:
            case 13:
                return @"撤单";
                break;
            case 17:
            case 153:
                return @"活动加款";
                break;
            case 20 :
                return @"出票";
                break;
            case 30:
                return @"自身投注返点";
                break;
            case 40:
                return @"下级返点";
                break;
            case 50:
                return @"中奖";
                break;
            case 60:
                return @"撤奖";
                break;
            case 70:
            case 90:
                return @"提款";
                break;
            case 80:
                return @"申请提款失败";
                break;
            case 100:
                return @"提款审批同意--后台人工出款";
                break;
            case 110:
                return @"提款审批同意--自动出款";
                break;
            case 120:
                return @"人工出款";
                break;
            case 121:
                return @"提款成功--刷新";
                break;
            case 122:
                return @"人工提款";
                break;
            case 130:
                return @"提款失败";
                break;
            case 131:
                return @"提款失败--刷新1";
                break;
            case 140:
                return @"申请充值";
                break;
            case 150:
            {
                if(RechargeType==0){
                    temp=@"网银充值";
                }else if(RechargeType==1){
                    temp=@"在线转账";
                }else if(RechargeType==2){
                    temp=@"其他";
                }else if(RechargeType==3){
                    temp=@"人工存款";
                }else if(RechargeType==4){
                    temp=@"活动";
                }else {
                    
                    for (NSString *key in dicBankCode.allKeys) {
                        if ([key isEqualToString:[NSString stringWithFormat:@"%d",RechargeType]]) {
                            self.dataSource.BankCode = dicBankCode[key];
                        }
                    }
                    for ( NSDictionary *dic in self.arrData) {
                        
                        if ([dic[@"Pay"] isEqualToString:self.dataSource.BankCode]) {
                           temp = dic[@"PayName"];
                        }
                    }

                }
                return temp;
            }
                break;
            case 151:
                return @"其他加款";
                break;
            case 152:
                return @"人工存款";
                break;
            case 160:
                return @"充值失败";
                break;
            case 170:
            case 180:
                return @"转账";
                break;
            case 190:
                return @"给下级充值";
                break;
            case 200:
                return @"来自上级的充值";
                break;
            case 210:
                return @"分红";
                break;
            case 220:
            case 230:
            case 231:
            case 240:
            case 241:
            case 251:
            case 252:
            case 253:
            case 254:
            case 255:
            case 256:
            case 257:
                return @"系统活动";
                break;
            case 261:
                return temp=@"按比例发放日工资";
                break;
            case 262:
                return temp=@"按阶梯发放日工资";
                break;
            case 263:
                return temp=@"来自上级的日工资";
                break;
            case 264:
                return temp=@"发给下级的日工资";
                break;
            case 265:
                return temp=@"人工添加日工资";
                break;
            case 266:
                return temp=@"人工扣除日工资";
                break;
            case 267:
            case 268:
            case 269:
                return temp=@"分红";
                break;
            case 301:
            case 302:
                return temp=@"日工资";
                break;
            case 303:
                return temp=@"其他扣款";
                break;
            case 304:
                return temp=@"活动扣款";
                break;
            default:
                return temp = @"---";
                break;
        }
    
    
}
@end
