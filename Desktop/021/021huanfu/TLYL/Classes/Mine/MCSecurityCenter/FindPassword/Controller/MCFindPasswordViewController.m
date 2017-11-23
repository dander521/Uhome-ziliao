//
//  MCFindPasswordViewController.m
//  TLYL
//
//  Created by MC on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCFindPasswordViewController.h"
#import "MCMineCellModel.h"
#import "MCSecurityAllQuestionModel.h"
#import "MCSecurityQuestionTool.h"
#import "MCSetSecurityQuestionModel.h"
#import "MCGetSecurityStateModel.h"
#import "MCModifySecurityQuestionModel.h"
#import "MCMineInfoModel.h"
#import "MCRetrievePasswordModel.h"
#import "MCFindPasswordTableViewCell.h"
#import "MCResetLoginPwdModel.h"
#import "NSString+Helper.h"
#import "MCFindPasswordHeaderView.h"

@interface MCFindPasswordViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;

//查询是否已设置密保问题
@property(nonatomic, strong)MCGetSecurityStateModel * getSecurityStateModel;
//获取所有的密保问题
@property(nonatomic, strong)MCSecurityAllQuestionModel * securityAllQuestionModel;
//第一次设置密保问题
@property(nonatomic, strong)MCSetSecurityQuestionModel * setSecurityQuestionModel;
//修改已设置的密保问题
@property(nonatomic, strong)MCModifySecurityQuestionModel * modifySecurityQuestionModel;
//验证密保答案是否正确
@property(nonatomic, strong)MCRetrievePasswordModel * retrievePasswordModel;
//当忘记密码后，重置登录密码
@property(nonatomic, strong)MCResetLoginPwdModel * resetLoginPwdModel;
@property(nonatomic, strong)MCFindPasswordTableViewCell * ex_cell;


@property(nonatomic, strong)UITextField * textField1;
@property(nonatomic, strong)UITextField * textField2;
@property(nonatomic, weak)UIAlertAction * sureAction;
@property(nonatomic, strong)MCFindPasswordHeaderView * headerView;

@end

@implementation MCFindPasswordViewController

#pragma mark-viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self loadAllQuestion];
    
}

- (void)setNavigationState:(BOOL)state{
    if (state) {
        self.edgesForExtendedLayout=UIRectEdgeBottom;
    }
    else{
        self.edgesForExtendedLayout=UIRectEdgeTop;
    }
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController setNavigationBarHidden:state animated:YES];
}

#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(231,231,231);
    self.title=@"找回密码";
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
    // 键盘会当tableView上下滚动的时候自动收起
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:singleTapGesture];
    
}

-(void)setNav{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"图层-6"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"图层-6"] forState:UIControlStateHighlighted];
    button.size = CGSizeMake(70, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(disMissViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.hidesBottomBarWhenPushed = YES;
}


-(void)disMissViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - gesture actions
- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

#pragma mark==================loadData======================
-(void)loadData{
    
    
    CellModel* Cmodel =[[CellModel alloc]init];
    Cmodel.reuseIdentifier = [NSString stringWithFormat:@"%@---",NSStringFromClass([MCFindPasswordTableViewCell class])];
    Cmodel.className=NSStringFromClass([MCFindPasswordTableViewCell class]);
    Cmodel.height = [MCFindPasswordTableViewCell computeHeight:nil];
    Cmodel.selectionStyle=UITableViewCellSelectionStyleNone;
    Cmodel.accessoryType=UITableViewCellAccessoryNone;
    /*
     * 传递参数
     */
    Cmodel.userInfo = nil;
    
    SectionModel *model=[SectionModel sectionModelWithTitle:@"" cells:@[Cmodel]];
    model.headerhHeight=0.00001;
    model.footerHeight=0.00001;
    [_sectionMarr addObject:model];
    
    [_tableView reloadData];
    
}


-(void)loadAllQuestion{
    
    __weak __typeof__ (self) wself = self;
    
    MCSecurityAllQuestionModel * securityAllQuestionModel=[MCSecurityAllQuestionModel sharedMCSecurityAllQuestionModel];
    self.securityAllQuestionModel=securityAllQuestionModel;
    [BKIndicationView showInView:self.view];
    [securityAllQuestionModel refreashDataAndShow];
    
    securityAllQuestionModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
    };
    
    securityAllQuestionModel.callBackSuccessBlock = ^(id manager) {
        NSMutableArray * marr=[[NSMutableArray alloc]init];
        for (NSDictionary * dic in manager) {
            [marr addObject:[MCSecurityQuestionModel mj_objectWithKeyValues:dic]];
        }
        wself.securityAllQuestionModel.dataSource=marr;
    };
    
   
}

