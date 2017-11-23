//
//  MCMoneyPopView.m
//  TLYL
//
//  Created by miaocai on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMoneyPopView.h"

static MCMoneyPopView *_alertMoneyWindow;

@interface MCMoneyPopView()<UITableViewDelegate,UITableViewDataSource>
#pragma  mark - property
@property (nonatomic,weak) UITableView *tab;

@end

@implementation MCMoneyPopView

#pragma mark - Init

+ (instancetype)alertInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _alertMoneyWindow = [[self alloc] init];
        [_alertMoneyWindow setUpUI];
    });
    return _alertMoneyWindow;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tab.frame = self.bounds;
    
}
- (void)setUpUI{
    self.backgroundColor=RGB(255, 255, 255);
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
    
    UITableView *tab = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self addSubview:tab];
    tab.dataSource = self;
    tab.delegate = self;
    tab.rowHeight = 30;
    tab.backgroundColor = RGB(255, 255, 255);
    [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MCMoneyPopView"];
    self.tab = tab;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCMoneyPopView"];
    cell.backgroundColor=[UIColor clearColor];
    MCShowBetModel * model=self.dataArray[indexPath.row];
    cell.textLabel.text = model.showRebate;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.MoneySelectRowBlock != nil) {
        self.MoneySelectRowBlock(self.dataArray[indexPath.row]);
        [self hideModelWindow];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - show and hide window

- (void)showModelWindow{
    [self.tab reloadData];
    _alertMoneyWindow.hidden = NO;
}

- (void)hideModelWindow{
    
    _alertMoneyWindow.hidden = YES;
    
}

#pragma mark - getter and setter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc]init];
//        _dataArray = [NSMutableArray arrayWithArray:@[@"1982,0.0",@"1980,0.0",@"1978,0.0",@"1976,0.0",@"1974,0.0",@"1972,0.0",@"1982,0.0",@"1982,0.0",@"1982,0.0"]];
    }
    return _dataArray;
}


@end
