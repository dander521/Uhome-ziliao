//
//  MCRechargeViewController.m
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeViewController.h"
#import "MCRechargeDetailViewController.h"
#import "MCMineCellModel.h"
#import "MCRechargeHeaderView.h"
#import "MCRechargeFooterView.h"
#import "MCRechargeTableViewCell.h"
#import "MCGroupPaymentModel.h"
#import "MCRechargeModel.h"
#import "MCUserMoneyModel.h"
#import "MCSelectedBottomView.h"
#import "ExceptionView.h"
#import "MCPopAlertView.h"

@interface MCRechargeViewController ()
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
MCSelectedBottomDelegate,
MCRechargeFooterDelegate,
MCRechargeTypeDelegate
>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;
@property(nonatomic, strong)MCRechargeHeaderView * headerView;
@property(nonatomic, strong)MCRechargeFooterView * footerView;
@property(nonatomic, strong)UITextField  * textField;
@property(nonatomic, weak  )MCSelectedBottomView * bottomView;
@property(nonatomic, weak  )UIView * maskView;
@property(nonatomic, strong)MCPaymentModel *selectedModel;

/*
 * Api模型
 */
/**获取用户组充值方式*/
@property(nonatomic, strong)MCGroupPaymentModel * groupPaymentModel;
/**添加充值信息*/
@property(nonatomic, strong)MCRechargeModel     * rechargeModel;
/**查询用户余额及冻结金额*/
@property(nonatomic, strong)MCUserMoneyModel    * userMoneyModel;


@property(nonatomic, strong)ExceptionView * exceptionView;

@end

@implementation MCRechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    [self loadData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [BKIndicationView dismiss];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    /*
     * 重新加载余额
     */
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [userMoneyModel refreashDataAndShow];
    self.userMoneyModel=userMoneyModel;
    self.headerView.dataSource=userMoneyModel.LotteryMoney;

    __weak __typeof(self)wself = self;
 
    userMoneyModel.callBackSuccessBlock = ^(id manager) {
        
        wself.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
        wself.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
        wself.headerView.dataSource=manager[@"LotteryMoney"];
    };

}


#pragma mark==================setProperty======================
-(void)setProperty{

    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"充值";
    _sectionMarr= [[NSMutableArray alloc]init];
    _selectedModel=[[MCPaymentModel alloc]init];
}

#pragma mark==================createUI======================
-(void)createUI{
    
    [self.view addSubview:self.headerView];
    self.headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, [MCRechargeHeaderView computeHeight:nil]);

    [self.view addSubview:self.tableView];
    _tableView.frame=CGRectMake(0, [MCRechargeHeaderView computeHeight:nil], G_SCREENWIDTH, G_SCREENHEIGHT-[MCRechargeHeaderView computeHeight:nil]);

    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:singleTapGesture];
    
    UIView * maskView=[[UIView alloc]init];
    _maskView=maskView;
    [self.view addSubview:_maskView];
    _maskView.backgroundColor=RGB(40, 40, 40);
    _maskView.alpha=0.5;
    _maskView.hidden=YES;
    _maskView.frame=CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);
    
    MCSelectedBottomView * bottomView=[[MCSelectedBottomView alloc]init];
    [self.view addSubview:bottomView];
    _bottomView=bottomView;
    _bottomView.delegate=self;
    bottomView.frame=CGRectMake(0, G_SCREENHEIGHT, G_SCREENWIDTH, 0.0);
    
}
#pragma mark - gesture actions
- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}


#pragma mark==================loadData======================
-(void)loadData{
    
    
    [BKIndicationView showInView:self.view];
    
    MCGroupPaymentModel * groupPaymentModel =[[MCGroupPaymentModel alloc]init];
    
    self.groupPaymentModel=groupPaymentModel;
    
    [groupPaymentModel refreashDataAndShow];
    __weak MCGroupPaymentModel *weakSelf = groupPaymentModel;
    __weak __typeof__ (self) wself = self;

    
    groupPaymentModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
        wself.exceptionView.originY=64;
        ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
            [wself.exceptionView dismiss];
            wself.exceptionView = nil;
            [wself loadData];
        }];
        [wself.exceptionView addAction:action];
        [wself.exceptionView showInView:wself.view];

        
    };
    groupPaymentModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        
        NSDictionary * dic = manager.ResponseRawData;
        NSArray * arr = dic[@"payInType"];
        if (!arr||![arr isKindOfClass:[NSArray class]]) {

            return;
        }
        if ([arr count]<1) {
            return;
        }
        
        
        [weakSelf setPayMentArrWithData:manager.ResponseRawData];

        [wself reloadData];
        
    };


}