#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.cells.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return self.headerView;
    }
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
    
    __weak __typeof__ (self) wself = self;
    if ([cm.className isEqualToString:NSStringFromClass([MCFindPasswordTableViewCell class])]) {
        MCFindPasswordTableViewCell *ex_cell=(MCFindPasswordTableViewCell *)cell;
        ex_cell.dataSource=self.securityAllQuestionModel.dataSource;
        _ex_cell=ex_cell;
        
        ex_cell.block = ^{
            [wself retrievePassword];
        };
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

//验证密保答案是否正确
-(void)retrievePassword{
    
    if (_ex_cell.userNameTf.text.length<1 ) {
        [SVProgressHUD showInfoWithStatus:@"请输入用户名！"];
        return;
    }
    
    if (_ex_cell.question1Btn.model.Question.length<1) {
        [SVProgressHUD showInfoWithStatus:@"请选择问题！"];
        return;
    }
    
    if (_ex_cell.answer1Tf.text.length<1){
        [SVProgressHUD showInfoWithStatus:@"请输入答案！"];
        return;
    }
    
    NSDictionary * dic = @{
                           @"UserName":_ex_cell.userNameTf.text,//用户名称
                           @"RecoveryMode":@"2",//找回方式（1：按资金密码 2：通过密保答案找回），此处传固定值2
                           @"SecurityID":_ex_cell.question1Btn.model.ID,//当前问题的ID值
                           @"Answer":_ex_cell.answer1Tf.text//用户输入答案
                           };
    __weak __typeof__ (self) wself = self;

    MCRetrievePasswordModel * retrievePasswordModel = [[MCRetrievePasswordModel alloc]initWithDic:dic];
    _retrievePasswordModel = retrievePasswordModel;
    [BKIndicationView showInView:self.view];
    [retrievePasswordModel refreashDataAndShow];
    retrievePasswordModel.callBackSuccessBlock = ^(id manager) {
        
        [wself setNewPassWord];
        
    };
    
    retrievePasswordModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        
        
    };

    
    
}

-(void)setNewPassWord{

    __weak __typeof__ (self) wself = self;
    
    //创建UIAlertController 设置标题，信息，样式
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"重置登录密码" message:@"\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 60, 240, 100)];
    [alertController.view addSubview:view];
    view.backgroundColor=[UIColor clearColor];
    
    UITextField * textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];//wight = 270;
    textField1.borderStyle = UITextBorderStyleRoundedRect;//设置边框的样式
    //添加子控件也是直接add,爽
    [view addSubview:textField1];
    textField1.delegate=self;
    textField1.placeholder = @"请输入新登录密码！";
    textField1.secureTextEntry=YES;
    textField1.font = [UIFont systemFontOfSize:14];
    textField1.textColor = RGB(40, 40, 40);
    textField1.textAlignment = NSTextAlignmentLeft;
    textField1.returnKeyType = UIReturnKeyDone;
    textField1.keyboardType = UIKeyboardTypeDefault;
    [textField1 setValue:RGB(190, 190, 190) forKeyPath:@"_placeholderLabel.textColor"];
    [textField1 setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [textField1 addTarget:wself action:@selector(textFieldChane:) forControlEvents:UIControlEventEditingChanged];
    _textField1=textField1;
    

    UITextField * textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 240, 30)];//wight = 270;
    textField2.borderStyle = UITextBorderStyleRoundedRect;//设置边框的样式
    //添加子控件也是直接add,爽
    [view addSubview:textField2];
    textField2.delegate=self;
    textField2.placeholder = @"请再次输入登录密码！";
    textField2.secureTextEntry=YES;
    textField2.font = [UIFont systemFontOfSize:14];
    textField2.textColor = RGB(40, 40, 40);
    textField2.textAlignment = NSTextAlignmentLeft;
    textField2.returnKeyType = UIReturnKeyDone;
    textField2.keyboardType = UIKeyboardTypeDefault;
    [textField2 setValue:RGB(190, 190, 190) forKeyPath:@"_placeholderLabel.textColor"];
    [textField2 setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [textField2 addTarget:wself action:@selector(textFieldChane:) forControlEvents:UIControlEventEditingChanged];
    _textField2=textField2;

    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wself ResetLoginPwd];
        
    }];
    sureAction.enabled=NO;
    _sureAction=sureAction;
    //设置UIAlertAction对象是否可用
    [alertController addAction:sureAction];
    
    //展现UIAlertController
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)textFieldChane:(UITextField *)tf{
    
    tf.text = [tf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (_textField1.text.length>0&&_textField2.text.length>0) {
        _sureAction.enabled=YES;
    }else{
        _sureAction.enabled=NO;
    }
}

-(void)ResetLoginPwd{
    if (_textField1.text.length<6||_textField2.text.length<6||_textField1.text.length>18||_textField2.text.length>18 ||[NSString judgePassWordLegal:_textField1.text] == NO ) {
        [SVProgressHUD showErrorWithStatus:@"密码只能为6～18位字母和数字"];
        return;
    }
    
    if ([_textField1.text isEqualToString:_textField2.text]) {
        
    }else{
        [SVProgressHUD showInfoWithStatus:@"两次输入的密码不一致！"];
        return;
    }
    
    
    NSDictionary * dic =@{
                          @"UserName":_ex_cell.userNameTf.text,
                          @"NewPassword":_textField1.text
                          };
    MCResetLoginPwdModel *resetLoginPwdModel = [[MCResetLoginPwdModel alloc]initWithDic:dic];
    _resetLoginPwdModel = resetLoginPwdModel;
    [BKIndicationView showInView:self.view];
    [resetLoginPwdModel refreashDataAndShow];
    resetLoginPwdModel.callBackSuccessBlock = ^(id manager) {
        
        [SVProgressHUD showInfoWithStatus:@"修改成功！"];
        [self disMissViewController];
        
    };
    
    resetLoginPwdModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        
        [SVProgressHUD showInfoWithStatus:@"修改失败！"];
    };

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-set/get
-(MCFindPasswordHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[[MCFindPasswordHeaderView alloc]init];
    }
    return _headerView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

