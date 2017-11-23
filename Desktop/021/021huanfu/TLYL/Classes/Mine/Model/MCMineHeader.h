//
//  MCMineHeader.h
//  TLYL
//
//  Created by MC on 2017/7/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#ifndef MCMineHeader_h
#define MCMineHeader_h

#define singleton_h(name) + (instancetype)shared##name;

#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init];\
});\
return _instance; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}


#endif /* MCMineHeader_h */
