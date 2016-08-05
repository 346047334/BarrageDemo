//
//  BarrageManager.h
//  BarrageDemo
//
//  Created by 方常伟 on 16/8/5.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BarrageView;
@interface BarrageManager : NSObject


@property (nonatomic ,copy)void(^barrageViewBlock)(BarrageView *view);

-(instancetype)initWithData:(NSMutableArray *)dataArray;
- (void)start;
- (void)stop;
@end
