//
//  MCPersonInformationViewController.m
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPersonInformationViewController.h"
#import "MCPersonInformationTableViewCell.h"
#import "MCPersonInformationHeaderView.h"
#import "MCPersonInformationFooterView.h"
#import "MCMineCellModel.h"
#import "MCMineInfoModel.h"
#import "MCModifyUserInfoModel.h"
#import "MCBandRealNameModel.h"
#import "NSString+Helper.h"
#import "MCBindingPhoneViewController.h"
#import "MCBindingEmailViewController.h"
#import "MCBindingNickNameViewController.h"
#import "MCGetSecurityStateModel.h"

@interface MCPersonInformationViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong)UITableView   *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;

@property(nonatomic, strong)MCMineInfoModel * mineInfoModel;
@property(nonatomic, strong)MCModifyUserInfoModel * modifyUserInfoModel;
@property(nonatomic, strong)MCGetSecurityStateModel * getSecurityStateModel;

@end

@implementation MCPersonInformationViewController

#pragma mark-viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
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
    self.title=@"个人资料";
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
    
    MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    self.mineInfoModel = mineInfoModel;
    __weak __typeof__ (self) wself = self;
    [mineInfoModel refreashDataAndShow];
    mineInfoModel.callBackSuccessBlock = ^(id manager) {
        
        wself.mineInfoModel=[MCMineInfoModel mj_objectWithKeyValues:manager];
        [wself setCellMarry];
    };
    
    mineInfoModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        
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

-(void)setCellMarry{
    
    [_sectionMarr removeAllObjects];
    
    CellModel* model0 =[[CellModel alloc]init];
    model0.reuseIdentifier = NSStringFromClass([MCPersonInformationTableViewCell class]);
    model0.className=NSStringFromClass([MCPersonInformationTableViewCell class]);
    model0.height = [MCPersonInformationTableViewCell computeHeight:nil];
    model0.selectionStyle=UITableViewCellSelectionStyleNone;
    model0.accessoryType=UITableViewCellAccessoryNone;
    /*`
     * 传递参数
     */
    model0.userInfo = self.mineInfoModel;
    
    SectionModel *Smodel0=[SectionModel sectionModelWithTitle:@"" cells:@[model0]];
    Smodel0.headerhHeight=0.0001;
    Smodel0.footerHeight=0.00001;
    [_sectionMarr addObject:Smodel0];
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
    return nil ;
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
    if ([cm.className isEqualToString:NSStringFromClass([MCPersonInformationTableViewCell class])]) {
        
        MCPersonInformationTableViewCell *ex_cell=(MCPersonInformationTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;

        ex_cell.block = ^(NSInteger type) {
            //用户姓名
            if (type==1001) {
            //用户昵称
            }else if (type==1002){
                MCBindingNickNameViewController * vc =[[MCBindingNickNameViewController alloc]init];
                [wself.navigationController pushViewController:vc animated:YES];
            //真实姓名
            }else if (type==1003){
            //绑定手机
            }else if (type==1004){
                
                MCBindingPhoneViewController * vc =[[MCBindingPhoneViewController alloc]init];
                [wself.navigationController pushViewController:vc animated:YES];
            //绑定邮箱
            }else if (type==1005){
                MCBindingEmailViewController * vc =[[MCBindingEmailViewController alloc]init];
                [wself.navigationController pushViewController:vc animated:YES];
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
