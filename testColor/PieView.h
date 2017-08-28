//
//  PieView.h
//  testColor
//
//  Created by 朱云 on 8/26/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieView : UIView
@property (nonatomic,assign) CGFloat padding;//文字到view的内边距
@property (nonatomic,assign) CGFloat fontSize;//文字的大小
- (instancetype)initFrame:(CGRect)frame Datas:(NSArray*)data  color:(NSArray*)colors titles:(NSArray*)titles;
- (void)strokeChart;
@end
