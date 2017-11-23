//
//  MCGameRecordDetailCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/9/5.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGameRecordDetailCollectionViewCell.h"
@interface MCGameRecordDetailCollectionViewCell ()

@property (nonatomic,strong)UILabel * label;

@end



@implementation MCGameRecordDetailCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touzhu-lskj-dbg"]];
    
    _label = [[UILabel alloc] init];
    [self addSubview:_label];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    _label.textAlignment = NSTextAlignmentCenter;
    
    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}
-(void)setDataSource:(id)dataSource{
    
    _label.text = dataSource;
//    _label.text = self.collectionViewArray[indexPath.row];
    
    
}

@end
