//
//  PhotoPlay.h
//  photoPlay
//
//  Created by addcn591 on 15/12/14.
//  Copyright © 2015年 Addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoPlay;

typedef void(^IndexClickBlock)(NSInteger index);

@interface PhotoPlay : UIView<UIScrollViewDelegate>

//照片數組
@property (copy, nonatomic) NSArray *photoArr;

//輪播間隔時間
@property (assign, nonatomic) NSInteger playInterval;

//照片點擊回調
@property (copy, nonatomic) IndexClickBlock indexClickBlock;

@end
