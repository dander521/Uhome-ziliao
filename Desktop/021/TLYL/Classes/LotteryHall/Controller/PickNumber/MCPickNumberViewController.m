//
//  MCPickNumberViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPickNumberViewController.h"
#import "MCLotteryHalllPickTableViewCell.h"
#import "MCLotteryHalllPickTableViewModel.h"
#import "UIImage+Extension.h"
#import "MCBallCollectionModel.h"
#import "MCPaySelectedLotteryTableViewController.h"
#import "MCPullMenuViewController.h"
#import "MCLotteryRecordView.h"
#import "MCRandomUntits.h"
#import "MCPaySelectedLotteryModel.h"
#import "MCLotteryRecordViewController.h"
#import "MCPullMenuPresentationController.h"
#import "MCLotteryDrawDetailsViewController.h"
#import "MCMaxbonusModel.h"
#import "ExceptionView.h"
#import "MCHistoryIssueDetailAPIModel.h"


@interface MCPickNumberViewController ()<UITableViewDataSource,UITableViewDelegate>

#pragma mark -property

///**分组保存选中的号码球*/
//@property (nonatomic,strong) NSMutableArray *selectedArrary;
/**随机数*/
@property (nonatomic,strong) NSMutableArray *randomBallArray;
/**cell强引用*/
@property (nonatomic,strong) NSMutableArray *cellArray;

@property (nonatomic,assign)CGFloat height_Footer;

@property (nonatomic,strong)UIView * view_footer;
/**该彩种开奖记录API*/
@property (nonatomic,strong)MCHistoryIssueDetailAPIModel * historyIssueDetailAPIModel;
/**该彩种开奖记录占位图*/
@property (nonatomic,strong)ExceptionView * exceptionView;

@property (nonatomic,assign,getter=isClearAllNumber) BOOL clearAllNumber;

@property (nonatomic,strong) UIView * noIssueNumberView;
@end

@implementation MCPickNumberViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.baseWFmodel.czName) {
        self.navigationItem.title = self.baseWFmodel.czName;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mcTableView_height:) name:@"MCTABLEVIEW_FOOTER_HEIGHT" object:nil];
    _height_Footer=0.0001;
    /*
     * 初始化 小圆点
     */
    MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    if (model.dataSource.count>0) {
        self.addItemLabel.text = [NSString stringWithFormat:@"%d",(int)model.dataSource.count];
        self.addItemLabel.hidden = NO;
    }else{
        self.addItemLabel.hidden = YES;
    }
    

