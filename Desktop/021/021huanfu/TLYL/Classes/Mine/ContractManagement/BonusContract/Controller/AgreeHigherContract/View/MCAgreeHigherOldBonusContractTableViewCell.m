//
//  MCAgreeHigherOldBonusContractTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCAgreeHigherOldBonusContractTableViewCell.h"
#import "MCAgreeHigherOldBonusContractCellView.h"
@interface MCAgreeHigherOldBonusContractTableViewCell ()

@property (nonatomic,assign)BOOL isCreateUI;
@end

@implementation MCAgreeHigherOldBonusContractTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor=[UIColor whiteColor];
    self.layer.cornerRadius = 6;
    self.clipsToBounds=YES;
    _isCreateUI=NO;
}

-(void)setDataSource:(NSMutableArray<MCMyBonusContractListDeatailDataModel *> *)dataSource{
    _dataSource=dataSource;
    
    CGFloat T = 13 ,H=75,W=G_SCREENWIDTH-60,L = 20;
    int i = 0;
    if (dataSource&&(_isCreateUI==NO)) {
        
        for (MCMyBonusContractListDeatailDataModel * model in dataSource) {
            MCAgreeHigherOldBonusContractCellView * cell = [[MCAgreeHigherOldBonusContractCellView alloc]init];
            cell.frame=CGRectMake(L, T+i*(75+13), W, H);
            [self addSubview:cell];
            cell.dataSouce=model;
            i++;
            _isCreateUI=YES;
        }
    }
    
}

+(CGFloat)computeHeight:(NSMutableArray *)info{
    return 13+(13+75)*info.count;
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andFont:(CGFloat)font  andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment;
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.text = contentStr;
    contentLbl.textAlignment = textAlignment;
    contentLbl.font = [UIFont systemFontOfSize:font];
    contentLbl.textColor=textColor;
    contentLbl.clipsToBounds=YES;
    
    return contentLbl;
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
