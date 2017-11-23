//
//  MCChartView.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCChartView.h"
#import <Charts/Charts.h>
#import "MCChartModel.h"
#import "MCValueFormatter.h"

@interface MCChartView()<ChartViewDelegate,IChartAxisValueFormatter,IChartValueFormatter>
//折线图
@property (nonatomic,weak) LineChartView *lineView;
//柱状图
@property (nonatomic,weak) BarChartView *barChartView;
//按钮点击状态
@property (nonatomic,weak) UIButton *lastBtn;
//单位
@property (nonatomic,weak) UILabel *unitLabel;
@property (nonatomic,weak) UILabel *noDataLabel;

@property (nonatomic,weak) UIView *btnView;
@property (nonatomic,assign) bool isLineChartView;
@end

@implementation MCChartView
#pragma mark - 生命循环
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    self.isLineChartView = YES;
    //"团队充值",@"团队提款",@"团队投注",@"注册人数",@"投注人数",@"登录人数" 按钮
    self.backgroundColor = RGB(144, 8, 215);
    NSArray *titleArr = @[@"团队充值",@"团队提款",@"团队投注",@"注册人数",@"投注人数",@"登录人数"];
    UIView *btnView = [[UIView alloc] init];
    [self addSubview:btnView];
    btnView.backgroundColor = RGB(144, 8, 215);
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MC_REALVALUE(20));
        make.top.equalTo(self).offset(MC_REALVALUE(29));
        make.height.equalTo(@(MC_REALVALUE(30)));
        make.width.equalTo(@(MC_REALVALUE(174)));
    }];
    
    for (NSInteger i = 0; i<titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btnView addSubview:btn];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(198, 120, 238) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
        if (i==0) {
            btn.selected = YES;
            self.lastBtn = btn;
        }
        if (i<=2) {
            btn.frame = CGRectMake(i*MC_REALVALUE(27) + i*MC_REALVALUE(45), 0, MC_REALVALUE(45), MC_REALVALUE(10));
        }else{
           btn.frame = CGRectMake((i -3)*MC_REALVALUE(27) + (i-3)*MC_REALVALUE(45), MC_REALVALUE(20), MC_REALVALUE(45), MC_REALVALUE(10));
        }
        btn.tag = i;
        [btn addTarget: self action:@selector(btnCLick:) forControlEvents:UIControlEventTouchDown];
        
    }
    // 曲线 柱状 下载 按钮
    NSArray *arr = @[@"dlgl-down",@"dlgl-szt",@"dlgl-zx"];
    for (NSInteger i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        if (i==0) {
            btn.selected = YES;
        }
            btn.frame = CGRectMake(G_SCREENWIDTH - MC_REALVALUE(66) - (i)*MC_REALVALUE(32), MC_REALVALUE(36), MC_REALVALUE(16), MC_REALVALUE(16));
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        [btn addTarget: self action:@selector(btnClickChange:) forControlEvents:UIControlEventTouchDown];
    }
    self.btnView = btnView;
    [self setUpCharts:btnView];
    [self setUpClumnView:btnView];
    self.barChartView.hidden = YES;

}
#pragma mark -- 切换dataType
- (void)btnCLick:(UIButton *)btn{

    self.lastBtn.selected = NO;
    btn.selected = !btn.selected;
    self.lastBtn = btn;
    self.unitLabel.hidden = YES;
    if (btn.tag<3) {
        self.unitLabel.text = @"单位：元";
        self.unitLabel.hidden = NO;
    } else {
        self.unitLabel.text = @"单位：人";
        self.unitLabel.hidden = NO;
    }
    if (self.dateTypeBtnBlock) {
        self.dateTypeBtnBlock(btn.tag);
    }
    
}

#pragma mark -- 切换图形
- (void)btnClickChange:(UIButton *)btn{

    if (btn.tag == 2) {// 折线
        self.isLineChartView = YES;
        self.barChartView.hidden = YES;
        self.lineView.hidden = NO;
    } else if (btn.tag == 1) {// 柱形图
        self.isLineChartView = NO;
        self.barChartView.hidden = NO;
        self.lineView.hidden = YES;
    }else if (btn.tag == 0) {
        [self saveImageToPhotos:[self captureCurrentView:self]];
    }
    if (self.chartTypeBtnBlock) {
        self.chartTypeBtnBlock(btn.tag);
    }
    
}

