//
//  MCHelpCenterViewController.m
//  TLYL
//
//  Created by MC on 2017/11/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCHelpCenterViewController.h"
#import "MCHelpCenterTableViewCell.h"
#import "MCMineCellModel.h"
#import "MCHelpCenterDetailViewController.h"

@interface MCHelpCenterViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MCHelpCenterCellDelegate
>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;
@property(nonatomic, strong)NSArray*titleMarr;



@end

@implementation MCHelpCenterViewController

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

}
#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"帮助中心";
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
        model.reuseIdentifier = NSStringFromClass([MCHelpCenterTableViewCell class]);
        model.className=NSStringFromClass([MCHelpCenterTableViewCell class]);
        model.height = [MCHelpCenterTableViewCell computeHeight:temp];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = temp;
        
        SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
        model0.headerhHeight=0.0001;
        model0.footerHeight=0.0001;
        [_sectionMarr addObject:model0];
        [_tableView reloadData];
        i++;
        
    }
}

#pragma mark tableView 代理相关
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCHelpCenterTableViewCell class])]) {
        
        MCHelpCenterTableViewCell *ex_cell=(MCHelpCenterTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        ex_cell.delegate=self;
        
    }
    
    return cell;
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
        _titleMarr = @[@[@"资料绑定",@"忘记密码",@"账户安全",@"账户回收"],@[@"充值不到账",@"充值到账时间"],@[@"如何提款",@"提款时间",@"提款要求",@"提款安全"]];
        
        
    }
    return _titleMarr;
}

- (void)cellDidSelectWithType:(NSString *)type{
    
    MCHelpCenterDetailViewController * vc = [[MCHelpCenterDetailViewController alloc]init];
    vc.helpTitle=type;
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
}



@end














































