//
//  BarChart.m
//  testColor
//
//  Created by 朱云 on 8/29/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import "BarChart.h"
#import "BarView.h"
#define GroupSpace 20
@interface BarChart()
@property (nonatomic, strong)NSMutableArray<BarView *> *bars;
@end
@implementation BarChart
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _chartMargin = UIEdgeInsetsMake(15, 15, 15, 15);
        self.backgroundColor = [UIColor clearColor];
        _itemSpace = 1;
    }
    return self;
}
-(void)show{
    CGFloat itemCount = [_data count];
    CGFloat groupWidth =   self.bounds.size.width - _chartMargin.left - _chartMargin.right ;
    CGFloat barHeight = self.bounds.size.height - _chartMargin.top - _chartMargin.bottom;
    CGFloat barWidth = ( groupWidth-_itemSpace )/itemCount - _itemSpace;
    if(_bars.count>0){
        for (int i =0; i<_bars.count; i++) {
            BarView *bar = _bars[i];
            [bar removeFromSuperview];
            [_bars removeObjectAtIndex:i];
        }
    }
    _bars = [NSMutableArray array];
    for (int i = 0; i<_data.count; i++) {
        BarChartData *dataset = _data[i];
            CGFloat bar_x =_itemSpace + _chartMargin.left + i*(barWidth+_itemSpace);
            BarView *bar = [[BarView alloc]initWithFrame:CGRectMake(bar_x, _chartMargin.top, barWidth, barHeight)];
            NSNumber *value = dataset.value;
            bar.barProgress = isnan(value.floatValue / dataset.maxValue.floatValue)? 0:(value.floatValue / dataset.maxValue.floatValue);
            bar.barColor = dataset.barColor;
            bar.backgroundColor = dataset.BarbackGroudColor;
           bar.barText = [ NSString stringWithFormat:@"%@\n%@",dataset.label,value.stringValue];
            bar.displayAnimated = _displayAnimated;
            [_bars addObject:bar];
            [self addSubview:bar];
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 绘 x/y 坐标轴
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor); //设置线的颜色为灰色
        CGContextMoveToPoint(context, _chartMargin.left-0.5, _chartMargin.top); //设置线的起始点
        CGContextAddLineToPoint(context, _chartMargin.left, self.bounds.size.height-_chartMargin.bottom+0.5); //设置线中间的一个点
        CGContextStrokePath(context);//直接把所有的点连起来
  //////////////y
        CGContextSetLineWidth(context, 0.25);
        CGFloat step = ((self.bounds.size.height-_chartMargin.bottom+0.5) - _chartMargin.top)/4 ;
        for (int i=0; i<=4; i++) {
            CGContextMoveToPoint(context, _chartMargin.left, self.bounds.size.height-_chartMargin.bottom+0.5-i*step); //设置线的起始点
            CGContextAddLineToPoint(context, self.bounds.size.width-_chartMargin.right, self.bounds.size.height-_chartMargin.bottom+0.5-i*step); //设置线中间的一个点
            CGContextStrokePath(context);//直接把所有的点连起来
            
        }
    
}

@end