#pragma mark ---折线图
- (void)setUpCharts:(UIView *)btnView{
    LineChartView *lineView = [[LineChartView alloc] init];
    self.lineView = lineView;
    if (![self.subviews containsObject:self.lineView]) {
        [self addSubview:self.lineView];
    }
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(btnView).offset(MC_REALVALUE(64));
    }];
    
    lineView.delegate = self;//设置代理
    lineView.backgroundColor =  RGB(144, 8, 215);
    lineView.drawGridBackgroundEnabled = NO;
    lineView.rightAxis.enabled = NO;//不显示y-r
    lineView.xAxis.drawGridLinesEnabled = NO;//不显示格栅x
    lineView.xAxis.gridLineCap = kCGLineCapButt;
    lineView.xAxis.labelPosition = XAxisLabelPositionBottom;
    lineView.xAxis.axisLineColor = RGB(204, 105, 255);
    lineView.xAxis.labelTextColor = [UIColor whiteColor];
    lineView.leftAxis.drawGridLinesEnabled = NO;
    lineView.rightAxis.drawGridLinesEnabled = NO;
    lineView.leftAxis.axisLineColor = RGB(204, 105, 255);
    lineView.leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    lineView.leftAxis.labelCount = 5;
    lineView.leftAxis.drawTopYLabelEntryEnabled = YES;
    lineView.leftAxis.drawBottomYLabelEntryEnabled = YES;
    lineView.leftAxis.labelTextColor = [UIColor whiteColor];
    lineView.leftAxis.labelFont = [UIFont systemFontOfSize:MC_REALVALUE(8)];
    lineView.gridBackgroundColor = [UIColor clearColor];
    lineView.leftAxis.drawZeroLineEnabled = YES;
    lineView.noDataText = @"暂无数据";
    lineView.noDataTextColor = [UIColor whiteColor];
    lineView.chartDescription.enabled = NO;
    lineView.scaleYEnabled = NO;//取消Y轴缩放
    lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
    lineView.dragEnabled = YES;//启用拖拽图标
    lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    //描述及图例样式
    [lineView setDescriptionText:@""];
    lineView.legend.enabled = NO;
    [lineView animateWithXAxisDuration:1.0f];
    lineView.leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    lineView.xAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    self.lineView.xAxis.labelCount = 4;
    self.lineView.leftAxis.valueFormatter = self;
    
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.hidden = YES;
    self.unitLabel = unitLabel;
    self.unitLabel.text = @"单位：元";
    unitLabel.textColor = [UIColor whiteColor];
    unitLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(8)];
    if (![self.subviews containsObject:self.unitLabel]) {
        [self addSubview:self.unitLabel];
    }
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(btnView.mas_bottom).offset(MC_REALVALUE(25));
    }];
    
    
    UILabel *noDataLabel = [[UILabel alloc] init];
    noDataLabel.hidden = YES;
    self.noDataLabel = noDataLabel;
    self.noDataLabel.text = @"暂无数据";
    noDataLabel.textColor = [UIColor whiteColor];
    noDataLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    if (![self.subviews containsObject:self.noDataLabel]) {
        [self addSubview:self.noDataLabel];
    }
    [noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(MC_REALVALUE(15));
    }];
}
#pragma mark ---折线图数据
- (void)dataSourceChuLI:(NSArray *)arrX arrY:(NSArray <NSNumber *>*)arrY{
    
    if (arrX.count > 0) {
    self.lineView.xAxis.axisMaxValue = (double)arrX.count - 1 + 0.3;
        }
    self.lineView.xAxis.valueFormatter = [[MCValueFormatter alloc] initWithDateArr: arrX];
    NSArray *colors = @[[UIColor whiteColor]]; // 折线颜色数组
    NSMutableArray *dataSets = [[NSMutableArray alloc] init]; //数据集数组
    NSArray *legendTitles = @[@""];//图例
    NSArray *statistics = @[arrY];
    // 这样写的好处是, 无论你传多少条数据, 都可以处理展示
    for (int i = 0; i < statistics.count; i++) {
        // 循环创建数据集
        LineChartDataSet *set = [self drawLineWithArr:statistics[i]  title:legendTitles[i] color:colors[i]];
        if (set) {
            [dataSets addObject:set];
        }
    }
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    self.lineView.data = data;
    

}
#pragma mark - 根据数据数组 title color 创建折线set
- (LineChartDataSet *)drawLineWithArr:(NSArray *)arr title:(NSString *)title color:(UIColor *)color {
    if (arr.count == 0) {
        return nil;
    }
    // 处理折线数据
    NSMutableArray *statistics = [NSMutableArray array];
    double leftAxisMin = 0;
    double leftAxisMax = 0;
    for (int i = 0; i < arr.count; i++) {
        NSNumber *num = arr[i];
        double value = [num doubleValue];
        leftAxisMax = MAX(value, leftAxisMax);
        leftAxisMin = MIN(value, leftAxisMin);
        [statistics addObject:[[ChartDataEntry alloc] initWithX:i y:value]];
    }
    CGFloat topNum = leftAxisMax * (5.0/4.0);
    _lineView.leftAxis.axisMaxValue = topNum;
    _lineView.leftAxis.axisMinValue = leftAxisMin;
    if (leftAxisMin < 0) {
        CGFloat minNum = leftAxisMin * (5.0/4.0);
        _lineView.leftAxis.axisMinValue = minNum ;
    }

    if ((leftAxisMax -leftAxisMin)<=4) {
        _lineView.leftAxis.axisMaxValue = leftAxisMax + 1;
        _lineView.leftAxis.axisMinValue = leftAxisMin;
    }
    // 设置Y轴数据
    _lineView.leftAxis.valueFormatter = self; //需要遵IChartAxisValueFormatter协议
    // 设置折线数据
    LineChartDataSet *set1 = nil;
    set1 = [[LineChartDataSet alloc] initWithValues:statistics label:title];
    set1.mode = LineChartModeLinear;   // 曲线还是折线mode
    [set1 setColor:color];
    [set1 setCircleColor:RGB(229, 180, 255)];
    set1.lineWidth = 1.0;
    set1.circleRadius = 3.5;
    set1.valueColors = @[color];
    set1.drawValuesEnabled = NO;
    set1.valueFormatter = self; //需要遵循IChartValueFormatter协议
    set1.valueFont = [UIFont systemFontOfSize:9.f];
    return set1;
}
#pragma mark - IChartValueFormatter delegate (折线值)
- (NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler {

    return [NSString stringWithFormat:@"%.f", value];
}

#pragma mark - IChartAxisValueFormatter delegate (y轴值) (x轴的值写在DateValueFormatter类里, 都是这个协议方法)

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    if (ABS(value) > 1000) {
        return [NSString stringWithFormat:@"%.1fk", value/(double)1000];
    }
//    if (value == (int)value) {
//  if
//        return [NSString stringWithFormat:@"%.f", value];
//    } else {
        return [NSString stringWithFormat:@"%.1f", value];
//    }
    
}



