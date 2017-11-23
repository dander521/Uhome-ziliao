//
//  MCPayListHeaderView.h
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCPayListHeaderView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,assign) int dataSource;

-(void)setYuE:(NSString *)yuE;

@property (nonatomic,strong)NSString * IssueNumber;

@property (nonatomic,strong)void (^timeISZeroBlock)();

-(void)stopTimer;

//期号
@property (nonatomic,strong)UILabel * issueNumberLab;
//时间
@property (nonatomic,strong)UILabel * titleLabel;



@end

