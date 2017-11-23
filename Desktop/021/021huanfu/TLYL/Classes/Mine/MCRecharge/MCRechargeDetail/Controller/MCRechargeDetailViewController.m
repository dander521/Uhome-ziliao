//
//  MCRechargeDetailViewController.m
//  TLYL
//
//  Created by MC on 2017/7/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import "MCRechargeDetailViewController.h"
#import "MCRechargeDetailUserInfoTableViewCell.h"
#import "MCRechargeDetailExplainTableViewCell.h"
#import "MCRechargeDetailSubmitTableViewCell.h"
#import "MCRechargeDetailUnionpayTableViewCell.h"
#import "MCRechargeOrderReminderModel.h"
#import "MCPayWebViewController.h"
#import "MCMineCellModel.h"

@interface MCRechargeDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;


//姓名
@property (nonatomic,strong)UITextField * userNameTextField;

//金额
@property (nonatomic,strong)UITextField * moneyTextField;

//时间
@property (nonatomic,strong)UITextField * timeTextField;

/**提交审核成功后  该按钮隐藏*/
@property (nonatomic,strong)UIButton * submitBtn;

@property (nonatomic,strong)MCRechargeOrderReminderModel *rechargeOrderReminderModel;

@end

@implementation MCRechargeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    [self createUI];
    [self loadData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [BKIndicationView dismiss];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    
}
#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"充值详情";
    _sectionMarr= [[NSMutableArray alloc]init];
    
}

#pragma mark==================createUI======================
-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    _tableView.frame=CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(0);
//        make.left.and.right.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    }];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:singleTapGesture];
    
    
    
}

#pragma mark - gesture actions
- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

