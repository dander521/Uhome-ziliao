//
//  MCWithdrawRecDeltailViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWithdrawRecDeltailViewController.h"
#import "MCRechargeHeaderView.h"
#import "MCBankTableViewController.h"
#import "MCSelectedBottomView.h"
#import "NSString+Helper.h"
#import "MCUserMoneyModel.h"
#import "MCWithdrawAPIModel.h"
#import "MCMineInfoModel.h"
#import "MCDataTool.h"
#define UILABEL_LINE_SPACE 5
#define UILABEL_Kern_SPACE 0.1
@interface MCWithdrawRecDeltailViewController ()
<
MCSelectedBottomDelegate
>
typedef void(^MCWithdrawRecDeltailViewControllerCompeletion)(BOOL result, NSDictionary *data );

@property (nonatomic,strong)MCRechargeHeaderView * headerView;

@property (weak, nonatomic)  UITextField *bankTextFeild;
@property (weak, nonatomic)  UITextField *moneyTextField;
@property (weak, nonatomic)  UITextField *passwordTextField;

@property (nonatomic,strong)UIButton *withdrawBtn;
@property (nonatomic,strong)MCBankModel *selectModel;
@property (nonatomic,strong)MCUserMoneyModel * money_model;
@property (nonatomic,strong)MCWithdrawAPIModel * apiModel;
@property (nonatomic,strong)MCMineInfoModel *mineInfoModel;
//提现最小值
@property (nonatomic,assign)int DrawMinMoney;
//提现最大值
@property (nonatomic,assign)int DrawMaxMoney;

@end

@implementation MCWithdrawRecDeltailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    self.navigationItem.title = @"提款";
    self.view.backgroundColor = RGB(231, 231, 231);
    
 
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [BKIndicationView dismiss];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    [self loadData];
    [self reloadUserMoney];
}

#pragma mark-Header
-(MCRechargeHeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[MCRechargeHeaderView alloc]init];
    }
    return _headerView;
}

-(void)setTitle:(NSString *)title andTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type andIndex:(int)index andBackView:(UIView *)backView{
    
    CGFloat padding=50;
    
    UILabel * lab=[[UILabel alloc]init];
    [backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.text=title;
    lab.textColor=RGB(46,46,46);
    lab.frame=CGRectMake(10, index*padding, 80, padding);

    [backView addSubview:textField];
    textField.frame=CGRectMake(80, index*padding, G_SCREENWIDTH-20-100, padding);
    textField.placeholder=placeholder;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor=[UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = RGB(40, 40, 40);
    textField.textAlignment = NSTextAlignmentLeft;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = type;
    [textField setValue:RGB(190, 190, 190) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    
    if (index<2) {
        UIView * line=[[UIView alloc]init];
        line.backgroundColor=RGB(213,213,213);
        line.frame=CGRectMake(10, padding*(index+1), G_SCREENWIDTH-20-10, 0.5);
        [backView addSubview:line];
    }
}

- (void)setUpUI{
    
    [self.view addSubview:self.headerView];
    self.headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, [MCRechargeHeaderView computeHeight:nil]);
    _selectModel=[[MCBankModel alloc]init];

    UIView * upview=[[UIView alloc]init];
    [self.view addSubview:upview];
    upview.backgroundColor=[UIColor whiteColor];
    upview.frame=CGRectMake(10, [MCRechargeHeaderView computeHeight:nil]+10, G_SCREENWIDTH-20, 150);
    upview.layer.cornerRadius=10;
    upview.clipsToBounds=YES;
    
    UITextField * bankTextFeild=[[UITextField alloc]init];
    _bankTextFeild=bankTextFeild;
    _bankTextFeild.userInteractionEnabled=NO;
    [self setTitle:@"到款账户" andTextField:bankTextFeild WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:0 andBackView:upview];
    
    UITextField * moneyTextField=[[UITextField alloc]init];
    _moneyTextField=moneyTextField;
    _moneyTextField.tag=1001;
    [self setTitle:@"提款金额" andTextField:moneyTextField WithPlaceholder:@"" and:UIKeyboardTypeDecimalPad andIndex:1 andBackView:upview];
    
    UITextField * passwordTextField=[[UITextField alloc]init];
    _passwordTextField=passwordTextField;
    _passwordTextField.secureTextEntry = YES;
    [self setTitle:@"资金密码" andTextField:passwordTextField WithPlaceholder:@"请输入您的资金密码" and:UIKeyboardTypeDefault andIndex:2 andBackView:upview];
    
    _withdrawBtn=[[UIButton alloc]init];
    [self setFooter:_withdrawBtn];

    UILabel *infoLabel = [[UILabel alloc] init];
    NSString *DrawBeginTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"DrawBeginTime"];
    NSString *DrawEndTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"DrawEndTime"];
    if ([DrawBeginTime isEqualToString:DrawEndTime]) {
        infoLabel.text = @"取款到账时间为1-5分钟，取款时间为:全天24小时";
    } else {
        infoLabel.text = [NSString stringWithFormat:@"取款到账时间为1-5分钟，取款时间为:%@~%@", [self timeStr:[DrawEndTime intValue]],[self timeStr:[DrawBeginTime intValue]]];
    }
    [self setLabelSpace:infoLabel withValue:[NSString stringWithFormat:@"提款到默认银行\n%@",infoLabel.text] withFont:[UIFont systemFontOfSize:12]];
    infoLabel.numberOfLines=0;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = RGB(136,136,136);
    [self.view addSubview:infoLabel];
    infoLabel.frame = CGRectMake(0, G_SCREENHEIGHT - 50 - 64, G_SCREENWIDTH, 40);
    

    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [self.view  addGestureRecognizer:singleTapGesture];
    

    
}
- (NSString *)timeStr:(int)drawTime{
    
        if(drawTime>=0 && drawTime < 6){
            return [NSString stringWithFormat:@"凌晨%d:00",drawTime];
        }else if (drawTime>=6 && drawTime < 12){
            return [NSString stringWithFormat:@"上午%d:00",drawTime];

        }else if (drawTime>=12 && drawTime < 18){
            return [NSString stringWithFormat:@"下午%d:00",drawTime];
   
        }else{
            return [NSString stringWithFormat:@"晚上%d:00",drawTime];
        }
}