//    if (self.isDanShi) {
//        [self.alertView showStackWindow];
//    }
    

    
    
    

}
-(void)openFailedIssue{
    if (self.isShowFaildIssue) {
        
    }else{
        [UIView animateWithDuration:0.4 animations:^{
            
            self.baseTableView.frame = CGRectMake(0, HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO, G_SCREENWIDTH, G_SCREENHEIGHT - (HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO)- 49-44-HEIGHTnoIssueView);
            
            self.baseTableView.transform = CGAffineTransformTranslate(self.baseTableView.transform, 0,HEIGHTnoIssueView);
            self.btnDaojishi.transform = CGAffineTransformTranslate(self.btnDaojishi.transform, 0,HEIGHTnoIssueView);
            self.btnPCatergy.transform = CGAffineTransformTranslate(self.btnPCatergy.transform, 0,HEIGHTnoIssueView);
            self.btnKaiJiang.transform = CGAffineTransformTranslate(self.btnKaiJiang.transform, 0,HEIGHTnoIssueView);
            self.isShowFaildIssue=YES;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MCHistoryIssueDetailAPIModel *historyIssueDetailAPIModel=[MCHistoryIssueDetailAPIModel sharedMCHistoryIssueDetailAPIModel];
    historyIssueDetailAPIModel.isNeedUpdate=NO;
}
- (void)dealloc{
    [self.cellArray removeAllObjects];
    NSLog(@"MCPickNumberViewController-----dealloc");
}

/*
 * 每次重置菜种
 */
-(void)MC_PICKNUMBERVC_INIT{
    if (self.isShowFaildIssue) {
        self.baseTableView.transform = CGAffineTransformTranslate(self.baseTableView.transform, 0,HEIGHTnoIssueView);
    }
    
    typeof(self) weakSelf = self;
    //tableView滑到顶端
    if (weakSelf.baseTableView) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [weakSelf.baseTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    //cellArray  add的方法始终在此方法后面
    if (weakSelf.cellArray.count==weakSelf.baseWFmodel.item.count) {
        [weakSelf clearData];
    }
    
 
}

- (void)showStackWindow{
    self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0,  20, 0);
}
- (void)hidenStackWindow{
    self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0,  20, 0);
}
#pragma mark - setUpUI
- (void)setUpUI{
    self.view.backgroundColor = RGB(239, 239, 239);
    /**tabView 创建*/
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, G_SCREENWIDTH, G_SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView = tab;
    self.baseTableView.backgroundColor=RGB(239, 239, 239);
    if (G_SCREENHEIGHT<500) {
        self.baseTableView.estimatedRowHeight = 10;
    } else if(G_SCREENHEIGHT<600){
        self.baseTableView.estimatedRowHeight = 40;
    }else{
        self.baseTableView.estimatedRowHeight = 50;
    }

    self.baseTableView.contentInset = UIEdgeInsetsMake(50, 0, 20, 0);
//    [self.view  insertSubview:self.noIssueNumberView belowSubview:self.baseTableView];
//    self.noIssueNumberView.frame=CGRectMake(0, 0, G_SCREENWIDTH, HEIGHTnoIssueView);
    
    //创建手势对象
//    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapAction:)];
//    tap.numberOfTapsRequired =1;
//    [self.noIssueNumberView addGestureRecognizer:tap];
    
}
-(void)tapAction:(UITapGestureRecognizer*)recognizer{
    
    [super loadIssueData:^(BOOL result) {
        if (result) {
            [UIView animateWithDuration:0.4 animations:^{
                self.isShowFaildIssue=NO;
                self.baseTableView.transform = CGAffineTransformIdentity;
                self.btnDaojishi.transform = CGAffineTransformIdentity;
                self.btnPCatergy.transform = CGAffineTransformIdentity;
                self.btnKaiJiang.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                self.baseTableView.frame = CGRectMake(0, HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO, G_SCREENWIDTH, G_SCREENHEIGHT - (HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO)- 49-44);
            }];
        }
        
    }];
    
}

-(UIView *)noIssueNumberView{
    if (!_noIssueNumberView) {
        _noIssueNumberView=[[UIView alloc]init];
        _noIssueNumberView.backgroundColor=RGB(238, 198, 198);
        UIImageView * img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noIssue_icon"]];
        [_noIssueNumberView addSubview:img];
        img.frame=CGRectMake(10, (HEIGHTnoIssueView-14)/2.0, 14, 14);
        UILabel * lab=[[UILabel alloc]init];
        lab.text=@"获取期号失败，请稍后再试。（点击刷新）";
        [_noIssueNumberView addSubview:lab];
        lab.font=[UIFont systemFontOfSize:12];
        lab.textAlignment=NSTextAlignmentLeft;
        lab.frame=CGRectMake(34, 0, G_SCREENWIDTH, HEIGHTnoIssueView);
        lab.textColor=[UIColor redColor];
    }
    return _noIssueNumberView;
}


#pragma mark -UITableViewDataSource And UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.baseWFmodel.lineCount  isEqualToString: @""]) {
        return 0;
    } else {
        if ([self.baseWFmodel.filterCriteria isEqualToString:@"2"]) {
            return 1;
        } else {
            return [self.baseWFmodel.lineCount intValue];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = [NSString stringWithFormat:@"MCLotteryHalllPickTableViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    MCLotteryHalllPickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell == nil) {
        cell = [[MCLotteryHalllPickTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if (![self.cellArray containsObject:cell]) {
        [self.cellArray addObject:cell];
    }
    
    cell.lotteriesType = self.lotteriesTypeModel.LotteryID;
    
    if (![self.baseWFmodel.filterCriteria isEqualToString:@"2"]) {
        
        cell.dataSource = self.baseWFmodel.item[indexPath.row];
        
        cell.baseSlectedModel.index = (int)indexPath.row;
        
        __weak MCLotteryHalllPickTableViewCell *weakcell = cell;
        
        __weak typeof(self) weakSelf = self;
        cell.slectedBallBlock = ^(NSMutableArray *arr){
           
            weakcell.baseSlectedModel.selectedArray = arr;
            if (![weakSelf.selectedArrary containsObject:weakcell.baseSlectedModel] && arr.count != 0 ) {
                
                [weakSelf.selectedArrary addObject:weakcell.baseSlectedModel];
                
            }else if ([weakSelf.selectedArrary containsObject:weakcell.baseSlectedModel] && arr.count == 0){
                [weakSelf.selectedArrary removeObject:weakcell.baseSlectedModel];
            }
            weakSelf.baseWFmodel.baseSelectedModel = weakSelf.selectedArrary;
            
            if ([weakSelf.baseWFmodel.mutex isEqualToString:@"1"]) {
                
                [weakSelf dantuoWFMetuxWithCell:weakcell];
                
            }
            MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:weakSelf.baseWFmodel];
           
           if (arr.count != 0 || weakSelf.clearAllNumber == YES) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
            }
            
        };
        
    }else{
        
    }
    cell.baseWFmodel = self.baseWFmodel;
    if (self.randomBallArray.count != 0) {
        cell.randomNumber = self.randomBallArray[indexPath.row];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  self.baseWFmodel.lineH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return _height_Footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.00001;
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    return  self.view_selectedCard;
//    
//}
#pragma mark-修改tableView 的 Footer高度
- (void)mcTableView_height:(NSNotification *)noti{
    
    NSDictionary *dic = noti.userInfo;
    int isShowFooter = [dic[@"isShowFooter"] intValue];
    if (isShowFooter) {
        _height_Footer=(146-49);
    }else{
        _height_Footer=0.0001;
    }
    self.view_footer.frame=CGRectMake(0, 0, G_SCREENWIDTH, _height_Footer);
    [self.baseTableView setTableFooterView:self.view_footer];

}

#pragma mark-点击近期开奖
-(void)KaiJiangClick{

    
//    [self.baseTableView setContentOffset:CGPointMake(0,0) animated:NO];
    MCLotteryRecordViewController *VC = [[MCLotteryRecordViewController alloc]init];
    VC.LotteryCode=self.baseWFmodel.LotteryID;
    MCPullMenuPresentationController *PC = [[MCPullMenuPresentationController alloc] initWithPresentedViewController:VC presentingViewController:self];
    PC.type=MCPullMenuKaiJiangType;
    PC.isShowFaildIssue=self.isShowFaildIssue;
    VC.transitioningDelegate = PC;
    [self presentViewController:VC animated:YES completion:NULL];

}


#pragma mark -Custem Method
/**胆拖上下互斥玩法*/
- (void)dantuoWFMetuxWithCell:(MCLotteryHalllPickTableViewCell *)cell{
    
    if (self.selectedArrary.count >=2) {
        MCBaseSelectedModel *model1 = self.selectedArrary[0];
        MCBaseSelectedModel *model2 = self.selectedArrary [1];
        [model1.selectedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            [model2.selectedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *str1 = obj1;
                NSString *str2 = obj2;
                if ([self.baseWFmodel.tongxuan isEqualToString:@"2"]) {
                    if ([self.baseWFmodel.lotteryCategories isEqualToString:@"k3"]) {
                    str1 = [NSString stringWithFormat:@"%@",[obj1 substringWithRange:NSMakeRange(0, 1)]];
                    str2 = [NSString stringWithFormat:@"%@",[obj2 substringWithRange:NSMakeRange(0, 1)]];
                    }else{
                    str1 = [NSString stringWithFormat:@"0%@",[obj1 substringWithRange:NSMakeRange(0, 1)]];
                    }
                }
                if ([str1 isEqualToString:str2] ) {
                    if (![self.baseWFmodel.lotteryCategories isEqualToString:@"k3"]) {
                    MCLotteryHalllPickTableViewCell *cell1 = [self.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:model1.index inSection:0]];
                    MCLotteryHalllPickTableViewCell *cell2 = [self.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:model2.index inSection:0]];
                    if (cell == cell2) {
                        for (MCBallCollectionModel*model in cell1.ballArray) {
                            if ([obj1 isEqualToString:model.textInfo]) {
                                model.seleted = NO;
                            }
                            [model1.selectedArray removeObject:obj1];
                        }
                        [cell1.ballColletionView reloadData];
                    } else {
                        for (MCBallCollectionModel*model in cell2.ballArray) {
                            if ([str1 isEqualToString:model.textInfo]) {
                                model.seleted = NO;
                            }
                            [model2.selectedArray removeObject:obj1];
                        }
                        [cell2.ballColletionView reloadData];
                    }
                    }else{
                        MCLotteryHalllPickTableViewCell *cell1 = [self.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:model1.index inSection:0]];
                        MCLotteryHalllPickTableViewCell *cell2 = [self.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:model2.index inSection:0]];
                        if (cell == cell2) {
                            for (MCBallCollectionModel*model in cell1.ballArray) {
                                if ([str1 isEqualToString:[NSString stringWithFormat:@"%@",[model.textInfo substringWithRange:NSMakeRange(0, 1)]]]) {
                                    model.seleted = NO;
                                }
                                [model1.selectedArray removeObject:obj1];
                            }
                            [cell1.ballColletionView reloadData];
                        } else {
                            for (MCBallCollectionModel*model in cell2.ballArray) {
                                if ([str1 isEqualToString:[NSString stringWithFormat:@"%@",[model.textInfo substringWithRange:NSMakeRange(0, 1)]]]) {
                                    model.seleted = NO;
                                }
                                [model2.selectedArray removeObject:obj2];
                            }
                            [cell2.ballColletionView reloadData];
                        }

                        
                    }
                
                }
            }];
        }];
    }
}

