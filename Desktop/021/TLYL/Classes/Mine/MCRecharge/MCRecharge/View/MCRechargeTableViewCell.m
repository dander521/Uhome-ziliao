//
//  MCRechargeTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/9/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeTableViewCell.h"
#define UILABEL_Kern_SPACE 0.1
#define UILABEL_LINE_SPACE 5
#define TIP @"温馨提示：\n1.点击确认充值按钮后会通过手机浏览器进入充值页面；\n2.充值完成后，重新进入APP查看余额；\n3.请在15分钟内完成充值"
@interface MCRechargeTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property(nonatomic, strong)UICollectionView * selectedCollectionView;
@property (nonatomic,strong)NSString * minRecMoney	;//此充值方式最低充值额
@property (nonatomic,strong)NSString * maxRecMoney	;//此充值方式最高充值额

@end

@implementation MCRechargeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}


- (void)initView{
    self.backgroundColor=[UIColor clearColor];
    
    UIView * upView=[[UIView alloc]init];
    upView.frame=CGRectMake(0, 0, G_SCREENWIDTH, 131);
    upView.backgroundColor=[UIColor clearColor];
    [self addSubview:upView];
    
    CGFloat W = 30;
    
    UIButton * leftbtn=[[UIButton alloc]init];
    [upView addSubview:leftbtn];
    [self setBtn:leftbtn andImgName:@"MCRecharge_zuohua" andTag:1001 andText:nil];
    [leftbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(upView.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(W);
        make.width.mas_equalTo(W);
    }];
    
    UIButton * rightbtn=[[UIButton alloc]init];
    [upView addSubview:rightbtn];
    [self setBtn:rightbtn andImgName:@"MCRecharge_youhua" andTag:1002 andText:nil];
    [rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(upView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(W);
        make.width.mas_equalTo(W);
    }];
    
    [upView addSubview:self.selectedCollectionView];
    self.selectedCollectionView.backgroundColor=[UIColor clearColor];
    [self.selectedCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(upView.mas_centerY);
        make.left.equalTo(upView.mas_left).offset(50);
        make.right.equalTo(upView.mas_right).offset(-50);
        make.height.mas_equalTo(80);
    }];
    
    CGFloat down_H =100;
    
    UIView * downView = [[UIView alloc]init];
    [self addSubview:downView];
    downView.layer.cornerRadius=5;
    downView.clipsToBounds=YES;
    downView.backgroundColor=[UIColor whiteColor];
    downView.frame=CGRectMake(10, 131, G_SCREENWIDTH-20, down_H);
    
    UITextField * textField=[[UITextField alloc]init];
    [downView addSubview:textField];
    textField.frame=CGRectMake(100, 0, G_SCREENWIDTH-120, down_H/2.0);
    _textField=textField;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    textField.font=[UIFont systemFontOfSize:14];
    [textField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    //    [_textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    if (_minRecMoney&&_maxRecMoney) {
        _textField.placeholder=[NSString stringWithFormat:@"充值金额范围：%@~%@元",_minRecMoney,_maxRecMoney];
    }
    
    UILabel * lab1=[[UILabel alloc]init];
    [downView addSubview:lab1];
    lab1.frame=CGRectMake(10, 0, 60, down_H/2.0);
    [self setLab:lab1 andColor:RGB(46, 46, 46) andFont:14 andText:@"充值金额"];
    
    UIView * line=[[UIView alloc]init];
    line.frame=CGRectMake(10, down_H/2.0, G_SCREENWIDTH-20-10, 0.5);
    [downView addSubview:line];
    line.backgroundColor=RGB(213,213,213);
    
    UILabel * lab2=[[UILabel alloc]init];
    [downView addSubview:lab2];
    lab2.frame=CGRectMake(10, down_H/2.0, 60, down_H/2.0);
    [self setLab:lab2 andColor:RGB(46, 46, 46) andFont:14 andText:@"快速选择"];
    

    int i=0;
    NSArray * arr=@[@"100",@"200",@"500",@"1000"];
    for (NSString * str in arr) {
        UIButton * sbtn=[[UIButton alloc]init];
        sbtn.backgroundColor=RGB(255, 170, 47);
        sbtn.layer.cornerRadius=3;
        sbtn.clipsToBounds=YES;
        [sbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sbtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [self setBtn:sbtn andImgName:nil andTag:[str integerValue] andText:str];
        [downView addSubview:sbtn];
        CGFloat W_sbtn=(G_SCREENWIDTH-20-100-15-10)/4.0;
        sbtn.frame=CGRectMake(100+i*(W_sbtn+5),down_H/2.0+(down_H/2.0-21)/2.0 , W_sbtn, 21);
        i++;
    }
    
    UILabel * tip=[[UILabel alloc]init];
    tip.numberOfLines=0;
    [self addSubview:tip];
    [self setLab:tip andColor:RGB(136,136,136) andFont:10 andText:TIP];
    [self setLabelSpace:tip withValue:TIP withFont:[UIFont systemFontOfSize:10]];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(19);
        make.right.equalTo(self.mas_right).offset(-19);
        make.top.equalTo(downView.mas_bottom).offset(44);
    }];
}

#pragma mark-根据选择不同的充值方式  变化充值金钱的范围
-(void)setRangeOfMoney:(MCPaymentModel *)model{
    
    _minRecMoney=model.minRecMoney;
    _maxRecMoney=model.maxRecMoney;
    _textField.placeholder=[NSString stringWithFormat:@"充值金额范围：%@~%@元",_minRecMoney,_maxRecMoney];
    
}

