//
//  CutOutClearView.m
//  RubyCoaoaPods
//
//  Created by IOS开发者 on 16/8/18.
//  Copyright © 2016年 IOS 李宁. All rights reserved.
//

#import "CutOutClearView.h"

@implementation CutOutClearView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.fillColor       = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        self.opaque          = NO;
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [self.fillColor setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIBezierPath *path in self.paths) {
        
        CGContextAddPath(context, path.CGPath);
        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextFillPath(context);
    }
}



@end
