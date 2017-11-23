//
//  MCModifyUserImgVViewController.m
//  TLYL
//
//  Created by MC on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyUserImgVViewController.h"
#import "MCModifyUserImgVCollectionViewCell.h"
#import "MCModifyUserImgVModel.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMineInfoModel.h"
#import "MCContractMgtTool.h"

@interface MCModifyUserImgVViewController ()

<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray*cellMarr;


@property (nonatomic,strong) MCModifyUserImgVModel * modifyUserImgVModel;
@property (nonatomic,strong) MCMineInfoModel * mineInfoModel;
@property (nonatomic,assign) NSInteger selected_T;

@end

@implementation MCModifyUserImgVViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    self.title=@"修改头像";
    _cellMarr=[[NSMutableArray alloc]init];
    [_cellMarr    removeAllObjects];
}

#pragma mark==================createUI======================
-(void)createUI{
    
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor=[UIColor clearColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
   
    
}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //    [rightBtn setImage:[UIImage imageNamed:@"MCUserDefined_Sure"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
}


-(void)rightBtnAction{
    __weak __typeof(self)wself = self;
    
    if (![MCContractMgtTool GetNetworkStatus]) {
        [SVProgressHUD showInfoWithStatus:@"网络异常！"];
        return;
    }
    
    NSDictionary * dic = @{@"headIcon":[NSString stringWithFormat:@"%ld",(long)_selected_T]};

    MCModifyUserImgVModel * modifyUserImgVModel = [[MCModifyUserImgVModel alloc]initWithDic:dic];
    _modifyUserImgVModel =modifyUserImgVModel;
    [modifyUserImgVModel refreashDataAndShow];
    modifyUserImgVModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [SVProgressHUD showInfoWithStatus:@"修改失败"];
    };
    modifyUserImgVModel.callBackSuccessBlock = ^(id manager) {
        [SVProgressHUD showInfoWithStatus:@"修改成功！"];
        [wself refreshData];
        
    };

}

-(void)refreshData{
    __weak __typeof(self)wself = self;

    MCMineInfoModel * mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    self.mineInfoModel = mineInfoModel;
    mineInfoModel.HeadPortrait = [NSString stringWithFormat:@"%ld",(long)_selected_T];
    [mineInfoModel refreashDataAndShow];
    mineInfoModel.callBackSuccessBlock = ^(id manager) {
        
        wself.mineInfoModel=[MCMineInfoModel mj_objectWithKeyValues:manager];
        
    };
    
    if (self.userImgBlock) {
        self.userImgBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
 * collectionView
 */
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        [_collectionView registerClass:[MCModifyUserImgVCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCModifyUserImgVCollectionViewCell class])];
        
    }
    
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>
// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        return nil ;
    }
    return nil ;
}

//设置section的颜色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    return [UIColor clearColor];
}

//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat W = (G_SCREENWIDTH-2)/3.0;
    CGFloat H = W;
    return CGSizeMake(W,H);
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.cellMarr.count>0){
        return self.cellMarr.count;
    }
    return 0;
}

//numberOfSections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MCModifyUserImgVCollectionViewCell*  cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCModifyUserImgVCollectionViewCell class]) forIndexPath:indexPath];
    if (_cellMarr.count>0) {
        cell.dataSource=_cellMarr[indexPath.row];
    }
    return cell;
}

#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int i = 1;
    _selected_T=indexPath.row+1;
    for (MCUserImgVModel * model in _cellMarr) {
        if (i==(indexPath.row+1)) {
            model.isSelected=YES;
        }else{
            model.isSelected=NO;
        }
        i++;
    }
    [self.collectionView reloadData];

}

-(void)loadData{
    
    MCMineInfoModel * mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    _selected_T = 1;
    if (mineInfoModel.HeadPortrait.length>0) {
        _selected_T = [mineInfoModel.HeadPortrait intValue];
    }
    for (int i=1; i<31 ; i++) {
        MCUserImgVModel *model =[[MCUserImgVModel alloc]init];
        model.HeadPortrait = [NSString stringWithFormat:@"MoRenPerson_%d",i];
        if (i==_selected_T) {
            model.isSelected=YES;
        }else{
            model.isSelected=NO;
        }
        [_cellMarr addObject:model];
    }
    
    [self.collectionView reloadData];
    
}




@end
































































































