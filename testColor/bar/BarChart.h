//
//  BarChart.h
//  testColor
//
//  Created by 朱云 on 8/29/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarChartData.h"
@interface BarChart : UIView

// 中间图标区域(不包含坐标轴)的边距
@property (nonatomic, assign)UIEdgeInsets chartMargin;

@property (nonatomic, strong)NSArray<BarChartData*> *data;

@property (nonatomic, assign)BOOL displayAnimated;
@property (nonatomic, assign)CGFloat itemSpace;
- (void)show;//显示柱状图

@end
