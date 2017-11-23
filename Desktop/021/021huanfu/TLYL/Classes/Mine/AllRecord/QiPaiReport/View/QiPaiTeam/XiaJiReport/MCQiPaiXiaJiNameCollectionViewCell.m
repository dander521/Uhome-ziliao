//
//  MCQiPaiXiaJiNameCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/30.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiXiaJiNameCollectionViewCell.h"

@interface MCQiPaiXiaJiNameCollectionViewCell ()

@property (nonatomic,strong)UILabel *titleLab;

@end


@implementation MCQiPaiXiaJiNameCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}


-(void)initView{
    self.backgroundColor = [UIColor  clearColor];
    
    
    
    _titleLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _titleLab.textColor=RGB(144,8,215);
    _titleLab.font=[UIFont systemFontOfSize:12];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
 
}

-(void)setDataSource:(NSString *)dataSource{
    _dataSource = dataSource;
    _titleLab.text=dataSource;
    
    NSRange range = [dataSource rangeOfString:@">"];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:dataSource];
    
    // 修改富文本中的不同文字的样式
//    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(range.location, range.length-1)];
    
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(46,46,46) range:range];
    _titleLab.attributedText=attri;

}

@end









