//
//  UIView+Add.m
//  练习
//
//  Created by 付金诗 on 16/4/18.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)
- (void)setOrigin:(CGPoint)o {
    CGRect rect = self.frame;
    rect.origin = o;
    self.frame = rect;
}
@end