-(void)reloadData{
    NSMutableArray * marr_Model=[[NSMutableArray alloc]init];
   
    CellModel* model1 =[[CellModel alloc]init];
    model1.reuseIdentifier = NSStringFromClass([MCRechargeTableViewCell class]);
    model1.className=NSStringFromClass([MCRechargeTableViewCell class]);
    model1.height = [MCRechargeTableViewCell computeHeight:self.groupPaymentModel.payMentArr.count];
    model1.selectionStyle=UITableViewCellSelectionStyleNone;
    model1.accessoryType=UITableViewCellAccessoryNone;

    /*
     * 传递参数
     */
    //默认第一个选中
    MCPaymentModel *ppmodel=self.groupPaymentModel.payMentArr[0];
    ppmodel.isSelected=YES;
    
    model1.userInfo=self.groupPaymentModel.payMentArr;
    if (self.groupPaymentModel.payMentArr.count>0) {
        [marr_Model addObject:model1];
    }
    
    
    SectionModel *model_Section=[SectionModel sectionModelWithTitle:@"" cells:marr_Model];
    model_Section.headerhHeight=0.0001;
    model_Section.footerHeight=[MCRechargeFooterView computeHeight:nil];

    [_sectionMarr addObject:model_Section];

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



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return self.footerView;
    
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
    
 
    if([cm.className isEqualToString:NSStringFromClass([MCRechargeTableViewCell class])]){
        MCRechargeTableViewCell *ex_cell=(MCRechargeTableViewCell *)cell;
        _textField=ex_cell.textField;
        _textField.delegate=self;
        ex_cell.delegate=self;
        if (cm.userInfo) {
            ex_cell.dataSource=cm.userInfo;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Header
-(MCRechargeHeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[MCRechargeHeaderView alloc]init];
    }
    return _headerView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark-Footer
-(MCRechargeFooterView *)footerView{
    if (!_footerView) {
        _footerView =[[MCRechargeFooterView alloc]init];
        _footerView.delegate=self;
    }
    return _footerView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_textField resignFirstResponder];
}


#pragma mark-MCRechargeFooterDelegate /确认充值/
-(void)performRecharge{
    if ([_selectedModel.RechargeType intValue]==43||[_selectedModel.RechargeType intValue]==52||[_selectedModel.RechargeType intValue]==53||[_selectedModel.RechargeType intValue]==68){
        [self bankSelectedBtnClick];
    }else{
        [self DoPay];
    }
}

-(void)DoPay{
    _selectedModel.RechargeMoney=_textField.text;
    
    
    if (_selectedModel.RechargeMoney==nil||[_selectedModel.RechargeMoney isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入充值金额！"];
    }
    
    
    
    float money= [_textField.text floatValue];
    
    if (money<[_selectedModel.minRecMoney intValue]||money>[_selectedModel.maxRecMoney intValue]) {
        
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"充值金额范围%@~%@",_selectedModel.minRecMoney,_selectedModel.maxRecMoney]] ;
        return;

    }
    if (!_selectedModel.RechargeType||_selectedModel.RechargeType==nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择充值方式"] ;
        return;
    }
    
    
    
    NSDictionary * dic=@{
                         @"RechargeMoney":_selectedModel.RechargeMoney,
                         @"BankCode":_selectedModel.BankCode,
                         @"RechargeType":_selectedModel.RechargeType
                         };
    
    MCRechargeModel     * rechargeModel = [[MCRechargeModel alloc]initWithDic:dic];
    self.rechargeModel = rechargeModel;
    [BKIndicationView showInView:self.view];
    [rechargeModel refreashDataAndShow];
    
    
    
    rechargeModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        //            [MBProgressHUD showError:@"服务器链接失败" toView:self.view];
        
    };
    
    
    
    __weak __typeof__ (self) wself = self;
    
    rechargeModel.callBackSuccessBlock = ^(id manager) {
        
        MCRechargeModel *dataSource=[[MCRechargeModel alloc]init];
        dataSource = [MCRechargeModel mj_objectWithKeyValues:manager];
        
        
        MCPopAlertView *mcAlertView = [[MCPopAlertView alloc] initWithType:MCPopAlertTypeCZRequest_Confirm Title:@"支付确认" leftBtn:@"前往支付" rightBtn:@"取消返回" RechargeModel:dataSource];
        
        mcAlertView.resultIndex = ^(NSInteger index){
            if (index==1) {
                MCRechargeDetailViewController * vc=[[MCRechargeDetailViewController alloc]init];
                vc.dataSource=dataSource;
                if (dataSource.PayBank.length<1) {
                    vc.dataSource.PayBank=wself.selectedModel.PayName;
                }
                vc.dataSource.PayMoney=wself.selectedModel.RechargeMoney;
                vc.dataSource.BankCode=_selectedModel.BankCode;
                [wself.navigationController pushViewController:vc animated:YES];
            }
        };
        [mcAlertView showXLAlertView];
        
        /*
         * 开户行的显示规则是这样的：在 add_recharge_info 这个接口中，会返回 PayBank 这个字段，这个字段可能有3种情况，一种为空（针对在线充值类），一种只包含“收款银行”，一种同时包含了“收款银行”和“开户银行”。
         举例如下： PayBank:"工商银行,安徽阜阳"，逗号前为收款银行，逗号后为开户银行。
         程序中逻辑为：①判断是否有逗号，有则用逗号分隔，无则直接赋值为“收款银行”；②有逗号，则分隔后取下标为0的作为“收款银行”；③下标为1的判断是否有值，有则显示到“开户银行”，无则不显示。（因为有的时候会返回“工商银行, ”这样的字段）
         */
        
    };
    
    

}




