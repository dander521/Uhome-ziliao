//
//  MCLotteryHalllPickTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/6/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryHalllPickTableViewCell.h"
#import "MCFilterCollectionViewCell.h"
#import "MCBallCollectionViewCell.h"
#import "MCBallCollectionModel.h"
#import "MCStakeUntits.h"
#import "NSString+Helper.h"
#import "MCRandomUntits.h"
#import "MCTextView.h"
#import "UIView+MCParentController.h"
#import "MCPickNumberViewController.h"

@interface MCLotteryHalllPickTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UIAlertViewDelegate>

#pragma mark - property
/** 说明信息*/
//@property (nonatomic,weak) UILabel *infoLabel;
/** 筛选条件*/
@property (nonatomic,strong) UICollectionView *filterCriteriaColletionView;
/** 筛选条件数据源*/
@property (nonatomic,strong) NSMutableArray *filterArray;
/** fitersize*/
@property (nonatomic,assign) CGFloat fiterWidth;
/** 球的宽高*/
@property (nonatomic,assign) CGFloat ballWidth;
/** 选中的cell*/
@property (nonatomic,strong) NSIndexPath *selectedIndex;
/** 单式view*/
@property (nonatomic,weak) UIView *mcDSView;
/** 单式textView*/
@property (nonatomic,weak) UIButton *delRepartBtn;
/** 单式textView*/
@property (nonatomic,weak) UIButton *delWrongBtn;
/** 单式textView*/
@property (nonatomic,weak) UILabel *infoDanShiLabel;
/** 球行数*/
@property (nonatomic,assign) CGFloat lineCount;
/** 是否是和值*/
@property (nonatomic,assign) BOOL sumValue;
/** 去错后数组*/
@property (nonatomic,strong) NSArray *numberDelWrongStringArr;


@property (nonatomic,assign) int test;
@property (nonatomic,weak) UIView *bgV;
@property (nonatomic,weak) UIImageView *bgImgV;
@property (nonatomic,weak) UIImageView *iconImgeV;

@end


@implementation MCLotteryHalllPickTableViewCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor=[UIColor clearColor];
        self.baseSlectedModel = [[MCBaseSelectedModel alloc] init];
        
        [self setUpUI];
        
        [self regesterNotification];
    }
    return self;
}

- (void)setUpUI{
    
    UIView *bgV = [[UIView alloc] init];
    [self addSubview:bgV];
    self.bgV = bgV;
    UIImageView *bgImgV = [[UIImageView alloc] init];
    [bgV addSubview:bgImgV];
    self.bgImgV =bgImgV;
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"touzhu-beijing"];
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 拉伸图片
     UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
     bgImgV.image = newImage;
     bgImgV.userInteractionEnabled = YES;
    
