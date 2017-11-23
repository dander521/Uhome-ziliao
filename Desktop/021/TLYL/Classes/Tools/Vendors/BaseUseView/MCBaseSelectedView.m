//
//  MCBaseSelectedView.m
//  TLYL
//
//  Created by MC on 2017/10/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBaseSelectedView.h"
#import "UIView+MCParentController.h"
#import "MCRechargeViewController.h"
#import "NSString+Helper.h"
#import "MCMineInfoModel.h"
#import "MCUserMoneyModel.h"

#define HEIGHTMINEHEADERVIEW  300

#define WIDTH_BTN  45
#define NAVTOP 40
@interface MCBaseSelectedView()

@property (nonatomic ,strong)UIImageView * backImgV;


//用户头像
@property (nonatomic,strong)UIImageView * test_userIconImgV;
@property (nonatomic,strong)UIImageView * userIconImgV;

//用户名
@property (nonatomic,strong)UILabel * userNameLab;

//可用余额
@property (nonatomic,strong)UILabel *lab_accountBalance;

//冻结金额
@property (nonatomic,strong)UILabel *lab_frozenAccount;
@property (nonatomic,strong)UIButton * zhuanZhangBtn;
@end

@implementation MCBaseSelectedView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor=RGB(35, 16, 51);
    
    _backImgV=[[UIImageView alloc]init];
    [self addSubview:_backImgV];
    _backImgV.userInteractionEnabled=YES;
    _backImgV.frame=CGRectMake(0, 0, G_SCREENWIDTH, HEIGHTMINEHEADERVIEW);
