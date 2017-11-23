//
//  MCBallCollectionViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBallCollectionViewCell.h"
#import "UIImage+Extension.h"
#import "MCStakeUntits.h"
#import "UIImage+Extension.h"
#import "UIView+MCParentController.h"
#import "MCPickNumberViewController.h"

@interface MCBallCollectionViewCell()

@property (nonatomic,assign,getter=isFirstChange) BOOL firstChange;

@end

@implementation MCBallCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconBtn.backgroundColor=RGB(243, 220, 255);
    self.iconBtn.clipsToBounds=YES;
    CGFloat bw = (G_SCREENWIDTH - 5*10 -20*2 ) /6;
    self.iconBtn.layer.cornerRadius=MC_REALVALUE(20);
    self.iconBtn.layer.borderColor = RGB(144, 8, 215).CGColor;
    [self.iconBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:MC_REALVALUE(20)]];
    [self.iconBtn setTitleColor:RGB(192, 71, 255) forState:UIControlStateNormal];
    [self.iconBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    UIImage *imgNormal = [UIImage imageNamed:@"touzhu-bg-icon"];
    UIImage *imgSelected = [UIImage imageNamed:@"touzhu-lskj-dbg"];
    [self.iconBtn setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [self.iconBtn setBackgroundImage:imgSelected forState:UIControlStateSelected];
    self.iconBtn.userInteractionEnabled = NO;
    [self.iconBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
}
- (void)btnClick:(UIButton *)btn{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEY_BOARD_HIDEN" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BALL_BTN_CLICK" object:nil userInfo:nil];
    
    btn.selected = !btn.selected;
    self.dataSource.filterSelectd = NO;
    self.firstChange = NO;
    self.dataSource.seleted = btn.selected;
    
    if (self.selectedBall != nil) {
        self.selectedBall(self.dataSource);
    }
    if (self.selectedBallK3TongXuan != nil) {
        self.selectedBallK3TongXuan(self.dataSource);
    }
    
    if (self.selectedBallZuXuanBaoDan != nil) {
        self.selectedBallZuXuanBaoDan(self.dataSource);
    }
}

- (void)setDataSource:(MCBallCollectionModel *)dataSource{
    
    self.dataSource.filterSelectd = YES;
    
    _dataSource = dataSource;
    self.iconBtn.userInteractionEnabled = YES;
    if (dataSource.textInfo.length>=2) {
        [self.iconBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:MC_REALVALUE(17)]];
    } else {
        [self.iconBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:MC_REALVALUE(20)]];
    }
    [self.iconBtn setTitle:dataSource.textInfo forState:UIControlStateNormal];
    self.iconBtn.selected = dataSource.seleted;
    
    
    self.ballItemSelected = dataSource.seleted;
    if (self.selectedBall != nil ) {
        self.selectedBall(self.dataSource);
    }
    
}


- (void)setSelected:(BOOL)selected{
    self.ballItemSelected = YES;
    if ([self.dataSource.mutex isEqualToString:@"2"]) {
        
        //        NSString *jixuan = [[NSUserDefaults standardUserDefaults] objectForKey:@"JIXUAN"];
        //
        //        if ([jixuan intValue]==1) {
        //
        //        }else{
        
        //            [super setSelected:selected];
        //            //清空前面的         选择当前
        //            self.iconBtn.selected = selected;
        //            self.dataSource.seleted = selected;
        //            if (self.selectedBall != nil && selected == YES) {
        //                self.selectedBall(self.dataSource);
        //            }
        //        }
        
    } else {
        
        return;
        
    }
    
    
}

- (void)dealloc{
    NSLog(@"MCBallCollectionViewCell----------------------------------------------------dealloc");
}

@end
