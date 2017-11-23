//
//  MCBankcardManageViewController.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBankcardManageViewController.h"
#import "MCMineAddBankCardViewController.h"
#import "MCBankcardManageHeader.h"
#import "MCMineCellModel.h"
#import "MCBankCardListModel.h"
#import "MCDefaultBankCardModel.h"
#import "ExceptionView.h"
#import "MCBankcardManageTableViewCell.h"
#import "MCMineInfoModel.h"
#import "MCBankcardManageFooter.h"

@interface MCBankcardManageViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MCBankcardManageHeaderDelegate
>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray<SectionModel *>*sectionMarr;
@property(nonatomic, strong)MCBankcardManageHeader *headerView;

@property(nonatomic, strong)NSMutableArray <MCBankModel *>* modelMarr;
@property(nonatomic, strong)MCBankCardListModel *apiModel;
@property(nonatomic, strong)MCDefaultBankCardModel *defaultBankCardModel;
@property(nonatomic, strong)MCMineInfoModel *mineInfoModel;
@property(nonatomic, strong)ExceptionView * exceptionView;
@property(nonatomic, strong)MCBankcardManageFooter *footer;


@end

@implementation MCBankcardManageViewController

#pragma mark-viewDidLoad
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    [self loadData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];


}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    [self refreshData];
}

-(void)refreshData{
    __weak __typeof(self)wself = self;
    
    MCMineInfoModel * mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    self.mineInfoModel = mineInfoModel;
    
    [mineInfoModel refreashDataAndShow];
    mineInfoModel.callBackSuccessBlock = ^(id manager) {
        
        wself.mineInfoModel=[MCMineInfoModel mj_objectWithKeyValues:manager];
        
    };
 
}

#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(236, 236, 236);
    self.title=@"银行卡管理";
    _sectionMarr= [[NSMutableArray alloc]init];
    _modelMarr=[[NSMutableArray alloc]init];

}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"客服" forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
}

-(void)rightBtnAction{
    
    
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
    [_modelMarr removeAllObjects];
    
    MCBankCardListModel  * apiModel =[[MCBankCardListModel alloc]init];
    [apiModel refreashDataAndShow];
    self.apiModel=apiModel;

    __weak __typeof__ (self) wself = self;
    [BKIndicationView showInView:self.view];
    
    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [BKIndicationView dismiss];
        

        wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
        ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
            [wself.exceptionView dismiss];
            wself.exceptionView = nil;
            [wself loadData];
        }];
        [wself.exceptionView addAction:action];
        [wself.exceptionView showInView:wself.view];

        
    };
    apiModel.callBackSuccessBlock = ^(id manager) {
        
        [BKIndicationView dismiss];

        NSArray * arr=manager;
        int i=0,index=0;
        for (NSDictionary * dic in arr) {
            if (i<5) {
                MCBankModel * model=[[MCBankModel alloc]init];
                model.bankNumer=[NSString stringWithFormat:@"%@",dic[@"CardNumber"]];
                model.showBankNumber=[MCMathUnits GetBankCardShowNum:dic[@"CardNumber"]];
                model.Isdefault=[NSString stringWithFormat:@"%@",dic[@"Isdefault"]];
                model.bankName=dic[@"BranchName"];
                if ([model.Isdefault isEqualToString:@"1"]) {
                    index=i;
                }
                model.bankId=[NSString stringWithFormat:@"%@",dic[@"ID"]];
                model.BankCode=[NSString stringWithFormat:@"%@",dic[@"BankCode"]];
                model.userName=[NSString stringWithFormat:@"%@",dic[@"UserName"]];
                model.CreateTime=[NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
                [_modelMarr addObject:model];
            }
            i++;
        }
        if (index!=0) {
            [_modelMarr exchangeObjectAtIndex:0 withObjectAtIndex:index];
        }
        
        [self reloadData];
        
    };

}