//    UILabel *infoLabel = [[UILabel alloc] init];
//    [bgV addSubview:infoLabel];
//    self.infoLabel = infoLabel;
//    self.infoLabel.textColor = MC_ColorWithAlpha(119, 119, 119, 1);
//    self.infoLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.filterArray removeAllObjects];
    NSArray *arr = @[@"全",@"大",@"小",@"奇",@"偶",@"清"];
    for (NSInteger i = 0; i< arr.count; i++) {
        MCfilterBallModel *model = [[MCfilterBallModel alloc] init];
        model.info = arr[i];
        model.selected = NO;
        [self.filterArray addObject:model];
    }
    
    CGFloat padding = MC_REALVALUE(8);
    CGFloat w = (G_SCREENWIDTH-padding*4-5*15)/6;
    self.fiterWidth = w;
    UICollectionViewFlowLayout *ballLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat bw = (G_SCREENWIDTH - 5*10 -20*2 ) /6;
    ballLayout.minimumLineSpacing = MC_REALVALUE(8);
    ballLayout.minimumInteritemSpacing = MC_REALVALUE(8);
    ballLayout.sectionInset = UIEdgeInsetsMake(MC_REALVALUE(8), MC_REALVALUE(8) * 2, MC_REALVALUE(8), MC_REALVALUE(8) * 2);
    self.ballWidth = bw;
    ballLayout.itemSize = CGSizeMake(MC_REALVALUE(40), MC_REALVALUE(40));
    UICollectionView *ballColletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:ballLayout];
    [ballColletionView registerNib:[UINib nibWithNibName:NSStringFromClass([MCBallCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"MCBallCollectionViewCell"];
    ballColletionView.delegate = self;
    ballColletionView.dataSource = self;
    ballColletionView.scrollEnabled = NO;
    [bgImgV addSubview:ballColletionView];
    self.ballColletionView = ballColletionView;
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MC_REALVALUE(35), MC_REALVALUE(35))];
    [ballColletionView addSubview:imgV];
    self.iconImgeV = imgV;
    /*
     * 筛选条件
     */
    UICollectionViewFlowLayout *filterLayout = [[UICollectionViewFlowLayout alloc] init];
    filterLayout.itemSize = CGSizeMake(MC_REALVALUE(25), MC_REALVALUE(25));
//    filterLayout.minimumLineSpacing = padding*0.5;
//    filterLayout.minimumInteritemSpacing = padding * 0.5;
    filterLayout.sectionInset = UIEdgeInsetsMake(MC_REALVALUE(4), MC_REALVALUE(10), 0, MC_REALVALUE(10));
    UICollectionView *filterCriteriaColletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:filterLayout];
    
    
    [filterCriteriaColletionView registerNib:[UINib nibWithNibName:NSStringFromClass([MCFilterCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"MCFilterCollectionViewCell"];
    filterCriteriaColletionView.delegate = self;
    filterCriteriaColletionView.dataSource = self;
    filterCriteriaColletionView.backgroundColor = [UIColor clearColor];
    filterCriteriaColletionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qdxqoq-icon"]];
    filterCriteriaColletionView.layer.cornerRadius = MC_REALVALUE(14);
    filterCriteriaColletionView.clipsToBounds = YES;
    [bgV addSubview:filterCriteriaColletionView];
    self.filterCriteriaColletionView = filterCriteriaColletionView;
    filterCriteriaColletionView.scrollEnabled = NO;
    
    
    /**单式输入框*/
//    UIView *mcTextView = [[UIView alloc] init];
//    [bgImgV addSubview:mcTextView];
//    self.mcDSView = mcTextView;
    
    MCTextView *textView = [[MCTextView alloc] init];
    [self.bgImgV addSubview:textView];
    textView.layer.borderWidth = 1.0;
    textView.layer.borderColor = RGB(220, 220, 220).CGColor;
    self.mcTextView = textView;
    textView.delegate = self;
    textView.placeHolder=@"请输入号码球内容";
    textView.placeHolderColor=RGB(130, 130, 130);
    textView.keyboardType = UIKeyboardTypeNumberPad;
    textView.returnKeyType = UIReturnKeyDone;
    textView.inputAccessoryView = [self addToolbar];
    
    /*
     * 去重复号
     */
    UIButton *quCFBtn = [[UIButton alloc] init];
    quCFBtn.titleLabel.font    = [UIFont systemFontOfSize: 12];
    [self.bgImgV addSubview:quCFBtn];
    quCFBtn.backgroundColor = RGB(144, 8, 215);
    [quCFBtn setTitle:@"去除重复" forState:UIControlStateNormal];
    [quCFBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    self.delRepartBtn = quCFBtn;
    quCFBtn.layer.cornerRadius = 4;
    quCFBtn.clipsToBounds = YES;
    /*
     * 去错误号
     */
    UIButton *quCWBtn = [[UIButton alloc] init];
    [self.bgImgV addSubview:quCWBtn];
    quCWBtn.titleLabel.font    = [UIFont systemFontOfSize: 12];
    quCWBtn.backgroundColor = RGB(255, 168, 0);
    [quCWBtn setTitle:@"去错误号" forState:UIControlStateNormal];
    [quCWBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    self.delWrongBtn = quCWBtn;
    quCWBtn.layer.cornerRadius = 4;
    quCWBtn.clipsToBounds = YES;
    
    /*
     * 格式说明
     */
    UILabel *infoDanShiLabel = [[UILabel alloc] init];
    infoDanShiLabel.font = [UIFont systemFontOfSize:13];
    infoDanShiLabel.textColor = [UIColor darkGrayColor];
    [bgV addSubview:infoDanShiLabel];
    textView.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.infoDanShiLabel = infoDanShiLabel;
    self.infoDanShiLabel.numberOfLines = 0;
    infoDanShiLabel.text = @"这是说明信息这是说明信息这是说明信";
    [quCWBtn addTarget:self action:@selector(delWrongNumber) forControlEvents:UIControlEventTouchDown];
    [quCFBtn addTarget:self action:@selector(delRepeatNumber) forControlEvents:UIControlEventTouchDown];
    [self.bgV addSubview:self.view_selectedCard];

    self.ballColletionView.backgroundColor = [UIColor clearColor];
}

- (UIToolbar *)addToolbar{
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 35)];
    toolbar.tintColor = RGB(58, 130, 208);
    toolbar.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

//完成
-(void)textFieldDone{
    [self.mcTextView resignFirstResponder];
    
}

- (void)updateConstraints{
    CGFloat padding = MC_REALVALUE(20);
    CGFloat h = ceilf(self.ballArray.count /6.0);
    if (h==0||!h) {
        h=1;
    }
    
    [self.bgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        
    }];
    
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgV).offset(MC_REALVALUE(13));
        make.right.equalTo(self.bgV).offset(MC_REALVALUE(-13));
        make.top.equalTo(self.bgV).offset(MC_REALVALUE(10));
        make.bottom.equalTo(self.bgV.mas_bottom).offset(MC_REALVALUE(-14));
        
    }];

    if ([self.baseWFmodel.filterCriteria  isEqualToString: @"0"]) {
        self.ballColletionView.hidden = NO;
        self.filterCriteriaColletionView.hidden = YES;
        self.mcDSView.hidden = YES;
        self.mcTextView.hidden = YES;
        self.delRepartBtn.hidden = YES;
        self.delWrongBtn.hidden = YES;
        
        if ([self.baseWFmodel.isShowSelectedCard isEqualToString:@"1"]) {
            [self.bgImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgV).offset(MC_REALVALUE(13));
                make.right.equalTo(self.bgV).offset(MC_REALVALUE(-13));
                make.top.equalTo(self.bgV).offset(MC_REALVALUE(60));
                make.bottom.equalTo(self.bgV.mas_bottom).offset(MC_REALVALUE(-14));
                
            }];
            [self.view_selectedCard mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.bgImgV);
                make.top.equalTo(self.bgV).offset(MC_REALVALUE(18));
                make.height.equalTo(@(MC_REALVALUE(50)));
            }];
            self.view_selectedCard.hidden = NO;
       
        }
        
        [self.ballColletionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.bgImgV).offset(0);
            make.height.equalTo(@(ceilf(h) * self.ballWidth +  h * MC_REALVALUE(8)+MC_REALVALUE(10)));
            
        }];
        
    } else if ([self.baseWFmodel.filterCriteria isEqualToString: @"1"]) {
        self.ballColletionView.hidden = NO;
        self.filterCriteriaColletionView.hidden = NO;
        self.mcDSView.hidden = YES;
        self.mcTextView.hidden = YES;
        self.delRepartBtn.hidden = YES;
        self.delWrongBtn.hidden = YES;
        if ([self.baseWFmodel.isShowSelectedCard isEqualToString:@"1"]) {
            [self.bgImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgV).offset(MC_REALVALUE(13));
                make.right.equalTo(self.bgV).offset(MC_REALVALUE(-13));
                make.top.equalTo(self.bgV).offset(MC_REALVALUE(60));
                make.bottom.equalTo(self.bgV.mas_bottom).offset(MC_REALVALUE(-14));
                
            }];
            [self.view_selectedCard mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.bgImgV);
                make.top.equalTo(self.bgV.mas_top).offset(MC_REALVALUE(18));
                make.height.equalTo(@(MC_REALVALUE(50)));
            }];
            self.view_selectedCard.hidden = NO;
        }
        [self.ballColletionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.bgImgV).offset(0);
            make.height.equalTo(@(ceilf(h) * self.ballWidth +  h * MC_REALVALUE(8)+MC_REALVALUE(10)));
            
        }];

        [self.filterCriteriaColletionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgImgV.mas_bottom).offset(MC_REALVALUE(22));
            make.centerX.equalTo(self.ballColletionView);
            make.left.equalTo(self.mas_left).offset(MC_REALVALUE(60));
            make.right.equalTo(self.mas_right).offset(MC_REALVALUE(-60));
            make.height.equalTo(@(MC_REALVALUE(44)));
        }];
           }else{
        self.ballColletionView.hidden = YES;
        self.filterCriteriaColletionView.hidden = YES;
        self.mcDSView.hidden = NO;
        self.mcTextView.hidden = NO;
        self.delRepartBtn.hidden = NO;
        self.delWrongBtn.hidden = NO;
               if ([self.baseWFmodel.isShowSelectedCard isEqualToString:@"1"]) {
                   
                   [self.bgImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.left.equalTo(self.bgV).offset(MC_REALVALUE(13));
                       make.right.equalTo(self.bgV).offset(MC_REALVALUE(-13));
                       make.top.equalTo(self.bgV).offset(MC_REALVALUE(10));
                       make.height.equalTo(@(MC_REALVALUE(268)));
                       
                   }];
                   [self.view_selectedCard mas_makeConstraints:^(MASConstraintMaker *make) {
                       make.left.right.top.equalTo(self.bgImgV);
                       make.height.equalTo(@(MC_REALVALUE(50)));
                   }];
                   [self.mcTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.left.equalTo(self.bgImgV).offset(padding * 0.5);
                       make.top.equalTo(self.bgImgV).offset(MC_REALVALUE(60));
                       make.right.equalTo(self.bgImgV).offset(-padding * 0.5);
                       make.height.equalTo(@(G_SCREENWIDTH - 2*padding - MC_REALVALUE(180)));
                   }];
                   
                   self.view_selectedCard.hidden = NO;
               } else {
                   [self.bgImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.left.equalTo(self.bgV).offset(MC_REALVALUE(13));
                       make.right.equalTo(self.bgV).offset(MC_REALVALUE(-13));
                       make.top.equalTo(self.bgV).offset(MC_REALVALUE(10));
                       make.height.equalTo(@(MC_REALVALUE(228)));
                       
                   }];
                   [self.mcTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.left.equalTo(self.bgImgV).offset(padding * 0.5);
                       make.top.equalTo(self.bgImgV).offset(padding * 0.5);
                       make.right.equalTo(self.bgImgV).offset(-padding * 0.5);
                       make.height.equalTo(@(G_SCREENWIDTH - 2*padding - MC_REALVALUE(180)));
                   }];
                   self.view_selectedCard.hidden = YES;
               }
        [self.delRepartBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgImgV).offset(MC_REALVALUE(40));
            make.top.equalTo(self.mcTextView.mas_bottom).offset(10);
            make.width.equalTo(@(MC_REALVALUE(126)));
            make.height.equalTo(@(MC_REALVALUE(34)));
        }];
        [self.delWrongBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.delRepartBtn);
            make.right.equalTo(self.bgImgV).offset(-MC_REALVALUE(40));
            make.width.equalTo(@(MC_REALVALUE(126)));
            make.height.equalTo(@(MC_REALVALUE(34)));
            
        }];
        
        [self.infoDanShiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImgV.mas_bottom).offset(20);
            make.left.equalTo(self.bgV).offset(18);
            make.right.equalTo(self.bgV).offset(-18);
        }];
        
    }
    
    
    [super updateConstraints];
    
  
}
#pragma mark - layout
- (void)layoutSubviews{
    
    [super layoutSubviews];
#warning  FIXME !!! 修改数字
    
}



