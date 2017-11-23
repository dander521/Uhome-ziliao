//
//  DatePickerView.h
//  自定义导航
//
//  Created by 可可家里 on 2017/4/8.
//  Copyright © 2017年 可可家里. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelButtonBlock)();
typedef void(^sureButtonBlock)(NSString * selectDateStr);
@interface DatePickerView : UIView
@property (strong, nonatomic)  UIDatePicker *datePicker;
@property (nonatomic,strong) cancelButtonBlock cancelBlock;
@property (nonatomic,strong) sureButtonBlock sureBlock;
@property (weak, nonatomic) IBOutlet UILabel *datePickerTitle;
@property (nonatomic,strong) NSString*Datetitle;
@property (nonatomic,strong) NSDate *minDate;
@property (nonatomic,strong) NSDate *maxDate;
//如果是记录   时间格式用2017/02/18
@property (nonatomic,assign) BOOL isRecord;

@property (nonatomic,strong) NSDate * showDate;

@end
