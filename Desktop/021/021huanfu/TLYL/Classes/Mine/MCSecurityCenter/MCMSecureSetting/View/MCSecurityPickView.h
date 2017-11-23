//
//  MCSecurityPickView.h
//  TLYL
//
//  Created by MC on 2017/10/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSecurityQuestionTool.h"

@interface MCSecurityPickView : UIView
/** 问题库 */
@property (nonatomic,strong) NSArray <MCSecurityQuestionModel *>*dataSource;

/** 已经选择过的问题 */
@property (nonatomic,strong) NSArray *hadSelectedQuestionArray;

//快速创建
+(instancetype)pickerView;

//弹出
-(void)show;


@end
