#pragma mark -collectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == self.filterCriteriaColletionView) {
        return self.filterArray.count;
    } else {
        return self.ballArray.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = nil;
    
    if (collectionView == self.filterCriteriaColletionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCFilterCollectionViewCell" forIndexPath:indexPath];
        MCFilterCollectionViewCell *cellTemp = (MCFilterCollectionViewCell *)cell;
        cellTemp.dataSource = self.filterArray[indexPath.row];
        
        
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCBallCollectionViewCell" forIndexPath:indexPath];
        MCBallCollectionViewCell *cellTemp = (MCBallCollectionViewCell *)cell;
        MCBallCollectionModel *model = self.ballArray[indexPath.row];
        
        __weak MCBallCollectionViewCell *cellTempWeak = cellTemp;
        __weak typeof(self)weakSelf = self;
        cellTemp.selectedBallK3TongXuan = ^(MCBallCollectionModel *model){
            if ([weakSelf.baseWFmodel.tongxuan isEqualToString:@"1"]) {
                if (model.seleted == YES) {
                    for (NSInteger i = 0; i<weakSelf.ballArray.count; i++) {
                        MCBallCollectionModel *model = weakSelf.ballArray[i];
                        model.seleted = YES;
                        if (model.seleted == YES && ![weakSelf.selectedBallArray containsObject:model.textInfo]) {
                            [weakSelf.selectedBallArray addObject:model.textInfo];
                        }
                    }
                }else{
                    for (NSInteger i = 0; i<weakSelf.ballArray.count; i++) {
                        MCBallCollectionModel *model = weakSelf.ballArray[i];
                        model.seleted = NO;
                        [weakSelf.selectedBallArray removeAllObjects];
                    }
                }
                [weakSelf.ballColletionView reloadData];
                if (weakSelf.slectedBallBlock != nil) {
                    weakSelf.slectedBallBlock(weakSelf.selectedBallArray);
                }
                return;
            }
        };
        cellTemp.selectedBallZuXuanBaoDan = ^(MCBallCollectionModel *Bmodel){
            
            if ([model.mutex isEqualToString:@"2"]){
                if (model.seleted == YES) {
                    for (NSInteger i = 0; i<weakSelf.ballArray.count; i++) {
                        MCBallCollectionModel *model = weakSelf.ballArray[i];
                        
                        if ([model.textInfo isEqualToString:Bmodel.textInfo]) {
                            model.seleted = YES;
                        }else{
                            model.seleted = NO;
                        }
                        [weakSelf.selectedBallArray removeAllObjects];
                    }
                    
                    for (NSInteger i = 0; i<weakSelf.ballArray.count; i++) {
                        
                        MCBallCollectionModel *model = weakSelf.ballArray[i];
                        //                        model.seleted = YES;
                        if (model.seleted == YES && ![weakSelf.selectedBallArray containsObject:model.textInfo]) {
                            [weakSelf.selectedBallArray addObject:model.textInfo];
                        }
                    }
                }else{
                    for (NSInteger i = 0; i<weakSelf.ballArray.count; i++) {
                        MCBallCollectionModel *model = weakSelf.ballArray[i];
                        model.seleted = NO;
                        [weakSelf.selectedBallArray removeAllObjects];
                    }
                }
                [weakSelf.ballColletionView reloadData];
                if (weakSelf.slectedBallBlock != nil) {
                    weakSelf.slectedBallBlock(weakSelf.selectedBallArray);
                }
                return;

            }

        };
        
        cellTemp.selectedBall = ^(MCBallCollectionModel *model){
            
            if ([model.mutex isEqualToString:@"0"]) {// 不互斥
                
                [weakSelf addSelectedBallToArray:model];
                
            }else if ([model.mutex isEqualToString:@"1"]){// 互斥
                
                if (model.seleted == YES && ![weakSelf.selectedBallArray containsObject:model.textInfo]) {
                    if ([weakSelf.dataSource.maxBallNumber intValue] > weakSelf.selectedBallArray.count) {
                        [weakSelf.selectedBallArray addObject:model.textInfo];
                    } else {
                        [SVProgressHUD showErrorWithStatus:weakSelf.dataSource.info];
                        cellTempWeak.iconBtn.selected = NO;
                        model.seleted = NO;
                        return;
                    }
                } else if(model.seleted == NO && [weakSelf.selectedBallArray containsObject:model.textInfo]){
                    [weakSelf.selectedBallArray removeObject:model.textInfo];
                    
                }else{
                    
                }
                
            }else if ([model.mutex isEqualToString:@"2"]){
                
                [weakSelf addSelectedBallToArray:model];
                
                
                //                if (model.seleted) {
                //                    cellTempWeak.ballItemSelected = YES;
                //                }
                
                //                if(cellTempWeak.ballItemSelected == YES){
                //                    [weakSelf.selectedBallArray removeAllObjects];
                //                    [weakSelf.selectedBallArray addObject:model.textInfo];
                //                }
                //                [weakSelf addSelectedBallToArray:model];
                
                
                //                if (model.seleted == YES && ![self.selectedBallArray containsObject:model.textInfo]) {
                //                    [self.selectedBallArray addObject:model.textInfo];
                //
                //                } if(model.seleted == NO && [self.selectedBallArray containsObject:model.textInfo]){
                //                    [self.selectedBallArray removeObject:model.textInfo];
                //                }
                
                
                
                
                //                NSString *jixuan = [[NSUserDefaults standardUserDefaults] objectForKey:@"JIXUAN"];
                //                if ([jixuan intValue]==0) {
                //                    for (MCBallCollectionModel *bmodel in self.ballArray) {
                //                        if ([bmodel.textInfo isEqualToString:model.textInfo]) {
                //                            bmodel.seleted=YES;
                //                        }else{
                //                            bmodel.seleted=NO;
                //                        }
                //                    }
                //                }
                //
                //                [weakSelf.selectedBallArray removeAllObjects];
                //                [weakSelf addSelectedBallToArray:model];
                
                
                
            }else{
                
            }
            
            if (weakSelf.slectedBallBlock != nil) {
                
                //                [weakSelf.ballColletionView reloadData];
                
                weakSelf.slectedBallBlock(weakSelf.selectedBallArray);
            }
        };
        
        
        
        cellTemp.dataSource = model;
        
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MCBallCollectionModel *model = self.ballArray[indexPath.row];
    //    if ([model.mutex isEqualToString:@"2"]){
    //        for (MCBallCollectionModel *model in self.ballArray) {
    //            model.seleted = NO;
    //        }
    //        [self.selectedBallArray removeAllObjects];
    //
    //    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEY_BOARD_HIDEN" object:nil userInfo:nil];
    if (collectionView == self.filterCriteriaColletionView) {
        [self filterBtnClickWithIndex:indexPath];
    } else {
        
    }
    
    
}


#pragma mark - uitextView Delegate


- (void)textViewDidChange:(UITextView *)textView{
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_HIDEN" object:nil];
    return YES;
}

#pragma mark-失去焦点
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [[UIView MCcurrentViewController].view endEditing:YES];
    
}


