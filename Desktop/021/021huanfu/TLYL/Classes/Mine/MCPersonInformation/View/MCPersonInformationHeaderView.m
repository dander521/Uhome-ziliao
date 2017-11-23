//
//  MCPersonInformationHeaderView.m
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPersonInformationHeaderView.h"
@interface MCPersonInformationHeaderView ()

@end

@implementation MCPersonInformationHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=RGB(236, 236, 236);
        
    UILabel * Lab = [[UILabel alloc]init];
    Lab.backgroundColor = [UIColor clearColor];
    Lab.font = [UIFont systemFontOfSize:12];
    Lab.numberOfLines=1;
    Lab.textColor=RGB(125, 125, 125);
    Lab.text = @"个人资料完善后无法修改，如需修改，请联系客服";
    Lab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:Lab];
    [Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(25);
    }];
  
}



-(void)setDataSource:(MCMineInfoModel *)dataSource{
    _dataSource=dataSource;

}

+(CGFloat)computeHeight:(id)info{
    
    return 25;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
