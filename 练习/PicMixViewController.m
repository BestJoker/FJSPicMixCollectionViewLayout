//
//  PicMixViewController.m
//  练习
//
//  Created by 付金诗 on 16/4/13.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "PicMixViewController.h"
#import "FJSPicMixCollectionViewLayout.h"
#import "FJSPicCenterMaxCollectionViewFlowLayout.h"
#import "FJSWaterFlowCollectionViewFlowLayout.h"
#import "FJSWaterFlowMixCollectionViewFlowLayout.h"
#import "BQImageModel.h"
#import "MyCollectionViewCell.h"
@interface PicMixViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UICollectionViewFlowLayout * flowLayuot;
@end

@implementation PicMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (self.type) {
        case 0:
        {
            self.flowLayuot = [[FJSPicMixCollectionViewLayout alloc] init];
            self.flowLayuot.minimumLineSpacing = 1;
            self.flowLayuot.minimumInteritemSpacing = 1;
            self.flowLayuot.sectionInset = UIEdgeInsetsZero;
        }
            break;
        case 1:
        {
            self.flowLayuot = [[FJSPicCenterMaxCollectionViewFlowLayout alloc] init];            
        }
            break;
        case 2:
        {
            self.flowLayuot = [[FJSWaterFlowCollectionViewFlowLayout alloc] init];
            ((FJSWaterFlowCollectionViewFlowLayout *)self.flowLayuot).ColOfPortrait = 3;
            ((FJSWaterFlowCollectionViewFlowLayout *)self.flowLayuot).ColOfLandscape = 4;
        }
            break;
        case 3:
        {
            self.flowLayuot = [[FJSWaterFlowMixCollectionViewFlowLayout alloc] init];
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).ColOfPortrait = 3;
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).ColOfLandscape = 4;
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).DoubleColumnProbality = 20;
        }
            break;
        default:
            break;
    }
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayuot];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    [self getImageDataArray];
    
}


- (void)getImageDataArray
{
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 30; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]];
        BQImageModel * imageModel = [[BQImageModel alloc] init];
        imageModel.image = image;
        //图片原来尺寸比较大,为了能够出现一行多张,所以处理了图片的宽度进行模拟.
        imageModel.width = image.size.width / 5.0f;
        imageModel.height = image.size.height / 5.0f;
        imageModel.whScale = image.size.width / image.size.height;
        //        NSLog(@"width == %f***height == %fwhScale===%f",imageModel.width,imageModel.height,imageModel.whScale);
        [self.dataArray addObject:imageModel];
    }
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.dataArray];
    [array addObjectsFromArray:self.dataArray];
    [array addObjectsFromArray:self.dataArray];
    self.dataArray = array;
    
    switch (self.type) {
        case 0:
        {
            ((FJSPicMixCollectionViewLayout *)self.flowLayuot).modelArray = self.dataArray;
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            ((FJSWaterFlowCollectionViewFlowLayout *)self.flowLayuot).modelArray = self.dataArray;
        }
            break;
        case 3:
        {
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).modelArray = self.dataArray;
        }
            break;
        default:
            break;
    }
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    BQImageModel * model = [self.dataArray objectAtIndex:indexPath.item];
    cell.imageView.image = model.image;
    //    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
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