//    _backImgV.image=[UIImage imageNamed:@"BackHeaderView"];
    
    [self createRight];
    
    //下方视图
    [self createDownView];
    
    /*
     * 用户头像
     */
    _userIconImgV=[[UIImageView alloc]init];
    [_backImgV addSubview:_userIconImgV];
    _userIconImgV.userInteractionEnabled=YES;
    _userIconImgV.layer.cornerRadius=30;
    _userIconImgV.clipsToBounds=YES;
    _userIconImgV.frame=CGRectMake(18, NAVTOP+2, 60, 60);
    MCMineInfoModel * Mmodel=[MCMineInfoModel sharedMCMineInfoModel];
    NSLog(@"%@=-----",Mmodel.HeadPortrait);
    
    if (Mmodel.HeadPortrait.length<1) {
        _userIconImgV.image=[UIImage imageNamed:@"MoRenPerson_1"];
    }else{
        _userIconImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"MoRenPerson_%@",Mmodel.HeadPortrait]];
    }
    

    _test_userIconImgV=[[UIImageView alloc]init];
    [_backImgV addSubview:_test_userIconImgV];
    _test_userIconImgV.userInteractionEnabled=YES;
    _test_userIconImgV.image=[UIImage imageNamed:@"testMoRenPerson"];
    _test_userIconImgV.frame=CGRectMake(18, NAVTOP+2, 60, 60);
    _test_userIconImgV.layer.cornerRadius=30;
    _test_userIconImgV.clipsToBounds=YES;
    
    
    UIButton * modifyIconImgVBtn = [[UIButton alloc]init];
    modifyIconImgVBtn.frame=CGRectMake(18, NAVTOP+2, 60, 60);
    [_backImgV addSubview:modifyIconImgVBtn];
    modifyIconImgVBtn.tag=2009;
    [modifyIconImgVBtn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     * 用户名
     */
    _userNameLab =[[UILabel alloc]init];
    [_backImgV addSubview:_userNameLab];
    [self setLab:_userNameLab andColor:[UIColor whiteColor] andFont:14];
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIconImgV.mas_right).offset(12.5);
        make.top.equalTo(_userIconImgV.mas_top).offset(5);
        make.height.mas_equalTo(16);
    }];
    UIButton * modifyuserNameBtn = [[UIButton alloc]init];
    [_backImgV addSubview:modifyuserNameBtn];
    [modifyuserNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_userNameLab);
    }];
    modifyuserNameBtn.tag=2010;
    [modifyuserNameBtn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
    
    /******************************************/
    /*
     * 可用余额
     */
    _lab_accountBalance=[[UILabel alloc]init];
    [_backImgV addSubview:_lab_accountBalance];
    [self setLab:_lab_accountBalance andColor:RGB(255, 228, 0) andFont:12];
    [_lab_accountBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLab.mas_left).offset(0);
        make.top.equalTo(_userNameLab.mas_bottom).offset(5);
    }];
    
    
    /*
     * 冻结金额
     */
    _lab_frozenAccount=[[UILabel alloc]init];
    [_backImgV addSubview:_lab_frozenAccount];
    [self setLab:_lab_frozenAccount andColor:RGB(255, 228, 0) andFont:12];
    [_lab_frozenAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLab.mas_left).offset(0);
        make.top.equalTo(_lab_accountBalance.mas_bottom).offset(5);
    }];
    
    /*
     * 退出登录
     */
    UIButton * loginOutBtn = [[UIButton alloc]init];
    [self addSubview:loginOutBtn];
    loginOutBtn.backgroundColor=[UIColor clearColor];
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [loginOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginOutBtn.layer.cornerRadius=16;
    [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(32);
        make.bottom.equalTo(_backImgV.mas_bottom).offset(-20);
    }];
    [loginOutBtn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
    loginOutBtn.tag=3000;
    loginOutBtn.layer.borderColor = RGB(95,39,128).CGColor;
    loginOutBtn.layer.borderWidth = 0.5;
    
}
-(void)createRight{
    CGFloat Radius = 30;
    CGFloat W = Radius+24;
    CGFloat L =G_SCREENWIDTH-18-24-24-Radius*3 -12;
    CGFloat Top =NAVTOP + 12;
    CGFloat H = Radius+20;
    //充值
    UIButton * rechargeBtn=[[UIButton alloc]init];
    rechargeBtn.frame=CGRectMake(L, Top, W,H);
    [_backImgV addSubview:rechargeBtn];
    [self setBtn:rechargeBtn andTitle:@"充值" andImgName:@"icon-recharge" andIndex:1 andImgVRadius:Radius andTag:1001 andColor:[UIColor whiteColor]];
    
    
    //提款
    UIButton * withdrawBtn=[[UIButton alloc]init];
    withdrawBtn.frame=CGRectMake(L+W, Top, W,H);
    [_backImgV addSubview:withdrawBtn];
    [self setBtn:withdrawBtn andTitle:@"提款" andImgName:@"icon-drawing" andIndex:2 andImgVRadius:Radius andTag:1002 andColor:[UIColor whiteColor]];
    
    //转账
    UIButton * zhuanZhangBtn=[[UIButton alloc]init];
    zhuanZhangBtn.frame=CGRectMake(L+2*W, Top, W,H);
    [_backImgV addSubview:zhuanZhangBtn];
    [self setBtn:zhuanZhangBtn andTitle:@"转账" andImgName:@"denzzjlxz" andIndex:3 andImgVRadius:Radius andTag:1003 andColor:[UIColor whiteColor]];
    _zhuanZhangBtn=zhuanZhangBtn;
    _zhuanZhangBtn.hidden=YES;
}

