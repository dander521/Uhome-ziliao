//
//  MCSendPersonCollectionViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSendPersonCollectionViewCell.h"

@interface MCSendPersonCollectionViewCell()

@end

@implementation MCSendPersonCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.textColor = RGB(46, 46, 46);
        _firstLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
        [self.contentView addSubview:_firstLabel];

        [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            
        }];
    }
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    


}



@end
