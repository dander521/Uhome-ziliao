//
//  MCPickNumberHeaderView.m
//  TLYL
//
//  Created by Canny on 2017/7/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPickNumberHeaderView.h"
#import "UIView+MCParentController.h"
#import "UIImage+Extension.h"
#import "MCPickNumberViewController.h"
#import "MCLotteryHalllPickTableViewCell.h"

@implementation MCPickNumberHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=RGB(240, 240, 240);
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    UIView *selectedCardView = [[UIView alloc] init];
      self.backgroundColor=RGB(255, 255, 255);
      self.layer.cornerRadius = 4;
      self.clipsToBounds = YES;
//    [self addSubview:selectedCardView];
//    self.selectedCardView = selectedCardView;
//    self.selectedCardView.hidden = NO;
//    
//    if (self.heiht < 1) {
//        
//    } else {
//        [selectedCardView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(10);
//            make.left.right.bottom.equalTo(self);
//        }];
//    }
 
    NSArray *selectedCardArray = @[@"万位",@"千位",@"百位",@"十位",@"个位"];
    for (NSInteger i = 0; i<selectedCardArray.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn setTitle:selectedCardArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:10];
        [btn setTitleColor:RGB(46, 46, 46) forState:UIControlStateNormal];
        [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateSelected];
        CGFloat W_btn=(G_SCREENWIDTH-46-10*4)/5.0;
        btn.frame = CGRectMake(10+i*(W_btn+10), 8, W_btn, MC_REALVALUE(30));
        [btn addTarget:self action:@selector(selectedCardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"touzhu-wanfa-wbg"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"touzhu-wanfa-xzbg"] forState:UIControlStateSelected];
        btn.tag = 1999 - i;
        
    }

    
}

#pragma mark-点击选项卡
- (void)selectedCardBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    MCPickNumberViewController * vc=(MCPickNumberViewController *)[UIView MCcurrentViewController];
    if (btn.selected == YES) {
        
        [vc.selectedCardArray addObject:[btn titleForState:UIControlStateNormal]];
    } else {
        [vc.selectedCardArray removeObject:[btn titleForState:UIControlStateNormal]];
    }
    vc.baseWFmodel.selectedCardArray = vc.selectedCardArray;
    
    
    /*
     * 注数计算
     */
    
    //非单式注数计算
    MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:vc.baseWFmodel];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
    
    //单式注数计算
    MCLotteryHalllPickTableViewCell *cell=[vc.baseTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell caculateStakeNumber];
    
    
}


-(void)setDataSource:(MCBasePWFModel *)dataSource{
    MCPickNumberViewController * vc=(MCPickNumberViewController *)[UIView MCcurrentViewController];
    
    _dataSource=dataSource;
    if ([dataSource.isShowSelectedCard isEqualToString:@"1"]) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
//    if (self.heiht < 1) {
//        
//    } else {
//        [_selectedCardView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(10);
//            make.left.right.bottom.equalTo(self);
//        }];
//    }
    int i = 0;
    [vc.selectedCardArray removeAllObjects];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            
            btn.selected = NO;
            
        } else {
            
        }
    }
    i=0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (i >= (5 - [dataSource.SelectedCardNumber intValue])) {
                btn.selected = YES;
                [vc.selectedCardArray addObject:[btn titleForState:UIControlStateNormal]];
                
            }
            i++;
            vc.baseWFmodel.selectedCardArray = vc.selectedCardArray;
        } else {
            
        }
    }
}


@end
