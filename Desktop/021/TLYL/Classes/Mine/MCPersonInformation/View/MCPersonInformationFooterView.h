//
//  MCPersonInformationFooterView.h
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCPersonInformationFooterDelegate <NSObject>
@required
/*
 *  保存
 */
-(void)savePersonalInformation;

@end

@interface MCPersonInformationFooterView : UIView

@property (nonatomic, weak) id<MCPersonInformationFooterDelegate>delegate;

+(CGFloat)computeHeight:(id)info;

-(void)relayOutUI;
@end
