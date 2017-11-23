//
//  MCModifyUserImgVCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyUserImgVCollectionViewCell.h"

@interface MCModifyUserImgVCollectionViewCell ()

@property (nonatomic,strong)UIImageView * imgVLogo;

@end

@implementation MCModifyUserImgVCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)setDataSource:(MCUserImgVModel*)dataSource{
    
    _dataSource=dataSource;
    _imgVLogo.image=[UIImage imageNamed:dataSource.HeadPortrait];
    if (dataSource.isSelected) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [RGB(144,8,215) CGColor];
    }else{
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
    
}

-(void)initView{
    
    self.backgroundColor=[UIColor whiteColor];
    self.layer.cornerRadius=3;
    self.clipsToBounds=YES;
    
    _imgVLogo=[[UIImageView alloc]init];
    [self addSubview:_imgVLogo];
    _imgVLogo.backgroundColor=[UIColor clearColor];
    [_imgVLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.top.equalTo(self.mas_top).offset(13);
        make.bottom.equalTo(self.mas_bottom).offset(-13);
    }];
   
    
}

+(CGFloat)computeHeight:(id)info{
    
    CGFloat W = (G_SCREENWIDTH-2)/3.0;
    return W;
}
@end





































