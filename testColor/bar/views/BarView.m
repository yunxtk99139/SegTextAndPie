//
//  BarView.m
//  testColor
//
//  Created by 朱云 on 8/29/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import "BarView.h"

#define BarTextFont 10
#define BarAnimationDuration 1.0
#define TextAnimationDuration 2.0
static CABasicAnimation* fadeAnimation(){
    CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.duration = TextAnimationDuration;
    return fadeAnimation;
}
@interface BarView()
@property (nonatomic, strong)CAShapeLayer *backgroundLayer; //背景层
@property (nonatomic, strong)UIBezierPath *backgroundPath; //背景贝赛尔路径
@property (nonatomic, strong)CAShapeLayer *barLayer; //柱状层
@property (nonatomic, strong)UIBezierPath *barPath; //柱状贝赛尔路径
@property (nonatomic, strong)CATextLayer *textLayer; //数值文字显示层
@property (nonatomic, assign)CGFloat barWidth;

@end
@implementation BarView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        _barLayer = [CAShapeLayer new];
        [self.layer addSublayer:_barLayer];
        _barLayer.strokeColor = [UIColor greenColor].CGColor;
        _barLayer.lineCap = kCALineCapButt;
        _barLayer.frame = self.bounds;
        self.barWidth = self.bounds.size.width;
        _textHeight = 23;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (_textLayer) {
        _textLayer.position = CGPointMake(self.bounds.size.width/2 , _backgroundLayer? -BarTextFont:self.bounds.size.height*(1-_barProgress)-_textHeight*2/3);
    }
    if (_displayAnimated) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = BarAnimationDuration;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        [_barLayer addAnimation:pathAnimation forKey:nil];
        if (_textLayer) {
            CABasicAnimation *fade = fadeAnimation();
            [self.textLayer addAnimation:fade forKey:nil];
        }
    }
    
}

- (void)setProgress{
    _barPath = [UIBezierPath bezierPath];
    [_barPath moveToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.size.height)];
    [_barPath addLineToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.size.height*(1-_barProgress))];
    [_barPath setLineWidth:_barWidth];
    [_barPath setLineCapStyle:kCGLineCapSquare];
    
    _barLayer.strokeEnd = 1.0;
    _barLayer.path = _barPath.CGPath;
}

- (void)setDisplayAnimated:(BOOL)displayAnimated{
    _displayAnimated = displayAnimated;
}
//设置柱子的宽度
- (void)setBarWidth:(CGFloat)barWidth{
    _barWidth = barWidth;
    _barLayer.lineWidth = _barWidth;
    [self setProgress];
}

//设置背景色
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    if (backgroundColor && ![backgroundColor isEqual:[UIColor clearColor]]) {
        self.backgroundLayer.strokeColor = backgroundColor.CGColor;
    }
}

//设置柱子颜色
- (void)setBarColor:(UIColor *)barColor{
    _barLayer.strokeColor = barColor.CGColor;
}

- (void)setBarRadius:(CGFloat)barRadius{
    _barLayer.cornerRadius = barRadius;
}
//设置柱子进度
- (void)setBarProgress:(float)progress{
    _barProgress = progress;
    [self setProgress];
}

- (CATextLayer *)textLayer{
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.foregroundColor = _barLayer.strokeColor;
        _textLayer.fontSize = BarTextFont;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.contentsScale = [[UIScreen mainScreen] scale];
        CGRect bounds = _barLayer.bounds;
        bounds.size.height = _textHeight;
        bounds.size.width *= 2;
        _textLayer.bounds = bounds;
        [self.layer addSublayer:_textLayer];
    }
    return _textLayer;
}

- (CAShapeLayer *)backgroundLayer{
    if (!_backgroundLayer) {
        _backgroundLayer = [CAShapeLayer new];
        [self.layer insertSublayer:_backgroundLayer below:_barLayer];
        _backgroundLayer.frame = self.bounds;
        _backgroundLayer.lineWidth = _barWidth;
        _backgroundPath = [UIBezierPath bezierPath];
        [_backgroundPath moveToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.size.height)];
        [_backgroundPath addLineToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.origin.y)];
        [_backgroundPath setLineWidth:_barWidth];
        [_backgroundPath setLineCapStyle:kCGLineCapSquare];
        _backgroundLayer.path = _backgroundPath.CGPath;
    }
    return _backgroundLayer;
}
//设置数值
- (void)setBarText:(NSString*)text{
    self.textLayer.string = text;
}


@end
