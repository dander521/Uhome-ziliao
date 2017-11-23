//
//  MCAlertView.m
//
//
//  Created by menhao on 17/6/12.
//
//

#import "MCAlertView.h"
#import "MCMSPopView.h"
#import "MCMoneyPopView.h"

static MCAlertView *_alertWindow;

@interface MCAlertView ()


#pragma  mark - property

@property (nonatomic,weak)  UIButton *btBtn;

@property (nonatomic,strong)UIButton * doneInKeyboardButton;
@property (nonatomic,weak)  UIButton *addBtn;



@property (nonatomic,weak) UIButton *misBtn;

@property (nonatomic,weak) UIView *coverView;

@property (nonatomic,assign) int currentIndex;

@end

@implementation MCAlertView

#pragma mark - Init

+ (instancetype)alertInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _alertWindow = [[self alloc] init];
        [_alertWindow setUpUI];
    });
    return _alertWindow;
}


- (void)setUpUI{
    
    self.frame = CGRectMake(0, G_SCREENHEIGHT - 49 -20, G_SCREENWIDTH, 60);
    self.backgroundColor = MC_ColorWithAlpha(255, 255, 255, 1);
    
    UIButton *btBtn = [[UIButton alloc] init];
    [btBtn setTitle:@"       倍" forState:UIControlStateNormal];
    [btBtn.titleLabel setFont:[UIFont systemFontOfSize:MC_REALVALUE(15)]];
    self.btBtn = btBtn;
    UITextField *btTF = [[UITextField alloc] init];
    [btBtn addSubview:btTF];
    
    [btBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:btBtn];
    self.btTF = btTF;
    btTF.textAlignment = NSTextAlignmentCenter;
    btTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName : [UIColor blackColor]}];
    btTF.font=[UIFont systemFontOfSize:12];
    btTF.keyboardType = UIKeyboardTypeNumberPad;
    btTF.clearButtonMode = UITextFieldViewModeNever;
    btTF.returnKeyType = UIReturnKeyDone;
    btTF.inputAccessoryView = [self addToolbar];
    
    [btTF addTarget:self action:@selector(action_EditingChanged:) forControlEvents:(UIControlEventEditingChanged)];
   
    
    UIButton *msBtn = [[UIButton alloc] init];
    [msBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [msBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self addSubview:msBtn];
    [msBtn setTitle:@"元  模式" forState:UIControlStateNormal];
    self.msBtn = msBtn;
    
    
    UIButton *moneyBtn = [[UIButton alloc] init];
    [self addSubview:moneyBtn];
    self.moneyBtn = moneyBtn;
    [moneyBtn setTitle:@"1982.0.0" forState:UIControlStateNormal];
    [moneyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moneyBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    
    UIButton *imgB = [[UIButton alloc] initWithFrame:CGRectMake(MC_REALVALUE(10), MC_REALVALUE(14), MC_REALVALUE(16), MC_REALVALUE(16))];
    [self addSubview:imgB];
    [imgB setBackgroundImage:[UIImage imageNamed:@"touzhu-zs-icon"] forState:UIControlStateNormal];

    btBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btBtn.layer.borderWidth = 0.5f;
    btBtn.layer.masksToBounds = YES;
    msBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    msBtn.layer.borderWidth = 0.5f;
    msBtn.layer.cornerRadius = 4.0f;
    msBtn.layer.masksToBounds = YES;
    moneyBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    moneyBtn.layer.borderWidth = 0.5f;
    moneyBtn.layer.cornerRadius = 4.0f;
    moneyBtn.layer.masksToBounds = YES;
    [msBtn addTarget:self action:@selector(msBtnClick:) forControlEvents:UIControlEventTouchDown];
    [moneyBtn addTarget:self action:@selector(moneyBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton *addBtn = [[UIButton alloc] init];
    [self addSubview:addBtn];
    self.addBtn = addBtn;
    [addBtn setBackgroundImage:[UIImage imageNamed:@"-"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(minsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(MC_REALVALUE(36), 5, 30, 30);
    UIButton *minsBtn = [[UIButton alloc] init];
    [self addSubview:minsBtn];
    [minsBtn setBackgroundImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    [minsBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.misBtn = minsBtn;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard) name:@"HEY_BOARD_HIDEN" object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    
#pragma mark-监听键盘的回收
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)addBtnClick{
    self.currentIndex = [self.btTF.text intValue];
    self.currentIndex = self.currentIndex + 1;
    self.btTF.text = [NSString stringWithFormat:@"%d",self.currentIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:MCActionMultiple object:nil userInfo:@{@"multiple":self.btTF.text}];
}
- (void)minsBtnClick{
    self.currentIndex = [self.btTF.text intValue];
    if (self.currentIndex <= 1) {
        self.btTF.text = @"1";
        return;
    }
    self.currentIndex = self.currentIndex - 1;
    self.btTF.text = [NSString stringWithFormat:@"%d",self.currentIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:MCActionMultiple object:nil userInfo:@{@"multiple":self.btTF.text}];
}
- (UIToolbar *)addToolbar{
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 35)];
    toolbar.tintColor = RGB(58, 130, 208);
    toolbar.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *Button10 = [[UIBarButtonItem alloc] initWithTitle:@"10倍" style:UIBarButtonItemStylePlain target:self action:@selector(TextField10)];
    UIBarButtonItem *Button100 = [[UIBarButtonItem alloc] initWithTitle:@"100倍" style:UIBarButtonItemStylePlain target:self action:@selector(TextField100)];
    UIBarButtonItem *Button1000 = [[UIBarButtonItem alloc] initWithTitle:@"1000倍" style:UIBarButtonItemStylePlain target:self action:@selector(TextField1000)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[Button10, Button100,Button1000, space, bar];
    return toolbar;
}
//10倍
-(void)TextField10{
    self.btTF.text=@"10";
}
//100倍
-(void)TextField100{
    self.btTF.text=@"100";
}
//1000倍
-(void)TextField1000{
    self.btTF.text=@"1000";
}
//完成
-(void)textFieldDone{
    [self.btTF resignFirstResponder];
    
}

#pragma mark - Layout
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat btnHeight = 30;
    CGFloat padding = 5.0f;
    
    [self.titleSelectedInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(padding));
    }];
    
    [self.btBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(padding);
        make.left.equalTo(self.addBtn.mas_right).offset(padding);
        make.height.equalTo(@(btnHeight));
        make.width.equalTo(@((self.widht - padding * 5 - 120) * 0.3));
    }];
    [self.misBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btBtn.mas_right).offset(5);
        make.top.bottom.equalTo(self.btBtn);
        make.height.width.equalTo(@(30));
    }];
    [self.msBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(padding);
        make.left.equalTo(self.misBtn.mas_right).offset(padding );
        make.height.equalTo(@(btnHeight));
        make.width.equalTo(@((self.widht - padding * 4 - 60) * 0.3 ));
    }];
    
    [self.moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(padding);
        make.left.equalTo(self.msBtn.mas_right).offset(padding);
        make.right.equalTo(self.mas_right).offset(- padding);
        make.height.equalTo(@(btnHeight));
        
    }];

    [self.btTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btBtn.mas_right).offset(-30);
        make.centerY.equalTo(self.btBtn.mas_centerY);
        make.top.equalTo(self.btBtn.mas_top);
        make.bottom.equalTo(self.btBtn.mas_bottom);
        make.left.equalTo(self.btBtn.mas_left);
    }];

}

