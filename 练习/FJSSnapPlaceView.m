//
//  FJSSnapPlaceView.m
//  练习
//
//  Created by 付金诗 on 16/4/17.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSSnapPlaceView.h"

@interface FJSSnapPlaceView ()
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)BQImageModel * model;
@end
@implementation FJSSnapPlaceView
- (instancetype)initWithFrame:(CGRect)frame ImageModel:(BQImageModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.image = model.image;
        [self addSubview:self.imageView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
