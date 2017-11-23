//
//  MCChoiceMesPersonViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCChoiceMesPersonViewController.h"
#import "MCMesSendPersonTableViewCell.h"
#import "MCEmailAllModel.h"
#import <MJRefresh/MJRefresh.h>

@interface MCChoiceMesPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
// 上级的小圆圈
@property (nonatomic,weak) UIImageView *imageV;
//A~~~Z 数据源
@property (nonatomic,strong) NSArray *sectionArray;
// tableview 数据
@property (nonatomic,strong) NSMutableArray *dataArray;
// tableview 数据
@property (nonatomic,strong) NSMutableArray *dataStatusArray;
// search   tableview 数据
@property (nonatomic,strong) NSMutableArray *selectedArray;
// 选择的   tableview 数据
@property (nonatomic,strong) NSMutableArray *searchArray;
// 发送请求的model
@property (nonatomic,strong) MCEmailAllModel *allModel;
// tableview
@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,weak) UIButton *btn;

@end

@implementation MCChoiceMesPersonViewController
- (NSMutableArray *)titleArray{
    
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (NSMutableArray *)dataStatusArray{
    
    if (_dataStatusArray == nil) {
        _dataStatusArray = [NSMutableArray array];
    }
    return _dataStatusArray;
}
- (NSMutableArray *)searchArray{
    
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(231, 231, 231);
    self.navigationItem.title = @"选择收件人";
    [self addNavRightBtn];
    [self setUpUI];
   [self loadListData];

   
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
 
}

- (void)loadData{
    [super loadData];
    [self loadListData];
}

#pragma mark -- set UI
- (void)addNavRightBtn {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(18)];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *baseSc = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:baseSc];
    baseSc.backgroundColor = RGB(231, 231, 231);
  
    UIButton *upBtn = [[UIButton alloc] init];
    [baseSc addSubview:upBtn];
    upBtn.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(53));
    upBtn.backgroundColor = [UIColor whiteColor];
    [upBtn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    upBtn.layer.cornerRadius = 6;
    upBtn.clipsToBounds = YES;
    UILabel *upTitleLabel = [[UILabel alloc] init];
    [upBtn addSubview:upTitleLabel];
    upTitleLabel.text = @"上级";
    upTitleLabel.textColor = RGB(46, 46, 46);
    upTitleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    upTitleLabel.frame = CGRectMake(MC_REALVALUE(20), MC_REALVALUE(20), MC_REALVALUE(30), MC_REALVALUE(15));
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"zhwxz"];
    [upBtn addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(upBtn).offset(MC_REALVALUE(-20));
        make.centerY.equalTo(upTitleLabel);
        make.height.width.equalTo(@(MC_REALVALUE(15)));
    }];
    self.imageV = imageV;

    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [baseSc addSubview:searchBar];
    searchBar.layer.cornerRadius = MC_REALVALUE(15);
    searchBar.clipsToBounds = YES;
    searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchBar = searchBar;
    // 设置SearchBar的颜色主题为白色
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.delegate = self;
    [searchBar setImage:[UIImage imageNamed:@"tx"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *searchField = [searchBar valueForKey:@"searchField"];
    if (searchField) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.frame = CGRectMake(0, 0, MC_REALVALUE(18), MC_REALVALUE(18));
        searchField.leftView = imgV;
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{NSForegroundColorAttributeName : RGB(191, 191, 191),NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(14)]}];
    }
    

    searchBar.barTintColor = RGB(191, 191, 191);
    searchBar.backgroundColor = [UIColor whiteColor];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(upBtn);
        make.top.equalTo(upBtn.mas_bottom).offset(MC_REALVALUE(14));
        make.height.equalTo(@(MC_REALVALUE(30)));
    }];
    
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(119) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT - 64 - MC_REALVALUE(132)) style:UITableViewStylePlain];
    [baseSc addSubview:tab];
    tab.dataSource = self;
    tab.delegate = self;
    [tab registerClass:[MCMesSendPersonTableViewCell class] forCellReuseIdentifier:@"cell"];
    tab.layer.cornerRadius = 6;
    tab.clipsToBounds = YES;
    tab.sectionIndexColor = RGB(67, 67, 67);
    self.tableView = tab;
    self.sectionArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UserLevel"] intValue] == 1) {
        [upBtn removeFromSuperview];
        [searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tab);
            make.top.equalTo(self.view).offset(MC_REALVALUE(13) + 64);
            make.height.equalTo(@(MC_REALVALUE(30)));
        }];

        tab.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(119) + 64 - MC_REALVALUE(66), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT - 64 - MC_REALVALUE(132) + MC_REALVALUE(66));
    }

}



