//
//  MCTopSelectedCollectionViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/10/30.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTopSelectedCollectionViewCell.h"
@interface MCTopSelectedCollectionViewCell()

@property (nonatomic,weak)UIImageView *imgV;

@end

@implementation MCTopSelectedCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.textColor = RGB(144, 8, 215);
        _firstLabel.font = [UIFont systemFontOfSize:12];
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.numberOfLines = 1;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.font = [UIFont systemFontOfSize:12];
        _secondLabel.text = @" >";
        _secondLabel.textColor = RGB(46, 46, 46);
        [self.contentView addSubview:_firstLabel];
        [self.contentView addSubview:_secondLabel];
  
    }
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];


    __weak typeof(self) weakSelf = self;
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        make.height.equalTo(weakSelf.contentView).priorityLow();
    }];

    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.firstLabel.mas_right);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        make.right.equalTo(weakSelf.contentView).priorityLow();
        make.height.equalTo(weakSelf.contentView).priorityLow();

    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    CGPoint leftLocation = [touch locationInView: self.firstLabel];
//    CGPoint tapLoccation = [touch locationInView: self.imgV];
    if ([self.contentView pointInside:leftLocation withEvent:event])
    {
        [super touchesBegan:touches withEvent:event];
    } else {
       
    }
    
}

@end
