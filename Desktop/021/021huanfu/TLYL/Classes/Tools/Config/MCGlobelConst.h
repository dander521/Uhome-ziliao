//
//  MCGlobelConst.h
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MC_BALLSELECRED_COLOR [UIColor colorWithRed:0 green:130/255.0 blue:210/255.0 alpha:1]
#define MC_BALLNORMAL_COLOR [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1]
#define MC_FILTER_COLOR [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
#define MC_ColorWithAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define MC_SKYBLUE_COLOR RGB(54, 128, 211)
#define MC_SEPAETOR_COLOR RGB(182, 182, 182)
#define  G_SCREENWIDTH  [[UIScreen mainScreen] bounds].size.width
#define  G_SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define RGB(__r, __g, __b)  [UIColor colorWithRed:(1.0*(__r)/255)\
green:(1.0*(__g)/255)\
blue:(1.0*(__b)/255)\
alpha:1.0]
#define MC_REALVALUE(value) ceil((value)/375.0f*[UIScreen mainScreen].bounds.size.width)
#define MerchantMaxRebate   @"MerchantMaxRebate"
#define MerchantMinRebate   @"MerchantMinRebate"
#define MerchantMode        @"MerchantMode"
#define MerchantXRebate     @"MerchantXRebate"
#define McSelectedBetRebate  @"MCSELECTED_BETREBEATE"
#define MCActionYuanJiaoFen  @"MCAction_YuanJiaoFen"
#define MCActionMultiple     @"MCAction_Multiple"
#define MCRefreshMineDataUI     @"MCRefreshMineDataUI"
#define SEVERBASEURL     @"http://192.168.1.51:8080/"
@interface MCGlobelConst : NSObject

@end
