//
//  MCFindPasswordTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSecurityQuestionTool.h"


typedef void(^MCFindPasswordFinishBlock)();
@interface MCFindPasswordTableViewCell : UITableViewCell

@property (nonatomic,strong)QuestionBtn * question1Btn;
@property (nonatomic,strong)UITextField * answer1Tf;
@property (nonatomic,strong)UITextField * userNameTf;

@property (nonatomic,strong)UIButton * finishBtn;

@property (nonatomic,strong)NSArray <MCSecurityQuestionModel *> * dataSource;

@property (nonatomic,copy)MCFindPasswordFinishBlock block;
+(CGFloat)computeHeight:(id)info;



@end