-(void)setLab:(UILabel *)lab andColor:(UIColor*)color andFont:(CGFloat)font andText:(NSString *)text{
    lab.font = [UIFont systemFontOfSize:font];
    lab.textColor=color;
    lab.text=text;
    lab.textAlignment = NSTextAlignmentLeft;
    
}
-(void)setBtn:(UIButton *)btn andImgName:(NSString *)imgName andTag:(NSInteger)tag andText:(NSString *)text{
    btn.tag=tag;
    if (imgName) {
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    if (text) {
        [btn setTitle:text forState:UIControlStateNormal];
    }
    [btn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)action_Btn:(UIButton *)btn{
    //左边滑动
    if (btn.tag==1001) {

        NSArray * arr =[self.selectedCollectionView indexPathsForVisibleItems ];
        NSMutableArray * marr=[NSMutableArray arrayWithArray:arr];
        if (arr.count>4) {
            NSIndexPath * index=arr[0];
            for (NSIndexPath * indexP in arr) {
                if (index.row>indexP.row) {
                    index=indexP;
                }
            }
            [marr removeObject:index];
        }
        
        NSIndexPath * m_index=marr[0];
        for (NSIndexPath * indexP in marr) {
            if (m_index.row>indexP.row) {
                m_index=indexP;
            }
        }
        
        NSUInteger row =m_index.row;
        if (row>0) {
            row--;
        }
        NSIndexPath *indexPP=[NSIndexPath indexPathForRow:row inSection:m_index.section];
        
        [self.selectedCollectionView scrollToItemAtIndexPath:indexPP atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

    //右边滑动
    }else if (btn.tag==1002){
        NSArray * arr =[self.selectedCollectionView indexPathsForVisibleItems ];
        NSMutableArray * marr=[NSMutableArray arrayWithArray:arr];
        if (arr.count>4) {
            NSIndexPath * index=arr[0];
            for (NSIndexPath * indexP in arr) {
                if (index.row<indexP.row) {
                    index=indexP;
                }
            }
            [marr removeObject:index];
        }
        NSIndexPath * m_index=marr[0];
        for (NSIndexPath * indexP in marr) {
            if (m_index.row<indexP.row) {
                m_index=indexP;
            }
        }
        
        
        NSUInteger row =m_index.row;
        if (row<(self.dataSource.count-2)) {
            row++;
        }else{
            row=self.dataSource.count-1;
        }
        NSIndexPath *indexPP=[NSIndexPath indexPathForRow:row inSection:m_index.section];
        
        [self.selectedCollectionView scrollToItemAtIndexPath:indexPP atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        
    }else{
        _textField.text=[NSString stringWithFormat:@"%ld",(long)btn.tag];
    }
    
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource=dataSource;
    
    [self.selectedCollectionView reloadData];
    
    if (self.dataSource.count>0) {
        MCPaymentModel *pmodel=self.dataSource[0];
        [self setRangeOfMoney:pmodel];
        
        if ([self.delegate respondsToSelector:@selector(celldidSelectPaymentType:)]) {
            [self.delegate celldidSelectPaymentType:pmodel];
        }
        
    }
    

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
    if (_maxRecMoney.length>0) {
        if (f_num>= [_maxRecMoney intValue]) {
            textfield.text =_maxRecMoney;
        }
    }
   
    if (arr.count >1) {
        
        NSString *str = arr[1];
        if (str.length > 2) {
            str = [str substringWithRange:NSMakeRange(0, 2)];
        }
        textfield.text = [NSString stringWithFormat:@"%@.%@",arr[0],str];
        
        NSString * str1=arr[0];
        if (_maxRecMoney.length>0) {
            if ([str1 isEqualToString:_maxRecMoney]) {
                textfield.text = _maxRecMoney;
            }
        }
    }

}


+(CGFloat)computeHeight:(NSUInteger)info{
    return 345;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(UICollectionView *)selectedCollectionView{
    if (!_selectedCollectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _selectedCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _selectedCollectionView.backgroundColor=[UIColor clearColor];
        _selectedCollectionView.dataSource=self;
        _selectedCollectionView.delegate=self;
        [_selectedCollectionView registerClass:[MCRechargeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCRechargeCollectionViewCell class])];
        
    }
    return _selectedCollectionView;
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
    CGFloat W = ( G_SCREENWIDTH-50*2)/4.0;
    CGFloat H = 60 ;
    return CGSizeMake(W, H);
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataSource.count>0) {
        return self.dataSource.count;
    }
    return 0;
}

//numberOfSections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


//UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell*  cell = nil;
    if (!cell) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCRechargeCollectionViewCell class]) forIndexPath:indexPath];
    }

    
    MCRechargeCollectionViewCell *ex_cell=(MCRechargeCollectionViewCell *)cell;
    if (self.dataSource.count>indexPath.row) {
        ex_cell.dataSource=self.dataSource[indexPath.row];
    }
    
    return cell;
}
#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    MCPaymentModel * pmodel=self.dataSource[indexPath.row];
    pmodel.isSelected=YES;
    
    for (MCPaymentModel * ppmodel in self.dataSource) {
        if ([pmodel.RechargeType isEqualToString:ppmodel.RechargeType]) {
            ppmodel.isSelected=YES;
        }else{
            ppmodel.isSelected=NO;
        }
    }
    [self.selectedCollectionView reloadData];
    
    [self setRangeOfMoney:pmodel];
    
    
    /*
     * 选择付款方式
     */
    if ([self.delegate respondsToSelector:@selector(celldidSelectPaymentType:)]) {
        [self.delegate celldidSelectPaymentType:pmodel];
    }
}

//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@UILABEL_Kern_SPACE
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


@end



















