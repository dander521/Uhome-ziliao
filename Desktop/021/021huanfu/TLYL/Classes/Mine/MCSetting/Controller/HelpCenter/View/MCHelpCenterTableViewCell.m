//
//  MCHelpCenterTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCHelpCenterTableViewCell.h"

@implementation MCHelpCenterBtn
@end

@interface MCHelpCenterTableViewCell ()

@property (nonatomic,strong)UIView * backView;

@property (nonatomic,strong)UILabel * title;

@end

@implementation MCHelpCenterTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    _backView=[[UIView alloc]init];
    [self addSubview:_backView];
    _backView.backgroundColor=[UIColor whiteColor];
    _backView.layer.cornerRadius=5;
    _backView.clipsToBounds=YES;
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(G_SCREENWIDTH-20);
        make.top.equalTo(self.mas_top).offset(40);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor=RGB(143,0,210);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(2);
        make.top.equalTo(self.mas_top).offset(14);
        make.height.mas_equalTo(12);
    }];
    
    _title = [[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:12];
    _title.textColor=RGB(46, 46, 46);
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(100);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(40);
    }];
}



-(void)actionCell:(MCHelpCenterBtn *)btn{
    if ([self.delegate respondsToSelector:@selector(cellDidSelectWithType:)]) {
        [self.delegate cellDidSelectWithType:btn.type];
    }
}

-(void)setCellWithMineTitle:(NSString*)minetitle andHaveLine:(BOOL)haveLine  andBsaeBtn:(MCHelpCenterBtn*)btn andIsAppVersion:(BOOL)isAppVersion{
    [btn addTarget:self action:@selector(actionCell:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *maintitleLab= [UILabel new];
    maintitleLab.layer.masksToBounds = YES;
    maintitleLab.textColor=RGB(46, 46, 46);
    maintitleLab.font = [UIFont systemFontOfSize:12];
    maintitleLab.numberOfLines=1;
    maintitleLab.text = minetitle;
    maintitleLab.textAlignment=NSTextAlignmentLeft;
    [btn addSubview:maintitleLab];
    [maintitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn.mas_left).offset(10);
        make.width.mas_equalTo(G_SCREENWIDTH-50);
        make.centerY.equalTo(btn.mas_centerY);
    }];
    
    
    
    if (isAppVersion) {
        UILabel *appVersionLab= [UILabel new];
        appVersionLab.layer.masksToBounds = YES;
        appVersionLab.textColor=RGB(46, 46, 46);
        appVersionLab.font = [UIFont systemFontOfSize:12];
        appVersionLab.numberOfLines=1;
        appVersionLab.textAlignment=NSTextAlignmentRight;
        [btn addSubview:appVersionLab];
        [appVersionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn.mas_right).offset(-10);
            make.width.mas_equalTo(G_SCREENWIDTH-100);
            make.centerY.equalTo(btn.mas_centerY);
        }];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        appVersionLab.text = app_Version;
        
        
    }else{
        UIImageView * arrow=[[UIImageView alloc]init];
        [btn addSubview:arrow];
        arrow.image=[UIImage imageNamed:@"person-icon-more"];
        arrow.userInteractionEnabled=NO;
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn.mas_right).offset(-10);
            make.width.mas_equalTo(9);
            make.height.mas_equalTo(16);
            make.centerY.equalTo(btn.mas_centerY);
        }];
        
        
    }
    
    /*
     * 画线
     */
    if (haveLine==YES) {
        UIView *lineView=[[UIView alloc]init];
        lineView.backgroundColor=RGB(200, 200, 200);
        [btn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(maintitleLab.mas_left).offset(0);
            make.right.equalTo(btn.mas_right).offset(0);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(btn.mas_bottom);
        }];
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setDataSource:(NSArray *)dataSource{
    
    
    _dataSource=dataSource;
    int i=0;
    for (NSString * type in dataSource) {
        
        MCHelpCenterBtn * btn =[[MCHelpCenterBtn alloc]init];
        [self.backView addSubview:btn];
        btn.frame=CGRectMake(0,i*50 , G_SCREENWIDTH-20, 50);
        btn.type=type;
        i++;
        if (i==dataSource.count) {
            
            [self setCellWithMineTitle:type andHaveLine:NO andBsaeBtn:btn andIsAppVersion:NO];
            
        }else{
            [self setCellWithMineTitle:type andHaveLine:YES andBsaeBtn:btn andIsAppVersion:NO];
        }
    }
    if ([dataSource containsObject:@"忘记密码"]) {
        _title.text=@"常见问题";
    }else if ([dataSource containsObject:@"充值不到账"]){
        _title.text=@"充值问题";
    }else if ([dataSource containsObject:@"提款时间"]){
        _title.text=@"提款问题";
    }
}

+(CGFloat)computeHeight:(NSArray *)info{
    return 50*info.count + 40 ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