#pragma mark ---柱子图
- (void)setUpClumnView:(UIView *)btnView{
    BarChartView *barChartView = [[BarChartView alloc] init];
    self.barChartView = barChartView;
    if (![self.subviews containsObject:self.barChartView]) {
        [self addSubview:self.barChartView];
    }
    [self addSubview:barChartView];
    [barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(btnView).offset(MC_REALVALUE(64));
    }];
    
    barChartView.delegate = self;//设置代理
    barChartView.backgroundColor =  RGB(144, 8, 215);
    barChartView.drawGridBackgroundEnabled = NO;
    barChartView.rightAxis.enabled = NO;//不显示y-r
    barChartView.xAxis.drawGridLinesEnabled = NO;//不显示格栅x
    barChartView.xAxis.gridLineCap = kCGLineCapButt;
    barChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    barChartView.xAxis.axisLineColor = RGB(204, 105, 255);
    barChartView.xAxis.labelTextColor = [UIColor whiteColor];
    barChartView.leftAxis.drawGridLinesEnabled = NO;
    barChartView.rightAxis.drawGridLinesEnabled = NO;
    barChartView.leftAxis.drawTopYLabelEntryEnabled = YES;
    barChartView.leftAxis.drawBottomYLabelEntryEnabled = YES;
    barChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    barChartView.leftAxis.axisLineColor = RGB(204, 105, 255);
    barChartView.leftAxis.drawLabelsEnabled = YES;
    barChartView.leftAxis.labelTextColor = [UIColor whiteColor];
    barChartView.leftAxis.labelFont = [UIFont systemFontOfSize:MC_REALVALUE(8)];
    barChartView.gridBackgroundColor = [UIColor clearColor];
    barChartView.noDataText = @"暂无数据";
    barChartView.noDataTextColor = [UIColor whiteColor];
    barChartView.chartDescription.enabled = YES;
    barChartView.scaleYEnabled = NO;//取消Y轴缩放
    barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    barChartView.dragEnabled = YES;//启用拖拽图标
    barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    //描述及图例样式
    [barChartView setDescriptionText:@""];
    barChartView.legend.enabled = NO;
    [barChartView animateWithXAxisDuration:1.0f];
    barChartView.leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    barChartView.xAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    self.barChartView.leftAxis.valueFormatter = self;
    barChartView.leftAxis.drawZeroLineEnabled = YES;
    barChartView.leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    _barChartView.leftAxis.valueFormatter = self;
    barChartView.xAxis.labelCount = 4;
    barChartView.leftAxis.labelCount = 5;
    self.lineView.clearsContextBeforeDrawing = YES;
    self.barChartView.clearsContextBeforeDrawing = YES;
    
}
#pragma mark ---柱子图数据
- (void)setUPCulnmData:(NSArray *)arrX arrY:(NSArray <NSNumber *>*)arrY{
    // 开始设值
    NSMutableArray *yVals = [NSMutableArray array];
    double leftAxisMin = 0;
    double leftAxisMax = 0;
    for (int i = 0; i < arrY.count; i++) {
        NSNumber *num = arrY[i];
        double value = [num doubleValue];
        leftAxisMax = MAX(value, leftAxisMax);
        leftAxisMin = MIN(value, leftAxisMin);
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:value]];
    }
    CGFloat topNum = leftAxisMax * (5.0/4.0);
    _barChartView.leftAxis.axisMaxValue = topNum;
    _barChartView.leftAxis.axisMinValue = leftAxisMin;
    // 设置Y轴数据
    if (leftAxisMin < 0) {
        CGFloat minNum = leftAxisMin * (5.0/4.0);
        _barChartView.leftAxis.axisMinValue = minNum ;
    }
    
    if ((leftAxisMax -leftAxisMin)<=4) {
        _barChartView.leftAxis.axisMaxValue = leftAxisMax + 1;
        _barChartView.leftAxis.axisMinValue = leftAxisMin;
    }
   
    // 设置柱形数值
    BarChartDataSet *set1 = nil;
    set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
    set1.valueFormatter = self;
    set1.highlightEnabled = NO;
    set1.drawValuesEnabled = NO;
    [set1 setColors:@[RGB(229, 180, 215)]];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    data.barWidth = 1;
    _barChartView.xAxis.axisMaxValue = arrX.count - 1 + 0.8;
    _barChartView.data = data;
     self.barChartView.xAxis.valueFormatter = [[MCValueFormatter alloc] initWithDateArr:arrX];
     self.barChartView.data = data;
    
}


