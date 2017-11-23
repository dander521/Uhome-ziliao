//
//  MCMineAddBankCardViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineAddBankCardViewController.h"
#import "MCSelectedBottomView.h"
#import "MCBankModel.h"
#import "MCButton.h"
#import "MCAddBankCardModel.h"
#import "MCMineInfoModel.h"
#import "MCModifyPayPasswordViewController.h"
#import "MCMineInfoModel.h"
#import "MCBankCardListModel.h"

@interface MCMineAddBankCardViewController ()
<
MCSelectedBottomDelegate,
UITextFieldDelegate
>
typedef void(^MCMineAddBankCardViewControllerCompeletion)(BOOL result, id data );

@property (nonatomic,weak) UIButton *addBtn;
@property (nonatomic,weak) UITextField *nameTF;
@property (nonatomic,weak) MCSelectedBottomView * bottomView;

@property (nonatomic,weak)UIButton *shengSelectedBtn;
@property (nonatomic,weak)UIButton *citySelectedBtn;
@property (nonatomic,weak)UIButton *bankSelectedBtn;
//支行名称
@property (nonatomic,weak)UITextField *bankNameTf;

//银行卡号
@property (nonatomic,weak)UITextField *cardNumTf;

@property (nonatomic,strong)MCBankModel *bankModel;

@property (nonatomic,strong)MCAddBankCardModel * apiModel;
@property (nonatomic,strong)MCMineInfoModel *mineInfoModel;
@property (nonatomic,strong)MCBankCardListModel  * bankCardListModel;
@property (nonatomic,strong)NSString *UserRealName;
@end

@implementation MCMineAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    [self setNav];
    [self setUpUI];
   
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;

}

