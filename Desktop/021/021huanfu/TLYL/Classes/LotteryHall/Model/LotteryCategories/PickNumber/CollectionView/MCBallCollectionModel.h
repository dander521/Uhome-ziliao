//
//  MCBallCollectionModel.h
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCBallCollectionModel : NSObject
/**号码球是否被选中*/
@property (nonatomic,assign,getter=isSeleted) BOOL seleted;
/**号码球是内容文字*/
@property (nonatomic,strong) NSString *textInfo;
/**号码球号码*/
@property (nonatomic,strong) NSString *number;
/**号码球筛选条件是否被选中*/
@property (nonatomic,assign) BOOL filterSelectd;
/**号码球互斥规则*/
@property (nonatomic,strong) NSString *mutex;

@end
