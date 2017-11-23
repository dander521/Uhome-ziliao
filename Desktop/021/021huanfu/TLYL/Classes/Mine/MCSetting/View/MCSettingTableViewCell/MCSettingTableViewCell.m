//
//  MCSettingTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSettingTableViewCell.h"
#import "MCGetSecurityStateModel.h"

@implementation MCSettingBtn
@end

@interface MCSettingTableViewCell ()

@property (nonatomic,strong)UIView * backView;

@end

@implementation MCSettingTableViewCell
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
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];

    
}



-(void)actionCell:(MCSettingBtn *)btn{
    if ([self.delegate respondsToSelector:@selector(cellDidSelectWithType:)]) {
        [self.delegate cellDidSelectWithType:btn.type];
    }
}

-(void)setCellWithMineTitle:(NSString*)minetitle andHaveLine:(BOOL)haveLine  andBsaeBtn:(MCSettingBtn*)btn andIsAppVersion:(BOOL)isAppVersion{
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
        
        if ([minetitle isEqualToString:@"安全问题"]) {
            _anqunWenTiLab= [UILabel new];
            _anqunWenTiLab.layer.masksToBounds = YES;
            _anqunWenTiLab.textColor=RGB(46, 46, 46);
            _anqunWenTiLab.font = [UIFont systemFontOfSize:12];
            _anqunWenTiLab.numberOfLines=1;
            MCGetSecurityStateModel * getSecurityStateModel = [MCGetSecurityStateModel sharedMCGetSecurityStateModel];
            if ([getSecurityStateModel.hadSecurityState integerValue]==1) {
                _anqunWenTiLab.text = @"(已设置)";
            }else{
                _anqunWenTiLab.text = @"";
            }
            _anqunWenTiLab.textAlignment=NSTextAlignmentLeft;
            [btn addSubview:_anqunWenTiLab];
            [_anqunWenTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(50);
                make.centerY.equalTo(btn.mas_centerY);
                make.right.equalTo(btn.mas_right).offset(-20);
                make.height.mas_equalTo(20);
            }];
            
            
        }
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
        
        MCSettingBtn * btn =[[MCSettingBtn alloc]init];
        [self.backView addSubview:btn];
        btn.frame=CGRectMake(0,i*50 , G_SCREENWIDTH-20, 50);
        btn.type=type;
        i++;
        if (i==dataSource.count) {
            if ([type isEqualToString:@"版本更新"]) {
                [self setCellWithMineTitle:type andHaveLine:NO andBsaeBtn:btn andIsAppVersion:YES];
            }else{
                [self setCellWithMineTitle:type andHaveLine:NO andBsaeBtn:btn andIsAppVersion:NO];
            }

        }else{
             [self setCellWithMineTitle:type andHaveLine:YES andBsaeBtn:btn andIsAppVersion:NO];
        }
    }
}

+(CGFloat)computeHeight:(NSArray *)info{
    return 50*info.count ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
