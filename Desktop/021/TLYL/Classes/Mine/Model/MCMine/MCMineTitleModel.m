//
//  MCMineTitleModel.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineTitleModel.h"

@implementation MCMineTitleModel

+(MCMineTitleModel*)getModelWithMainTitle:(NSString *)maintitle andSubTitle:(NSArray *)arr_subtitle{
    MCMineTitleModel * model=[[MCMineTitleModel alloc]init];
    model.maintitle=maintitle;
    model.arr_subtitle=arr_subtitle;
    return model;
}
@end
