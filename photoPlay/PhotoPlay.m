//
//  PhotoPlay.m
//  photoPlay
//
//  Created by addcn591 on 15/12/14.
//  Copyright © 2015年 Addcn. All rights reserved.
//

#import "PhotoPlay.h"

@interface PhotoPlay () {
    CGFloat _photoWidth;
    CGFloat _photoHeight;
    NSInteger _currentIndex;
}

@property (strong, nonatomic) UIScrollView *scrollview;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation PhotoPlay

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        [self commonInit];
    }
    return self;
}

/**
 *  初始化
 */
- (void)commonInit
{
    //默認輪播間隔時間
    self.playInterval = 3;
    
    //當前下標
    _currentIndex = 0;
    
    _photoWidth = self.frame.size.width;
    _photoHeight = self.frame.size.height;
    
    //滾動區域
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _photoWidth, _photoHeight)];
    
    //去掉滚动条
    self.scrollview.showsHorizontalScrollIndicator = NO;
    
    //设置分页
    self.scrollview.pagingEnabled = YES;
    
    //代理
    self.scrollview.delegate = self;
    [self addSubview:self.scrollview];
    
    //初始頁標
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _photoHeight - 20, _photoWidth, 20)];
    self.pageControl.currentPage = _currentIndex;
}

- (void)addPhotoToScrollView {
    
    //遍歷所有照片放入scrollerView
    for (int i = 0; i < self.photoArr.count; i++) {
        UIImageView *photoImage = [self.photoArr objectAtIndex:i];
        CGFloat photoX = i * _photoWidth;
        photoImage.frame = CGRectMake(photoX, 0, _photoWidth, _photoHeight);
        [self.scrollview addSubview:photoImage];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
        
        photoImage.userInteractionEnabled = YES;
        [photoImage addGestureRecognizer:tap];
    }
    
    //設置scrollerView內容大小
    self.scrollview.contentSize = CGSizeMake(_photoWidth * self.photoArr.count, _photoHeight);
}

- (void)imageClick{
    if (self.indexClickBlock) {
        self.indexClickBlock(_currentIndex);
    }
}

- (void)addPageControl {
    self.pageControl.numberOfPages = self.photoArr.count;
    [self addSubview:self.pageControl];
    
    [self autoPlay];
}

- (void)setPhotoArr:(NSArray *)photoArr {
    _photoArr = photoArr;
    
    [self addPhotoToScrollView];
    if (photoArr.count > 1) {
        [self addPageControl];
    }
}

/**
 *  下一張照片
 */
- (void)nextPhoto {
    NSInteger currentPage = self.pageControl.currentPage;
    if (currentPage == self.photoArr.count - 1) {
        currentPage = 0;
    }
    else {
        currentPage++;
    }
    CGRect rect = self.scrollview.frame;
    rect.origin.x = currentPage * rect.size.width;
    rect.origin.y = 0;
    [self.scrollview scrollRectToVisible:rect animated:YES];
}

/**
 *  自動輪播照片
 */
- (void)autoPlay {
    [self stopPlay];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.playInterval target:self selector:@selector(nextPhoto) userInfo:nil repeats:YES];
}

/**
 *  停止播放
 */
- (void)stopPlay {
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
}

/**
 *  滾動結束
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollview) {
        [self reloadPageControl];
    }
}

/**
 *  拖拽结束
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.scrollview) {
        [self reloadPageControl];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.scrollview && decelerate) {
        [self autoPlay];
    }
}

- (void)reloadPageControl {
    _currentIndex = self.scrollview.contentOffset.x / self.scrollview.frame.size.width;
    self.pageControl.currentPage = _currentIndex;
}

@end
