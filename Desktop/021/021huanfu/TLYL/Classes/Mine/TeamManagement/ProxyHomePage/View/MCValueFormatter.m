//
//  MCValueFormatter.m
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCValueFormatter.h"
#import <Charts/Charts.h>

@implementation MCValueFormatter{
    NSArray *_dateArr;
    NSDateFormatter *_preFormatter;
    NSDateFormatter *_needFormatter;
}
- (id)initWithDateArr:(NSArray *)arr {
    if (self = [super init]) {
        _dateArr = [NSArray arrayWithArray:arr];
        
        _preFormatter = [[NSDateFormatter alloc] init];
        _preFormatter.dateFormat = @"yyyy/MM/dd";
        
        
        _needFormatter = [[NSDateFormatter alloc] init];
        _needFormatter.dateFormat = @"yyyy/MM/dd";
    }
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    if (_dateArr.count > 0) {
        if (value < _dateArr.count) {
            NSString *dateStr = _dateArr[(int)value];
            NSDate *date = [_preFormatter dateFromString:dateStr];
            return [_needFormatter stringFromDate:date];
        }
     
    }
    return nil;
}
@end
