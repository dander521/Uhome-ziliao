//
//  MCMSecureSettingViewController.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMSecureSettingViewController.h"
#import "MCMSecureSettingTableViewCell.h"
#import "MCMineCellModel.h"
#import "MCSecurityAllQuestionModel.h"
#import "MCSecurityQuestionTool.h"
#import "MCSetSecurityQuestionModel.h"
#import "MCGetSecurityStateModel.h"
#import "MCModifySecurityQuestionModel.h"

@interface MCMSecureSettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource
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

@property(nonatomic, strong)MCMSecureSettingTableViewCell *ex_cell;

@end

@implementation MCMSecureSettingViewController

#pragma mark-viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadAllQuestion];
}


#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(231,231,231);
    self.title=@"安全问题";
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

#pragma mark - gesture actions
- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

#pragma mark==================loadData======================
-(void)loadData{
    

    CellModel* Cmodel =[[CellModel alloc]init];
    Cmodel.reuseIdentifier = [NSString stringWithFormat:@"%@---",NSStringFromClass([MCMSecureSettingTableViewCell class])];
    Cmodel.className=NSStringFromClass([MCMSecureSettingTableViewCell class]);
    Cmodel.height = [MCMSecureSettingTableViewCell computeHeight:nil];
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

    MCGetSecurityStateModel * getSecurityStateModel = [MCGetSecurityStateModel sharedMCGetSecurityStateModel];
    _getSecurityStateModel=getSecurityStateModel;
    [getSecurityStateModel refreashDataAndShow];
    getSecurityStateModel.callBackSuccessBlock = ^(id manager) {
        
        wself.getSecurityStateModel.hadSecurityState=manager[@"Result"];
    };
    
    getSecurityStateModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
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
    SectionModel *sm = _sectionMarr[section];
    return sm.footerHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.headerhHeight;
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
    if ([cm.className isEqualToString:NSStringFromClass([MCMSecureSettingTableViewCell class])]) {
        MCMSecureSettingTableViewCell *ex_cell=(MCMSecureSettingTableViewCell *)cell;
        ex_cell.dataSource=self.securityAllQuestionModel.dataSource;
        _ex_cell=ex_cell;
        if (_Type == MCMSecureSettingType_FirstSet) {
            [_ex_cell.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        }else{
            [_ex_cell.finishBtn setTitle:@"修改" forState:UIControlStateNormal];
        }
        ex_cell.block = ^{
            [wself finishBtnAction];
        };
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)finishBtnAction{
    MCMSecureSettingTableViewCell * cell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString * question1 = cell.question1Btn.titleLabel.text;
    NSString * question2 = cell.question2Btn.titleLabel.text;
    NSString * answer1 = cell.answer1Tf.text;
    NSString * answer2 = cell.answer2Tf.text;
    
    if ([question1 isEqualToString:@"请选择问题"]||[question2 isEqualToString:@"请选择问题"]) {
        [SVProgressHUD showInfoWithStatus:@"请选择问题！"];
        return;
    }
    
    if (!answer1||!answer2||[answer1 isEqualToString:@""]||[answer2 isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请填写答案！"];
        return;
    }
    
    NSDictionary * firstSetDic =
         @{
              @"UserID":[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"],
              @"UserName":[[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"],
              @"SecurityQuestionModels":
                 @[
                    @{
                      @"ID":_ex_cell.question1Btn.model.ID,
                      @"Question":_ex_cell.question1Btn.model.Question
                      },
                    @{
                      @"ID":_ex_cell.question2Btn.model.ID,
                      @"Question":_ex_cell.question2Btn.model.Question
                      }
                  ]
          };
    
    if (_Type == MCMSecureSettingType_FirstSet) {
#pragma mark---------第一次设置密保
        [BKIndicationView showInView:self.view];
        MCSetSecurityQuestionModel * setSecurityQuestionModel=[[MCSetSecurityQuestionModel alloc]initWithDic:firstSetDic];
        self.setSecurityQuestionModel=setSecurityQuestionModel;
        [setSecurityQuestionModel refreashDataAndShow];
        setSecurityQuestionModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        };
        setSecurityQuestionModel.callBackSuccessBlock = ^(id manager) {
        };
    }else{
#pragma mark---------修改密保
        NSDictionary * modifyDic =
           @{
              @"UserID":[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"],
              @"UserName":[[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"],
              @"SecurityQuestionModels":
                 @[
                      @{
                          @"ID":_ex_cell.question1Btn.model.ID,
                          @"Question":_ex_cell.question1Btn.model.Question,
                          @"KeyID":_ex_cell.question2Btn.model.KeyID
                      },
                      @{
                          @"ID":_ex_cell.question2Btn.model.ID,
                          @"Question":_ex_cell.question2Btn.model.Question,
                          @"KeyID":_ex_cell.question2Btn.model.KeyID
                       }
                  ]
            };
        [BKIndicationView showInView:self.view];
        MCModifySecurityQuestionModel * modifySecurityQuestionModel=[[MCModifySecurityQuestionModel alloc]initWithDic:modifyDic];
        self.modifySecurityQuestionModel=modifySecurityQuestionModel;
        [modifySecurityQuestionModel refreashDataAndShow];
        modifySecurityQuestionModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        };
        modifySecurityQuestionModel.callBackSuccessBlock = ^(id manager) {
        };
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
