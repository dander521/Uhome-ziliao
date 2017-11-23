//
//  MCFavorableActivityTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCFavorableActivityTableViewCell.h"
@interface MCFavorableActivityTableViewCell ()
/*
 * 打底背景
 */
@property(nonatomic,strong)UIView * backView;
/*
 * 活动图片
 */
@property(nonatomic,strong)UIImageView * activityImgV;
/*
 * 活动标题
 */
@property(nonatomic,strong)UILabel * titleLab;
/*
 * 点击进入>>
 */
@property(nonatomic,strong)UIButton * pushBtn;

@end

@implementation MCFavorableActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor whiteColor];
    /*
     * 打底背景
     */
    _backView=[[UIView alloc]init];
    _backView.layer.cornerRadius=1;
    _backView.clipsToBounds=YES;
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor = [[UIColor grayColor] CGColor];
    _backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_backView];
    
    
    /*
     * 活动图片
     */
    _activityImgV=[[UIImageView alloc]init];
    _activityImgV.backgroundColor=[UIColor cyanColor];
    [self addSubview:_activityImgV];
    
    /*
     * 活动标题
     */
    _titleLab=[[UILabel alloc]init];
    _titleLab.text=@"加载中...";
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.textColor=[UIColor grayColor];
    [self addSubview:_titleLab];
    
    /*
     * 点击进入>>
     */
    _pushBtn=[[UIButton alloc]init];
    [self addSubview:_pushBtn];
    [_pushBtn setTitle:@"点击进入>>" forState:UIControlStateNormal];
    _pushBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_pushBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _pushBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [self layOutConstraints];
    
}

-(void)layOutConstraints{
    /*
     * 打底背景
     */
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    
    /*
     * 活动图片
     */
    [_activityImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(1);
        make.right.equalTo(_backView.mas_right).offset(-1);
        make.left.equalTo(_backView.mas_left).offset(1);
        make.bottom.equalTo(_backView.mas_bottom).offset(-30);
    }];
    
    /*
     * 系统公告标题
     */
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityImgV.mas_bottom).offset(5);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.left.equalTo(_backView.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    /*
     * 点击进入>>
     */
    [_pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(_titleLab.mas_centerY);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.left.equalTo(_backView.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
}


+(CGFloat)computeHeight:(id)info{
    return 200;
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
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
