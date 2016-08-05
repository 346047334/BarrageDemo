//
//  barrageView.h
//  BarrageDemo
//
//  Created by 方常伟 on 16/8/5.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, MoveStutas) {
    start,
    enter,
    end,
};
@interface BarrageView : UIView
@property (nonatomic,assign) int trajectory;//弹道
@property (nonatomic,copy)   void(^moveStutas)(MoveStutas stutas);//记录弹幕状态的回调


- (instancetype)initWithContent:(NSString *)content;//初始化方法


- (void)startAnimation;
- (void)stopAnimation;
@end
