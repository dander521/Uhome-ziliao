//
//  MCBonusRecordViewController.m
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusRecordViewController.h"
#import "MCBonusRecordSlideView.h"
#import "MCGetDividentsListModel.h"
#import "MCRecordTool.h"

#define MORENCOUNT 15

@interface MCBonusRecordViewController ()

@property (nonatomic,strong)MCBonusRecordSlideView *segmentedView;
@property(nonatomic, strong)MCNaviSelectedPopView *popView1;
@property(nonatomic, weak)  MCInputView * viewPop1;
@property(nonatomic, weak)  DatePickerView *datePicker1;
@property(nonatomic, assign)BOOL  isShowPopView1;

@property (nonatomic,strong) NSDate *start_minDate1;
@property (nonatomic,strong) NSDate *start_maxDate1;
@property (nonatomic,strong) NSDate *end_minDate1;
@property (nonatomic,strong) NSDate *end_maxDate1;

@property(nonatomic, strong) NSString * statTime1;
@property(nonatomic, strong) NSString * endTime1;

@property(nonatomic,assign)BOOL isHadRefreashUI;
@end

@implementation MCBonusRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self dismissAllPopView1];
    
}




#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationItem.title = @"分红记录";
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
    
    _isShowPopView1=NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSArray * arr=[MCRecordTool GetMonthFirstAndLastDay];
    NSString * BenMonthFirstDay =arr[0];
    
    _statTime1=[NSString stringWithFormat:@"%@ 00:00:00",BenMonthFirstDay];
    _endTime1=[NSString stringWithFormat:@"%@ 23:59:59",currentDateStr];
    
    self.start_minDate1 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:-3 day:1];
    self.start_maxDate1 = [NSDate date];
    self.end_minDate1 = [MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",BenMonthFirstDay]];
    self.end_maxDate1 = [NSDate date];

    self.popView1.label3.text = BenMonthFirstDay;
    self.popView1.label4.text = [NSString stringWithFormat:@"%@",currentDateStr];
    
}


#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    MCNaviButton *rightBtn = [[MCNaviButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


#pragma mark==================createUI======================
-(void)createUI{
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
    
    self.view.backgroundColor=RGB(231,231,231);
    [self createSlide];
    
}

#pragma mark ================================创建Slide
-(void)createSlide{
    
    NSArray *array = [NSArray arrayWithObjects:@"直属下级分红",@"自身分红",nil];
    _segmentedView = [MCBonusRecordSlideView segmentControlViewWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT-64)];
    
    _segmentedView.normalColor = RGB(102,102,102);
    _segmentedView.selectedColor = RGB(144,8,215 );
    _segmentedView.SlideSelectedColor=RGB(144,8,215);
    
    _segmentedView.titleArray = array;
    _segmentedView.selectedTitleArray = array;
    [self.view addSubview:_segmentedView];
    
    
}

-(void)rightBtnAction{
    
    if (_isShowPopView1) {
        _isShowPopView1=NO;
        [self.popView1 dismiss];
        
    }else{
        _isShowPopView1=YES;
        
        typeof(self) weakself = self;
        
        self.popView1.block = ^(NSInteger type) {
            
            if (type==0) {
#pragma mark-开始时间
            }else if (type==1){
                [weakself.viewPop1 hiden];
                
                weakself.datePicker1.minDate=weakself.start_minDate1;
                weakself.datePicker1.maxDate=weakself.start_maxDate1;
                weakself.datePicker1.showDate = [MCRecordTool getDateWithStr:weakself.statTime1];

                weakself.datePicker1.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                    }];
                };
                
                weakself.datePicker1.sureBlock = ^(NSString *selectDateStr) {
                    
                    weakself.popView1.label3.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.statTime1 = [NSString stringWithFormat:@"%@ 00:00:00",selectDateStr];
                    weakself.end_minDate1=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                        
                    }];
                };
                
                
            }else if (type==2){
#pragma mark-结束时间
                [weakself.viewPop1 hiden];
                
                weakself.datePicker1.minDate=weakself.end_minDate1;
                weakself.datePicker1.maxDate=weakself.end_maxDate1;
             
                
                NSString * endTime = [weakself.endTime1 stringByReplacingOccurrencesOfString:@"23:59:59" withString:@"00:00:00"];
                weakself.datePicker1.showDate = [MCRecordTool getDateWithStr:endTime];

                [weakself.viewPop1 hiden];
                weakself.datePicker1.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                    }];
                };
                
                weakself.datePicker1.sureBlock = ^(NSString *selectDateStr) {
                    weakself.start_maxDate1=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    weakself.popView1.label4.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.endTime1 = [NSString stringWithFormat:@"%@ 23:59:59",selectDateStr];
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                        
                    }];
                };
#pragma mark-搜索
            }else if (type==8){

                weakself.isShowPopView1=NO;
                [weakself dismissAllPopView1];

                [weakself setBonusRecordProperty];
                
                [weakself.segmentedView.xiaJiCell refreashDataFromSearchBar];
                
                [weakself.segmentedView.mySelfCell refreashDataFromSearchBar];
            }
        };
        
        self.popView1.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
        [self.popView1 showPopView];
    }
}

- (MCNaviSelectedPopView *)popView1{
    
    if (_popView1 == nil) {
        MCNaviSelectedPopView * popView1 = [[MCNaviSelectedPopView alloc]InitWithType:MCNaviSelectedPopType_BonusRecord];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [popView1 addGestureRecognizer:tap1];
        [self.navigationController.view addSubview:popView1];
        _popView1 = popView1;
    }
    return _popView1;
}

- (MCInputView *)viewPop1{
    if (_viewPop1 == nil) {
        
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [self.navigationController.view addSubview:viewStatus];
        _viewPop1 = viewStatus;
    }
    return _viewPop1;
}
- (DatePickerView *)datePicker1{
    
    if (_datePicker1 == nil) {
        DatePickerView *datePicker1 =[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:0] lastObject];
        datePicker1.frame =CGRectMake(0,self.view.frame.size.height  - 200 + 64, self.view.frame.size.width, 200);
        datePicker1.Datetitle =@"日期选择";
        [self.navigationController.view addSubview:datePicker1];
        _datePicker1 = datePicker1;
    }
    return _datePicker1;
}
- (void)tap1{
    _isShowPopView1=NO;
    [self dismissAllPopView1];
}
-(void)dismissAllPopView1{
    [self.popView1 dismiss];
    [self.viewPop1 hiden];
    [self.datePicker1 removeFromSuperview];
}

-(void)setBonusRecordProperty{

    MCBonusRecordProperty * PersonProperty = [MCBonusRecordProperty sharedMCBonusRecordProperty];
    PersonProperty.BeginTime=self.statTime1;
    PersonProperty.EndTime=self.endTime1;
    PersonProperty.CurrentPageIndex=@"1";
    PersonProperty.CurrentPageSize=[NSString stringWithFormat:@"%d",MORENCOUNT];
    if (_popView1.tf1.text.length>0) {
        PersonProperty.UserName=_popView1.tf1.text;
    }else{
        PersonProperty.UserName=nil;
    }
}
@end



