#pragma mark - show and hide window

- (void)showStackWindow{
    



    self.frame = CGRectMake(0, G_SCREENHEIGHT- 49 - 60 - 64, G_SCREENWIDTH, 49 + 60);

    
    self.hidden = NO;
    /*
     * 发送通知   ---》tableView 的footer 高度变化0->(146-49+64)
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCTABLEVIEW_FOOTER_HEIGHT" object:nil userInfo:@{@"isShowFooter":@"1"}];
}
- (void)showStackWindowWithHeight:(CGFloat)height{
    
    self.frame = CGRectMake(0, G_SCREENHEIGHT- height - 10, G_SCREENWIDTH, height);

    self.hidden = NO;
    /*
     * 发送通知   ---》tableView 的footer 高度变化0->(146-49+64)
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCTABLEVIEW_FOOTER_HEIGHT" object:nil userInfo:@{@"isShowFooter":@"1"}];
}

- (void)hideStackWindow{

    if (self.hidden) {
        return;
    }

    [self popViewHidden];
    
    self.frame = CGRectMake(0, G_SCREENHEIGHT - 49, G_SCREENWIDTH, 0);

    self.hidden = YES;
    /*
     * 发送通知   ---》tableView 的footer 高度变化(146-49+64)->0
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCTABLEVIEW_FOOTER_HEIGHT" object:nil userInfo:@{@"isShowFooter":@"0"}];

}

#pragma mark - touch event
/**
 *
 *返点点击弹出框
 **/
- (void)moneyBtnClick:(UIButton *)btn{
    
  
    if ([self.btTF resignFirstResponder]) {
        [self endEditing:YES];
    } else {
        
        if (_isShowMoneyPop) {
            
            _isShowMoneyPop=NO;
            MCMoneyPopView *popView = [MCMoneyPopView alertInstance];
            [popView hideModelWindow];
            
        }else{
            
           _isShowMoneyPop=YES;
            MCMoneyPopView *popView = [MCMoneyPopView alertInstance];
            NSArray * arr=popView.dataArray;
            
            if (arr.count<1) {
                return;
            }
            CGFloat HEIGHT=arr.count*30;
            if (arr.count>4) {
                HEIGHT=120;
            }
            
            CGFloat Top=G_SCREENHEIGHT-(49+MC_REALVALUE(60)-self.msBtn.frame.origin.y)- HEIGHT;
            
            popView.frame = CGRectMake(self.moneyBtn.left , Top, self.moneyBtn.widht, HEIGHT);
            
            __weak MCAlertView *weakSelf = self;
            popView.MoneySelectRowBlock = ^(MCShowBetModel *model){
                
                weakSelf.isShowMoneyPop=NO;
                [weakSelf.moneyBtn setTitle:model.showRebate forState:UIControlStateNormal];
                [[NSNotificationCenter defaultCenter] postNotificationName:McSelectedBetRebate object:nil userInfo:@{@"MCShowBetModel":model}];
            };
            [popView showModelWindow];
        }
        
    }
    if (self.fandianBlock&&[MCMoneyPopView alertInstance].dataArray.count>0) {
        self.fandianBlock();
    }
}

/**
 *
 *元角模式点击弹出框
 **/
- (void)msBtnClick:(UIButton *)btn{
  
    if ([self.btTF resignFirstResponder]) {
        [self endEditing:YES];
    } else {
        
        if (_isShowMSPop) {
            
            _isShowMSPop=NO;
            MCMSPopView *popView2 = [MCMSPopView alertInstance];
            [popView2 hideModelWindow];
            
        }else{
            
            _isShowMSPop=YES;
            MCMSPopView *popView = [MCMSPopView alertInstance];
            NSArray * arr=popView.dataArray;
            CGFloat Top=G_SCREENHEIGHT-(49+MC_REALVALUE(60)-self.msBtn.frame.origin.y)- arr.count*30;
            //        NSLog(@"----%f--------%f----Top:%f",self.msBtn.frame.origin.y,self.msBtn.frame.size.height,Top);
            popView.frame = CGRectMake(self.msBtn.left, Top  , self.msBtn.widht, arr.count*30);
            popView.backgroundColor = [UIColor clearColor];
            __weak MCAlertView *weakSelf = self;
            popView.MSSelectRowBlock = ^(NSString *type){
                
                weakSelf.isShowMSPop=NO;
                
                [weakSelf.msBtn setTitle:type forState:UIControlStateNormal];
                //修改元角分模式-》发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:MCActionYuanJiaoFen object:nil userInfo:@{@"type":type}];
            };
            [popView showModelWindow];
            
        }
    }
    if (self.moshiBlock) {
        self.moshiBlock();
    }
}

#pragma mark-修改完倍投后   发送通知
- (void) keyboardWillHide : (NSNotification*)notification {
    
    
    if ([_btTF.text intValue]==0) {
        _btTF.text=@"1";
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:MCActionMultiple object:nil userInfo:@{@"multiple":_btTF.text}];
    
}
- (void) keyboardWillShow : (NSNotification*)notification {
    [self popViewHidden];
}

-(void)action_btn_finish{
    [self.btTF resignFirstResponder];
}
#pragma mark -- 输入变化
- (void)action_EditingChanged:(UITextField *)textField
{
    
    if (textField.text.length>=4) {
        textField.text=[textField.text substringToIndex:4];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

- (void)hideKeyBoard{
    if ([self.btTF resignFirstResponder]) {
        [self endEditing:YES];
    }
    
}
-(void)popViewHidden{
    MCMoneyPopView *popView = [MCMoneyPopView alertInstance];
    [popView hideModelWindow];
    MCMSPopView *popView2 = [MCMSPopView alertInstance];
    [popView2 hideModelWindow];
    _isShowMSPop=NO;
    _isShowMoneyPop=NO;
}

- (UIView *)coverView{
    if (_coverView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT)];
        view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
        [self addSubview:view];
    }
    return _coverView;
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