#pragma mark-失去焦点  和  点击选项卡  进行注数计算
-(void)caculateStakeNumber{
    [SVProgressHUD showWithStatus:@"请稍后..."];
    //校验格式
    self.mcTextView.text = [NSString GetFormatStr:self.mcTextView.text WithModel:self.baseWFmodel];
    
    if (self.lastNumberString.length>0 && _AModel.Do_Wrong) {
        if ([self.lastNumberString isEqualToString:self.mcTextView.text]) {
            
        }else{
            _AModel= [self.mcTextView.text MC_delWrongLottoryNumberWithWF:self.baseWFmodel andShow:YES];
        }
    }else{
        _AModel= [self.mcTextView.text MC_delWrongLottoryNumberWithWF:self.baseWFmodel andShow:YES];
    }
    self.lastNumberString = self.mcTextView.text;
    
    if (_AModel.arr_Wrong.count<1&&_AModel.arr_Result.count>0) {
        self.baseWFmodel.danShiArray = _AModel.arr_Result;
        MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
        
    }
    [SVProgressHUD dismiss];
}

#pragma mark - custom Method
- (void)getKl8RandomNumber:(NSString *)typeName{
    for (MCBallCollectionModel *model in self.ballArray) {
        
        model.seleted = NO;
        model.filterSelectd = YES;
    }
    
    [self.ballColletionView reloadData];
    
    
    [self performSelector:@selector(delayMethodKl8:) withObject:typeName afterDelay:0.05];
}
-(void)delayMethodKl8:(NSString *)typeName{
    NSMutableArray *arr = MCRandomKl8(self.baseWFmodel, typeName);
    if (arr.count>=1) {
        NSArray *arrM = arr[0];
        for (NSString *str in arrM) {
            for (MCBallCollectionModel *model in self.ballArray) {
                if ([model.textInfo isEqualToString:str]) {
                    model.seleted = YES;
                    
                }
            }
        }
    }
    [self.ballColletionView reloadData];
}
- (void)filterBtnClickWithIndex:(NSIndexPath *)index{
    
    for (MCBallCollectionModel *model in self.ballArray) {
        model.seleted = NO;
        model.filterSelectd = YES;
    }
    switch (index.row) {
        
        case 0://全
        if ([self.baseWFmodel.filterCriteriaNotAll isEqualToString:@"1"]) {
            [self getKl8RandomNumber:@"全"];
            break;
        } else {
            for (MCBallCollectionModel *model in self.ballArray) {
                model.seleted = YES;
            }
            break;
        }
        case 1://大
        if ([self.baseWFmodel.filterCriteriaNotAll isEqualToString:@"1"]) {
            [self getKl8RandomNumber:@"上"];
            break;
        } else {
            if (![self.baseWFmodel.filterCriteriaNotAll isEqualToString:@""] && self.baseWFmodel.filterCriteriaNotAll != nil) {
                for (NSInteger i = 0; i<self.ballArray.count/2; i++) {
                    MCBallCollectionModel *model = self.ballArray[i];
                    model.seleted = YES;
                }
                
            } else {
                for (NSInteger i = self.ballArray.count /2; i<self.ballArray.count; i++) {
                    MCBallCollectionModel *model = self.ballArray[i];
                    model.seleted = YES;
                }
                
            }
            
            break;
        }
        case 2://小
        
        if ([self.baseWFmodel.filterCriteriaNotAll isEqualToString:@"1"]) {
            [self getKl8RandomNumber:@"下"];
            break;
        } else {
            if (![self.baseWFmodel.filterCriteriaNotAll isEqualToString:@""]&& self.baseWFmodel.filterCriteriaNotAll != nil) {
                
                for (NSInteger i = self.ballArray.count /2; i<self.ballArray.count; i++) {
                    MCBallCollectionModel *model = self.ballArray[i];
                    model.seleted = YES;
                }
            } else {
                for (NSInteger i = 0; i<self.ballArray.count/2; i++) {
                    MCBallCollectionModel *model = self.ballArray[i];
                    model.seleted = YES;
                }
                
            }
            
            break;
        }
        case 3://奇数
        
        if ([self.baseWFmodel.filterCriteriaNotAll isEqualToString:@"1"]) {
            [self getKl8RandomNumber:@"奇"];
            break;
        } else {
            if ([self.baseWFmodel.ballStartNumber integerValue] == 0) {
                for (NSInteger i = 0; i<self.ballArray.count; i++) {
                    if (i%2!=0) {
                        MCBallCollectionModel *model = self.ballArray[i];
                        model.seleted = YES;
                    }
                }
            } else {
                for (NSInteger i = 1; i<=self.ballArray.count; i++) {
                    if (i%2!=0) {
                        MCBallCollectionModel *model = self.ballArray[i-1];
                        model.seleted = YES;
                    }
                }
            }
            break;
        }
        case 4://偶数
        if ([self.baseWFmodel.filterCriteriaNotAll isEqualToString:@"1"]) {
            [self getKl8RandomNumber:@"偶"];
            break;
        } else {
            if ([self.baseWFmodel.ballStartNumber integerValue] == 0) {
                for (NSInteger i = 0; i<self.ballArray.count; i++) {
                    if (i%2==0) {
                        MCBallCollectionModel *model = self.ballArray[i];
                        model.seleted = YES;
                    }
                }
            } else {
                for (NSInteger i = 1; i<=self.ballArray.count; i++) {
                    if (i%2==0) {
                        MCBallCollectionModel *model = self.ballArray[i-1];
                        model.seleted = YES;
                    }
                }
            }
            break;
        }
        case 5://清
        for (MCBallCollectionModel *model in self.ballArray) {
            
            model.seleted = NO;
            
        }
        //延迟调用的原因：self.baseWFmodel里面小球的选中信息没有及时更新过来，导致显示注数不对
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.05];
        
        break;
        
        default:
        break;
        
        
    }
    [self.ballColletionView reloadData];
}

