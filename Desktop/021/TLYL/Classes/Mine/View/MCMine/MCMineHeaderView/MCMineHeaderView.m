//
//  MCMineHeaderView.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineHeaderView.h"
#import "NSString+Helper.h"
#import "MCModifyUserImgVModel.h"

#define WIDTH_BTN  45
#define NAVTOP 64
@interface MCMineHeaderView()

@property (nonatomic ,strong)UIImageView * backImgV;


//用户头像
@property (nonatomic,strong)UIImageView * test_userIconImgV;
@property (nonatomic,strong)UIImageView * userIconImgV;

//用户名
@property (nonatomic,strong)UILabel * userNameLab;

//打底二
@property (nonatomic,strong)UIView * downView;

//可用余额
@property (nonatomic,strong)UILabel *lab_accountBalance;

//冻结金额
@property (nonatomic,strong)UILabel *lab_frozenAccount;

@property (nonatomic,strong)UIButton * zhuanZhangBtn;
@property (nonatomic,strong)MCModifyUserImgVModel * modifyUserImgVModel;
@end

@implementation MCMineHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor=[UIColor clearColor];
    
    _backImgV=[[UIImageView alloc]init];
    [self addSubview:_backImgV];
    _backImgV.userInteractionEnabled=YES;
    _backImgV.frame=CGRectMake(0, 0, G_SCREENWIDTH, HEIGHTMINEHEADERVIEW);
    _backImgV.image=[UIImage imageNamed:@"BackHeaderView"];

    [self createRight];

    //下方视图
    [self createDownView];

    /*
     * 用户头像
     */
    _userIconImgV=[[UIImageView alloc]init];
    [_backImgV addSubview:_userIconImgV];
    _userIconImgV.userInteractionEnabled=YES;
    _userIconImgV.frame=CGRectMake(18, NAVTOP+2, 60, 60);
    _userIconImgV.layer.cornerRadius=30;
    _userIconImgV.clipsToBounds=YES;
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
    _test_userIconImgV.userInteractionEnabled = YES;
    
    UIButton * modifyIconImgVBtn = [[UIButton alloc]init];
    modifyIconImgVBtn.frame=CGRectMake(18, NAVTOP+2, 60, 60);
    [_backImgV addSubview:modifyIconImgVBtn];
    [modifyIconImgVBtn addTarget:self action:@selector(modifyIcon) forControlEvents:UIControlEventTouchUpInside];
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [_test_userIconImgV addGestureRecognizer:singleTap];
    
    
    
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
//    modifyIconImgVBtn.frame=CGRectMake(18, NAVTOP+2, 60, 60);
    [_backImgV addSubview:modifyuserNameBtn];
    [modifyuserNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_userNameLab);
    }];
    [modifyuserNameBtn addTarget:self action:@selector(modifyuserName) forControlEvents:UIControlEventTouchUpInside];
    

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
    UIButton * dismissBtn=[[UIButton alloc]init];
    dismissBtn.frame=CGRectMake(L+2*W, Top, W,H);
    [_backImgV addSubview:dismissBtn];
    [self setBtn:dismissBtn andTitle:@"转账" andImgName:@"denzzjlxz" andIndex:3 andImgVRadius:Radius andTag:1003 andColor:[UIColor whiteColor]];
    _zhuanZhangBtn=dismissBtn;
    _zhuanZhangBtn.hidden=YES;
}

