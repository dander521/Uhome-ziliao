//
//  MCSettingViewController.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSettingViewController.h"
#import "MCMineCellModel.h"
#import "MCSettingTableViewCell.h"
#import "MCBankcardManageViewController.h"
#import "MCSecurityCenterViewController.h"
#import "MCPersonInformationViewController.h"
#import "MCModifyPayPasswordViewController.h"
#import "MCModifyLoginPasswordViewController.h"
#import "MCMSecureSettingViewController.h"
#import "MCGetSecurityStateModel.h"
#import "MCGetRandomSecurityModel.h"
#import "MCRetrievePasswordModel.h"
#import "MCMineInfoModel.h"
#import "MCCancelPopView.h"
#import "MCLoginOutModel.h"
#import "MCGetMerchantInfoModel.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"
#import "MCLoginViewController.h"
#import "MCHelpCenterViewController.h"

@interface MCSettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MCSettingCellDelegate
>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;
@property(nonatomic, strong)NSArray*titleMarr;
@property(nonatomic, weak)UITextField * textField;
//查询是否已设置密保问题
@property(nonatomic, strong)MCGetSecurityStateModel * getSecurityStateModel;
//获取所有的密保问题
@property(nonatomic, strong)MCGetRandomSecurityModel * getRandomSecurityModel;
//验证密保答案是否正确
@property(nonatomic, strong)MCRetrievePasswordModel  * retrievePasswordModel;
@property(nonatomic, weak)UIAlertAction *sureAction;
@property(nonatomic, strong)MCLoginOutModel  * loginOutModel;

@property(nonatomic, strong)UIView * footer;
@end

@implementation MCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    [self createUI];
    [self setSectionMarr];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    [self loadData];
}
#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"信息设置";
    _sectionMarr= [[NSMutableArray alloc]init];
    //初始化
    MCGetSecurityStateModel * getSecurityStateModel = [MCGetSecurityStateModel sharedMCGetSecurityStateModel];
    getSecurityStateModel.hadSecurityState=@"0";
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
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
}


-(void)setSectionMarr{
    int i=0;
    for(NSArray * temp in self.titleMarr){
        
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCSettingTableViewCell class]);
        model.className=NSStringFromClass([MCSettingTableViewCell class]);
        model.height = [MCSettingTableViewCell computeHeight:temp];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = temp;
        
        SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
        model0.headerhHeight=10;
        if (i==2) {
            model0.footerHeight=40+45;
        }else{
            model0.footerHeight=0.0001;
        }
        [_sectionMarr addObject:model0];
        [_tableView reloadData];
        i++;
        
    }
}
#pragma mark==================loadData======================
-(void)loadData{
    
    __weak __typeof__ (self) wself = self;
    [BKIndicationView showInView:self.view];
    MCGetSecurityStateModel * getSecurityStateModel = [MCGetSecurityStateModel sharedMCGetSecurityStateModel];
    _getSecurityStateModel=getSecurityStateModel;
    [getSecurityStateModel refreashDataAndShow];
    getSecurityStateModel.callBackSuccessBlock = ^(id manager) {
        [BKIndicationView dismiss];
        wself.getSecurityStateModel.hadSecurityState=manager[@"Result"];
        [wself.tableView reloadData];
    };
    
    getSecurityStateModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [BKIndicationView dismiss];
    };
    
}
#pragma mark tableView 代理相关
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        
        self.footer.frame=CGRectMake(10, 45, G_SCREENWIDTH-20, 40);
        return self.footer;
    }
    return nil;
}


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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCSettingTableViewCell class])]) {
        
        MCSettingTableViewCell *ex_cell=(MCSettingTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        ex_cell.delegate=self;
        if ([self.getSecurityStateModel.hadSecurityState integerValue]==1) {
            ex_cell.anqunWenTiLab.text=@"(已设置)";
        }
  
    }
    
    return cell;
}

