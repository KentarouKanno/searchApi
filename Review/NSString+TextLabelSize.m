//
//  NSString+TextLabelSize.m
//  Review
//
//  Created by KentarOu on 2014/08/20.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "NSString+TextLabelSize.h"

@implementation NSString (TextLabelSize)

- (CGRect)getTextFrameWithFont:(UIFont *)font label:(UILabel *)label padding:(CGFloat)padding {
    
    CGSize size;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        //OS7
        NSDictionary *attributeDic = @{NSFontAttributeName:font};
        size = [self boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                               attributes:attributeDic
                                  context:nil].size;
        size.height++;
    }
    else {
        //OS6以下
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX)];
    }
    
    CGRect frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, size.height + padding);
    
    return frame;
}

- (CGSize)getTextSizeWithFont:(UIFont *)font viewWidth:(CGFloat)viewWidth padding:(CGFloat)padding {
    
    CGSize size;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        //OS7
        NSDictionary *attributeDic = @{NSFontAttributeName:font};
        size = [self boundingRectWithSize:CGSizeMake(viewWidth, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                               attributes:attributeDic
                                  context:nil].size;
      //  size.height += 1;
    }
    else {
        //OS6以下
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(viewWidth, CGFLOAT_MAX)];
    }
    
    size.height += padding;
    
    return size;
}

@end
