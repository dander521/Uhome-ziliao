//
//  MCPullMenuModel.h
//  TLYLSF
//
//  Created by MC on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPullMenuHeader.h"

@interface MCCZHelperModel : NSObject

@property (nonatomic,strong)NSString *tag;//": "bjklb",
@property (nonatomic,strong)NSString *type;//": "kl8",
@property (nonatomic,strong)NSString *name;//": "北京快乐8",
@property (nonatomic,strong)NSString *logo;//": "images/bjkl8.png"
@property (nonatomic,strong)NSString *WFExplain;
@end

@interface MCPullMenuModel : NSObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *lotteryId;
@property (nonatomic,strong)NSString *logo;
@property (nonatomic,strong)NSString *type;
//{
//    "name": "天利1分彩",
//    "lotteryId": "51",
//    "logo": "images/ffc.png",
//    "type": "ssc"
//}

@end

@interface MC_LC_Model : NSObject
@property (nonatomic,strong) NSArray * ssc;
@property (nonatomic,strong) NSArray * esf;
@property (nonatomic,strong) NSArray * sd;
@property (nonatomic,strong) NSArray * pls;
@property (nonatomic,strong) NSArray * plw;
@property (nonatomic,strong) NSArray * ssl;
@property (nonatomic,strong) NSArray * kl8;
@property (nonatomic,strong) NSArray * pks;
@property (nonatomic,strong) NSArray * k3;
@property (nonatomic,strong) NSArray * tb;
//{
//    "ssc": [
//    "esf": [
//    "sd": [
//    "pls": [
//    "plw": [
//    "ssl": [
//    "kl8": [
//    "pks": [
//    "k3": [
//    "tb": [
//
//}
@end

@interface MC_PCS_Model : NSObject

@property (nonatomic,strong) NSArray *playType;
@property (nonatomic,strong) NSArray *playMethod;

@end

@interface MC_PC_Model : NSObject

@property (nonatomic,strong) MC_PCS_Model * ssc;
@property (nonatomic,strong) MC_PCS_Model * esf;
@property (nonatomic,strong) MC_PCS_Model * sd;
@property (nonatomic,strong) MC_PCS_Model * pls;
@property (nonatomic,strong) MC_PCS_Model * plw;
@property (nonatomic,strong) MC_PCS_Model * ssl;
@property (nonatomic,strong) MC_PCS_Model * kl8;
@property (nonatomic,strong) MC_PCS_Model * pks;
@property (nonatomic,strong) MC_PCS_Model * k3;
@property (nonatomic,strong) MC_PCS_Model * tb;

@end

@interface MC_PlayType_Model : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *typeId;

@end

@interface MC_PlayMethod_Model : NSObject

@property (nonatomic,strong) NSString *typeId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *methodId;

@end

@interface MCPullMenuCollectionCellModel : NSObject

@property (nonatomic,assign) MCPullMenuCellType type;
@property (nonatomic,strong) NSDictionary * dic;
@property (nonatomic,assign) BOOL isSelected;

@end
@interface MCMenuDataModel : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * typeId;
@property (nonatomic,strong) NSMutableArray <MCPullMenuCollectionCellModel *> * dataSource;
//"name": "五星",
//"typeId": "0"
@end






















