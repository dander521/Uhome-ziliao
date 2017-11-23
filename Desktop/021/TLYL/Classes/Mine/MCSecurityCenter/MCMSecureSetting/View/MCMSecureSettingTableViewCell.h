//
//  MCMSecureSettingTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSecurityQuestionTool.h"

typedef void(^MCMSecureSettingFinishBlock)();
typedef void(^MCMSecureSettingResetBlock)();
@interface MCMSecureSettingTableViewCell : UITableViewCell

@property (nonatomic,strong)QuestionBtn * question1Btn;
@property (nonatomic,strong)QuestionBtn * question2Btn;
@property (nonatomic,strong)UITextField * answer1Tf;
@property (nonatomic,strong)UITextField * answer2Tf;

@property (nonatomic,strong)UIButton * finishBtn;

@property (nonatomic,strong)NSArray <MCSecurityQuestionModel *> * dataSource;

@property (nonatomic,copy)MCMSecureSettingFinishBlock block;
@property (nonatomic,copy)MCMSecureSettingResetBlock ResetBlock ;
+(CGFloat)computeHeight:(id)info;



@end
