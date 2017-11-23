//
//  MCFilterCollectionViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCFilterCollectionViewCell.h"
#import "UIImage+Extension.h"

@interface MCFilterCollectionViewCell()



@end
@implementation MCfilterBallModel
@end

@implementation MCFilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = MC_REALVALUE(12.5);
    self.clipsToBounds = YES;
//    self.backgroundColor = RGB(255, 168, 0);
    [self.iconBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    //    [self.iconBtn setTitleColor:RGB(192, 71, 255) forState:UIControlStateNormal];
    [self.iconBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.iconBtn.layer.cornerRadius = MC_REALVALUE(12.5);
    self.iconBtn.clipsToBounds = YES;
    self.iconBtn.userInteractionEnabled = NO;
    self.iconBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [self.iconBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [self.iconBtn setBackgroundImage:[UIImage createImageWithColor:RGB(236, 170, 44)] forState:UIControlStateSelected];
    
    //    UIImage *selectedImg = [UIImage createImageWithColor:MC_BALLSELECRED_COLOR];
    //    [self.iconBtn setBackgroundImage:[selectedImg drawRectWithRoundedCorner:self.widht * 0.5 size:self.bounds.size] forState:UIControlStateSelected];
    //    UIImage *normalImg = [UIImage createImageWithColor:[UIColor clearColor]];
    //    [self.iconBtn setBackgroundImage:[normalImg drawRectWithRoundedCorner:self.widht size:self.bounds.size] forState:UIControlStateNormal];
    
}

- (void)setDataSource:(MCfilterBallModel *)dataSource{
    _dataSource = dataSource;
    [self.iconBtn setTitle:self.dataSource.info forState:UIControlStateNormal];
    
//    [self.iconBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
//    [self.];
}



- (void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    self.iconBtn.selected = selected;
    self.dataSource.selected = selected;
}

- (void)dealloc{
    
    NSLog(@"MCFilterCollectionViewCell----dealloc");
}
@end