-(void)createDownView{
    
    CGFloat Radius = 16;
    CGFloat W = 70;
    CGFloat L =30;
    CGFloat Top =120+10;
    CGFloat H = 16;
    CGFloat Padding = 40;

    
//    购彩大厅              优惠活动              会员中心
    UIButton * buyLotteryHallBtn=[[UIButton alloc]init];
    [_backImgV addSubview:buyLotteryHallBtn];
    buyLotteryHallBtn.frame=CGRectMake(L, Top, W,H);
    [self setDown_Btn:buyLotteryHallBtn andTitle:@"购彩大厅" andImgName:@"drop-down-home"  andImgVRadius:Radius andTag:2000 andColor:[UIColor whiteColor]];

    UIButton * youhuiHuoDongBtn=[[UIButton alloc]init];
    [_backImgV addSubview:youhuiHuoDongBtn];
    youhuiHuoDongBtn.frame=CGRectMake((G_SCREENWIDTH-W)/2.0, Top, W,H);
    [self setDown_Btn:youhuiHuoDongBtn andTitle:@"优惠活动" andImgName:@"drop-down-discount"  andImgVRadius:Radius andTag:2001 andColor:[UIColor whiteColor]];
    
    
    UIButton * huiYuanZhongXinBtn=[[UIButton alloc]init];
    [_backImgV addSubview:huiYuanZhongXinBtn];
    huiYuanZhongXinBtn.frame=CGRectMake(G_SCREENWIDTH-W-L, Top, W,H);
    [self setDown_Btn:huiYuanZhongXinBtn andTitle:@"会员管理" andImgName:@"drop-down-my" andImgVRadius:Radius andTag:2002 andColor:[UIColor whiteColor]];
    
//    系统公告              开奖公告              游戏记录
    UIButton * xiTongGongGaoBtn=[[UIButton alloc]init];
    [_backImgV addSubview:xiTongGongGaoBtn];
    xiTongGongGaoBtn.frame=CGRectMake(L, Top+Padding, W,H);
    [self setDown_Btn:xiTongGongGaoBtn andTitle:@"系统公告" andImgName:@"drop-down-notice"  andImgVRadius:Radius andTag:2003 andColor:[UIColor whiteColor]];
    
    UIButton * kaiJiangGongGaoBtn=[[UIButton alloc]init];
    [_backImgV addSubview:kaiJiangGongGaoBtn];
    kaiJiangGongGaoBtn.frame=CGRectMake((G_SCREENWIDTH-W)/2.0, Top+Padding, W,H);
    [self setDown_Btn:kaiJiangGongGaoBtn andTitle:@"开奖公告" andImgName:@"drop-down-prize" andImgVRadius:Radius andTag:2004 andColor:[UIColor whiteColor]];
    
    
    UIButton * youXiJiLuBtn=[[UIButton alloc]init];
    [_backImgV addSubview:youXiJiLuBtn];
    youXiJiLuBtn.frame=CGRectMake(G_SCREENWIDTH-W-L, Top+Padding, W,H);
    [self setDown_Btn:youXiJiLuBtn andTitle:@"投注记录" andImgName:@"drop-down-record" andImgVRadius:Radius andTag:2005 andColor:[UIColor whiteColor]];
    
    
//    彩票走势              使用帮助              在线客服
//    UIButton * caiPiaoZouShiBtn=[[UIButton alloc]init];
//    [_backImgV addSubview:caiPiaoZouShiBtn];
//    caiPiaoZouShiBtn.frame=CGRectMake(L, Top+Padding*2, W,H);
//    [self setDown_Btn:caiPiaoZouShiBtn andTitle:@"彩票走势" andImgName:@"drop-down-trend"  andImgVRadius:Radius andTag:2006 andColor:[UIColor whiteColor]];
    
    UIButton * shiYongBangZhuBtn=[[UIButton alloc]init];
    [_backImgV addSubview:shiYongBangZhuBtn];
//    shiYongBangZhuBtn.frame=CGRectMake((G_SCREENWIDTH-W)/2.0, Top+Padding*2, W,H);
    shiYongBangZhuBtn.frame=CGRectMake(L, Top+Padding*2, W,H);
    [self setDown_Btn:shiYongBangZhuBtn andTitle:@"使用帮助" andImgName:@"drop-down-help" andImgVRadius:Radius andTag:2007 andColor:[UIColor whiteColor]];
    
    
    UIButton * zaiXianKeFuBtn=[[UIButton alloc]init];
    [_backImgV addSubview:zaiXianKeFuBtn];
    zaiXianKeFuBtn.frame=CGRectMake((G_SCREENWIDTH-W)/2.0, Top+Padding*2, W,H);
//    zaiXianKeFuBtn.frame=CGRectMake(G_SCREENWIDTH-W-L, Top+Padding*2, W,H);
    [self setDown_Btn:zaiXianKeFuBtn andTitle:@"在线客服" andImgName:@"drop-down-service" andImgVRadius:Radius andTag:2008 andColor:[UIColor whiteColor]];
   
}

-(void)setLab:(UILabel *)lab andColor:(UIColor*)color andFont:(CGFloat)font{
    lab.font = [UIFont boldSystemFontOfSize:font];
    lab.textColor=color;
    lab.text=@"加载中...";
    lab.textAlignment = NSTextAlignmentLeft;
    
}


