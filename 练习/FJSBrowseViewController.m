//
//  FJSBrowseViewController.m
//  练习
//
//  Created by 付金诗 on 16/4/17.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSBrowseViewController.h"
#import "PicBrowseCollectionViewCell.h"
#import "UICollectionView+FJSIndexPath.h"
@interface FJSBrowseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UICollectionViewFlowLayout * flowLayuot;
@end

@implementation FJSBrowseViewController

- (instancetype)initModelArray:(NSMutableArray *)modelArray
{
    self = [super init];
    if (self) {
        self.dataArray = modelArray;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.flowLayuot = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayuot.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayuot.itemSize = CGSizeMake(ScreenWidth, ScreenHeight);
    self.flowLayuot.sectionInset = UIEdgeInsetsZero;
    self.flowLayuot.minimumLineSpacing = 0;
    self.flowLayuot.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayuot];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[PicBrowseCollectionViewCell class] forCellWithReuseIdentifier:@"PicBrowseCollectionViewCell"];
    [self.view addSubview:self.collectionView];

    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, 30, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(aaaaaaa:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)aaaaaaa:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PicBrowseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PicBrowseCollectionViewCell" forIndexPath:indexPath];
    BQImageModel * model = [self.dataArray objectAtIndex:indexPath.item];
    [cell getValueFromBQImageModel:model];
//    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (UICollectionView *)transitionCollectionView
{
    return self.collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
