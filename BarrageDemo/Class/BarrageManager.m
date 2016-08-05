//
//  BarrageManager.m
//  BarrageDemo
//
//  Created by 方常伟 on 16/8/5.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import "BarrageManager.h"
#import "BarrageView.h"

@interface BarrageManager()
//弹幕的数据来源
@property (nonatomic, strong)NSMutableArray *dataSource;
//弹幕使用过程中的临时存储数据变量
@property (nonatomic, strong)NSMutableArray *tampcontent;
//创建的弹幕数组
@property (nonatomic ,strong)NSMutableArray *barrageViews;
//是否正在动画
@property BOOL isAnimation;
@end
@implementation BarrageManager

-(instancetype)initWithData:(NSMutableArray *)dataArray{
    if (self = [super init]) {
        self.isAnimation = NO;
        self.dataSource = dataArray;
    }
    return self;
}
- (void)start{
    if (self.isAnimation) {
        return;
    }
    self.isAnimation = YES;
    [self.tampcontent removeAllObjects];
    [self.tampcontent addObjectsFromArray:self.dataSource];
    [self initBarrageView];
}
-(void)stop{
    if (!self.isAnimation) {
        return;
    }
    self.isAnimation = NO;
    [self.barrageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BarrageView *view = obj;
        [view stopAnimation];
        view = nil;
        
    }];
    [self.barrageViews removeAllObjects];
}
- (void)initBarrageView{
    NSMutableArray *tragectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for (NSInteger i  = 0; i < 3; i++) {
        if (self.tampcontent.count>0) {
            //通过随机数获取弹道轨迹
            NSInteger index = arc4random()%tragectorys.count;
            int tragectory = [[tragectorys objectAtIndex:index] intValue];
            [tragectorys removeObjectAtIndex:index];
            //从弹幕数组中逐一取出弹幕数据
            NSString *content = [self.tampcontent firstObject];
            [self.tampcontent removeObjectAtIndex:0];
            //初始化弹幕
            
            [self createBarrageView:content targectory:tragectory];
        }
        
    }
}
//初始化弹幕
- (void)createBarrageView:(NSString *)content targectory:(int)targectory{
    if (!self.isAnimation) {
        return;
    }
    BarrageView *view = [[BarrageView alloc]initWithContent:content];
    view.trajectory  = targectory;
    [self.barrageViews addObject:view];
    
    __weak typeof (view)weakView = view;
    __weak typeof(self)weakSelf = self;
    view.moveStutas = ^(MoveStutas stutas ){
        if (!self.isAnimation) {
            return ;
        }
        switch (stutas) {
            case start:
            {
                [weakSelf.barrageViews addObject:weakView];
              break;
            }
            case enter:
            {
                NSString *content = [weakSelf nextContent];
                if (content) {
                    [weakSelf createBarrageView:content targectory:targectory];
                }
                break;
            }case end:
            {
                if ([weakSelf.barrageViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [weakSelf.barrageViews removeObject:weakView];
                    if (weakSelf.barrageViews.count ==0) {
                        weakSelf.isAnimation = NO;

                        [weakSelf start];
                    }
                }
                break;
            }
            default:
                break;
        }
    };
    self.isAnimation = YES;
    if (self.barrageViewBlock) {
        self.barrageViewBlock(view);
    }
}

-(NSString *)nextContent{
    NSString *content = [self.tampcontent firstObject];
    if (content) {
        [self.tampcontent removeObjectAtIndex:0];
    }
    return content;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (NSMutableArray *)tampcontent{
    if (!_tampcontent) {
        _tampcontent = [NSMutableArray array];
    }
    return _tampcontent;
}

- (NSMutableArray *)barrageViews{
    if (!_barrageViews) {
        _barrageViews = [NSMutableArray array];
    }
    return _barrageViews;
}
@end
