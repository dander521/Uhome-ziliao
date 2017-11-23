//
//  MCValueFormatter.h
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Charts/Charts.h>

@interface MCValueFormatter : NSObject<IChartAxisValueFormatter>  
- (id)initWithDateArr:(NSArray *)arr;
@end