- (NSMutableArray *)setNumberSelectedArray{
    
    NSMutableArray *allNumberArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i<self.baseWFmodel.item.count; i++) {
        NSMutableArray *sectionArray = [NSMutableArray array];
        MCLotteryHalllPickTableViewCell *cell = self.cellArray[i];
        for (MCBallCollectionModel *model in cell.ballArray) {
            if (model.seleted == YES) {
                [sectionArray addObject:model];
            }
        }
        if (sectionArray.count != 0) {
            [allNumberArray addObject:sectionArray];
        }
        
    }
    
    return  allNumberArray;
}
/**夫类方法*/
#pragma mark - 重写夫类方法
#pragma mark-机选
- (void)randomBtnClick{
    [super randomBtnClick];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"JIXUAN"];
    for (NSInteger i = 0; i<self.baseWFmodel.item.count; i++) {
        MCLotteryHalllPickTableViewCell *cell = self.cellArray[i];
        for (MCBallCollectionModel *model in cell.ballArray) {
            model.seleted = NO;
        }
        [cell.selectedBallArray removeAllObjects];
        [cell.ballColletionView reloadData];
    }

    
    [self.baseWFmodel.baseSelectedModel removeAllObjects];
    NSMutableArray *arr = [MCRandomUntits Get_RandomArrWithModel:self.baseWFmodel];
    if (arr.count != self.cellArray.count) {return;}
    for (NSInteger i = 0; i<arr.count; i++) {
        MCLotteryHalllPickTableViewCell *cell = self.cellArray[i];
        for (MCBallCollectionModel *model in cell.ballArray) {
            model.seleted = NO;
        }
        NSMutableArray *randomNumber = arr[i];
        for (NSInteger j = 0; j<randomNumber.count; j++) {
            NSString *str = randomNumber[j];
            for (MCBallCollectionModel *model in cell.ballArray) {
                if ([str isEqualToString:model.textInfo]) {
                    model.seleted = YES;
                }
            }
        }
    }
    [self.baseTableView reloadData];
    
    for (NSInteger i = 0; i<arr.count; i++) {
        MCLotteryHalllPickTableViewCell *cell = self.cellArray[i];
        [cell.ballColletionView reloadData];
    }
    
}


