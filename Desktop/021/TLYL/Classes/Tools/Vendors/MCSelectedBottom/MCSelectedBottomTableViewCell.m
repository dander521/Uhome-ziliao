//
//  MCSelectedBottomTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/7/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSelectedBottomTableViewCell.h"
@interface MCSelectedBottomTableViewCell ()

@property (nonatomic,strong)UILabel * lab_text;

@end

@implementation MCSelectedBottomTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor = RGB(213, 220, 227);
 
    _lab_text =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_text.textColor=RGB(68, 68, 68);
    _lab_text.font=[UIFont systemFontOfSize:16];
    _lab_text.text =@"加载中...";
    _lab_text.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_lab_text];

    
    [_lab_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    
}




-(void)setDataSource:(id)dataSource{
    
    _dataSource=dataSource;
    _lab_text.text = dataSource;

}

+(CGFloat)computeHeight:(id)info{
    
    return 36;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
