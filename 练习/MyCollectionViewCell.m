//
//  MyCollectionViewCell.m
//  练习
//
//  Created by 付金诗 on 16/4/11.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()
@property (nonatomic,strong)BQImageModel * model;
@end
@implementation MyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:self.contentView.bounds];
}

- (void)getValueFromBQImageModel:(BQImageModel *)model
{
    self.model = model;
    self.imageView.image = model.image;
}

-(FJSSnapPlaceView *)snapShotForTransition
{
    FJSSnapPlaceView *snapShotView = [[FJSSnapPlaceView alloc] initWithFrame:self.imageView.bounds ImageModel:self.model];
    snapShotView.backgroundColor = [UIColor greenColor];
    return snapShotView;
    
}

- (CGPoint)imageViewOringn
{
    return [self convertPoint:CGPointZero toView:nil];
}

@end
