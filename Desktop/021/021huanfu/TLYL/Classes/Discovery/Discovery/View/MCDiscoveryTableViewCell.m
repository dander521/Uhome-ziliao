//
//  MCDiscoveryTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCDiscoveryTableViewCell.h"

@interface MCDiscoveryTableViewCell ()
/*
 * logo
 */
@property (nonatomic,strong)UIImageView * logoImgV;

/*
 * 系统公告、优惠活动标题
 */
@property (nonatomic,strong)UILabel * titleLab;
/*
 * 描述
 */
@property (nonatomic,strong)UILabel * tipLab;
/*
 * 分隔线
 */
@property (nonatomic,strong)UIView * lineView;
/*
 * 箭头
 */
@property (nonatomic,strong)UIImageView * arrowImgV;


@end

@implementation MCDiscoveryTableViewCell

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
     * logo
     */
    _logoImgV=[[UIImageView alloc]init];
    [self addSubview:_logoImgV];
    
    
    
    /*
     * 系统公告、优惠活动标题
     */
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(68, 68, 68);
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_titleLab];
    
    /*
     * 描述
     */
    _tipLab =[[UILabel alloc]init];
    _tipLab.textColor=RGB(102, 102, 102);
    _tipLab.font=[UIFont systemFontOfSize:12];
    _tipLab.text =@"加载中";
    [_tipLab sizeToFit];
    _tipLab.numberOfLines = 0;
    _tipLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_tipLab];
    
    /*
     * 画线
     */
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=RGB(239, 246, 253);
    [self addSubview:_lineView];
    
    /*
     * 箭头
     */
    _arrowImgV=[[UIImageView alloc]init];
    [self addSubview:_arrowImgV];
    _arrowImgV.image=[UIImage imageNamed:@"矩形-11-拷贝-3"];
    
    
    [self layOutConstraints];
    
    
}

-(void)layOutConstraints{
    
    [_logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(35);
        
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(_logoImgV.mas_right).offset(10);
        make.height.mas_equalTo(17);
    }];
    
    [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(_logoImgV.mas_right).offset(10);
    }];
    
    /*
     * 画线
     */
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(0.8);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    /*
     * 箭头
     */
    [_arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(21*0.5);
        make.width.mas_equalTo(12*0.5);
    }];
    
    
}




+(CGFloat)computeHeight:(id)info{
 
    return 75;
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    _titleLab.text =dataSource;
    if ([dataSource isEqualToString:@"系统公告"]) {
        _tipLab.text =@"最新平台咨询都在这里";
        _logoImgV.image=[UIImage imageNamed:@"find-icon-notice"];
    }else{
        _tipLab.text =@"活动精彩好玩，优惠多多";
        _logoImgV.image=[UIImage imageNamed:@"find-icon-activity"];
    }
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


