- (BOOL)bissextile:(int)year {
    
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
#pragma mark 处理数据
- (NSArray *)dealWithDateDataModel:(NSArray *)dataSource{
    if (dataSource.count <=1) {return dataSource;}
    MCChartModel *model1 = dataSource.firstObject;
    MCChartModel *model2 = dataSource.lastObject;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate:[NSDate date]];
    NSDate *dateTemps = [dataFormatter dateFromString:model1.DateTime];
    NSDate *dateTempe = [dataFormatter dateFromString:model2.DateTime];
    NSDate *localDates = [NSDate dateWithTimeInterval:seconds sinceDate:dateTemps];
    NSDate *localDatee = [NSDate dateWithTimeInterval:seconds sinceDate:dateTempe];
    NSTimeInterval time = [localDatee timeIntervalSinceDate:localDates];
    CGFloat day = time/24/3600;
    if (day<=1) {return dataSource;}
    NSMutableArray *arr = [NSMutableArray array];
    if (dataSource.count < day) {
        for (NSInteger i = 0; i<=day; i++) {
            bool isAdd = YES;
            NSDate *dateNeedAdd = [dateTemps dateByAddingTimeInterval:24*3600*i];
            NSString *dateStrAdd = [dataFormatter stringFromDate:dateNeedAdd];
            for (MCChartModel *modelT in dataSource) {
                if ([modelT.DateTime isEqualToString:dateStrAdd]) {
                    if (![arr containsObject:modelT]) {
                        isAdd = NO;
                        [arr addObject:modelT];
                        break;
                    }
                }
            }
            if (isAdd == NO) {
            } else {
                MCChartModel *model = [[MCChartModel alloc] init];
                model.DateTime = dateStrAdd;
                model.Num = @"0.0000";
                if (![arr containsObject:model]) {
                    [arr addObject:model];
                }
            }
      
        }
    }
    return arr;
}
#pragma mark ---截屏
- (UIImage *)captureCurrentView:(UIView *)view {
    CGRect frame = view.frame;
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:contextRef];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark ---保存图片
- (void)saveImageToPhotos:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

-  (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        [SVProgressHUD showInfoWithStatus:@"保存成功"];
    } else {
        [SVProgressHUD showInfoWithStatus:@"保存失败"];
    }
}

#pragma mark ---setter and getter 
- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    NSMutableArray *arrX = [NSMutableArray array];
    NSMutableArray *arrY = [NSMutableArray array];
    NSArray *arr = [self dealWithDateDataModel:dataSource];
    if (arr.count == 0) {
        self.unitLabel.hidden = YES;
        self.noDataLabel.hidden = NO;
        if (self.isLineChartView) {
            self.lineView.hidden = YES;
        } else {
            self.lineView.hidden = YES;;
        }
        return;
    }
    else {
        self.unitLabel.hidden = NO;
        self.noDataLabel.hidden = YES;
        if (self.isLineChartView) {
            self.lineView.hidden = NO;
        } else {
            self.lineView.hidden = NO;;
        }
    }
    for (MCChartModel *model in arr) {
        [arrX addObject:model.DateTime];
        [arrY addObject:[NSNumber numberWithDouble:[model.Num doubleValue]]];
    }
    [self dataSourceChuLI:arrX arrY:arrY];
    [self setUPCulnmData:arrX arrY:arrY];
}

@end