////对数据进行排序 汉字转拼音
- (NSArray *)sortArrayBySendPersonName:(NSArray *)data{
    return [data sortedArrayUsingComparator:^NSComparisonResult(MCEmailAllModel *p1, MCEmailAllModel *p2) {
        bool result = YES;
        CFMutableStringRef  str1 =CFStringCreateMutableCopy(NULL, 0, (__bridge CFStringRef)(p1.ChildUserName));
        CFMutableStringRef  str2 =CFStringCreateMutableCopy(NULL, 0, (__bridge CFStringRef)(p2.ChildUserName));
        bool b1 = CFStringTransform(str1, NULL, kCFStringTransformStripDiacritics,NO);
        bool b2 = CFStringTransform(str2, NULL, kCFStringTransformStripDiacritics,NO);
        if ( b1 && b2) {
           NSComparisonResult  r = [(__bridge NSString *)(str1) compare:(__bridge NSString *)(str2)];
           
            if (r == NSOrderedAscending) {
                result = NO;
            } else {
                result = YES;
            }
        }else{
          NSComparisonResult  r =  [p1.ChildUserName compare:p2.ChildUserName];
            if (r == NSOrderedAscending) {
                result = NO;
            } else {
                result = YES;
            }
        }
        return result;
    }];
    
}


//对字符串进行判断，A~Z之外的字符开头字符串全部归为Z之后
- (BOOL)sortTitles:(NSString *)str1 andStr2:(NSString *)str2{
     bool result = YES;
    bool b1 = [[str1 substringToIndex:1].uppercaseString compare:@"A"] == NSOrderedAscending ? NO : YES;
    bool b2 = [[str2 substringToIndex:1].uppercaseString compare:@"A"] == NSOrderedAscending ? NO : YES;
    if (b1 && b2) {
        NSComparisonResult  r = [str1 compare:str2];
        if (r == NSOrderedAscending) {
            result = NO;
        } else {
            result = YES;
        }
        return result;
    }
    NSString *strT1 = [self judgeAZ:str1];
    NSString *strT2 = [self judgeAZ:str2];
    NSComparisonResult  r = [strT1 compare:strT2];
    if (r == NSOrderedDescending) {
        result = NO;
    } else {
        result = YES;
    }
    return result;
}

- (NSString *)judgeAZ:(NSString *)str{
   
    NSComparisonResult  r = [[str substringToIndex:1].uppercaseString compare:@"A"];
    if (r == NSOrderedDescending) {
        return [str substringToIndex:1];
    } else {
      return @"[";
    }
}