-(void)setTitle:(NSString *)title andTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type andIndex:(int)index andBackView:(UIView *)backView andMCButton:(UIButton *)btn1 andMCButton:(UIButton *)btn2{
    
    CGFloat padding=50;
    
    UILabel * lab=[[UILabel alloc]init];
    [backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.text=title;
    lab.textColor=RGB(46,46,46);
    lab.frame=CGRectMake(10, index*padding, 80, padding);
    
    if (textField) {
        [backView addSubview:textField];
        textField.frame=CGRectMake(80, index*padding, G_SCREENWIDTH-20-100-20, padding);
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
    }else if (btn1&&btn2){

        [backView addSubview:btn1];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn1 setTitle:@"请选择省份 >" forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn1 setTitleColor:RGB(68, 68, 68) forState:UIControlStateNormal];
        btn1.frame=CGRectMake(80, index*padding, (G_SCREENWIDTH-20-100)/2.0, padding);
        _shengSelectedBtn=btn1;
        
        UIView * line=[[UIView alloc]init];
        line.backgroundColor=RGB(213,213,213);
        line.frame=CGRectMake(80+(G_SCREENWIDTH-20-100)/2.0, index*padding, 0.5, padding);
        [backView addSubview:line];
        
        [backView addSubview:btn2];
        btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn2 setTitle:@"请选择市区 >" forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn2 setTitleColor:RGB(68, 68, 68) forState:UIControlStateNormal];
        btn2.frame=CGRectMake(80+(G_SCREENWIDTH-20-100)/2.0, index*padding, (G_SCREENWIDTH-20-100)/2.0, padding);
        _citySelectedBtn=btn2;
        
        
    }else if (btn1){
        
        [backView addSubview:btn1];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn1 setTitle:@"请选择银行 >" forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn1 setTitleColor:RGB(68, 68, 68) forState:UIControlStateNormal];
        btn1.frame=CGRectMake(80, index*padding, G_SCREENWIDTH-20-100, padding);
        _bankSelectedBtn=btn1;
        
    }
   
    if (index==3) {
        UILabel * tipLab=[[UILabel alloc]init];
        [backView addSubview:tipLab];
        tipLab.text=@"(选填*)";
        tipLab.font=[UIFont systemFontOfSize:10];
        tipLab.textColor=RGB(144,8,215);
        tipLab.frame=CGRectMake(G_SCREENWIDTH-20-50, index*padding, 50, padding);
    }
    if (index<4) {
        UIView * line=[[UIView alloc]init];
        line.backgroundColor=RGB(213,213,213);
        line.frame=CGRectMake(10, padding*(index+1), G_SCREENWIDTH-20-10, 0.5);
        [backView addSubview:line];
    }
}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
}
- (void)setUpUI{
    UIButton * btn=[[UIButton alloc]init];
    btn.frame=self.view.bounds;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(closeKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
//    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
//    singleTapGesture.numberOfTapsRequired = 1;
//    singleTapGesture.cancelsTouchesInView = NO;
//    [self.view  addGestureRecognizer:singleTapGesture];

    
    UIView * backView = [[UIView alloc]init];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(10, 10, G_SCREENWIDTH-20, 250);
    backView.layer.cornerRadius = 10;
    backView.clipsToBounds = YES;
    
    UITextField *nameTF=[[UITextField alloc]init];
    _nameTF=nameTF;
    _nameTF.tag=1001;
    [self setTitle:@"开户姓名" andTextField:nameTF WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:0 andBackView:backView andMCButton:nil andMCButton:nil];
    
    UIButton *bankSelectedBtn = [[UIButton alloc] init];
    [bankSelectedBtn addTarget:self action:@selector(bankSelectedBtnClick) forControlEvents:UIControlEventTouchDown];
    [self setTitle:@"开户银行" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:1 andBackView:backView andMCButton:bankSelectedBtn andMCButton:nil];
    
    UIButton *shengSelectedBtn = [[UIButton alloc] init];
    [shengSelectedBtn addTarget:self action:@selector(shengSelectedBtnClick) forControlEvents:UIControlEventTouchDown];
    UIButton *citySelectedBtn = [[UIButton alloc] init];
    [citySelectedBtn addTarget:self action:@selector(citySelectedBtnClick) forControlEvents:UIControlEventTouchDown];
    [self setTitle:@"开户地区" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:2 andBackView:backView andMCButton:shengSelectedBtn andMCButton:citySelectedBtn];
    
    UITextField *bankNameTf=[[UITextField alloc]init];
    _bankNameTf=bankNameTf;
    _bankNameTf.tag=1002;
    [self setTitle:@"支行名称" andTextField:bankNameTf WithPlaceholder:@"请输入开户行支行名称" and:UIKeyboardTypeDefault andIndex:3 andBackView:backView andMCButton:nil andMCButton:nil];
    
    UITextField *cardNumTf=[[UITextField alloc]init];
    _cardNumTf=cardNumTf;
    _cardNumTf.tag=1003;
    _cardNumTf.delegate=self;
    [self setTitle:@"银行卡号" andTextField:cardNumTf WithPlaceholder:@"请输入您的银行卡卡号" and:UIKeyboardTypeNumberPad andIndex:4 andBackView:backView andMCButton:nil andMCButton:nil];
    
    _bankModel=[[MCBankModel alloc]init];
    
    self.view.backgroundColor=RGB(231,231,231);
    
    MCMineInfoModel * mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    if (mineInfoModel.UserRealName.length>0) {
        _UserRealName=mineInfoModel.UserRealName;
        _nameTF.userInteractionEnabled=NO;
        _nameTF.text=[NSString stringWithFormat:@"%@**",[_UserRealName substringToIndex:1]];
    }

    MCSelectedBottomView * bottomView=[[MCSelectedBottomView alloc]init];
    [self.view addSubview:bottomView];
    _bottomView=bottomView;
    _bottomView.delegate=self;
    bottomView.frame=CGRectMake(0, G_SCREENHEIGHT, G_SCREENWIDTH, 0.0);

}



-(void)setTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type{
    textField.placeholder=placeholder;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor=[UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = RGB(68, 68, 68);
    textField.textAlignment = NSTextAlignmentLeft;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = type;
    [textField setValue:RGB(177, 177, 177) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    
    
}


-(void)textFieldDidChange:(UITextField *)textField{
    //卡号
    if (textField.tag==10003) {
     
        //请输入支行名称
    }else if (textField.tag==10002){
        
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];

        //姓名
    }else if (textField.tag==10001){
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
}



#pragma mark-银行卡号校验
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 24) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}
#pragma mark - gesture actions
- (void)closeKeyboard{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64, G_SCREENWIDTH,0.0);
    } completion:^(BOOL finished) {
        
    }];

}

