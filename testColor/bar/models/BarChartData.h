//
//  BarChartData.h
//  testColor
//
//  Created by 朱云 on 8/29/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BarChartData : NSObject
@property (nonatomic, strong)NSNumber *value;
@property (nonatomic, strong)NSNumber *maxValue;
@property (nonatomic, strong)NSString *label;
@property (nonatomic, strong) UIColor *barColor;
@property (nonatomic, strong) UIColor *BarbackGroudColor;
- (instancetype)initWithLabel:(NSString*)label value:(NSNumber*)value maxValue:(NSNumber*)maxValue;
@end