#pragma mark-MCRechargePaymentTypeDelegate  /选择付款方式/
-(void)celldidSelectPaymentType:(MCPaymentModel *)type{
    
    NSLog(@"------选择付款方式---------%@-",type.PayName);

    _selectedModel.PayName=type.PayName;
    _selectedModel.SortNum=type.SortNum;
    _selectedModel.minRecMoney=type.minRecMoney;
    _selectedModel.maxRecMoney=type.maxRecMoney;
    _selectedModel.BankCode=type.BankCode;
    _selectedModel.RechargeType=type.RechargeType;
    _selectedModel.arr_FastPayment=type.arr_FastPayment;
    _selectedModel.logoType=type.logoType;

    
}


#pragma mark-MCRechargePayMoneyDelegate  /选择金额/
-(void)celldidSelectChooseMoney:(id)money{
    
    NSLog(@"------选择金额---------%@",money);
    _textField.text=[NSString stringWithFormat:@"%d",[money intValue]];
    _selectedModel.RechargeMoney=_textField.text;
    
}

#pragma mark-银行选择
- (void)bankSelectedBtnClick{
    
    [_bottomView reloadDataWithType:FastPayType andDataSource:_selectedModel.arr_FastPayment];
    
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT-HEIGHT_MCSBVIEW, G_SCREENWIDTH,HEIGHT_MCSBVIEW);
        _maskView.hidden=NO;

    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark=======MCSelectedBottomDelegate==========


/*
 * 选择银行
 */
-(void)MCSelectedBottom_Bank:(MCBankModel *)model{
    
    NSLog(@"----%@-----%@",model.bankName,model.bankId);

    _selectedModel.BankCode=model.bankId;
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame=CGRectMake(0, G_SCREENHEIGHT, G_SCREENWIDTH,0.0);
        _maskView.hidden=YES;

    } completion:^(BOOL finished) {
        
        [self DoPay];
        
    }];
}


@end
















































