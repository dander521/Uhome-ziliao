//
//  MCSecurityCenterViewController.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSecurityCenterViewController.h"
#import "MCSecurityCenterTableViewCell.h"
#import "MCMSecureSettingViewController.h"
#import "MCModifyPayPasswordViewController.h"
#import "MCMineCellModel.h"
@interface MCSecurityCenterViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;

@end

@implementation MCSecurityCenterViewController

#pragma mark-viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"安全中心";
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
    
    NSArray * arr=@[@"密码设置",@"密保设置"];
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for (NSString * str in arr) {
        CellModel* Cmodel =[[CellModel alloc]init];
        Cmodel.reuseIdentifier = [NSString stringWithFormat:@"%@",NSStringFromClass([MCSecurityCenterTableViewCell class])];
        Cmodel.className=NSStringFromClass([MCSecurityCenterTableViewCell class]);
        Cmodel.height = [MCSecurityCenterTableViewCell computeHeight:nil];
        Cmodel.selectionStyle=UITableViewCellSelectionStyleNone;
        Cmodel.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        Cmodel.userInfo = str;
        [marr addObject:Cmodel];
    }
    
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr];
    model0.headerhHeight=0.0001;
    model0.footerHeight=0.0001;
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
    
    
    if ([cm.className isEqualToString:NSStringFromClass([MCSecurityCenterTableViewCell class])]) {
        
        MCSecurityCenterTableViewCell *ex_cell=(MCSecurityCenterTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    if ([cm.userInfo isEqualToString:@"密码设置"]) {
        MCModifyPayPasswordViewController * vc=[[MCModifyPayPasswordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([cm.userInfo isEqualToString:@"密保设置"]){
        MCMSecureSettingViewController * vc=[[MCMSecureSettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