#pragma mark-  /退出登录/
-(void)performLogOut{
    __weak __typeof__ (self) wself = self;
    
    MCCancelPopView * popView=[MCCancelPopView InitPopViewWithTitle:@"确定要退出登录吗？" sureTitle:@"确定" andCancelTitle:@"取消"];
    [popView show];
    popView.block = ^(NSInteger type) {
        if (type==1) {
            [wself requestLoginOut];
        }
    };
    
}

-(void)requestLoginOut{
    MCLoginOutModel  * loginOutModel =[[MCLoginOutModel alloc]init];
    [loginOutModel refreashDataAndShow];
    self.loginOutModel=loginOutModel;
    loginOutModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [[NSUserDefaults standardUserDefaults] setObject:@"logout" forKey:@"logout"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[MCGetMerchantInfoModel sharedMCGetMerchantInfoModel] clearData];
        [MCUserDefinedLotteryCategoriesViewController clearUserDefinedCZ];
        MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
        mineInfoModel = nil;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MCRefreshMineDataUI];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[MCLoginViewController alloc] init]];
    };
    loginOutModel.callBackSuccessBlock = ^(id manager) {
        [[NSUserDefaults standardUserDefaults] setObject:@"logout" forKey:@"logout"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[MCGetMerchantInfoModel sharedMCGetMerchantInfoModel] clearData];
        [MCUserDefinedLotteryCategoriesViewController clearUserDefinedCZ];
        MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
        mineInfoModel = nil;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MCRefreshMineDataUI];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[MCLoginViewController alloc] init]];
    };
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)titleMarr{
    if (!_titleMarr) {
        _titleMarr =[[NSArray alloc]init];
//        _titleMarr = @[@[@"个人资料",@"银行卡管理"],@[@"修改登录密码",@"修改资金密码",@"安全问题",@"IP名单设置"],@[@"奖金详情"],@[@"帮助中心",@"版本更新"]];
        _titleMarr = @[@[@"个人资料",@"银行卡管理"],@[@"修改登录密码",@"修改资金密码",@"安全问题"],@[@"帮助中心",@"版本更新"]];

        
    }
    return _titleMarr;
}

- (void)cellDidSelectWithType:(NSString *)type{
    
    UIViewController * vc = nil;

    if ([type isEqualToString:@"个人资料"]) {
        
        vc=[[MCPersonInformationViewController alloc]init];
        
    }else if ([type isEqualToString:@"银行卡管理"]){
        
        vc=[[MCBankcardManageViewController alloc]init];
        
    }else if ([type isEqualToString:@"修改登录密码"]){
        
        vc=[[MCModifyLoginPasswordViewController alloc]init];
        
    }else if ([type isEqualToString:@"修改资金密码"]){
        
        vc=[[MCModifyPayPasswordViewController alloc]init];
        
    }else if ([type isEqualToString:@"安全问题"]){
        if ([self.getSecurityStateModel.hadSecurityState integerValue]==1) {
            
            [self enSureSecureQuestion];
            
            return;
        }else{
            MCMSecureSettingViewController *svc=[[MCMSecureSettingViewController alloc]init];
            svc.Type = MCMSecureSettingType_FirstSet;
            self.navigationController.navigationBarHidden=NO;
            [self.navigationController pushViewController:svc animated:YES];
        }

    }else if ([type isEqualToString:@"IP名单设置"]){
        
    }else if ([type isEqualToString:@"奖金详情"]){
        
    }else if ([type isEqualToString:@"帮助中心"]){
        vc = [[MCHelpCenterViewController alloc]init];
    }else if ([type isEqualToString:@"版本更新"]){
        return;
    }
    if (vc == nil) {
        [SVProgressHUD showInfoWithStatus: @"功能完善中..."];
        return;
    }
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)enSureSecureQuestion{
    __weak __typeof__ (self) wself = self;
   
    MCGetRandomSecurityModel * getRandomSecurityModel = [MCGetRandomSecurityModel sharedMCGetRandomSecurityModel];
    if (getRandomSecurityModel.dataSource.Question.length>0) {
        [wself popRandomSecurity:getRandomSecurityModel.dataSource];
    }else{
        _getRandomSecurityModel=getRandomSecurityModel;
         [BKIndicationView showInView:self.view];
        [getRandomSecurityModel refreashDataAndShow];
        getRandomSecurityModel.callBackSuccessBlock = ^(id manager) {
            
            wself.getRandomSecurityModel.dataSource = [MCSecurityQuestionModel mj_objectWithKeyValues:manager[0]];
            [wself popRandomSecurity:wself.getRandomSecurityModel.dataSource];
            
        };
        
        getRandomSecurityModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        };
    }
    
    
    
}

