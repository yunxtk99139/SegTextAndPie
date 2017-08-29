//
//  BarCtl.m
//  testColor
//
//  Created by 朱云 on 8/29/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import "BarCtl.h"
#import "BarChart.h"
#import "BarChartData.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
@interface BarCtl ()
@property (nonatomic)BarChart *barChart;
@end

@implementation BarCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBarChart];
}
- (void)setupBarChart{
       _barChart = [[BarChart alloc]initWithFrame:CGRectMake(0, 145, SCREEN_WIDTH, 200)];
      NSMutableArray *tempData = [[NSMutableArray alloc] init];
    double mult = 5 * 1000.f;
    for (int i = 0; i < 5; i++){
         double val = (double) (arc4random_uniform(mult) + 3.0);
        BarChartData* data = [[BarChartData alloc] initWithLabel:[NSString stringWithFormat:@"test %d",i] value:@(val) maxValue:@(val+300)];
         double  val2 = (double) (arc4random_uniform(mult) + 3.0);
        data.barColor = [UIColor colorWithRed:245.0 * (val)/ 5000.0 / 255.0 green:94.0* (val2)/ 5000.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f];
        [tempData addObject:data];
    }
    _barChart.data = [tempData copy];
    _barChart.displayAnimated = YES;
    _barChart.itemSpace = 12;
     _barChart.chartMargin = UIEdgeInsetsMake(20, 15, 45, 15);

    [self.view addSubview:_barChart];
}
- (void)viewDidAppear:(BOOL)animated{
  [_barChart show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
