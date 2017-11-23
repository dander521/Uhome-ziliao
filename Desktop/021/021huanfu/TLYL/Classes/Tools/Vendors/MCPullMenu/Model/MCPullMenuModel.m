//
//  MCPullMenuModel.m
//  TLYLSF
//
//  Created by MC on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCPullMenuModel.h"
@implementation MCCZHelperModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
@end

@implementation MCPullMenuModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
@end


@implementation MC_LC_Model
+(NSDictionary *)objectClassInArray{
    
    return @{
             @"ssc" : [MCPullMenuModel class],
             @"esf" :[MCPullMenuModel class],
             @"sd" : [MCPullMenuModel class],
             @"pls" :[MCPullMenuModel class],
             @"plw" : [MCPullMenuModel class],
             @"ssl" :[MCPullMenuModel class],
             @"kl8" : [MCPullMenuModel class],
             @"pks" :[MCPullMenuModel class],
             @"k3" : [MCPullMenuModel class],
             @"tb" :[MCPullMenuModel class]
             };
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
@end

@implementation MC_PCS_Model
+(NSDictionary *)objectClassInArray{
    
    return @{
             @"playType" : [MC_PlayType_Model class],
             @"playMethod" :[MC_PlayMethod_Model class]
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
@end

@implementation MC_PC_Model
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

@end

@implementation MC_PlayType_Model
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

@end

@implementation MC_PlayMethod_Model
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
@end
@implementation MCPullMenuCollectionCellModel
@end
@implementation MCMenuDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
@end







































