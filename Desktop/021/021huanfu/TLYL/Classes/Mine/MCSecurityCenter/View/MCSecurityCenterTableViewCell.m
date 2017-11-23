//
//  MCSecurityCenterTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSecurityCenterTableViewCell.h"

@interface MCSecurityCenterTableViewCell ()
@property (nonatomic,strong)UIImageView * logoImgV;
@property (nonatomic,strong)UILabel     * titleLab;
@property (nonatomic,strong)UILabel     * tipLab;

@end

@implementation MCSecurityCenterTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    
    _logoImgV=[[UIImageView alloc]init];
    [self addSubview:_logoImgV];
    
    [_logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(20);
        
    }];
    
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(102, 102, 102);
    _titleLab.font=[UIFont systemFontOfSize:16];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(_logoImgV.mas_right).offset(10);
    }];
    
    UIView *line=[[UIView alloc]init];
    [self addSubview:line];
    line.backgroundColor=RGB(239, 246, 252);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    /*
     * 箭头
     */
    UIImageView *arrow=[[UIImageView alloc]init];
    [self addSubview:arrow];
    arrow.image=[UIImage imageNamed:@"MC_right_arrow"];
    /*
     * 箭头
     */
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(21*0.5);
        make.width.mas_equalTo(12*0.5);
    }];
    
    _tipLab=[[UILabel alloc]init];
    [self addSubview:_tipLab];
    _tipLab.textColor=[UIColor grayColor];
    _tipLab.font=[UIFont systemFontOfSize:15];
    _tipLab.text =@"";
    _tipLab.textAlignment=NSTextAlignmentLeft;
    [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(arrow.mas_left).offset(0);
    }];
    
    
}


-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    NSDictionary * dic_logo=@{@"密码设置":@"security_Password_setup",@"密保设置":@"security_sur_setup"};
    _titleLab.text=dataSource;
    _logoImgV.image=[UIImage imageNamed:dic_logo[dataSource]];
    

}
+(CGFloat)computeHeight:(id)info{
    return 50;
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
