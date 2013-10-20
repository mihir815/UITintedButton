//
//  UIButton+tintImage.m
//
//  Created by Filip Stefansson.
//  Copyright (c) 2013 Filip Stefansson. All rights reserved.
//

#import "UIButton+tintImage.h"

@implementation UIButton (tintImage)


-(void)setImageTintColor:(UIColor *)color
{
    if (self.imageView.image)
        [self.imageView setImage:[self tintedImageWithColor:color image:[self.imageView image]]];
    else
        NSLog(@"%@ UIButton does not have any image to tint.", self);
}

-(void)setBackgroundTintColor:(UIColor *)color forState:(UIControlState)state
{
    if ([self backgroundImageForState:state])
        [self setBackgroundImage:[self tintedImageWithColor:color image:[self backgroundImageForState:state]] forState:state];
    else
        NSLog(@"%@ UIButton does not have any background image to tint.", self);
}

// Mod of @horsejockey's method:
// http://stackoverflow.com/a/19413033

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor image:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // draw alpha-mask
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, image.CGImage);
    
    // draw tint color, preserving alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}


@end