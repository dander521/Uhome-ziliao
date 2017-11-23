//
//  MCZhuihaoTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCZhuihaoTableViewCell.h"

@interface MCZhuihaoTableViewCell()<UITextFieldDelegate>
/**checkBoxBtn*/
@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtn;
/**qihaoLabel 期号*/
@property (weak, nonatomic) IBOutlet UILabel *qihaoLabel;
/**beiShuTextField 倍数textFirld*/
@property (weak, nonatomic) IBOutlet UITextField *beiShuTextField;
/**jinELabel 金额label*/
@property (weak, nonatomic) IBOutlet UILabel *jinELabel;
/**lastCountStr 上一次数量str*/
@property (weak, nonatomic) NSString *lastCountStr;

@end

@implementation MCZhuihaoTableViewCell

- (IBAction)checkBoxClick:(UIButton *)sender {
    
    self.checkBoxBtn.selected = !sender.selected;
    self.dataSource.selected = sender.selected;
    if (self.textFiledDidSelected != nil) {
        self.dataSource.beishu = self.beiShuTextField.text;
        self.textFiledDidSelected(self.dataSource,self.lastCountStr);
    }
    
    if (self.dataSource.selected) {
        if (self.checkBoxDidSelected != nil) {
            self.dataSource.beishu = self.beiShuTextField.text;
            self.checkBoxDidSelected(self.dataSource,self.lastCountStr);
        }
    }else{
        if (self.checkBoxDidUnSelected != nil) {
            self.dataSource.beishu = self.beiShuTextField.text;
            self.checkBoxDidUnSelected(self.dataSource,self.lastCountStr);
        }
    }
    
    
    
}

- (void)awakeFromNib {

    [super awakeFromNib];
    self.qihaoLabel.textColor = RGB(119, 119, 119);
    self.beiShuTextField.layer.cornerRadius = 2;
    self.beiShuTextField.layer.borderWidth = 0.5f;
    self.beiShuTextField.layer.borderColor = RGB(119, 119, 119).CGColor;
//    [self.checkBoxBtn setTitleColor:RGB(119, 119, 119) forState:UIControlStateNormal];
//    [self.checkBoxBtn setTitleColor:RGB(119, 119, 119) forState:UIControlStateSelected];
    self.beiShuTextField.delegate = self;
    self.jinELabel.textColor = RGB(249, 84, 83);
    self.beiShuTextField.text = @"1";
    
    UILabel *beishuLabel = [[UILabel alloc] init];
    beishuLabel.text = @"倍";
    beishuLabel.font = [UIFont systemFontOfSize:12];
    beishuLabel.textColor = RGB(46, 46, 46);
    [self.beiShuTextField addSubview:beishuLabel];
    [beishuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.beiShuTextField);
        make.width.equalTo(@(20));
    }];


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
//    if (selected == YES) {
//      self.backgroundColor = RGB(255, 255, 255);
//    } else {
//        
//      self.backgroundColor = RGB(252, 247, 254);
//    }
    
   
}

- (void)setHighlighted:(BOOL)highlighted{
   
}

- (void)setDataSource:(MCZhuiHaoModel *)dataSource{
    _dataSource = dataSource;
    if (dataSource == nil) {
        return;
    }
    self.beiShuTextField.text = dataSource.beishu;
    self.checkBoxBtn.selected = dataSource.selected;
    self.qihaoLabel.text = dataSource.IssueNumber;
    if (self.textFiledDidSelected != nil) {
        dataSource.beishu = self.beiShuTextField.text;
        

        
        self.jinELabel.text = GetRealFloatNum([self.beiShuTextField.text intValue] * dataSource.typeValue);
        
        
        
        if ([self.beiShuTextField.text isEqualToString:@"0"]||[self.beiShuTextField.text isEqualToString:@""]||self.beiShuTextField.text == nil) {
            self.checkBoxBtn.selected = NO;
            self.dataSource.selected = NO;
        }
        self.textFiledDidSelected(self.dataSource,self.lastCountStr);
    }
  
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.checkBoxBtn.selected = YES;
    self.dataSource.selected = YES;
    if (self.textFiledDidBecomeFisrtR != nil) {
        self.textFiledDidBecomeFisrtR(textField.text, self.frame);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text  isEqual: @"0"] || [textField.text  isEqual: @""]) {
        self.checkBoxBtn.selected = NO;
        self.dataSource.selected = NO;
    } else {
        self.checkBoxBtn.selected = YES;
        self.dataSource.selected = YES;
    }

    if ([textField.text intValue] >= 9999) {
        textField.text = @"9999";
    }
    if (self.textFiledDidSelected != nil) {
        self.dataSource.beishu = textField.text;
        self.textFiledDidSelected(self.dataSource,self.lastCountStr);
    }
    
    self.jinELabel.text = GetRealFloatNum([self.beiShuTextField.text intValue] * self.dataSource.typeValue);

     self.lastCountStr = textField.text;
}



#pragma mark - getter and setter 

- (NSString *)lastCountStr{

    return _lastCountStr;
}
- (void)setTitle:(NSString *)title{
    _title = title;
//    [self.checkBoxBtn setTitle:title forState:UIControlStateNormal];
//    
//    [self.checkBoxBtn setTitle:title forState:UIControlStateSelected];
}
@end