-(void)setDown_Btn:(UIButton *)btn andTitle:(NSString *)title andImgName:(NSString *)imgName andImgVRadius:(CGFloat)radius andTag:(NSInteger)tag andColor:(UIColor*)color{
    
    btn.tag=tag;
    
    UIImageView * imgV=[[UIImageView alloc]init];
    [btn addSubview:imgV];
    imgV.layer.cornerRadius=radius/2.0;
    imgV.image=[UIImage imageNamed:imgName];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.width.mas_equalTo(radius);
        make.height.mas_equalTo(radius);
        make.left.equalTo(btn.mas_left);
    }];
    imgV.userInteractionEnabled=NO;
    
    UILabel * lab=[[UILabel alloc]init];
    lab.textColor=color;
    lab.font=[UIFont boldSystemFontOfSize:10];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.text=title;
    [btn addSubview:lab];
    lab.userInteractionEnabled=NO;
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.left.equalTo(imgV.mas_right).offset(10);
        make.right.equalTo(btn.mas_right);
        make.height.mas_equalTo(16);
    }];
    
    [btn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setBtn:(UIButton *)btn andTitle:(NSString *)title andImgName:(NSString *)imgName andIndex:(int)index andImgVRadius:(CGFloat)radius andTag:(NSInteger)tag andColor:(UIColor*)color{
    
    btn.tag=tag;
    
    UIImageView * imgV=[[UIImageView alloc]init];
    [btn addSubview:imgV];
    imgV.layer.cornerRadius=radius/2.0;
    imgV.image=[UIImage imageNamed:imgName];
    imgV.backgroundColor=[UIColor whiteColor];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.top.equalTo(btn.mas_top).offset(0);
        make.width.mas_equalTo(radius);
        make.height.mas_equalTo(radius);
    }];
    imgV.userInteractionEnabled=NO;
    
    UILabel * lab=[[UILabel alloc]init];
    lab.textColor=color;
    lab.font=[UIFont boldSystemFontOfSize:10];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.text=title;
    [btn addSubview:lab];
    lab.userInteractionEnabled=NO;
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.top.equalTo(imgV.mas_bottom).offset(5);
        make.left.equalTo(btn);
        make.right.equalTo(btn);
    }];
    
    [btn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)action_Btn:(UIButton*)btn{
    if (self.block) {
        self.block(btn.tag);
    }
}

/**
 *   获取字符宽度
 */
- (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat )font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    [label sizeToFit];
    return label.frame.size.width;
}

-(void)reloadData{
    MCUserMoneyModel *userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    if (userMoneyModel.FreezeMoney&&userMoneyModel.LotteryMoney) {
        //可用余额
        [self setAccountBalance:userMoneyModel.LotteryMoney];
        
        //冻结金额
        [self setFrozenAccount:userMoneyModel.FreezeMoney];
        
    }
    
    MCMineInfoModel * dataSource=[MCMineInfoModel sharedMCMineInfoModel];
//    NSString * UserName=[[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"];
    if (dataSource.UserNickName.length<1) {
        _userNameLab.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"];
    }else{
        _userNameLab.text=dataSource.UserNickName;
    }
    if ([dataSource.UserType intValue]==1) {
        _test_userIconImgV.hidden=NO;
    }else{
        _test_userIconImgV.hidden=YES;
    }

    int Mode = (int)[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode];
    MCMineInfoModel *mineInfoModel =[MCMineInfoModel sharedMCMineInfoModel];
    if (((Mode & 32) != 32) || ([mineInfoModel.UserType intValue] ==1) ) {
        //隐藏转账和棋牌项
        _zhuanZhangBtn.hidden=YES;
        
    }else{
        //显示转账和棋牌项
        _zhuanZhangBtn.hidden=NO;
    }
    
}


//可用余额
-(void)setAccountBalance:(NSString *)accountBalance{
    _lab_accountBalance.text=[NSString stringWithFormat:@"￥%@",[MCMathUnits GetMoneyShowNum:accountBalance]];
}


//冻结金额
-(void)setFrozenAccount:(NSString *)frozenAccount{
    _lab_frozenAccount.text=[NSString stringWithFormat:@"冻结：%@",[MCMathUnits GetMoneyShowNum:frozenAccount]];
}


#pragma mark-刷新头像
-(void)refreashImgVIcon{
    
    MCMineInfoModel * Mmodel=[MCMineInfoModel sharedMCMineInfoModel];
    NSLog(@"%@=-----",Mmodel.HeadPortrait);
    
    if (Mmodel.HeadPortrait.length<1) {
        _userIconImgV.image=[UIImage imageNamed:@"MoRenPerson_1"];
    }else{
        _userIconImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"MoRenPerson_%@",Mmodel.HeadPortrait]];
    }
    
}
@end





























