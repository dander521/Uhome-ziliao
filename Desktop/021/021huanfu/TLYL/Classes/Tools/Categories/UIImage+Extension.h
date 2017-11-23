//
//  UIImage+MCOriginal.h
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)originalImageFromImageNamed:(NSString *)imageName;

+ (UIImage*) createImageWithColor:(UIColor*) color;

- (UIImage *)drawRectWithRoundedCorner:(CGFloat)radius size:(CGSize)size;

+ (UIImage *)imageWithBorderW:(CGFloat)borderWH borderColor:(UIColor *)color image:(UIImage *)image;
+ (UIImage*)drawTextToImage:(NSString*)text addToView:(UIImage*)image;

@end

