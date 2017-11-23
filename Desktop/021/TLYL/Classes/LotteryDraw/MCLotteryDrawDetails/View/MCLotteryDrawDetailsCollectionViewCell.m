//
//  MCLotteryDrawDetailsCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryDrawDetailsCollectionViewCell.h"

@interface MCLotteryDrawDetailsCollectionViewCell ()

@property (nonatomic,strong)UIImageView *logoImgV;

@property (nonatomic,strong)UILabel *titleLab;

@end


@implementation MCLotteryDrawDetailsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}
    
-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    _titleLab.text =dataSource;
}

-(void)initView{
    self.backgroundColor = [UIColor  clearColor];
    
    _logoImgV=[[UIImageView alloc]init];
    _logoImgV.backgroundColor=RGB(255, 168, 0);
    _logoImgV.layer.cornerRadius=self.bounds.size.width/2.0;
    _logoImgV.clipsToBounds=YES;

//    _logoImgV.image=[UIImage imageNamed:@"lottery-number-bgbick-"];
    [self addSubview:_logoImgV];

    [_logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    _titleLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _titleLab.alpha=0.8;
    _titleLab.textColor=[UIColor whiteColor];
    _titleLab.font=[UIFont boldSystemFontOfSize:12];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    
}

+(CGFloat)computeHeight:(id)info{
    return 27;
}


@end
