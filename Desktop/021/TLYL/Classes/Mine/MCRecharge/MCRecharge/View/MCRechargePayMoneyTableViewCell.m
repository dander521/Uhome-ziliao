//
//  MCRechargePayMoneyTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import "MCRechargePayMoneyTableViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCRechargeCollectionViewCell.h"
#import "MCMineCellModel.h"

@interface MCRechargePayMoneyTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong) UILabel* titleLab;
@property (nonatomic,strong) NSMutableArray*cellMarr;

@property (nonatomic,strong)NSString * minRecMoney	;//此充值方式最低充值额
@property (nonatomic,strong)NSString * maxRecMoney	;//此充值方式最高充值额


@end

@implementation MCRechargePayMoneyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor  clearColor];
    
    /*
     * 请输入充值金额
     */
    _titleLab = [[UILabel alloc]init];
    _titleLab.layer.cornerRadius=5;
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.layer.masksToBounds = YES;
    _titleLab.font = [UIFont boldSystemFontOfSize:12];
    _titleLab.numberOfLines=1;
    _titleLab.textColor=RGB(102, 102, 102);
    _titleLab.text = @"充值金额:(10-50000元)";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLab];
    _titleLab.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 30);
    
    
    /*
     * 输入框
     */
    _textField = [[UITextField alloc] init];
    _textField.layer.borderColor= RGB(200, 200, 200).CGColor;
    _textField.layer.borderWidth= 1.0f;
    _textField.layer.cornerRadius=10;
    _textField.placeholder=@"请输入充值金额";
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = [UIColor blackColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self addSubview:_textField];
    _textField.frame=CGRectMake(10, 45, G_SCREENWIDTH-20, 50);
    
    
    [self addSubview:self.collectionView];
    self.collectionView.frame=CGRectMake(0, 95+25, G_SCREENWIDTH, 83);
    
    
    _cellMarr=[[NSMutableArray alloc]init];
    [_cellMarr    removeAllObjects];
    
    
    
}

-(void)textFieldDidChange:(UITextField *)textfield{
    
    if (textfield.text.length>12) {
        [textfield.text substringToIndex:12];
    }
    
    if (textfield.text.length == 1 && [textfield.text isEqualToString:@"."]) {
        textfield.text = @"0.";
    }
    NSArray *arr = [textfield.text componentsSeparatedByString:@"."];
    
    float f_num = [textfield.text floatValue];
    if (f_num>= [_maxRecMoney intValue]) {
        textfield.text =_maxRecMoney;
    }
    if (arr.count >1) {
        
        NSString *str = arr[1];
        if (str.length > 2) {
            str = [str substringWithRange:NSMakeRange(0, 2)];
        }
        textfield.text = [NSString stringWithFormat:@"%@.%@",arr[0],str];
        
        NSString * str1=arr[0];
        if ([str1 isEqualToString:_maxRecMoney]) {
            textfield.text = _maxRecMoney;
        }
    }
    
    
 

    
    
    if ([self isNum:textfield.text]>0) {
        
//        [self.collectionView  selectItemAtIndexPath:[NSIndexPath indexPathForItem:([self isNum:textfield.text]-1) inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
    }else{
        for (int i=0;i<_cellMarr.count;i++) {
            MCRechargeCollectionViewCell * cell=(MCRechargeCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [cell setSelected:NO];
        }
        
    }

}
-(int)isNum:(NSString *)num{
    float f_num = [num  floatValue];
    if (ABS(f_num-100)<0.001) {
        return 1;
    }else if (ABS(f_num-500)<0.001) {
        return 2;
    }else if (ABS(f_num-1000)<0.001){
        return 3;
    }else if (ABS(f_num-5000)<0.001){
        return 4;
    }else if (ABS(f_num-10000)<0.001){
        return 5;
    }
    return 0;
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
        [_collectionView registerClass:[MCRechargeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCRechargeCollectionViewCell class])];
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
    CollectionModel * model=self.cellMarr[section];
    return model.section_color;
}
//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.section];
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
    
    CollectionModel * model=self.cellMarr[section];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCRechargeCollectionViewCell class])]) {
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
    

    UICollectionViewCell*  cell=nil;
    CollectionModel * model=self.cellMarr[indexPath.row];
    if (model.id_dentifier) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:model.id_dentifier forIndexPath:indexPath];
    }
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCRechargeCollectionViewCell class])]) {
        
        MCRechargeCollectionViewCell *ex_cell=(MCRechargeCollectionViewCell *)cell;
        
        if (model.userInfo) {
            ex_cell.titleLab.text=model.userInfo;
//            ex_cell.dataSource=model.userInfo;
        }
        
    }
    

    return cell;
}

//didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.row];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCRechargeCollectionViewCell class])]) {
        /*
         * 选择金额
         */
        if ([self.delegate respondsToSelector:@selector(celldidSelectChooseMoney:)]) {
            [self.delegate celldidSelectChooseMoney:model.userInfo];
        }
    }
}


+(CGFloat)computeHeight:(id)info{
    
    return 200;
    
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    
    CGFloat  W= (G_SCREENWIDTH-20-27*2)/3.0;
    if (_cellMarr.count<1) {
        NSArray * arr=dataSource;
        for (int i=0; i<arr.count; i++) {
            CollectionModel * model0=[[CollectionModel alloc]init];
            model0.header_size=CGSizeMake(G_SCREENWIDTH, 40);
            model0.item_size=CGSizeMake(W, 34);
            model0.section_color=[UIColor whiteColor];
            model0.section_Edge=UIEdgeInsetsMake(0, 10, 0, 10);
            model0.interitemSpacing=0.1;
            model0.lineSpacing=10;
            model0.isHaveHeader=YES;
            model0.id_dentifier=NSStringFromClass([MCRechargeCollectionViewCell class]);
            /*
             * info
             */
            model0.userInfo=arr[i];
            [_cellMarr addObject:model0];
        }
        
        [_collectionView reloadData];
       
        /*
         * 默认选择100
         */
        [self.collectionView  selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        CollectionModel * model=self.cellMarr[0];
        _textField.text=model.userInfo;
        if ([self.delegate respondsToSelector:@selector(celldidSelectChooseMoney:)]) {
            [self.delegate celldidSelectChooseMoney:model.userInfo];
        }
    }
    
}

#pragma mark-根据选择不同的充值方式  变化充值金钱的范围
-(void)setRangeOfMoney:(MCPaymentModel *)model{
    
    _minRecMoney=model.minRecMoney;
    _maxRecMoney=model.maxRecMoney;
    
    _titleLab.text=[NSString stringWithFormat:@"充值金额:(%@-%@元)",_minRecMoney,_maxRecMoney];

    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end



















