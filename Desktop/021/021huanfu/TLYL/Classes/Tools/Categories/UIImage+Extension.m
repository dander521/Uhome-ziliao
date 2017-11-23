//
//  UIImage+MCOriginal.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)originalImageFromImageNamed:(NSString *)imageName{
    
    UIImage *image =  [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}





+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/**给圆角*/
- (UIImage *)drawRectWithRoundedCorner:(CGFloat)radius size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [newImage imageAntialias];
    [newImage imageAntialias];
    
    return newImage;
}

/***/

+ (UIImage *)imageWithBorderW:(CGFloat)borderWH borderColor:(UIColor *)color image:(UIImage *)image{
        
        CGSize size = CGSizeMake(image.size.width + 32 * borderWH, image.size.height + 32 * borderWH);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
        [color set];
        [path stroke];
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWH, borderWH, image.size.width, image.size.height)];
        [path addClip];
        [image drawAtPoint:CGPointMake(borderWH, borderWH)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [newImage imageAntialias];
        [newImage imageAntialias];
        return newImage;
        
    }



/**抗锯齿*/
- (UIImage *)imageAntialias
{
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, self.size.width-2*border, self.size.height-2*border);
    
    UIImage *img = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

//将文字添加到图片上

+ (UIImage*)drawTextToImage:(NSString*)text addToView:(UIImage*)image{
    
    //设置字体样式
    
    UIFont*font = [UIFont systemFontOfSize:16];
    
    NSDictionary*dict =@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    CGSize textSize = [text sizeWithAttributes:dict];
    
    //绘制上下文
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
    
    int borderY =5;
    int borderX =8;
    
    CGRect re = {CGPointMake(image.size.width- textSize.width- borderX, image.size.height- textSize.height- borderY), textSize};
    
    //此方法必须写在上下文才生效
    
    [text drawInRect:re withAttributes:dict];
    
    UIImage*newImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
@end
