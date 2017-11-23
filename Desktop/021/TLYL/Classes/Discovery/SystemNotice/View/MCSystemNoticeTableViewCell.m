//
//  MCSystemNoticeTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSystemNoticeTableViewCell.h"

@interface MCSystemNoticeTableViewCell ()
/*
 * 系统公告标题
 */
@property (nonatomic,strong)UILabel * titleLab;
/*
 * 系统公告时间
 */
@property (nonatomic,strong)UILabel * timeLab;
/*
 * 分隔线
 */
@property (nonatomic,strong)UIView * lineView;
/*
 * 箭头
 */
@property (nonatomic,strong)UIImageView * arrowImgV;


@end

@implementation MCSystemNoticeTableViewCell

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
     * 系统公告标题
     */
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(102, 102, 102);
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_titleLab];
    
    /*
     * 系统公告时间
     */
    _timeLab =[[UILabel alloc]init];
    _timeLab.textColor=RGB(177, 177, 177);
    _timeLab.font=[UIFont systemFontOfSize:12];
    _timeLab.text =@"加载中";
    _timeLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_timeLab];
    
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
    /*
     * 系统公告标题
     */
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    /*
     * 系统公告时间
     */
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    
    /*
     * 画线
     */
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab.mas_left).offset(0);
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
    return 55;
}

-(void)setDataSource:(MCSystemNoticeListModel *)dataSource{
    
    _dataSource=dataSource;
    
    _titleLab.text=dataSource.NewsTittle;
    _timeLab.text=dataSource.InsertTime;
    
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
