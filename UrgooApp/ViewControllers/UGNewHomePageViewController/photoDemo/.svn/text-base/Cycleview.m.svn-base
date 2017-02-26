//
//  Cycleview.m
//  图片轮播器
//
//  Created by Mac on 16/4/24.
//  Copyright © 2016年 闫龙. All rights reserved.
//

#import "Cycleview.h"
//#import "CycleCollection.h"


#import "CycleCollectionViewCell.h"
#import "XMHPageControl.h"
#import  "UGNewHomePageViewController.h"
#import "UGConsultantLIstViewController.h"
#import "SDCycleScrollView.h"

#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
@interface Cycleview()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic)UGNewHomePageViewController * PageViewController;
@property(strong,nonatomic) UICollectionViewFlowLayout * layout1;
@property(strong,nonatomic) UICollectionView * collection;
@property(strong,nonatomic)XMHPageControl * pageControl;
///  当前显示的索引
@property (nonatomic, assign) NSUInteger currentIndex;
///  定时器
@property (nonatomic, strong) NSTimer *timer;
@property (assign,nonatomic) int indextotle;
//@property (nonatomic, strong) UGPageControl * pageControl;
@end
@implementation Cycleview

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blueColor];
    
    return self;
    
}
-(void)setPicUrlArray:(NSArray *)picUrlArray{
    _picUrlArray = picUrlArray;
    
    NSString * intStr = [NSString stringWithFormat:@"%lu",(unsigned long)_picUrlArray.count];
    
    _indextotle = [intStr intValue];
    [self initUI];
    
    
    
}
-(void)initUI{
    _layout1 = [[UICollectionViewFlowLayout alloc]init];
    
    _layout1.itemSize = CGSizeMake(kWIDTH, self.bounds.size.height);
    //layout1.itemSize =CGRectMake(0, 100, kWIDTH, 190);
    _layout1.minimumInteritemSpacing = 0;
    _layout1.minimumLineSpacing = 0;
    
    // 设置滚动方向为水平
    _layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, self.bounds.size.height) collectionViewLayout:_layout1];
    
    _collection.backgroundColor = [UIColor whiteColor];
    self.collection.dataSource = self;
    self.collection.delegate = self;
   
    // 取消滚动进度条
    self.collection.showsHorizontalScrollIndicator = NO;
    
    // 取消弹簧效果
    self.collection.bounces = NO;
    
    // 设置分页
    self.collection.pagingEnabled = YES;
    
    [self.collection registerClass:[CycleCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    

    
    [self addSubview:self.collection];
    UIImage * image1 = [UIImage imageNamed:@"banner_nomor"];
    UIImage * image2 = [UIImage imageNamed:@"banner_select"];
    NSMutableArray * aray = [NSMutableArray arrayWithObjects:image1,image2, nil];
    _pageControl = [[XMHPageControl alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2 , 180, 100, 8) pageStyle:XMHPageControlStyleDefaoult withImageArray:aray];
    _pageControl.selectedColor = [UIColor blackColor];
    _pageControl.pageBackgroundColor = [UIColor brownColor];
    _pageControl.pageNumber = _indextotle;
    _pageControl.currentPageNumber = 0;
    [self addSubview:_pageControl];
    //[self.view addSubview:_pageControl];
    [self bringSubviewToFront:_pageControl];
    if (self.indextotle == 2) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
    
    [self startTimer];
}
///  启动定时器
- (void)startTimer {
    
   
    if ( self.timer != nil) {
        return;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

-(void)updateTimer{
    
   // NSLog(@"1");
    //获取当前显示的indexpath
    NSIndexPath * indexpath = [self.collection indexPathsForVisibleItems].lastObject;
   NSLog(@"%@",indexpath);
    if (self.indextotle == 2) {
          NSIndexPath * indexpath = [self.collection indexPathsForVisibleItems].firstObject;
        NSLog(@"%@",[self.collection indexPathsForVisibleItems]);
        
        
        NSLog(@"%ld",(long)indexpath.row);
      
            
            indexpath = [NSIndexPath indexPathForItem:indexpath.item   inSection:indexpath.section];
            
        
        
        [self.collection scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else{
        
        indexpath = [NSIndexPath indexPathForItem:indexpath.item + 1 inSection:indexpath.section];
        
        [self.collection scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

        
        
    }
    NSLog(@"%@",indexpath);
    //滚动到下一界面
    // 动画结束后调用滚动停止方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidEndDecelerating:self.collection];
    });

}
-(void)returnText:(ClickBannerBlock)block{
    self.bannerBlock = block;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath *firstIndexPath = [self.collection indexPathsForSelectedItems].lastObject ;
   // NSIndexPath *indexPath = [self.collection indexPathForRowAtPoint: currentTouchPosition];
    
    
    self.bannerBlock(self.pageControl.currentPageNumber);
    
//    if (self.pageControl.currentPageNumber == 0 ) {
//        NSLog(@"点击了 0");
//        
//        
//    }else if (self.pageControl.currentPageNumber == 1){
//         NSLog(@"点击了 1");
//    }else if (self.pageControl.currentPageNumber == 2){
//        NSLog(@"dianji 2");
//    }else if (self.pageControl.currentPageNumber == 3){
//        
//        
//        NSLog(@"点击了 4");
//    }
   
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int offset = scrollView.contentOffset.x / scrollView.bounds.size.width-1;
    if (offset !=0) {
       
    //3
    self.currentIndex = (self.currentIndex + offset + _indextotle) % _indextotle;
    self.pageControl.currentPageNumber = self.currentIndex;
       // NSLog(@"offset%d  (unsigned long)self.currentIndex %lu   (long)self.pageControl.currentPageNumber%ld",offset ,(unsigned long)self.currentIndex, (long)self.pageControl.currentPageNumber);
        if (self.indextotle == 2) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            NSLog(@"%ld",(long)indexPath.item);
            [self.collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            NSLog(@"%ld",(long)indexPath.row);
            // 快速拖动 bug 修订
            [UIView setAnimationsEnabled:NO];
            [self.collection reloadItemsAtIndexPaths:@[indexPath]];
            // [self.collection reloadItemsAtIndexPaths:@[indexPath]];
            [UIView setAnimationsEnabled:YES];
        }else{
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
            [self.collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            NSLog(@"%ld",(long)indexPath.row);
            // 快速拖动 bug 修订
            [UIView setAnimationsEnabled:NO];
            [self.collection reloadItemsAtIndexPaths:@[indexPath]];
            // [self.collection reloadItemsAtIndexPaths:@[indexPath]];
            [UIView setAnimationsEnabled:YES];

        }

    
    }
   
   // NSLog(@"2222");
    
}
#pragma make - 数据源 方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _indextotle;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CycleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   // NSLog(@"1-------%ld",(long)indexPath.item);
    
    if (self.indextotle == 2) {
        
//        NSUInteger index = indexPath.item;
//        NSLog(@"%lu",(unsigned long)index);
        NSLog(@"%lu",(unsigned long)self.currentIndex);
        NSString * str  = _picUrlArray[self.currentIndex];
        //NSLog(@"2-------%ld",index);
        //NSLog(@"111111111111----- %@",str);
        cell.str = str;

        
    }else{
        
        NSUInteger index = (indexPath.item  + self.currentIndex + _indextotle -1) % _indextotle;
        //(@"%lu",(unsigned long)index);
        NSString * str  = _picUrlArray[index];
        //NSLog(@"2-------%ld",index);
        //NSLog(@"111111111111----- %@",str);
        cell.str = str;
        
        
    }
    return cell;
    
    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 停止时钟
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.frame = CGRectMake(0, 0, kWIDTH, 300);
//    
//    
//    
//    
//    


@end
