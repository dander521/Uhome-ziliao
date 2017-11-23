//
//  MCUserDefinedLotteryCategoriesHeaderView.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedLotteryCategoriesHeaderView.h"
@interface MCUserDefinedLotteryCategoriesHeaderView ()

@property (nonatomic,strong)UILabel * titleLab;

@end

@implementation MCUserDefinedLotteryCategoriesHeaderView
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI{
    
    /*
     * 画线
     */
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=RGB(142, 0, 211);
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(13);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(136,136,136);
    _titleLab.font=[UIFont systemFontOfSize:12];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_titleLab];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(lineView.mas_left).offset(5);
        make.height.mas_equalTo(20);
        
    }];
    
    
    
}

+(CGFloat)computeHeight:(id)info{
    return 30;
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    _titleLab.text = dataSource;
}

    

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