#pragma mark-清
- (void)clearAllButtonClick{
    self.clearAllNumber = YES;
    [self clearData];
}

- (void)clearData{
    self.baseWFmodel.stakeNumber=0;
    //单式清除操作
    if ([self.baseWFmodel.filterCriteria isEqualToString:@"2"]) {
        
        MCLotteryHalllPickTableViewCell *cell=[self.baseTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell danShiClear];
        self.baseWFmodel.danShiArray=nil;
        
    }else{
        for (NSInteger i = 0; i<self.baseWFmodel.item.count; i++) {
            
            MCLotteryHalllPickTableViewCell *cell = self.cellArray[i];
            for (MCBallCollectionModel *model in cell.ballArray) {
                model.seleted = NO;
            }
            [cell.selectedBallArray removeAllObjects];
            [cell.ballColletionView reloadData];
            
        }
    }
}
#pragma mark-添加号码
- (void)addNumberToShoppingCar:(BOOL)isShow{
    if (!self.baseWFmodel.userSelectedRebate) {
        [SVProgressHUD showInfoWithStatus:@"返点获取失败！"];
        return;
    }
    if ([self.baseWFmodel.LotteryID isEqualToString:@"50"]) {
    }else{
        if (self.IssueNumber.length<1) {
            [SVProgressHUD showInfoWithStatus:@"期号获取失败！"];
            return;
        }
    }
    
    int minStakeNumber=1;
    if ([self.baseWFmodel.isDanTuo isEqualToString:@"1"]) {
        minStakeNumber=2;
    }
    if (self.baseWFmodel.stakeNumber > 0) {
        [self danqiNode];
    }
    //厘模式   >=0.02
    if ((ABS(self.baseWFmodel.yuanJiaoFen-0.001)<0.001)&&(self.baseWFmodel.payMoney+0.001)<0.02) {
        if (isShow) {
            [SVProgressHUD showErrorWithStatus:@"请至少选择0.02元！"];
        }
    }else{
        //单式添加号码
        if ([self.baseWFmodel.filterCriteria isEqualToString:@"2"]) {
            MCLotteryHalllPickTableViewCell *cell=[self.baseTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            //已经校验过了   并且  文本框没有被修改
            if ([cell.lastNumberString isEqualToString:cell.mcTextView.text] && cell.AModel.Do_Wrong && cell.lastNumberString.length>0 && cell.AModel.arr_Result.count>0) {
                /*
                 * 加入数据
                 */
                if (self.baseWFmodel.stakeNumber==0) {
                    MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
                }
                
                MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
                [model addDataSourceWithModel:self.baseWFmodel];
                self.addItemLabel.hidden=NO;
                self.addItemLabel.text = [NSString stringWithFormat:@"%d",(int)model.dataSource.count];
                
                [self clearAllButtonClick];
                if (self.isDanShi) {
                }else{
                    [self.alertView hideStackWindow];
                }
            }else{
                MCArryModel*Amodel= [cell delWrongNumber:NO];
                if (Amodel.Do_Wrong&&Amodel.arr_Result.count>0) {
                    /*
                     * 加入数据
                     */
                    if (self.baseWFmodel.stakeNumber==0) {
                        MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
                        
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
                    }
                    
                    MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
                    [model addDataSourceWithModel:self.baseWFmodel];
                    self.addItemLabel.hidden=NO;
                    self.addItemLabel.text = [NSString stringWithFormat:@"%d",(int)model.dataSource.count];
                    
                    [self clearAllButtonClick];
                    if (self.isDanShi) {
                    }else{
                        [self.alertView hideStackWindow];
                    }
                    
                }else{
                    if (Amodel.arr_Wrong.count>0) {
                        return;//此时会弹出去错误号码的框  不需要再弹出了
                    }
                    [SVProgressHUD showInfoWithStatus:@"请至少选择一注号码！"];
                }
            }
            
        }else{
            MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
            if (self.baseWFmodel.stakeNumber>=minStakeNumber) {
                
                /*
                 * 加入数据
                 */
                [model addDataSourceWithModel:self.baseWFmodel];
                self.addItemLabel.hidden=NO;
                self.addItemLabel.text = [NSString stringWithFormat:@"%d",(int)model.dataSource.count];
                
                [self clearAllButtonClick];
                
                
            }else{
                
                
                
                if(model.dataSource.count == 0||self.baseWFmodel.stakeNumber<minStakeNumber){
                    if (isShow) {
                        if (minStakeNumber==2) {
                            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请至少选择两注号码！"]];
                        }else{
                            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请至少选择一注号码！"]];
                        }
                    }
                    return;
                }
            }
            
        }
        
    }
}

- (void)danqiNode{
    int mode = [self.baseWFmodel.Mode intValue];
    if ((mode & 64) == 64) {//单挑功能
        for (MCMaxbonusModel *model in self.boModelArray) {
            if ([model.Sign isEqualToString:@"2"]) {
                continue;
            }
          NSString *strid =  [NSString stringWithFormat:@"%@%@",self.baseWFmodel.LotteryID,self.baseWFmodel.methodId];
            if ( [model.PlayCode isEqualToString:strid]) {
                if([model.SoloNote intValue] >= self.baseWFmodel.stakeNumber){
                    NSString *strinfo = [NSString stringWithFormat:@"您所投注内容为单挑玩法，最高奖金为%@元",GetRealSNum(model.SoloAmt)];
                    [SVProgressHUD showInfoWithStatus:strinfo];
                }
            }
        }
    }
}
#pragma mark-去投注
- (void)payTheSelectedNumbers{
    if (!self.baseWFmodel.userSelectedRebate) {
        [SVProgressHUD showInfoWithStatus:@"返点获取失败！"];
        return;
    }
    if ([self.baseWFmodel.LotteryID isEqualToString:@"50"]) {
        
    }else{
        if (self.IssueNumber.length<1) {
            [SVProgressHUD showInfoWithStatus:@"期号获取失败！"];
            return;
        }
    }
    //单式添加号码
    if ([self.baseWFmodel.filterCriteria isEqualToString:@"2"]) {
        MCLotteryHalllPickTableViewCell *cell=[self.baseTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        //已经校验过了   并且  文本框没有被修改
        if ([cell.lastNumberString isEqualToString:cell.mcTextView.text]&&cell.AModel.Do_Wrong && cell.lastNumberString.length>0 && cell.AModel.arr_Result.count>0) {
            /*
             * 加入数据
             */
            if (self.baseWFmodel.stakeNumber==0) {
                MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
            }
            
            MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
            [model addDataSourceWithModel:self.baseWFmodel];
            self.addItemLabel.hidden=NO;
            self.addItemLabel.text = [NSString stringWithFormat:@"%d",(int)model.dataSource.count];
            
            [self clearAllButtonClick];
            if (self.isDanShi) {
            }else{
                [self.alertView hideStackWindow];
            }
        }else{
            MCArryModel*Amodel= [cell delWrongNumber:NO];
            MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"danshiModel":model}];
            if (Amodel.Do_Wrong&&Amodel.arr_Result.count>0) {
                /*
                 * 加入数据
                 */
                if (self.baseWFmodel.stakeNumber==0) {
                    MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
                }
                
                MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
                [model addDataSourceWithModel:self.baseWFmodel];
                self.addItemLabel.hidden=NO;
                self.addItemLabel.text = [NSString stringWithFormat:@"%d",(int)model.dataSource.count];
                
                [self clearAllButtonClick];
                if (self.isDanShi) {
                }else{
                    [self.alertView hideStackWindow];
                }
                
            }else{
                
                MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
                if (model.dataSource.count<1&&Amodel.arr_Wrong.count>0) {
//                    [SVProgressHUD showInfoWithStatus:@"请先去除错误号码！"];
                    return;
                }else if(model.dataSource.count<1&&Amodel.arr_Result.count<1){
                    [SVProgressHUD showInfoWithStatus:@"请至少选择一注号码！"];
                    return;
                }
            }
        }
        MCPaySelectedLotteryTableViewController *vc =  [[MCPaySelectedLotteryTableViewController alloc] init];
        vc.boModelArray = self.boModelArray;
        vc.baseWFmodel = self.baseWFmodel;
        vc.RemainTime=self.time;
        vc.IssueNumber=self.IssueNumber;
        vc.betRebateArray = self.betRebateArray;
        [self.navigationController pushViewController:vc animated:YES];
        
        [self clearAllButtonClick];
        
        if (self.isDanShi) {
        }else{
            [self.alertView hideStackWindow];
        }
        return;
    }
    
    MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    
    //如果 当前角标为0  用户选择的球  够一注   也可以投注
    int minStakeNumber=1;
    if ([self.baseWFmodel.isDanTuo isEqualToString:@"1"]) {
        minStakeNumber=2;
    }
    if (model.dataSource.count==0&&self.baseWFmodel.stakeNumber>=minStakeNumber) {
        
        if ((self.baseWFmodel.payMoney+0.001)<0.02) {
            [SVProgressHUD showErrorWithStatus:@"请至少选择0.02元！"];
            return;
        }
        
        //        [model addDataSourceWithModel:self.baseWFmodel];
        //        MCPaySelectedLotteryTableViewController *vc =  [[MCPaySelectedLotteryTableViewController alloc] init];
        //        vc.RemainTime=self.time;
        //        vc.IssueNumber=self.IssueNumber;
        //        [self.navigationController pushViewController:vc animated:YES];
        //        return;
        
    }
    
    
    
    [self addNumberToShoppingCar:NO];
    if (self.baseWFmodel.stakeNumber<minStakeNumber&&model.dataSource.count<1&&self.baseWFmodel.danShiArray.count<1) {
        if (minStakeNumber==2) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请至少选择两注号码！"]];
            return;
        }
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请至少选择一注号码！"]];
        return;
    }
    
    
    MCPaySelectedLotteryTableViewController *vc =  [[MCPaySelectedLotteryTableViewController alloc] init];
    vc.boModelArray = self.boModelArray;
    vc.baseWFmodel = self.baseWFmodel;
    vc.RemainTime=self.time;
    vc.IssueNumber=self.IssueNumber;
    vc.betRebateArray = self.betRebateArray;
    [self.navigationController pushViewController:vc animated:YES];
    
    [self clearAllButtonClick];
    
    if (self.isDanShi) {
    }else{
        [self.alertView hideStackWindow];
    }
}
#pragma mark - getter and setter



