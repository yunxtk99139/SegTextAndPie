//
//  BarChartData.m
//  testColor
//
//  Created by 朱云 on 8/29/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import "BarChartData.h"

@implementation BarChartData
- (instancetype)initWithLabel:(NSString*)label value:(NSNumber*)value maxValue:(NSNumber*)maxValue{
    self = [super init];
    if(self){
        _label = label;
        _value = value;
        _maxValue = maxValue;
        _barColor = [UIColor greenColor];
        _BarbackGroudColor = nil;
    }
    return self;
}
@end
