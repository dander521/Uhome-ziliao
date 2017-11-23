

//
//  MCCoverView.m
//  TLYL
//
//  Created by miaocai on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCCoverView.h"
#import "MCDYPopView.h"

@interface MCCoverView()

@property (nonatomic,weak) MCDYPopView *popView;

@end

@implementation MCCoverView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
- (void)show{
    self.hidden = NO;
    [self.popView show];
   
   
}

- (void)hidden{
     self.hidden = YES;
     [self.popView hidden];
    
   
}
- (void)setUpUI{
    MCDYPopView *popView = [[MCDYPopView alloc] init];
    self.popView = popView;
    popView.cancelBtnBlock = ^{
       
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    };
    popView.continueBtnBlock = ^{
        if (self.coverViewBlock) {
            self.coverViewBlock();
        }
    };
    popView.frame = CGRectMake(MC_REALVALUE(20), (G_SCREENHEIGHT - 64 - G_SCREENWIDTH + MC_REALVALUE(40)) * 0.5, G_SCREENWIDTH - MC_REALVALUE(40), MC_REALVALUE(300));
    
    [self addSubview:popView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    if (self.cancelBlock) {
//        self.cancelBlock();
//    }
//    [self hidden];
}
- (void)setDataSource:(MCTopUpRecordModel *)dataSource{
    _dataSource = dataSource;
    self.popView.arrData = self.dataArr;
    self.popView.dataSource = self.dataSource;
}
- (void)setDataSourceD:(MCWithdrawModel *)dataSourceD{
    _dataSourceD = dataSourceD;
    self.popView.arrData = self.dataArr;
    self.popView.dataSourceD = self.dataSourceD;
    
}
- (void)setDataSourceZ:(MCZhuanRecordModel *)dataSourceZ{
    _dataSourceZ = dataSourceZ;
    self.popView.arrData = self.dataArr;
    self.popView.dataSourceZ = self.dataSourceZ;
}
@end