- (void)keyboardWillShow:(NSNotification *)noti
{
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64, G_SCREENWIDTH,0.0);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark-添加银行卡
- (void)rightBtnAction{
    [self.view endEditing:YES];
    
    if (_UserRealName.length>0) {
        
    }else{
        //姓名判断
        if (!_nameTF.text||[_nameTF.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"请输入姓名！"];
            return;
        }
    }
    
    
    if (!_bankModel.bankId) {
        [SVProgressHUD showErrorWithStatus:@"请选择银行！"];
        return;
    }
    
    if (!_bankModel.provinceId) {
        [SVProgressHUD showErrorWithStatus:@"请选择省份！"];
        return;
    }
    
    if (!_bankModel.cityId) {
        [SVProgressHUD showErrorWithStatus:@"请选择市区！"];
        return;
    }
    

    NSString *bankName=@"";
    if (!_bankNameTf.text||[_bankNameTf.text isEqualToString:@""]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入支行名称！"];
//        return;
    }else{
        bankName=_bankNameTf.text;
    }
    
    if (!_cardNumTf.text||[_cardNumTf.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入银行卡号！"];
        return;
    }
    if (_UserRealName.length>0) {
        _bankModel.userName=_UserRealName;
    }else{
        _bankModel.userName=_nameTF.text;
    }
        __weak __typeof__ (self) wself = self;

    _bankModel.subBankName=bankName;
    _bankModel.bankNumer=[_cardNumTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    MCMineInfoModel * mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    
    NSString * UserName =[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];

    NSDictionary * dic=
    @{
      @"UserName":UserName,
      @"RealName":_bankModel.userName,
      @"UserID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
      @"BankCode":_bankModel.bankId,//银行编码
      @"CardNumber":_bankModel.bankNumer,//银行卡号
      @"Province":_bankModel.provinceId,//所在省份
      @"City":_bankModel.cityId,//所在市级
      @"BranchName":_bankModel.subBankName//支行名称（非必填时可传空）
      
      };
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提示内容" preferredStyle:UIAlertControllerStyleAlert];

 
    //修改title
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:RGB(0, 0, 0) range:NSMakeRange(0, 2)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 2)];
    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    
    //修改message
    NSString * userName=[NSString stringWithFormat:@"%@**",[_bankModel.userName substringToIndex:1]];
    
    NSString * message;
    if (_bankNameTf.text&&(_bankNameTf.text.length>0)) {
        
        
        message=[NSString stringWithFormat:@"\n持卡人姓名：%@\n开户银行：%@\n支行：%@\n卡号：%@\n开户地址：%@-%@\n",userName,_bankModel.bankName,_bankModel.subBankName,_bankModel.bankNumer,_bankModel.provinceName,_bankModel.cityName];
        
    }else{
        
        message=[NSString stringWithFormat:@"\n持卡人姓名：%@\n开户银行：%@\n卡号：%@\n开户地址：%@-%@\n",userName,_bankModel.bankName,_bankModel.bankNumer,_bankModel.provinceName,_bankModel.cityName];
    }
    
    
    NSRange range1 = [message rangeOfString:userName];
    NSRange range2 = [message rangeOfString:_bankModel.bankName];
    NSRange range3 = [message rangeOfString:_bankModel.subBankName];
    NSRange range4 = [message rangeOfString:_bankModel.bankNumer];
    NSRange range5 = [message rangeOfString:[NSString stringWithFormat:@"%@-%@",_bankModel.provinceName,_bankModel.cityName]];
    
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [alertControllerMessageStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, alertControllerMessageStr.length)];

    
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:range1];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:range2];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:range3];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:range4];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:range5];
    
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, message.length)];
    [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wself AddBankCard:dic];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
    
    
   
}