#pragma mark - gesture actions
- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

-(void)setFooter:(UIButton *)btn{
    
    btn.frame=CGRectMake(10, [MCRechargeHeaderView computeHeight:nil]+10+50*3+10, G_SCREENWIDTH-20, 40);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即提款" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.backgroundColor=RGB(143, 0, 210);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(withdrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=5.0;
    btn.clipsToBounds=YES;

}


#pragma mark-loadData
-(void)loadData{

    MCMineInfoModel *mineInfo_model = [MCMineInfoModel sharedMCMineInfoModel];
//    _bankImgV.image=[UIImage imageNamed:mineInfo_model.BankCode];
    NSString * bank;
    if (mineInfo_model.BankCardNumber.length>4) {
        NSString * bankNumber=[mineInfo_model.BankCardNumber substringFromIndex:mineInfo_model.BankCardNumber.length-4];
        bank=[NSString stringWithFormat:@"%@(尾号%@)",[MCDataTool MC_GetDic_Bank][mineInfo_model.BankCode][@"name"],bankNumber];
    }else{
        bank=[NSString stringWithFormat:@"%@",[MCDataTool MC_GetDic_Bank][mineInfo_model.BankCode][@"name"]];
    }
    
    _bankTextFeild.text=bank;
    
    _moneyTextField.placeholder=[NSString stringWithFormat:@"单笔提款金额范围为：%@-%@元",mineInfo_model.DrawMinMoney,mineInfo_model.DrawMaxMoney];
    
    _DrawMinMoney=[mineInfo_model.DrawMinMoney intValue];
    _DrawMaxMoney=[mineInfo_model.DrawMaxMoney intValue];
    
   
}

-(void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag==1001) {
        if (textField.text.length == 1 && [textField.text isEqualToString:@"."]) {
            textField.text = @"0.";
        }
       NSArray *arr = [textField.text componentsSeparatedByString:@"."];
        
        float max = [textField.text floatValue];
        if (max>= _DrawMaxMoney) {
            max = _DrawMaxMoney;
            textField.text =[NSString stringWithFormat:@"%d",_DrawMaxMoney];
        }
        if (arr.count >1) {
            
            NSString *str = arr[1];
            if (str.length > 2) {
               str = [str substringWithRange:NSMakeRange(0, 2)];
            }
            textField.text = [NSString stringWithFormat:@"%@.%@",arr[0],str];
            
            NSString * str1=arr[0];
            if ([str1 isEqualToString:[NSString stringWithFormat:@"%d",_DrawMaxMoney]]) {
                textField.text = [NSString stringWithFormat:@"%d",_DrawMaxMoney];
            }
        }
        
    }else if(textField.tag==1002){
        
    }else if(textField.tag==1003){
        
    }
    
}



