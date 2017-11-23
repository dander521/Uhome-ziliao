//
//  MCUserDefinedLotteryCategoriesModel.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedLotteryCategoriesModel.h"
#import "MCUserDefinedAPIModel.h"

@implementation MCUserDefinedLotteryCategoriesModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

+(MCUserDefinedLotteryCategoriesModel *)GetMCUserDefinedLotteryCategoriesModelWithCZID:(NSString *)CZID{
    NSArray *saleCZIDArry= [MCUserDefinedAPIModel getSaleCZIDArry];
    for (MCUserDefinedLotteryCategoriesModel * model in saleCZIDArry) {
        if ([model.LotteryID isEqualToString:CZID]) {
            return model;
        }
    }
    return nil;
}
@end
