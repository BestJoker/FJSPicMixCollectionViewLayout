//
//  MyCollectionViewCell.m
//  练习
//
//  Created by 付金诗 on 16/4/11.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView.backgroundColor = [UIColor orangeColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
        
        
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.textAlignment = 1;
        self.label.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.label];
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:self.contentView.bounds];
    [self.label setFrame:self.contentView.bounds];
}




@end