#pragma mark --发送请求
-(void)loadListData{
    
    __weak typeof(self) weakself = self;
    MCEmailAllModel *allModel = [[MCEmailAllModel alloc] init];
    self.allModel = allModel;
    [allModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    allModel.callBackSuccessBlock = ^(NSDictionary *manager) {
        [weakself tableViewEndRefreshing];
        [BKIndicationView dismiss];
        
        NSArray *arr = [MCEmailAllModel mj_objectArrayWithKeyValuesArray:manager];
        NSArray *arrM =  [self sortArrayBySendPersonName:arr];
       NSArray * arrMT =  [arrM sortedArrayUsingComparator:^NSComparisonResult(MCEmailAllModel *p1, MCEmailAllModel *p2) {
            return [self sortTitles:p1.ChildUserName andStr2:p2.ChildUserName];
        }];
        NSMutableArray *mutableArr = [NSMutableArray array];
        for (MCEmailAllModel *m in arrMT) {
          NSString *title = [m.ChildUserName substringToIndex:1].uppercaseString;
            if (![mutableArr containsObject:title]) {
                 [mutableArr addObject:title];
            }
        }
        
        self.titleArray =mutableArr;
        MCEmailAllModel *model = [[MCEmailAllModel alloc] init];
        model.ChildUserName = @"选择全部下级";
        [weakself.dataArray addObject:model];
        [weakself.dataArray addObjectsFromArray:arrMT];
        [weakself.dataStatusArray addObjectsFromArray:arrMT];
        
        if (weakself.dataArray.count == 1) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
       
        if (MC_REALVALUE(65) *weakself.dataArray.count <= G_SCREENHEIGHT - 26 -64 -49) {
            weakself.tableView.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(65) *weakself.dataArray.count );
        }
        [weakself.tableView reloadData];
    };
    allModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [BKIndicationView dismiss];
        [weakself tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakself.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakself.errNetWin setHidden:NO];
            }
        } else {
            [weakself.errDataWin setHidden:NO];
        }
        
        [SVProgressHUD dismiss];
    };
    
}

- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCMesSendPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    __weak typeof(self) weakself = self;
    cell.selectedAllSubBlock = ^(BOOL selsected){
        if (selsected == YES) {
            for (MCEmailAllModel *m in weakself.dataArray) {
                m.selected = YES;
            }
        } else {
            for (MCEmailAllModel *m in weakself.dataArray) {
                m.selected = NO;
            }
        }
       
        [tableView reloadData];
    };
    cell.selectedSubBlock = ^{
        [weakself.searchBar resignFirstResponder];
        
    };
     cell.dataSource = self.dataArray[indexPath.row];
    return cell;
}

//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSString *key = [self.sectionArray objectAtIndex:index];
    if (![self.titleArray containsObject:key]) {
        return NSNotFound;
    }else{
        
        for (NSInteger i =0 ; i<self.dataArray.count;i++) {
            MCEmailAllModel *model = self.dataArray[i];
            if ([[model.ChildUserName substringToIndex:1].uppercaseString isEqualToString:key]){
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                [tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
                break;
            }
        }
        
        return index;
    }
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   
    //需要事先清空存放搜索结果的数组
    [self.searchArray removeAllObjects];
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    //这里最好放在数据库里面再进行搜索，效率会更快一些
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        if (searchText!=nil && searchText.length>0) {
            //遍历需要搜索的所有内容，其中self.dataArray为存放总数据的数组
            for (MCEmailAllModel *model in self.dataStatusArray) {
                NSString *tempStr = model.ChildUserName;
                //----------->把所有的搜索结果转成成拼音
                NSString *pinyin = [self transformToPinyin:tempStr];
                if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                    //把搜索结果存放self.resultArray数组
                    [self.searchArray addObject:model];
                }
            }
        }else{
            self.searchArray = [NSMutableArray arrayWithArray:self.dataStatusArray];
            
        }
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataArray = self.searchArray;
            [self.tableView reloadData];
        });
    });
}
- (NSString *)transformToPinyin:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];
                //区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    NSMutableString *initialStr = [NSMutableString new];
    //拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    return allString;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   [searchBar resignFirstResponder];
}



-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
- (void)upBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        self.imageV.image = [UIImage imageNamed:@"zhxz"];
    } else {
        self.imageV.image = [UIImage imageNamed:@"zhwxz"];
    }
    self.btn = btn;
}
- (void)allBtnClick{
    for (MCEmailAllModel *model in self.dataStatusArray) {
        
        if (model.selected == YES && ![self.selectedArray containsObject:model]) {

            [self.selectedArray addObject:model];
        }
        if (model.selected == NO && [self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
        }
    }
   
    if (self.selectedPersonBlock) {
        self.selectedPersonBlock(self.selectedArray,self.btn.selected);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _dataArray = arr;
    }
    return _dataArray;
    
}
- (NSMutableArray *)selectedArray{
    if (_selectedArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _selectedArray = arr;
    }
    return _selectedArray;
}
@end