-(void)AddBankCard:(NSDictionary *)dic{
    
    __weak __typeof__ (self) wself = self;
    
    MCAddBankCardModel  * apiModel =[[MCAddBankCardModel alloc]initWithDic:dic];
    self.apiModel=apiModel;
    [BKIndicationView showInView:self.view];

    [self GetBankCardList:^(BOOL result, id data) {
        NSArray * arr = data;
        if (result&&arr.count>4) {
            [BKIndicationView dismiss];
            [SVProgressHUD showInfoWithStatus:@"银行卡添加不能超过5张！"];
            return ;
        }else{
            [apiModel refreashDataAndShow];
            apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
                [BKIndicationView dismiss];
            };
            apiModel.callBackSuccessBlock = ^(id manager) {
                [BKIndicationView dismiss];
                if (wself.type==NOPasswordAndNOCard) {
                    [wself refreshData];
                    MCModifyPayPasswordViewController * vc =[[MCModifyPayPasswordViewController alloc]init];
                    [wself.navigationController pushViewController:vc animated:YES];
                }else{
                    if (wself.block) {
                        wself.block(_bankModel);
                    }
                    [wself.navigationController popViewControllerAnimated:YES];
                }
            };
        }
    }];

}

#pragma mark-省份选择
- (void)shengSelectedBtnClick{

    [self.view endEditing:YES];
    [_bottomView reloadDataWithType:ProvinceType andModel:_bankModel];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64-HEIGHT_MCSBVIEW, G_SCREENWIDTH,HEIGHT_MCSBVIEW);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark-市区选择
- (void)citySelectedBtnClick{
    
    if ([_bankModel.provinceName isEqualToString:@""]||!_bankModel.provinceName) {
        [SVProgressHUD showErrorWithStatus:@"请先选择省份！"];
        return;
    }
    [self.view endEditing:YES];
    [_bottomView reloadDataWithType:CityType andModel:_bankModel];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64-HEIGHT_MCSBVIEW, G_SCREENWIDTH,HEIGHT_MCSBVIEW);
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark-银行选择
- (void)bankSelectedBtnClick{
    [self.view endEditing:YES];
    [_bottomView reloadDataWithType:BankType andModel:_bankModel];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64-HEIGHT_MCSBVIEW, G_SCREENWIDTH,HEIGHT_MCSBVIEW);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark=======MCSelectedBottomDelegate==========
/*
 * 选择省份
 */
-(void)MCSelectedBottom_Province:(MCBankModel *)model{
    
    _bankModel.provinceName=model.provinceName;
    _bankModel.provinceId=model.provinceId;
    
    //市区重置
    _bankModel.cityName=nil;
    _bankModel.cityId=nil;

    [_shengSelectedBtn setTitle:model.provinceName forState:UIControlStateNormal];
    [_citySelectedBtn setTitle:@"请选择市区 >" forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64, G_SCREENWIDTH,0.0);
    } completion:^(BOOL finished) {
        
    }];
}

/*
 * 选择市区
 */
-(void)MCSelectedBottom_City:(MCBankModel *)model{
    _bankModel.cityName=model.cityName;
    _bankModel.cityId=model.cityId;
    [_citySelectedBtn setTitle:model.cityName forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64, G_SCREENWIDTH,0.0);
    } completion:^(BOOL finished) {
        
    }];
    
}

/*
 * 选择银行
 */
-(void)MCSelectedBottom_Bank:(MCBankModel *)model{
    _bankModel.bankName=model.bankName;
    _bankModel.bankLogo=model.bankLogo;
    _bankModel.bankId=model.bankId;
    
    [_bankSelectedBtn setTitle:model.bankName forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-64, G_SCREENWIDTH,0.0);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)refreshData{
    __weak __typeof(self)wself = self;
    
    MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    self.mineInfoModel = mineInfoModel;
    
    [mineInfoModel refreashDataAndShow];
    mineInfoModel.callBackSuccessBlock = ^(id manager) {
        
        wself.mineInfoModel=[MCMineInfoModel mj_objectWithKeyValues:manager];
        
    };
}

-(void)GetBankCardList:(MCMineAddBankCardViewControllerCompeletion)Compeletion{
    MCBankCardListModel  * bankCardListModel =[[MCBankCardListModel alloc]init];
    [bankCardListModel refreashDataAndShow];
    self.bankCardListModel=bankCardListModel;
//    __weak __typeof__ (self) wself = self;
    bankCardListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {

        Compeletion(NO,nil);
    };
    bankCardListModel.callBackSuccessBlock = ^(id manager) {
        
        [BKIndicationView dismiss];
        Compeletion(YES,manager);
    };
}
@end






































