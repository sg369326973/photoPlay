//
//  ViewController.m
//  photoPlay
//
//  Created by addcn591 on 15/12/9.
//  Copyright © 2015年 Addcn. All rights reserved.
//

#import "ViewController.h"
#import "PhotoPlay.h"

@interface ViewController ()

@end

@implementation ViewController

#define adWidth 300
#define adHeight 100

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //广告1
    UIImageView *ad_1 = [[UIImageView alloc] init];
    ad_1.image = [UIImage imageNamed:@"1"];
    
    //广告2
    UIImageView *ad_2 = [[UIImageView alloc] init];
    ad_2.image = [UIImage imageNamed:@"2"];
    
    //广告3
    UIImageView *ad_3 = [[UIImageView alloc] init];
    ad_3.image = [UIImage imageNamed:@"3"];
    
    //广告4
    UIImageView *ad_4 = [[UIImageView alloc] init];
    ad_4.image = [UIImage imageNamed:@"4"];
    
    //广告5
    UIImageView *ad_5 = [[UIImageView alloc] init];
    ad_5.image = [UIImage imageNamed:@"5"];
    
    //广告数组
    NSArray *adArr = [[NSArray alloc] initWithObjects:ad_1,ad_2,ad_3,ad_4,ad_5, nil];
    
    PhotoPlay *photoPlay = [[PhotoPlay alloc] initWithFrame:CGRectMake(0, 0, adWidth, adHeight)];
    photoPlay.center = self.view.center;
    photoPlay.photoArr = adArr;
    photoPlay.indexClickBlock = ^(NSInteger index){
        NSLog(@"%@",@(index));
    };
    [self.view addSubview:photoPlay];
}

@end