- (NSMutableArray *)cellArray{
    if (_cellArray== nil) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}


- (NSMutableArray *)randomBallArray{
    if (_randomBallArray == nil) {
        _randomBallArray = [NSMutableArray array];
    }
    return _randomBallArray;
}

- (NSMutableArray *)selectedArrary{
    if (_selectedArrary == nil) {
        _selectedArrary = [NSMutableArray array];
    }
    return _selectedArrary;
}

-(UIView *)view_footer{
    if (!_view_footer) {
        _view_footer=[[UIView alloc]init];
        _view_footer.backgroundColor=[UIColor clearColor];
    }
    return _view_footer;
}

- (void)setBaseWFmodel:(MCBasePWFModel *)baseWFmodel{
    
    [super setBaseWFmodel:baseWFmodel];
    self.clearAllNumber = NO;
    baseWFmodel.lotteryCategories = self.lotteriesTypeModel.type;
    if ([baseWFmodel.filterCriteria isEqualToString:@"2"]) {
        if (self.isShowFaildIssue) {
            self.baseTableView.frame = CGRectMake(0, HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO, G_SCREENWIDTH, G_SCREENHEIGHT - (HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO)- 49-44-HEIGHTnoIssueView);
        }else{
            self.baseTableView.frame = CGRectMake(0, HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO, G_SCREENWIDTH, G_SCREENHEIGHT - (HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO)-49-44);
        }
    } else {
        if (self.isShowFaildIssue) {
            self.baseTableView.frame = CGRectMake(0, HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO, G_SCREENWIDTH, G_SCREENHEIGHT - (HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO)- 49-44-HEIGHTnoIssueView);
        }else{
            self.baseTableView.frame = CGRectMake(0, HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO, G_SCREENWIDTH, G_SCREENHEIGHT - (HEIGHTDAOJISHI+HEIGHTKAIJIANGHAO)- 49-44);
        }
    }
    [self.cellArray removeAllObjects];
    [self.randomBallArray removeAllObjects];
    
    for (MCBaseSelectedModel *model in self.selectedArrary) {
        
        [model.selectedArray removeAllObjects];
    }
    [self.selectedArrary removeAllObjects];
    
    [self.baseTableView reloadData];
    
    
}


@end
