//
//  BarView.h
//  testColor
//
//  Created by 朱云 on 8/29/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarView : UIView{
    CAShapeLayer *_backgroundLayer; //背景层
    UIBezierPath *_backgroundPath; //背景贝赛尔路径
    CAShapeLayer *_barLayer; //柱状层
    UIBezierPath *_barPath; //柱状贝赛尔路径
    CATextLayer *_textLayer; //数值文字显示层
}
@property (nonatomic, strong)UIColor *backgroundColor;//背景色
@property (nonatomic, strong)UIColor *barColor;//柱的颜色

@property (nonatomic, strong)UIColor *labelTextColor;
@property (nonatomic, strong)UIFont  *labelFont;

@property (nonatomic, assign)float barProgress;//柱子长度 0-1之间
@property (nonatomic, assign) CGFloat barRadius;
@property (nonatomic, assign)float textHeight;
@property (nonatomic, strong)NSString *barText;//数值

@property (nonatomic, assign)BOOL displayAnimated;



@end