-(void)reloadData{
    
    
    [_sectionMarr removeAllObjects];
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    int i=0;
    for (MCBankModel * bankmodel in _modelMarr) {
        
        CellModel* Cmodel =[[CellModel alloc]init];
        Cmodel.reuseIdentifier = [NSString stringWithFormat:@"%@-%d",NSStringFromClass([MCBankcardManageTableViewCell class]),i];
        Cmodel.className=NSStringFromClass([MCBankcardManageTableViewCell class]);
        Cmodel.height = [MCBankcardManageTableViewCell computeHeight:nil];
        Cmodel.selectionStyle=UITableViewCellSelectionStyleNone;
        Cmodel.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        Cmodel.userInfo = bankmodel;
        
        [marr addObject:Cmodel];
        i++;
    }
   

    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr];
    model0.headerhHeight=[MCBankcardManageHeader computeHeight:nil];
    model0.footerHeight=[MCBankcardManageFooter computeHeight:_modelMarr];
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


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.footerHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_modelMarr.count==5) {
        [self.headerView setHiddenBtn];
        return self.headerView ;
    }else{
        return self.headerView ;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_modelMarr.count==5) {
        return 10 ;
    }else{
        SectionModel *sm = _sectionMarr[section];
        return sm.headerhHeight;
    }
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
    
    
    if ([cm.className isEqualToString:NSStringFromClass([MCBankcardManageTableViewCell class])]) {
        
        MCBankcardManageTableViewCell *ex_cell=(MCBankcardManageTableViewCell *)cell;
        if (indexPath.row%2==0) {
            [ex_cell setBackViewWithSingal:YES];
        }else{
            [ex_cell setBackViewWithSingal:NO];
        }
        ex_cell.dataSource=cm.userInfo;
    }
    
    return cell;
}

-(void)setDefaultBankCard:(MCBankModel *)model{
        if ([model.Isdefault intValue]==1) {
            return;
        }else{
    
            /*
             * 设置该卡位默认银行卡
             */
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认将此卡设为默认卡吗？" preferredStyle:UIAlertControllerStyleAlert];
    
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
                [self setDefaultBankCardWithModel:model];
    
            }]];
    
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消按钮");
            }]];
    
            [self presentViewController:alert animated:YES completion:nil];
            
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    [self setDefaultBankCard:cm.userInfo];
    
}

#pragma mark-设置默认银行卡
-(void)setDefaultBankCardWithModel:(MCBankModel *)model{

    MCDefaultBankCardModel  * defaultBankCardModel =[[MCDefaultBankCardModel alloc]init];
    defaultBankCardModel.BankCardId=model.bankId;
    defaultBankCardModel.CardNumber=model.bankNumer;
    [BKIndicationView showInView:self.view];
    [defaultBankCardModel refreashDataAndShow];
    self.defaultBankCardModel=defaultBankCardModel;
    
    
    
    defaultBankCardModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {

    };
    
    defaultBankCardModel.callBackSuccessBlock = ^(id manager) {
        
        [self loadData];

    };
}

-(MCBankcardManageHeader *)headerView{
    if (!_headerView) {
        _headerView=[[MCBankcardManageHeader alloc]init];
        _headerView.delegate=self;
    }
    return _headerView;
}

#pragma mark-MCBankcardManageFooterDelegate /添加银行卡/
-(void)goToAddBankcardViewController{
    
    if (_modelMarr.count>4) {
        [SVProgressHUD showErrorWithStatus:@"最多只能绑定5张银行卡！"];
        return;
    }
    __weak __typeof(self)wself = self;
    
     MCMineAddBankCardViewController* vc=[[MCMineAddBankCardViewController alloc]init];
    vc.block=^(MCBankModel *model){
        
        [wself loadData];
        
    };
    

    [self.navigationController pushViewController:vc animated:YES];
}

-(MCBankcardManageFooter *)footer{
    if (!_footer) {
        _footer=[[MCBankcardManageFooter alloc]init];
    }
    return _footer;
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
