//
//  NSString+TextLabelSize.h
//  Review
//
//  Created by KentarOu on 2014/08/20.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextLabelSize)

- (CGRect)getTextFrameWithFont:(UIFont *)font label:(UILabel *)label padding:(CGFloat)padding;
- (CGSize)getTextSizeWithFont:(UIFont *)font viewWidth:(CGFloat)viewWidth padding:(CGFloat)padding;

@end
