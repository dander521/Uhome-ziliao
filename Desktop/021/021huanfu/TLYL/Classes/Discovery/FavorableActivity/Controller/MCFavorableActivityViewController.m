//
//  MCFavorableActivityViewController.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCFavorableActivityViewController.h"
#import "MCFavorableActivityCollectionViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMineCellModel.h"
#import "UIImage+Extension.h"

#define W_CONTENT   (G_SCREENWIDTH-120)
#define H_CONTENT   (G_SCREENHEIGHT-200)
#define W_SPACE     30

@interface MCFavorableActivityViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic,strong) UICollectionView* collectionView;
@property (nonatomic,strong) NSMutableArray*cellMarr;


@end

@implementation MCFavorableActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
    
}

#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(48, 127, 207);
    self.navigationItem.title = @"优惠活动";

    
}

#pragma mark==================createUI======================
-(void)createUI{
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor=[UIColor clearColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    _cellMarr=[[NSMutableArray alloc]init];
    [_cellMarr    removeAllObjects];
}

-(void)loadData{
    
    
    
    CollectionModel * model0=[[CollectionModel alloc]init];
    model0.header_size=CGSizeMake(0.0001, 0.0001);
    model0.item_size=CGSizeMake(W_SPACE, H_CONTENT);
    model0.section_color=[UIColor clearColor];
    model0.section_Edge=UIEdgeInsetsMake(0, 0, 0, 0);
    model0.interitemSpacing=W_SPACE;
    model0.lineSpacing=50;
    model0.isHaveHeader=YES;
    model0.id_dentifier=NSStringFromClass([MCFavorableActivityBlankCell class]);
    /*
     * info
     */
    model0.userInfo=nil;
    [_cellMarr addObject:model0];
    

        for (int i=0; i<4; i++) {
            CollectionModel * model0=[[CollectionModel alloc]init];
            model0.header_size=CGSizeMake(0.0001, 0.0001);

            model0.item_size=CGSizeMake(W_CONTENT, H_CONTENT);
            model0.section_color=[UIColor clearColor];
            model0.section_Edge=UIEdgeInsetsMake(0, 0, 0, 0);
            model0.interitemSpacing=W_SPACE;
            model0.lineSpacing=50;
            model0.isHaveHeader=YES;
            model0.id_dentifier=NSStringFromClass([MCFavorableActivityCollectionViewCell class]);
            /*
             * info
             */
            model0.userInfo=nil;
            [_cellMarr addObject:model0];
        }

    
    [self.collectionView reloadData];
}


/*
 * collectionView
 */
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        [_collectionView registerClass:[MCFavorableActivityCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCFavorableActivityCollectionViewCell class])];
        [_collectionView registerClass:[MCFavorableActivityBlankCell class] forCellWithReuseIdentifier:NSStringFromClass([MCFavorableActivityBlankCell class])];
        
        
    }
    return _collectionView;
}



#pragma mark - <UICollectionViewDataSource>
//设置section的颜色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.cellMarr[section];
    return model.section_color;
}
//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionModel * model=self.cellMarr[indexPath.row];
    return model.item_size;
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.cellMarr[section];
    return model.section_Edge;
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.cellMarr[section];
    return model.interitemSpacing;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.cellMarr[section];
    return model.lineSpacing;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section==0) {
        return self.cellMarr.count;
    }
//    CollectionModel * model=self.cellMarr[section];
//    
//    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCFavorableActivityCollectionViewCell class])]) {
//        return self.cellMarr.count;
//    }
    return 0;
}

//numberOfSections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell*  cell=nil;
    CollectionModel * model=self.cellMarr[indexPath.row];
    if (model.id_dentifier) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:model.id_dentifier forIndexPath:indexPath];
    }
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCFavorableActivityCollectionViewCell class])]) {
        
        MCFavorableActivityCollectionViewCell *ex_cell=(MCFavorableActivityCollectionViewCell *)cell;
        ex_cell.dataSource=model.userInfo;
       
        
    }
    return cell;
}
#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
   
}

//可以获取到滑动结束时contentOffset坐标
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    ;

    
    
    NSLog(@"结束时的坐标--%f",scrollView.contentOffset.x);
    
    if (scrollView.contentOffset.x<=(W_SPACE*2.0+W_CONTENT/2.0)) {
        
        [_collectionView setContentOffset:CGPointMake(0, 0) animated:YES];

        
    }else if (scrollView.contentOffset.x>(W_SPACE*2.0+W_CONTENT/2.0)&&scrollView.contentOffset.x<=(W_SPACE*3.0+W_CONTENT*3/2.0)) {
        
        [_collectionView setContentOffset:CGPointMake((W_CONTENT+W_SPACE)*1, 0) animated:YES];

    }else if (scrollView.contentOffset.x>(W_SPACE*3.0+W_CONTENT*3/2.0)&&scrollView.contentOffset.x<=(W_SPACE*4.0+W_CONTENT*5/2.0)){
        [_collectionView setContentOffset:CGPointMake((W_CONTENT+W_SPACE)*2, 0) animated:YES];
        
    }else if (scrollView.contentOffset.x>(W_SPACE*4.0+W_CONTENT*4/2.0)&&scrollView.contentOffset.x<(W_SPACE*5.0+W_CONTENT*6/2.0)){
        [_collectionView setContentOffset:CGPointMake((W_CONTENT+W_SPACE)*3, 0) animated:YES];

    }

}



//可以获取到开始时的坐标
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"开始时的坐标--%f",scrollView.contentOffset.x);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