-(void)createDownView{
    [self addSubview:self.downView];
    self.downView.frame=CGRectMake(20, 210-40, G_SCREENWIDTH-40, 80);
    CGFloat Radius = 40;
    CGFloat W = (G_SCREENWIDTH-40)/4.0;
    CGFloat L =0;
    CGFloat Top =10;
    CGFloat H = 80;
    
    //投注记录
    UIButton * tzRecordBtn=[[UIButton alloc]init];
    tzRecordBtn.frame=CGRectMake(L, Top, W,H);
    [_downView addSubview:tzRecordBtn];
    [self setBtn:tzRecordBtn andTitle:@"投注记录" andImgName:@"person-icon-tzjl" andIndex:1 andImgVRadius:Radius andTag:1004 andColor:RGB(46,46,46)];
    
    //追号记录
    UIButton * zhRecordBtn=[[UIButton alloc]init];
    zhRecordBtn.frame=CGRectMake(L+W, Top, W,H);;
    [_downView addSubview:zhRecordBtn];
    [self setBtn:zhRecordBtn andTitle:@"追号记录" andImgName:@"person-icon-zhjl" andIndex:2 andImgVRadius:Radius andTag:1005 andColor:RGB(46,46,46)];
    
    //账变记录
    UIButton * zbRecordBtn=[[UIButton alloc]init];
    zbRecordBtn.frame=CGRectMake(L+2*W, Top, W,H);;
    [_downView addSubview:zbRecordBtn];
    [self setBtn:zbRecordBtn andTitle:@"账变记录" andImgName:@"person-icon-zbjl" andIndex:3 andImgVRadius:Radius andTag:1006 andColor:RGB(46,46,46)];
    
    //中奖记录
    UIButton * zjRecordBtn=[[UIButton alloc]init];
    zjRecordBtn.frame=CGRectMake(L+3*W, Top, W,H);
    [_downView addSubview:zjRecordBtn];
    [self setBtn:zjRecordBtn andTitle:@"中奖记录" andImgName:@"person-icon-zjjl" andIndex:4 andImgVRadius:Radius andTag:1007 andColor:RGB(46,46,46)];
    

}

-(void)setLab:(UILabel *)lab andColor:(UIColor*)color andFont:(CGFloat)font{
    lab.font = [UIFont boldSystemFontOfSize:font];
    lab.textColor=color;
    lab.text=@"加载中...";
    lab.textAlignment = NSTextAlignmentLeft;

}


-(UIView *)downView{
    if (!_downView) {
        _downView=[[UIView alloc]init];
        _downView.backgroundColor=[UIColor whiteColor];
        _downView.layer.cornerRadius=40;
        _downView.clipsToBounds=YES;
        
    }
    return _downView;
}

-(void)setBtn:(UIButton *)btn andTitle:(NSString *)title andImgName:(NSString *)imgName andIndex:(int)index andImgVRadius:(CGFloat)radius andTag:(NSInteger)tag andColor:(UIColor*)color{
    
    btn.tag=tag;
    
    UIImageView * imgV=[[UIImageView alloc]init];
    imgV.backgroundColor=[UIColor whiteColor];
    [btn addSubview:imgV];
    imgV.layer.cornerRadius=radius/2.0;
    imgV.image=[UIImage imageNamed:imgName];
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
    NSString * type=@"";
    //充值
    if (btn.tag==1001) {
        type=@"充值";
    //提款
    }else if(btn.tag==1002){
        type=@"提款";
    //转账
    }else if(btn.tag==1003){
         type=@"转账";
    //投注记录
    }else if(btn.tag==1004){
        type=@"投注记录";
    //追号记录
    }else if(btn.tag==1005){
    
        type=@"追号记录";
    //帐变记录
    }else if(btn.tag==1006){
       type=@"帐变记录";
    //中奖记录
    }else if(btn.tag==1007){
        type=@"中奖记录";
    }
    if ([self.delegate respondsToSelector:@selector(goToViewControllerWithType:)]) {
        [self.delegate goToViewControllerWithType:type];
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
-(void)setDataSource:(MCMineInfoModel*)dataSource{
    _dataSource=dataSource;

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
    if (dataSource.HeadPortrait.length<1) {
        _userIconImgV.image=[UIImage imageNamed:@"MoRenPerson_1"];
    }else{
        _userIconImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"MoRenPerson_%@",dataSource.HeadPortrait]];
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


+(CGFloat)computeHeight:(id)info{
    return 210+40;
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    

}

-(void)modifyIcon{
   
   NSString * type=@"修改头像";
    if ([self.delegate respondsToSelector:@selector(goToViewControllerWithType:)]) {
        [self.delegate goToViewControllerWithType:type];
    }
    
}

-(void)modifyuserName{
    NSString * type=@"修改昵称";
    if ([self.delegate respondsToSelector:@selector(goToViewControllerWithType:)]) {
        [self.delegate goToViewControllerWithType:type];
    }
}



@end













