#pragma  mark-提款
- (void)withdrawBtnClick:(UIButton *)sender {

    if (!self.moneyTextField.text||[self.moneyTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入提款金额！"];
        return;
    }

    if (!self.passwordTextField.text||[self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入资金密码！"];
        return;
    }
    
    NSString * jinE=_moneyTextField.text;
    NSString * password=_passwordTextField.text;
    
    NSLog(@"金额：%@-密码：%@",jinE,password);
    //UserRealName	是	String	用户真实姓名
    //DrawingsMoney	是	String	提款金额
    //PayPassWord	是	String	提款密码（资金密码）
    MCUserMoneyModel * money_model=[MCUserMoneyModel sharedMCUserMoneyModel];
    double cccc = [jinE doubleValue] - [money_model.LotteryMoney doubleValue];
    if (cccc>0.0001) {
        [SVProgressHUD showInfoWithStatus:@"账户余额不足，不可提款!"];
        return;
    }
    
    if ([jinE floatValue]>_DrawMaxMoney||[jinE floatValue]<_DrawMinMoney) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"提现范围%d-%d元",_DrawMinMoney,_DrawMaxMoney]];
        return;
    }
    
    
    
    __weak __typeof__ (self) wself = self;
    [BKIndicationView showInView:self.view];
    [self loadMCMineInfoData:^(BOOL result, NSDictionary *data) {
        MCMineInfoModel *mineInfoModel =[MCMineInfoModel sharedMCMineInfoModel];
        NSDictionary * dic=@{
                             @"UserRealName":mineInfoModel.UserRealName,
                             @"DrawingsMoney":jinE,
                             @"PayPassWord":password
                             };
        MCWithdrawAPIModel  * apiModel = [[MCWithdrawAPIModel alloc]initWithDic:dic];
        self.apiModel = apiModel;
        [apiModel refreashDataAndShow];
        apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            [SVProgressHUD showInfoWithStatus:@"提现失败！"];
        };
        apiModel.callBackSuccessBlock = ^(id manager) {
            //提现成功   清空输入框
            wself.moneyTextField.text=@"";
            wself.passwordTextField.text=@"";
            // 刷新用户金额
            [wself reloadUserMoney];
            ApiBaseManager *manage=manager;
            if (manager) {
                if (manage.responseMessage) {
                    NSLog(@"%@",manage.responseMessage);
                    
                    [wself performSelector:@selector(delayMethod:) withObject:manage.responseMessage afterDelay:0.05];
                }
            }
        };
    }];
}
-(void)delayMethod:(NSString * )noti{
    [SVProgressHUD showSuccessWithStatus:noti];
}


-(void)reloadUserMoney{
    MCUserMoneyModel * money_model=[MCUserMoneyModel sharedMCUserMoneyModel];
    [money_model refreashDataAndShow];
    self.money_model=money_model;
    
    __weak __typeof(self)wself = self;
    
    money_model.callBackSuccessBlock = ^(id manager) {
        
        wself.money_model.FreezeMoney=manager[@"FreezeMoney"];
        wself.money_model.LotteryMoney=manager[@"LotteryMoney"];
        wself.headerView.dataSource=manager[@"LotteryMoney"];
    };
}

//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@UILABEL_Kern_SPACE
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

-(void)loadMCMineInfoData:(MCWithdrawRecDeltailViewControllerCompeletion)Compeletion{
    
    MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    self.mineInfoModel = mineInfoModel;
    __weak __typeof__ (self) wself = self;
    [mineInfoModel refreashDataAndShow];
    mineInfoModel.callBackSuccessBlock = ^(id manager) {
        wself.mineInfoModel=[MCMineInfoModel mj_objectWithKeyValues:manager];
        Compeletion(YES,manager);
    };
    
    mineInfoModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        Compeletion(NO,nil);
    };
}

@end


















