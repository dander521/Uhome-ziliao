
//
//  DatePickerView.m
//  自定义导航
//
//  Created by 可可家里 on 2017/4/8.
//  Copyright © 2017年 可可家里. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, G_SCREENWIDTH, 160)];
    [self addSubview:datePicker];
    [datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    self.datePicker = datePicker;
   

}
- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置当前显示时间
    if (_showDate) {
       [self.datePicker setDate:_showDate animated:YES];
    }else{
        [self.datePicker setDate:[NSDate date] animated:YES];
    }
    [self.datePicker setMaximumDate:self.maxDate];
    [self.datePicker setMinimumDate:self.minDate];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 
    self.datePickerTitle.text =[NSString stringWithFormat:@"%@",self.Datetitle];

    self.datePickerTitle.textColor = [UIColor whiteColor];
}

- (IBAction)clickCancelButtonAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
-(void)setIsRecord:(BOOL)isRecord{
    _isRecord=isRecord;
}
- (IBAction)clickSureButtonAction:(id)sender {
    NSDate *select = self.datePicker.date;
    NSDateFormatter *dateFormmater = [[NSDateFormatter alloc]init];
    if (_isRecord) {
        [dateFormmater setDateFormat:@"yyyy/MM/dd"];
    }else{
      [dateFormmater setDateFormat:@"yyyy/MM/dd"];
    }
    NSString *resultString = [dateFormmater stringFromDate:select];
    if (self.sureBlock) {
        self.sureBlock(resultString);
    }
    
    
}

-(void)setShowDate:(NSDate *)showDate{
    _showDate =  showDate;
    [self.datePicker setDate:showDate animated:YES];
}


@end
