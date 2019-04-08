//
//  OttoScratchView.m
//  OttoScratchView
//
//  Created by halo on 2019/4/4.
//  Copyright © 2019 otto. All rights reserved.
//

#import "OttoScratchView.h"

@interface OttoScratchView ()

@property (nonatomic, strong) CALayer * maskLayer;

@property (nonatomic, assign) CGPoint startPoint;;

@property (nonatomic, strong) NSMutableArray *rectArr;
@property (nonatomic, strong) NSMutableArray *passRectArr;

@end

@implementation OttoScratchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

- (void)initView{
    self.layer.mask = [CALayer new];
    self.scratchLineWidth = 14;
    self.passCount = 10.0;
    CGFloat rectW = self.frame.size.width / 4;
    CGFloat rectH = self.frame.size.height / 4;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            CGRect rect = CGRectMake(j * rectW, i * rectH, rectW, rectH);
            [self.rectArr addObject:[NSValue valueWithCGRect:rect]];
        }
    }
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.startPoint = touchLocation;
    
    //获取touch对象
    UITouch * t = touches.anyObject;
    [self recordPassRect:t];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    CAShapeLayer * layer = [CAShapeLayer new];
    layer.path = [self getPathFromPointA:self.startPoint toPointB:touchLocation].CGPath;
    if(!_maskLayer){
        _maskLayer = [CALayer new];
    }
    [_maskLayer addSublayer:layer];
    
    self.layer.mask = _maskLayer;
    self.startPoint = touchLocation;
    
    //获取touch对象
    UITouch *t = touches.anyObject;
    [self recordPassRect:t];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    CAShapeLayer * layer = [CAShapeLayer new];
    layer.path = [self getPathFromPointA:self.startPoint toPointB:touchLocation].CGPath;
    if(!_maskLayer){
        _maskLayer = [CALayer new];
    }
    [_maskLayer addSublayer:layer];
    
    self.layer.mask = _maskLayer;
    
    //获取touch对象
    UITouch *t = touches.anyObject;
    [self recordPassRect:t];
}

- (UIBezierPath *) getPathFromPointA:(CGPoint)a toPointB : (CGPoint) b
{
    UIBezierPath * path = [UIBezierPath new];
    UIBezierPath * curv1 = [UIBezierPath bezierPathWithArcCenter:a radius:self.scratchLineWidth startAngle:angleBetweenPoints(a, b)+M_PI_2 endAngle:angleBetweenPoints(a, b)+M_PI+M_PI_2 clockwise:b.x >= a.x];
    [path appendPath:curv1];
    UIBezierPath * curv2 = [UIBezierPath bezierPathWithArcCenter:b radius:self.scratchLineWidth startAngle:angleBetweenPoints(a, b)-M_PI_2 endAngle:angleBetweenPoints(a, b)+M_PI_2 clockwise:b.x >= a.x];
    [path addLineToPoint:CGPointMake(b.x * 2 - curv2.currentPoint.x, b.y * 2 - curv2.currentPoint.y)];
    [path appendPath:curv2];
    [path addLineToPoint:CGPointMake(a.x * 2 - curv1.currentPoint.x, a.y * 2 - curv1.currentPoint.y)];
    [path closePath];
    return path;
}

CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    if(height == 0){
        return 0;
    }
    CGFloat width = first.x - second.x;
    if(width == 0){
        return M_PI_2;
    }
    CGFloat rads = atan(height/width);
    return -rads;
}


#pragma mark --记录走过的区域
- (void)recordPassRect:(UITouch *)touch {
    //获取点击的点
    CGPoint point =[touch locationInView:touch.view];
    // 遍历所有的区域,判断是否包含了点击的点
    for (int i=0; i < self.rectArr.count; i++) {
        CGRect rect = [self.rectArr[i] CGRectValue];
        if (CGRectContainsPoint(rect, point)) {
            if (![self.passRectArr containsObject:self.rectArr[i]]) {
                //把触摸到区域添加到数组
                [self.passRectArr addObject:self.rectArr[i]];
                //经过了一半的区域,则移除自身
                if (self.passRectArr.count >= self.passCount) {
                    [self dismiss];
                }
            }
            
        }
    }
}

- (void)dismiss {
//    NSLog(@"dismiss");
    if ([self.delegate respondsToSelector:@selector(scratchViewDone)]) {
        [self.delegate scratchViewDone];
    }
}


- (NSMutableArray *)rectArr{
    if (_rectArr == nil) {
        _rectArr = [NSMutableArray array];
    }
    return _rectArr;
}

- (NSMutableArray *)passRectArr {
    if (_passRectArr == nil) {
        _passRectArr = [NSMutableArray array];
    }
    return _passRectArr;
}

@end
