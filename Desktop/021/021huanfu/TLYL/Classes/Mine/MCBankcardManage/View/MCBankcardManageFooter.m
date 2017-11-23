//
//  MCBankcardManageFooter.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBankcardManageFooter.h"
#import "MCBankcardManageTableViewCell.h"
#define TIP  @"1.只能添加同一个开户人姓名的银行卡，最多可添加5张银行卡；\n2.银行卡绑定后不能修改/删除/解绑，如需修改请联系在线客服；\n3.客服在线时间09:00-凌晨02:00"

#define FONTTIP  11

#define UILABEL_LINE_SPACE 5
#define UILABEL_Kern_SPACE 0.1
#define L_SPACE 15


@interface MCBankcardManageFooter ()

@property (nonatomic,strong)UILabel  * lab_tip;

@end
@implementation MCBankcardManageFooter
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}



-(void)createUI{
    
    self.backgroundColor=[UIColor clearColor];
    
    _lab_tip=[[UILabel alloc]init];
    _lab_tip.font=[UIFont systemFontOfSize:FONTTIP];
    [self addSubview:_lab_tip];
    _lab_tip.numberOfLines=0;
    _lab_tip.textColor=RGB(136,136,136);
    [self setLabelSpace:_lab_tip withValue:TIP withFont:[UIFont systemFontOfSize:FONTTIP]];
    
    [self layOutConstraints];
    
}

-(void)layOutConstraints{
    
    [_lab_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(L_SPACE);
        make.right.equalTo(self.mas_right).offset(-L_SPACE);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    
}

+(CGFloat)computeHeight:(NSMutableArray *)info{
    
    CGFloat min_H = [MCBankcardManageFooter getSpaceLabelHeight:TIP withFont:[UIFont systemFontOfSize:FONTTIP] withWidth:G_SCREENWIDTH-L_SPACE*2] +27 +20;
    
    CGFloat H=(G_SCREENHEIGHT - (info.count*[MCBankcardManageTableViewCell computeHeight:nil]+64));

    if (info.count<5) {
        H=H-60-20;
    }
    if (H<min_H) {
        return min_H;
    }else{
        return H;
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


//计算UILabel的高度(带有行间距的情况)
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@UILABEL_Kern_SPACE
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


@end




