-(void)popRandomSecurity:(MCSecurityQuestionModel *)model{
    __weak __typeof__ (self) wself = self;

    NSString * question = [NSString stringWithFormat:@"\n%@",model.Question];
    //创建UIAlertController 设置标题，信息，样式
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"验证密保问题" message:question preferredStyle:UIAlertControllerStyleAlert];
    
    //添加UITextField
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入答案！";
        textField.keyboardType = UIKeyboardTypeDefault;
        [textField addTarget:wself action:@selector(textFieldChane:) forControlEvents:UIControlEventEditingChanged];
        _textField=textField;
    }];
    
    //创建UIAlertAction对象，设置标题并添加到UIAlertController上
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self retrievePasswordModel:model];
        
    }];
    sureAction.enabled=NO;
    _sureAction=sureAction;
    //设置UIAlertAction对象是否可用
    [alertController addAction:sureAction];
    
    //展现UIAlertController
    [self presentViewController:alertController animated:YES completion:nil];
}

//验证密保答案是否正确
-(void)retrievePasswordModel:(MCSecurityQuestionModel *)model{
    
//    __weak __typeof__ (self) wself = self;
    MCMineInfoModel * mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    
    NSString * UserName;
    if (mineInfoModel.UserName.length>1) {
        UserName=mineInfoModel.UserName;
    }else{
        UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    }
    NSDictionary * dic = @{
                           @"UserName":UserName,//	是	String	用户名称
                           @"RecoveryMode":@"2",//	是	Int	找回方式（1：按资金密码 2：通过密保答案找回），此处传固定值2
                           @"SecurityID":model.ID,//	是	Int	当前问题的ID值
                           @"Answer":_textField.text//	是	String	用户输入答案
                           };
//    {"RecoveryMode":"2","Answer":"西安","UserName":"canny3","SecurityID":"2"}
    MCRetrievePasswordModel * retrievePasswordModel = [[MCRetrievePasswordModel alloc]initWithDic:dic];
    _retrievePasswordModel = retrievePasswordModel;
    [BKIndicationView showInView:self.view];
    [retrievePasswordModel refreashDataAndShow];
    retrievePasswordModel.callBackSuccessBlock = ^(id manager) {
        
        MCMSecureSettingViewController * vc=[[MCMSecureSettingViewController alloc]init];
        vc.Type = MCMSecureSettingType_ModifySet;
        self.navigationController.navigationBarHidden=NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    };

    retrievePasswordModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
    };
//    UserName	是	String	用户名称
//    RecoveryMode	是	Int	找回方式（1：按资金密码 2：通过密保答案找回），此处传固定值2
//    SecurityID	是	Int	当前问题的ID值
//    Answer	是	String	用户输入答案
    
    
}

-(void)textFieldChane:(UITextField *)tf{
    if (tf.text.length>0) {
        _sureAction.enabled=YES;
    }else{
        _sureAction.enabled=NO;
    }
}



-(UIView *)footer{
    if (!_footer) {
        _footer = [[UIView alloc]init];
        _footer.backgroundColor=[UIColor clearColor];
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"退出" forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        btn.backgroundColor =RGB(142, 0, 211);
        [btn addTarget:self action:@selector(performLogOut) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius=10.0;
        btn.clipsToBounds=YES;
        btn.frame=CGRectMake(10, 45, G_SCREENWIDTH-20, 40);
        [_footer addSubview:btn];
    }
    return _footer;
}
@end













































