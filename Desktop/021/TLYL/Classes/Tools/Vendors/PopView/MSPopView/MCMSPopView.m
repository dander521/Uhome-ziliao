//
//  MCMSPopView.m
//  TLYL
//
//  Created by miaocai on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import "MCMSPopView.h"

static MCMSPopView *_alertWindow;

@interface MCMSPopView()<UITableViewDelegate,UITableViewDataSource>
#pragma  mark - property
@property (nonatomic,weak) UITableView *tab;

@end

@implementation MCMSPopView

#pragma mark - Init

+ (instancetype)alertInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _alertWindow = [[self alloc] init];
        [_alertWindow setUpUI];
    });
    return _alertWindow;
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
    [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MCMSPopView"];
    self.tab = tab;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCMSPopView"];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.MSSelectRowBlock != nil) {
        self.MSSelectRowBlock(self.dataArray[indexPath.row]);
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
    
    _alertWindow.hidden = NO;
    [_alertWindow.tab reloadData];
}

- (void)hideModelWindow{
    
    _alertWindow.hidden = YES;
    
}

#pragma mark - getter and setter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        _dataArray = [NSMutableArray arrayWithArray:@[@"元  模式"]];
//        _dataArray = [NSMutableArray arrayWithArray:@[@"元模式",@"角模式",@"分模式",@"厘模式"]];
    }
    return _dataArray;
}

@end
