//
//  MCMineTitleModel.h
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMineTitleModel : NSObject

@property (nonatomic,strong)NSString * maintitle;

@property (nonatomic,strong)NSArray * arr_subtitle;

+(MCMineTitleModel*)getModelWithMainTitle:(NSString *)maintitle andSubTitle:(NSArray *)arr_subtitle;

@end
