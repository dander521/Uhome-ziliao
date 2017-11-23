//
//  MCQuestionView.m
//  TLYL
//
//  Created by MC on 2017/7/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQuestionView.h"
#import "MCMineCellModel.h"
@interface MCQuestionView ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*marr_Section;



@end

@implementation MCQuestionView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
    }
    return self;
}


#pragma mark==================createUI======================
-(void)createUI{
    
    
    
    _marr_Section =[[NSMutableArray alloc]init];
    self.backgroundColor=RGB(47, 127, 207);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 键盘会当tableView上下滚动的时候自动收起
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.and.right.equalTo(self).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
}


-(void)setDataSource:(NSMutableArray *)dataSource{
    
    [_marr_Section removeAllObjects];
    
    NSMutableArray * marr_model = [[NSMutableArray alloc]init];
    
    for (NSString * item in dataSource) {
        CellModel* Cmodel =[[CellModel alloc]init];
        Cmodel.reuseIdentifier = [NSString stringWithFormat:@"%@",NSStringFromClass([MCQuestionTableViewCell class])];
        Cmodel.className=NSStringFromClass([MCQuestionTableViewCell class]);
        Cmodel.height = [MCQuestionTableViewCell computeHeight:nil];
        Cmodel.selectionStyle=UITableViewCellSelectionStyleNone;
        Cmodel.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        Cmodel.userInfo = item;
        
        [marr_model addObject:Cmodel];
    }
    
    
    
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_model];
    model0.headerhHeight=10;
    model0.footerHeight=10;
    [_marr_Section addObject:model0];
    
    [_tableView reloadData];
}


#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _marr_Section.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.cells.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.footerHeight;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.headerhHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    
    if ([cm.className isEqualToString:NSStringFromClass([MCQuestionTableViewCell class])]) {
        
        MCQuestionTableViewCell *ex_cell=(MCQuestionTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
  

    if (self.block) {
        self.block(cm.userInfo);
    }

    
}



@end


@interface MCQuestionTableViewCell ()

@property (nonatomic,strong)UILabel * lab_text;

@end

@implementation MCQuestionTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor = [UIColor clearColor];
    
    _lab_text =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_text.textColor=[UIColor whiteColor];
    _lab_text.font=[UIFont systemFontOfSize:16];
    _lab_text.text =@"加载中...";
    _lab_text.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_lab_text];
    
    
    [_lab_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
    }];
    
    
}




-(void)setDataSource:(id)dataSource{
    
    _dataSource=dataSource;
    _lab_text.text = dataSource;
    
}

+(CGFloat)computeHeight:(id)info{
    
    return 36;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
