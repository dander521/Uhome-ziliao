//
//  MCNewActivityTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNewActivityTableViewCell.h"

@interface MCNewActivityTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *point;

@end

@implementation MCNewActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    self.btn.layer.cornerRadius = 3;
    self.btn.clipsToBounds = YES;
    self.point.layer.cornerRadius = 4;
    self.point.clipsToBounds = YES;
}

- (IBAction)btnClick:(UIButton *)sender {
    if (self.btnClick) {
        self.btnClick();
    }
}


@end