-(void)delayMethod{
    MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"ballModel":model}];
}
- (void)addSelectedBallToArray:(MCBallCollectionModel *) model{
    
    if (model.filterSelectd == YES) {
        for (MCBallCollectionModel *model in self.ballArray) {
            if (model.seleted == YES && ![self.selectedBallArray containsObject:model.textInfo]) {
                
                [self.selectedBallArray addObject:model.textInfo];
            } if(model.seleted == NO && [self.selectedBallArray containsObject:model.textInfo]){
                [self.selectedBallArray removeObject:model.textInfo];
            }
            
        }
    } else {
        
        if (model.seleted == YES && ![self.selectedBallArray containsObject:model.textInfo]) {
            [self.selectedBallArray addObject:model.textInfo];
            
        } if(model.seleted == NO && [self.selectedBallArray containsObject:model.textInfo]){
            [self.selectedBallArray removeObject:model.textInfo];
        }
        
    }
    
}

- (void)regesterNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLotteryWFERWF:) name:@"CHANGE_LOTTERY_WF_ERJIWF" object:nil];
    
    
}

/*
 * 清空输入框
 */
-(void)danShiClear{
    self.mcTextView.text=@"";
}
-(void)becomeFirstResp{
    [self.mcTextView
     becomeFirstResponder];
}
- (void)changeLotteryWFERWF:(NSNotification *)noti{
    [self.ballArray removeAllObjects];
    [self.ballColletionView reloadData];
    for (MCfilterBallModel *model in self.filterArray) {
        model.selected = NO;
    }
    [self.filterCriteriaColletionView reloadData];
    
    //清空输入框
    self.mcTextView.text=@"";
    
}
#pragma mark - touch event
#pragma mark-点击去错处理
- (MCArryModel*)delWrongNumber{
    return [self delWrongNumber:YES];
}
- (MCArryModel*)delWrongNumber:(BOOL)isShowHud{
    //校验格式
    self.mcTextView.text = [NSString GetFormatStr:self.mcTextView.text WithModel:self.baseWFmodel];
    
    if (self.lastNumberString.length>0 && _AModel.Do_Wrong) {
        if ([self.lastNumberString isEqualToString:self.mcTextView.text]&&isShowHud) {
            [SVProgressHUD showErrorWithStatus:@"未发现错误号！"];
        }else{
            _AModel= [self.mcTextView.text MC_delWrongLottoryNumberWithWF:self.baseWFmodel andShow:isShowHud];
        }
    }else{
        _AModel= [self.mcTextView.text MC_delWrongLottoryNumberWithWF:self.baseWFmodel andShow:isShowHud];
    }
    self.lastNumberString = self.mcTextView.text;
    
    self.numberDelWrongStringArr =_AModel.arr_Result;
    if (_AModel.arr_Wrong.count<1) {
    }else{
        NSString * tip=[NSString stringWithFormat:@"错误的号码,已经帮您过滤:%@",[_AModel.arr_Wrong componentsJoinedByString:@","]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate=self;
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    if ([self.baseWFmodel.lotteryCategories isEqualToString:@"esf"]||[self.baseWFmodel.lotteryCategories isEqualToString:@"pks"]) {
        self.mcTextView.text = [self.numberDelWrongStringArr componentsJoinedByString:@","];
    }else{
        self.mcTextView.text = [self.numberDelWrongStringArr componentsJoinedByString:@" "];
    }
    
    self.baseWFmodel.danShiArray = _AModel.arr_Result;
    if (_AModel.arr_Result.count>0) {
        self.baseWFmodel.danShiArray = self.numberDelWrongStringArr;
        MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"danshiModel":model}];
    }
    return _AModel;
}
#pragma mark-点击去重处理
- (void)delRepeatNumber{
    
    //校验格式
    self.mcTextView.text = [NSString GetFormatStr:self.mcTextView.text WithModel:self.baseWFmodel];
    
    if (self.lastNumberString.length>0 && _AModel.Do_Repart) {
        if ([self.lastNumberString isEqualToString:self.mcTextView.text]) {
            [SVProgressHUD showErrorWithStatus:@"未发现重复号！"];
        }else{
            _AModel=[self.mcTextView.text MC_delRepartLottoryNumberInStringmodel:self.baseWFmodel];
        }
    }else{
        _AModel=[self.mcTextView.text MC_delRepartLottoryNumberInStringmodel:self.baseWFmodel];
    }
    self.lastNumberString = self.mcTextView.text;
    if (_AModel.arr_Repart.count>0) {
        NSString * tip=[NSString stringWithFormat:@"重复的号码,已经帮您过滤:%@",[_AModel.arr_Repart componentsJoinedByString:@","]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate=self;
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    
    
    if ([self.baseWFmodel.lotteryCategories isEqualToString:@"esf"]||[self.baseWFmodel.lotteryCategories isEqualToString:@"pks"]) {
        self.mcTextView.text = [_AModel.arr_Result componentsJoinedByString:@","];
    }else{
        self.mcTextView.text = [_AModel.arr_Result componentsJoinedByString:@" "];
    }
    
    if (_AModel.arr_Wrong.count>0) {
        
    }else{
        if (_AModel.arr_Result.count>0) {
            self.baseWFmodel.danShiArray = _AModel.arr_Result;
            MCBallPropertyModel *model =  [MCStakeUntits GetBallPropertyWithWFModel:self.baseWFmodel];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_GETBALL_WF" object:nil userInfo:@{@"danshiModel":model}];
        }
    }
    
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    
}
/*
 * 单式  添加号码 调用检测
 */
-(BOOL)danShiaddNumber:(BOOL)isShow{
    
    //获取切割数组
    NSArray *arr0 = [NSString splitStringByDiffrentSplitMarkInString:self.mcTextView.text andModel:self.baseWFmodel];
    //获取去错数组
    MCArryModel*AModel= [self.mcTextView.text MC_delWrongLottoryNumberWithWF:self.baseWFmodel andShow:NO];
    
    if ((arr0.count<1||arr0==nil)) {
        if (isShow) {
            [SVProgressHUD showErrorWithStatus:@"请至少选择1注号码！"];
        }
        return NO;
    }
    
    //防止用户输入全部都是空格
    if (arr0.count==1&&[NSString isEmpty:self.mcTextView.text]) {
        if (isShow) {
            [SVProgressHUD showErrorWithStatus:@"请至少选择1注号码！"];
        }
        return NO;
    }
    if (AModel.arr_Wrong.count>0) {
        if (isShow) {
            [SVProgressHUD showErrorWithStatus:@"请先去除错误！"];
        }
        return NO;
    }
    
    self.baseWFmodel.danShiArray = AModel.arr_Result;
    return YES;
    
}


#pragma mark - getter and setter

/** 暂未使用*/
- (void)setLotteriesType:(NSString *)lotteriesType{
    
    
    _lotteriesType = lotteriesType;
    
    
    NSString *str = [MCLotteryID getLotteryCategoriesTypeNameByID:lotteriesType];
    if ([str isEqualToString:@"ssc"]) {
        self.lineCount = 5;
        
    } else if ([str isEqualToString:@"esf"]){
        self.lineCount = 5;
        
    }else{
        self.lineCount = 5;
    }
    
    
}
/** 取消高亮*/
- (void)setHighlighted:(BOOL)highlighted{}
/** 取消选中事件*/
- (void)setSelected:(BOOL)selected{}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)setRandomNumber:(NSNumber *)randomNumber{
    _randomNumber = randomNumber;
    for (NSInteger i = 0; i<self.ballArray.count; i++) {
        if ([self.randomNumber intValue] - 1 == i) {
            MCBallCollectionModel *model = self.ballArray[i];
            model.seleted = YES;
            
        }
    }
    [self.ballColletionView reloadData];
    
}

- (void)setBallCellTextInfo:(MCBasePWFModel *)baseWFmodel{
    if (![baseWFmodel.isAddZero isEqualToString:@"1"]) {
        for (NSInteger i = [baseWFmodel.ballStartNumber intValue]; i<= [baseWFmodel.ballEndNumber intValue]; i++) {
            NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
            MCBallCollectionModel *model = [[MCBallCollectionModel alloc] init];
            model.textInfo = str;
            model.mutex = baseWFmodel.mutex;
            [self.ballArray addObject:model];
        }
    } else {
        for (NSInteger i = [baseWFmodel.ballStartNumber intValue]; i<= [baseWFmodel.ballEndNumber intValue]; i++) {
            NSString *str = [NSString stringWithFormat:@"%.2ld",(long)i];
            MCBallCollectionModel *model = [[MCBallCollectionModel alloc] init];
            model.textInfo = str;
            model.mutex = baseWFmodel.mutex;
            [self.ballArray addObject:model];
        }
    }
    
}
- (void)setBallCellTextInfoWithBallText:(MCBasePWFModel *)baseWFmodel{
    NSArray *arrStr = [baseWFmodel.ballText componentsSeparatedByString:@"、"];
    for (NSString *title in arrStr) {
        MCBallCollectionModel *model = [[MCBallCollectionModel alloc] init];
        model.textInfo = title;
        model.mutex = self.baseWFmodel.mutex;
        [self.ballArray addObject:model];
        
    }
}
- (NSString *)iconName:(NSString *)info{
    
    if ([info containsString:@"万位"]) {
        return @"wan";
    } else if ([info containsString:@"千位"]) {
        return @"qian";
    } else if ([info containsString:@"百位"]) {
        return @"bai";
    } else if ([info containsString:@"十位"]) {
        return @"shi";
    } else if ([info containsString:@"个位"]) {
        return @"ge";
    } else if ([info containsString:@"胆"]) {
        return @"dan";
    } else if ([info containsString:@"拖"]) {
        return @"tuo";
    } else if ([info containsString:@"第一位"]) {
        return @"yiwei";
    } else if ([info containsString:@"第二位"]) {
        return @"erwei";
    } else if ([info containsString:@"第三位"]) {
        return @"sanwei";
    } else if ([info containsString:@"第四位"]) {
        return @"siwei";
    } else if ([info containsString:@"第五位"]) {
        return @"wuwei";
    } else if ([info containsString:@"第六位"]) {
        return @"liuwei";
    } else if ([info containsString:@"第七位"]) {
        return @"qiwei";
    } else if ([info containsString:@"第八位"]) {
        return @"bawei";
    } else if ([info containsString:@"冠军"]) {
        return @"guanjun";
    } else if ([info containsString:@"亚军"]) {
        return @"yajun";
    } else if ([info containsString:@"季军"]) {
        return @"jijun";
    } else if ([info containsString:@"第四名"]) {
        return @"sim";
    } else if ([info containsString:@"第五名"]) {
        return @"wum";
    } else if ([info containsString:@"第六名"]) {
        return @"lium";
    } else if ([info containsString:@"第七名"]) {
        return @"qim";
    } else if ([info containsString:@"第八名"]) {
        return @"bam";
    } else if ([info containsString:@"第九名"]) {
        return @"jium";
    } else if ([info containsString:@"第十名"]) {
        return @"shim";
    } else if ([info containsString:@"不同号"]) {
        return @"butong";
    } else if ([info containsString:@"同号"]) {
        return @"tongh";
    } else if ([info containsString:@"四重号"]) {
        return @"sichong";
    } else if ([info containsString:@"三重号"]) {
        return @"sanchong";
    } else if ([info containsString:@"二重号"]) {
        return @"erchong";
    } else if ([info containsString:@"单号"]) {
        return @"danh";
    } else if ([info containsString:@"上(01-40)"]||[info containsString:@"可选2"]||[info containsString:@"可选3"]||[info containsString:@"可选4"]||[info containsString:@"可选5"]||[info containsString:@"可选6"]||[info containsString:@"可选7"]) {
        return @"shang_xia";
    } else if ([info containsString:@"下"]) {
        return @"xia";
    } else if ([info containsString:@"中"]) {
        return @"zhong";
    } else if ([info containsString:@"二中二"]) {
        return @"erer";
    } else if ([info containsString:@"三中三"]) {
        return @"sansan";
    } else if ([info containsString:@"四中四"]) {
        return @"sisi";
    }else if ([info containsString:@"上下"]) {
        return @"shang_xia";
    }
    return @"";
}

- (void)setBaseWFmodel:(MCBasePWFModel *)baseWFmodel{
    _baseWFmodel = baseWFmodel;
    
    if (self.ballArray.count != 0) {
        return;
    }
    if ([baseWFmodel.ballText isEqualToString:@""] ) {
        [self setBallCellTextInfo:baseWFmodel];
    } else {
        if ([baseWFmodel.tongxuan isEqualToString:@"2"]) {
            if ([self.dataSource.danma isEqualToString:@"9"]) {
                [self setBallCellTextInfoWithBallText:baseWFmodel];
                
            } else {
                [self setBallCellTextInfo:baseWFmodel];
            }
        }else{
            [self setBallCellTextInfoWithBallText:baseWFmodel];
        }
      
    }
    
#warning mark -- 优化
    [self.filterArray removeAllObjects];
    NSArray *arr = nil;
    if ([self.baseWFmodel.lotteryCategories isEqualToString:@"kl8"]) {
        arr = @[@"全",@"上",@"下",@"奇",@"偶",@"清"];
    } else {
        arr = @[@"全",@"大",@"小",@"奇",@"偶",@"清"];
    }
    for (NSInteger i = 0; i< arr.count; i++) {
        MCfilterBallModel *model = [[MCfilterBallModel alloc] init];
        model.info = arr[i];
        model.selected = NO;
        [self.filterArray addObject:model];
    }
    self.infoDanShiLabel.text = baseWFmodel.info;
    self.view_selectedCard.dataSource=baseWFmodel; 
    [self setNeedsUpdateConstraints];
    
    
}
- (void)setDataSource:(MCItemModel *)dataSource{
    
    _dataSource = dataSource;
//    self.infoLabel.text = dataSource.info;
    self.iconImgeV.image = [UIImage imageNamed:[self iconName:dataSource.info]];
}

- (NSMutableArray *)selectedBallArray{
    
    if (_selectedBallArray == nil) {
        _selectedBallArray = [NSMutableArray array];
    }
    return _selectedBallArray;
}

- (NSMutableArray *)filterArray{
    
    if (_filterArray == nil) {
        _filterArray = [NSMutableArray array];
        
    }
    return _filterArray;
}

- (NSMutableArray *)ballArray{
    
    if (_ballArray == nil) {
        _ballArray = [NSMutableArray array];
    }
    
    return _ballArray;
}
-(MCPickNumberHeaderView *)view_selectedCard{
    if (!_view_selectedCard) {
        _view_selectedCard=[[MCPickNumberHeaderView alloc]init];
        _view_selectedCard.dataSource=self.baseWFmodel;
    }
    return _view_selectedCard;
}
- (void)dealloc{
    
    NSLog(@"MCLotteryHalllPickTableViewCell -- dealloc");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
