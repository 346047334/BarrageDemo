//
//  barrageView.m
//  BarrageDemo
//
//  Created by 方常伟 on 16/8/5.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import "barrageView.h"

#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICEHIEGHT [UIScreen mainScreen].bounds.size.height
#define BOBYSIZE  14.f
#define SPACE     10.f
@interface BarrageView()
@property (nonatomic,strong)UILabel * contentLable;
@end

@implementation BarrageView

-(instancetype)initWithContent:(NSString *)content{
    if (self =[super init]) {
        self.backgroundColor = [UIColor colorWithWhite:1.f alpha:.4f];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15.f;
        NSDictionary * attr = @{NSFontAttributeName:[UIFont systemFontOfSize:BOBYSIZE]};
        CGFloat width = [content sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width+2*SPACE, 30);
        self.contentLable.text = content;
        self.contentLable.frame = CGRectMake(SPACE, 0, width, 30);
        [self addSubview:self.contentLable];
        
    }
    return self;
}
//设置label
-(UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable = [[UILabel alloc]init];
        _contentLable.backgroundColor = [UIColor clearColor];
        _contentLable.textColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        _contentLable.textAlignment = NSTextAlignmentCenter;
        _contentLable.font = [UIFont systemFontOfSize:BOBYSIZE];
        
    }
    return _contentLable;
}

- (void)startAnimation{
    CGFloat duration = 4.0;//弹幕在屏幕中的时间
    CGFloat totalWidth = DEVICEWIDTH +CGRectGetWidth(self.bounds);
    CGFloat speed = totalWidth/duration;
    CGFloat enterDurtion = CGRectGetWidth(self.bounds)/speed;
    if (self.moveStutas) {
        self.moveStutas(start);
    }
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDurtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.moveStutas) {
            self.moveStutas(enter);
        }
    });
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x =  -CGRectGetWidth(self.bounds);
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (self.moveStutas) {
            self.moveStutas(end);
        }
    }];
    
    
    
}
- (void)stopAnimation{
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}
@end
