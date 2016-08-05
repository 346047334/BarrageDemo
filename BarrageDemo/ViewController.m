//
//  ViewController.m
//  BarrageDemo
//
//  Created by 方常伟 on 16/8/5.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import "ViewController.h"
#import "BarrageView.h"
#import "BarrageManager.h"

#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property (nonatomic, strong) BarrageManager * mananger;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * dataSource = [NSMutableArray arrayWithArray:@[@"弹幕1~~~~~~~~~~~~~~~~~~~~~~",
                                                                    @"弹幕2~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~",
                                                                    @"弹幕3~~~~~~~~~~~~~"
                                                                    ]];
    self.mananger = [[BarrageManager alloc]initWithData:dataSource];
    
    __weak typeof(self)weakSelf = self;
    self.mananger.barrageViewBlock = ^(BarrageView *view){
        [weakSelf addBarrageView:view];
    };
}
- (IBAction)btn:(UIButton *)btn {
    [self.mananger start];
}
- (IBAction)stop:(UIButton *)sender {
    [self.mananger  stop];
}

- (void)addBarrageView:(BarrageView *)view{
    view.frame = CGRectMake(DEVICEWIDTH, 300 + view.trajectory*40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    [view startAnimation];
}
@end
