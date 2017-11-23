//
//  MCInputView.m
//  TLYL
//
//  Created by miaocai on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCInputView.h"
@interface MCInputView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tabView;
@end
@implementation MCInputView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        if (self.dataArray.count >=4) {
           self.frame = CGRectMake(0, G_SCREENHEIGHT, G_SCREENWIDTH, 44 * 4);
        } else {
           self.frame = CGRectMake(0, G_SCREENHEIGHT, G_SCREENWIDTH, 44 * self.dataArray.count);
        }
        self.tabView.frame = self.bounds;
        self.backgroundColor = [UIColor whiteColor];
  
        
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.tabView.backgroundColor = [UIColor whiteColor];
}
- (void)show{
    
    [UIView animateWithDuration:0.1 animations:^{
        if (self.dataArray.count >=4) {
            self.frame = CGRectMake(0, G_SCREENHEIGHT -44 * 4, G_SCREENWIDTH, 44 * 4);

            
            
        } else {
            self.frame = CGRectMake(0, G_SCREENHEIGHT -44 * self.dataArray.count, G_SCREENWIDTH, 44 * self.dataArray.count);
           
        }
        
    }];
     self.tabView.frame = self.bounds;
    [self.tabView reloadData];

}

- (void)hiden{

    [UIView animateWithDuration:0.1 animations:^{
        if (self.dataArray.count >=4) {
            self.frame = CGRectMake(0, G_SCREENHEIGHT , G_SCREENWIDTH, 44 * 4);
        } else {
            self.frame = CGRectMake(0, G_SCREENHEIGHT , G_SCREENWIDTH, 44 * self.dataArray.count);
        }
        self.tabView.frame = self.bounds;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (self.dataArray.count -1 >= indexPath.row) {
                NSDictionary *dic = self.dataArray[indexPath.row];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                cell.textLabel.text = dic[@"name"];
            } else {
                cell.textLabel.text = self.dataArray[indexPath.row];
   
            }
            if ([dic isKindOfClass:[NSDictionary class]]) {
                cell.textLabel.text = dic[@"name"];
            } else {
                
                cell.textLabel.text = self.dataArray[indexPath.row];
                
                
            }

    
        }
   
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count == 2) {
        if (self.cellDidSelected) {
            self.cellDidSelected(indexPath.row);
        }
    }else{
        
        if ([self.dataArray[0] isKindOfClass:[NSString class]]) {
            if (self.cellDidSelectedTop) {
                self.cellDidSelectedTop(indexPath.row);
            }
            
        } else {
            NSDictionary *dic = self.dataArray[indexPath.row];
            if (self.cellDidSelectedBlock) {
                self.cellDidSelectedBlock(dic);
            }
        }
        
    }

}
- (UITableView *)tabView{
    
    if (_tabView == nil) {
    NSInteger count = self.dataArray.count;
    if (count>=4) {
        count = 4;
    }
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 44 * count) style:UITableViewStylePlain];
        [self addSubview:tab];
        tab.delegate = self;
        _tabView = tab;
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tab.dataSource = self;

    }
    return _tabView;
}
@end
