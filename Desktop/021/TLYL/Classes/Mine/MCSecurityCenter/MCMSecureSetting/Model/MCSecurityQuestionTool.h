//
//  MCSecurityQuestionTool.h
//  TLYL
//
//  Created by MC on 2017/10/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSecurityQuestionTool : NSObject

@end

@interface MCSecurityQuestionModel : NSObject

@property (nonatomic,strong) NSString * ID;// = 1;
@property (nonatomic,strong) NSString * KeyID;// = 0;
@property (nonatomic,strong) NSString * Question;// = "\U6211\U6700\U7231\U542c\U7684\U6b4c\Uff1f";
@property (nonatomic,strong) NSString * Reserve1;// = "<null>";


@end


@interface QuestionBtn : UIButton
@property MCSecurityQuestionModel *model;

@end
