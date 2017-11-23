//
//  MCSendMessageViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSendMessageViewController.h"
#import "MCKefuViewController.h"
#import "MCSendPersonCollectionViewCell.h"
#import "MCChoiceMesPersonViewController.h"
#import "MCEmailAllModel.h"
#import "MCSendMessageModel.h"
#import "MCInboxDetailModel.h"

@interface MCSendMessageViewController ()<UITextViewDelegate>

@property(nonatomic,assign) BOOL selected;
@property(nonatomic,weak) UIView *topView;
@property(nonatomic,weak) UILabel *sendPersonNameLabel;
@property(nonatomic,weak) UILabel *placeHolder;
@property (nonatomic,strong) MCSendMessageModel *sendMessageModel;
@property(nonatomic,weak)UITextField *titleTf;
@property(nonatomic,weak)UITextView *textView;
@property (nonatomic,strong) NSString *strName;
@property (nonatomic,strong) MCInboxDetailModel *inBoxModel;
@property (nonatomic,strong) MCChoiceMesPersonViewController *pvc;


@end

@implementation MCSendMessageViewController

- (instancetype)init{
    if (self == [super init]) {
        [self addNavRightBtn];
        [self setUpUI];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoWriteUser:) name:@"MCInBoxDetailViewController" object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发消息";
    self.view.backgroundColor = RGB(231, 231, 231);
   
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -- set UI
- (void)addNavRightBtn {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"客服" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(18)];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)allBtnClick{
    MCKefuViewController *kefu = [[MCKefuViewController alloc] init];
    [self.navigationController pushViewController:kefu animated:YES];
}
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(100))];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 6;
    topView.clipsToBounds =YES;
    self.topView = topView;
    UILabel *sendPersonLabel = [[UILabel alloc] init];
    [topView addSubview:sendPersonLabel];
    sendPersonLabel.textColor = RGB(46, 46, 46);
    sendPersonLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [sendPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(MC_REALVALUE(20));
        make.top.equalTo(topView);
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    sendPersonLabel.text = @"收件账户";
    
    UILabel *sendPersonNameLabel = [[UILabel alloc] init];
    [topView addSubview:sendPersonNameLabel];
    sendPersonNameLabel.text = @"编辑联系人";
    sendPersonNameLabel.textColor = RGB(144, 8, 215);
    sendPersonNameLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    sendPersonNameLabel.frame = CGRectMake(MC_REALVALUE(113), 0, G_SCREENWIDTH - MC_REALVALUE(148), MC_REALVALUE(49.5));
    self.sendPersonNameLabel = sendPersonNameLabel;
    sendPersonNameLabel.userInteractionEnabled = YES;
    sendPersonNameLabel.numberOfLines = 0;
    [sendPersonNameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendBianjiLabelClick)]];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    [topView addSubview:lineLabel];
    lineLabel.backgroundColor = RGB(213, 213, 213);
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(MC_REALVALUE(20));
        make.top.equalTo(sendPersonNameLabel.mas_bottom);
        make.height.equalTo(@(MC_REALVALUE(0.5)));
        make.right.equalTo(topView);
    }];
    
    UILabel *sendTitleLabel = [[UILabel alloc] init];
    [topView addSubview:sendTitleLabel];
    sendTitleLabel.textColor = RGB(46, 46, 46);
    sendTitleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [sendTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendPersonLabel);
        make.top.equalTo(sendPersonNameLabel.mas_bottom);
        make.height.equalTo(@(MC_REALVALUE(50)));
    }];
    sendTitleLabel.text = @"邮件标题";
    
    UITextField *titleTf = [[UITextField alloc] init];
    [topView addSubview:titleTf];
    titleTf.textColor = RGB(46, 46, 46);
    titleTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邮件标题(20个字以内)" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(14)],NSForegroundColorAttributeName : RGB(181, 181, 181)}];
    titleTf.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    titleTf.textAlignment = NSTextAlignmentLeft;
    [titleTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendPersonNameLabel);
        make.top.equalTo(sendTitleLabel);
        make.height.equalTo(@(MC_REALVALUE(50)));
        make.right.equalTo(topView);
    }];
    titleTf.autocorrectionType = UITextAutocorrectionTypeNo;
    self.titleTf = titleTf;
    [titleTf addTarget:self action:@selector(titleTextFiled) forControlEvents:UIControlEventEditingChanged];
    UITextView *textView = [[UITextView alloc] init];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.delegate = self;
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    textView.textColor = RGB(46, 46, 46);
    textView.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView);
        make.top.equalTo(topView.mas_bottom).offset(MC_REALVALUE(13));
        make.height.equalTo(@(MC_REALVALUE(146)));
    }];
    textView.layer.cornerRadius  = 6;
    textView.clipsToBounds = YES;
    self.textView = textView;
    UILabel *placeHolder = [[UILabel alloc] init];
    [textView addSubview:placeHolder];
    placeHolder.textColor = RGB(181, 181, 181);
    placeHolder.frame = CGRectMake(MC_REALVALUE(20), MC_REALVALUE(15), 300, MC_REALVALUE(15));
    placeHolder.text = @"请输入邮件内容(200个字以内)";
    placeHolder.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.placeHolder = placeHolder;
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"立即发送" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    btn.backgroundColor = RGB(144, 8, 215);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 6;
    btn.clipsToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(textView);
        make.top.equalTo(textView.mas_bottom).offset(MC_REALVALUE(13));
        make.height.equalTo(@(MC_REALVALUE(40)));
    }];
    
}
- (void)autoWriteUser:(NSNotification *)noti{
 
    MCInboxDetailModel  *model = noti.object;
    NSMutableString *str = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@；",model.SendPerson]];
    self.inBoxModel = model;
    [str appendString:@"编辑联系人"];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [str rangeOfString:@"编辑联系人"];
    [aString addAttribute:NSForegroundColorAttributeName value:RGB(46, 46, 46) range:NSMakeRange(0, str.length - range.length)];
    self.sendPersonNameLabel.attributedText = aString;
    self.titleTf.text = model.Title;
}
- (void)titleTextFiled{
    if (self.titleTf.text.length > 20) {
        self.titleTf.text = [self.titleTf.text substringWithRange:NSMakeRange(0, 20)];
        }
            
}
- (void)sendBianjiLabelClick{
    if (self.pvc == nil) {
        MCChoiceMesPersonViewController * pvc = [[MCChoiceMesPersonViewController alloc] init];
        self.pvc = pvc;
    }
    __weak typeof(self) weakself = self;
    self.pvc.selectedPersonBlock = ^(NSArray *arr,BOOL selected) {
        if (arr.count == 0) {
            [SVProgressHUD showInfoWithStatus:@"请选择收件人"];
        }
        weakself.selected = selected;
    NSMutableString *str = [NSMutableString string];
    for (MCEmailAllModel *model in arr) {
        if (![weakself.tableViewDataArray containsObject:model] && model.selected == YES) {
            [weakself.tableViewDataArray addObject:model];
        }
        if ([weakself.tableViewDataArray containsObject:model] && model.selected == NO) {
            [weakself.tableViewDataArray removeObject:model];
        }
    }
    for (MCEmailAllModel *model1 in weakself.tableViewDataArray) {
        if (model1.selected == YES) {
             [str appendString:[NSString stringWithFormat:@"%@；",model1.ChildUserName]];
        }
        }
   [str appendString:@"编辑联系人"];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [str rangeOfString:@"编辑联系人"];
    weakself.sendPersonNameLabel.textColor = RGB(144, 8, 215);
    [aString addAttribute:NSForegroundColorAttributeName value:RGB(46, 46, 46) range:NSMakeRange(0, str.length - range.length)];
        
   CGRect subviewRect1 = [str boundingRectWithSize:CGSizeMake(G_SCREENWIDTH - MC_REALVALUE(148), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(14)]} context:nil];
        if (subviewRect1.size.height > MC_REALVALUE(50)) {
            weakself.sendPersonNameLabel.frame = CGRectMake(MC_REALVALUE(113), 0,G_SCREENWIDTH - MC_REALVALUE(148), subviewRect1.size.height + MC_REALVALUE(18));
            weakself.topView.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(100) + MC_REALVALUE(18) + subviewRect1.size.height - MC_REALVALUE(50));
        } else {
            weakself.sendPersonNameLabel.frame = CGRectMake(MC_REALVALUE(113), 0,G_SCREENWIDTH - MC_REALVALUE(148), MC_REALVALUE(50));
            weakself.topView.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(100));
        }
       
        weakself.sendPersonNameLabel.attributedText = aString;
        

    };
    
    [self.navigationController pushViewController:self.pvc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)sendBtnClick{
    MCSendMessageModel *sendM = [[MCSendMessageModel alloc] init];
    self.sendMessageModel = sendM;
    NSMutableString *str = [NSMutableString string];
   
    if (self.selected == YES) {
        for (MCEmailAllModel *model in self.tableViewDataArray) {
            [str appendString:[NSString stringWithFormat:@"%d,",model.User_ID]];
        }
        [str appendString:@"-1"];
    } else {
        for (MCEmailAllModel *model in self.tableViewDataArray) {
            if ([self.tableViewDataArray.firstObject isKindOfClass:[MCEmailAllModel class]]) {
                if (model.selected == YES) {
                      [str appendString:[NSString stringWithFormat:@"%d,",model.User_ID]];
                }
            }
        }
        if (![str isEqualToString:@""]) {
            str = (NSMutableString *)[str substringToIndex:str.length -1];
        }
    }
    
   
    if (self.inBoxModel != nil) {
        str = (NSMutableString *)[NSString stringWithFormat:@"%d",self.inBoxModel.SendUserID];
    }
    NSLog(@"%@------------",str);
    if ([str isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请选择收件人"];
        return;
    }
    sendM.ReceivePerson = str;
    sendM.SendPserson = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    if ([self.titleTf.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入标题"];
        return;
    }
    if ([self.textView.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
        return;
    }
    sendM.Title = self.titleTf.text;
     sendM.Content = self.textView.text;
    
  
    [sendM refreashDataAndShow];
    sendM.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        [SVProgressHUD showInfoWithStatus:manager.responseMessage];
        self.titleTf.text = @"";
        self.textView.text = @"";
        [self.tableViewDataArray removeAllObjects];
        self.sendPersonNameLabel.text =@"编辑联系人";
        self.sendPersonNameLabel.textColor = RGB(144, 8, 215);

    };
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        self.placeHolder.hidden = NO;
    } else {
        self.placeHolder.hidden = YES;
    }
    if (self.textView.text.length > 200) {
        self.textView.text = [self.titleTf.text substringWithRange:NSMakeRange(0, 200)];
    }
}
- (NSMutableArray *)tableViewDataArray{
    
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [NSMutableArray array];
        
    }
    return _tableViewDataArray;
}
@end