#pragma mark==================loadData======================
-(void)loadData{
    NSMutableArray * marr_Model=[[NSMutableArray alloc]init];
 
    [_sectionMarr removeAllObjects];
    
    if ([_dataSource.PType integerValue]==15) {

        //MCRechargeDetailUserInfoTableViewCell
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCRechargeDetailUserInfoTableViewCell class]);
        model.className=NSStringFromClass([MCRechargeDetailUserInfoTableViewCell class]);
        model.height = [MCRechargeDetailUserInfoTableViewCell computeHeight:_dataSource];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        
        //传递参数
        model.userInfo = _dataSource;
        [marr_Model addObject:model];
        
        
        
        //MCRechargeDetailExplainTableViewCell
        CellModel* model1 =[[CellModel alloc]init];
        model1.reuseIdentifier = NSStringFromClass([MCRechargeDetailExplainTableViewCell class]);
        model1.className=NSStringFromClass([MCRechargeDetailExplainTableViewCell class]);
        model1.height = [MCRechargeDetailExplainTableViewCell computeHeight:_dataSource];
        model1.selectionStyle=UITableViewCellSelectionStyleNone;
        model1.accessoryType=UITableViewCellAccessoryNone;
        
        //传递参数
        model1.userInfo = _dataSource;
        [marr_Model addObject:model1];
        
        
        //MCRechargeDetailSubmitTableViewCell
        CellModel* model2 =[[CellModel alloc]init];
        model2.reuseIdentifier = NSStringFromClass([MCRechargeDetailSubmitTableViewCell class]);
        model2.className=NSStringFromClass([MCRechargeDetailSubmitTableViewCell class]);
        model2.height = [MCRechargeDetailSubmitTableViewCell computeHeight:nil];
        model2.selectionStyle=UITableViewCellSelectionStyleNone;
        model2.accessoryType=UITableViewCellAccessoryNone;
        
        //传递参数
        model2.userInfo = _dataSource;
        [marr_Model addObject:model2];
        
        
 
    }else{
     
        //MCRechargeDetailUnionpayTableViewCell
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCRechargeDetailUnionpayTableViewCell class]);
        model.className=NSStringFromClass([MCRechargeDetailUnionpayTableViewCell class]);
        model.height = [MCRechargeDetailUnionpayTableViewCell computeHeight:nil];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        
        //传递参数
        model.userInfo = _dataSource;
        [marr_Model addObject:model];
        
 
    }

    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_Model];
    model0.headerhHeight=0.0001;
    model0.footerHeight=64;
    [_sectionMarr addObject:model0];
    [_tableView reloadData];
    
}
#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.headerhHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    if ([cm.className isEqualToString:NSStringFromClass([MCRechargeDetailUserInfoTableViewCell class])]) {
        
        MCRechargeDetailUserInfoTableViewCell *ex_cell=(MCRechargeDetailUserInfoTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
    }
    
    if ([cm.className isEqualToString:NSStringFromClass([MCRechargeDetailExplainTableViewCell class])]) {
        
        MCRechargeDetailExplainTableViewCell *ex_cell=(MCRechargeDetailExplainTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
    }
    
    __weak __typeof(self)wself = self;
    if ([cm.className isEqualToString:NSStringFromClass([MCRechargeDetailSubmitTableViewCell class])]) {
        
        MCRechargeDetailSubmitTableViewCell *ex_cell=(MCRechargeDetailSubmitTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
        wself.userNameTextField=ex_cell.userNameTextField;
        wself.moneyTextField=ex_cell.moneyTextField;
        wself.moneyTextField.userInteractionEnabled=NO;
        wself.timeTextField=ex_cell.timeTextField;
        wself.submitBtn=ex_cell.submitBtn;
        //设置默认金额
        wself.moneyTextField.text=_dataSource.PayMoney;
        
        ex_cell.block=^(){
            /*
             * 已转账   提交审核
             */
            [wself submitToMC];
            
        };
        
    }
    
    
    if ([cm.className isEqualToString:NSStringFromClass([MCRechargeDetailUnionpayTableViewCell class])]) {
        
        MCRechargeDetailUnionpayTableViewCell *ex_cell=(MCRechargeDetailUnionpayTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        ex_cell.block=^(){
            /*
             * 跳转付款
             */
            [wself payToWeb];
            
        };
    }
    
    return cell;
}


#pragma mark-已转账   提交审核
-(void)submitToMC{
    
    if ([self.userNameTextField.text isEqualToString:@""]||self.userNameTextField==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名！"];
        return;
    }
    if ([self.moneyTextField.text isEqualToString:@""]||self.moneyTextField==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入充值金额！"];
        return;
    }
    if ([self.timeTextField.text isEqualToString:@""]||self.timeTextField==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入充值时间！"];
        return;
    }
    
    if (![self checkTime]) {
        [SVProgressHUD showErrorWithStatus:@"转账时间格式不正确!"];
        return;
    }
    
    MCRechargeOrderReminderModel * rechargeOrderReminderModel = [[MCRechargeOrderReminderModel alloc]init];
    self.rechargeOrderReminderModel=rechargeOrderReminderModel;
    
    
    rechargeOrderReminderModel.PayRealName = self.userNameTextField.text ;//真实姓名
    rechargeOrderReminderModel.TransferAmount = self.moneyTextField.text;//转账金额
    rechargeOrderReminderModel.TransferTime	= self.timeTextField.text ;//转账时间
    rechargeOrderReminderModel.ReceiveName	= _dataSource.PayBankName;//收款人
    rechargeOrderReminderModel.ReceiveBank = _dataSource.PayBank;//收款银行
    rechargeOrderReminderModel.ReceiveCardNumber= _dataSource.PayBankAccount;//收款卡号
    rechargeOrderReminderModel.OrderNumber = _dataSource.OrderID;//订单号
    rechargeOrderReminderModel.PayCarNumber	=@"" ;//固定值：传空字符串
    
    [rechargeOrderReminderModel refreashDataAndShow];
    
    __weak __typeof__ (self) wself = self;

    rechargeOrderReminderModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {

        //        NSLog(@"%@",manager.responseMessage);
//        [SVProgressHUD showErrorWithStatus:manager.responseMessage];
    };
    
    rechargeOrderReminderModel.callBackSuccessBlock = ^(id manager) {
        ApiBaseManager *manage=manager;
        wself.submitBtn.hidden=YES;
        NSLog(@"%@",manage.responseMessage);
        [SVProgressHUD showSuccessWithStatus:manage.responseMessage];
    };
    

    
}

#pragma mark-跳转付款
-(void)payToWeb{
/*
 
input_charset=UTF-8&sign=36824924413468CF3167D5761074C8B8&sign_type=MD5&service=speedy_pay&partner=100386+&return_url=http%3A%2F%2Ftlpt.am98d168.tianshunhuagong.com%3A58152%2FSDResult%2FILeFuKJAsyCallBack&request_time=20171120103321&out_trade_no=LOTP44CKTKMLRDQUXSLLAL6D&amount_str=88.00&tran_time=&tran_ip=36.56.115.193&buyer_name=canny&buyer_contact=11111111111&receiver_address=&good_name=wupin&goods_detail=naifen&bank_code=&advice_url=http%3A%2F%2Ftlpt.am98d168.tianshunhuagong.com%3A58152%2FSDResult%2FILeFuKJWebCallBack&redirect_url=http%3A%2F%2Ftlpt.am98d168.tianshunhuagong.com%3A58152%2FSDResult%2FILeFuKJWebCallBack
 
 
input_charset$UTF-8$sign$7B371A9BBAC80BE9F04CDCD14FC2BC30$sign_type$MD5$service$speedy_pay$partner$100386 $return_url$http://tlpt.am98d168.tianshunhuagong.com:58152/SDResult/ILeFuKJAsyCallBack$request_time$20171120095637$out_trade_no$LOTP442O72FU63FV0TIWMZIL$amount_str$200.00$tran_time$$tran_ip$222.93.96.128$buyer_name$canny$buyer_contact$11111111111$receiver_address$$good_name$wupin$goods_detail$naifen$bank_code$$advice_url$http://tlpt.am98d168.tianshunhuagong.com:58152/SDResult/ILeFuKJWebCallBack$redirect_url$http://tlpt.am98d168.tianshunhuagong.com:58152/SDResult/ILeFuKJWebCallBack
 

 
 */
    
    MCPayWebViewController * vc = [[MCPayWebViewController alloc]init];
    
    NSString * URL=_dataSource.BankUrl;
    
    NSArray * MValueArr=[_dataSource.MValue componentsSeparatedByString:@"$"];
    
    NSString * strValue =MValueArr[0];
    
    NSString * T_strValue =MValueArr[0];
    
    for (int i=1;i<MValueArr.count;i++) {
        
        if (i%2==0) {
//            strValue=[NSString stringWithFormat:@"%@&%@",strValue,MValueArr[i]];
            strValue=[NSString stringWithFormat:@"%@%26%@",strValue,MValueArr[i]];
        }else{
//            strValue=[NSString stringWithFormat:@"%@=%@",strValue,MValueArr[i]];
            strValue = [strValue stringByAppendingString:@"%3D"];
            strValue=[NSString stringWithFormat:@"%@%@",strValue,MValueArr[i]];
//            strValue=[NSString stringWithFormat:@"%@%3D%@",strValue,MValueArr[i]];
            
        }
        
    }
    
    for (int i=1;i<MValueArr.count;i++) {
        
        if (i%2==0) {
            T_strValue=[NSString stringWithFormat:@"%@&%@",T_strValue,MValueArr[i]];

        }else{
            T_strValue=[NSString stringWithFormat:@"%@=%@",T_strValue,MValueArr[i]];
            
        }
        
    }
    

//
////    %26  &
////    %3D  =
////    : =

    
    vc.url=[NSString stringWithFormat:@"%@?%@",URL,T_strValue];
    
    NSLog(@"strValue-------%@ ------",[NSString stringWithFormat:@"%@?%@",URL,strValue]);
    
    NSLog(@"T_strValue-------%@ ------",[NSString stringWithFormat:@"%@?%@",URL,T_strValue]);
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

//http://pay.yxmye.top:888/ILeFuKuaiJie.aspx?
//input_charset=UTF-8&
//sign=A1D4C959680F24C687E84DB157E31B13&
//sign_type=MD5&service=speedy_pay&
//partner=100386 &
//return_url=http://tlpt.am98d168.tianshunhuagong.com:58152/SDResult/ILeFuKJAsyCallBack
//&request_time=20171121164522
//&out_trade_no=LOTP44XC87HFUW8SXVY7KQHM
//&amount_str=200.00
//&tran_time=
//&tran_ip=139.207.106.53
//&buyer_name=canny
//&buyer_contact=11111111111
//&receiver_address=
//&good_name=wupin
//&goods_detail=naifen
//&bank_code=
//&advice_url=http://tlpt.am98d168.tianshunhuagong.com:58152/SDResult/ILeFuKJWebCallBack
//&redirect_url=http://tlpt.am98d168.tianshunhuagong.com:58152/SDResult/ILeFuKJWebCallBack

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkTime{
    if (self.timeTextField.text.length!=4) {
        return NO;
    }
    NSString * hour   = [self.timeTextField.text substringToIndex:2];
    NSString * minute = [self.timeTextField.text substringFromIndex:2];
    if ([hour intValue]>23) {
        return NO;
    }
    if ([minute intValue]>59) {
        return NO;
    }
    return YES;
}






- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}



- (void)keyboardWillShow:(NSNotification *)noti
{

    _tableView.frame=CGRectMake(0, -300, G_SCREENWIDTH, G_SCREENHEIGHT);
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    _tableView.frame=CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);

}



@end

























































