//
//  ViewController.m
//  testColor
//
//  Created by 朱云 on 8/9/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIView *backView;
@property (strong,nonatomic) UILabel* titleLabel;
@property (strong,nonatomic) UILabel* colorLabel;
@property (strong,nonatomic) CAShapeLayer* titleLabelLayer;
@property (strong,nonatomic) CAShapeLayer* colorLabelLayer;
@property (strong,nonatomic) CAShapeLayer* holdLabelLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self iniUI];
}
- (void)iniUI{
    self.view.backgroundColor = [UIColor grayColor];
    _backView = [UIView new];
    [self.view addSubview:_backView];
     _backView.backgroundColor = [UIColor clearColor];
    
    NSString* title =  @"Hello world ! sdfjalsgjladgasdg";
    UIFont *font = [UIFont systemFontOfSize:25 weight:800];
    NSLog(@"%@",title);
    CGRect rect = CGRectMake(20, 100, 250, 120);
    _backView.frame = CGRectMake(20, 50, 280, 220);
    _titleLabel = [UILabel new];
    _titleLabel.frame = rect;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment =1;
    _titleLabel.text = title;
    _titleLabel.font = font;
    [_backView addSubview:_titleLabel];
    
    _colorLabel = [UILabel new];
    _colorLabel.frame = rect;
    _colorLabel.textColor = [UIColor yellowColor];
    _colorLabel.textAlignment =1;
    _colorLabel.text = title;
    _colorLabel.font = font;
    [_backView addSubview:_colorLabel];
    CGFloat ratio = 0.185;
    CGFloat radius = 30;
    _titleLabelLayer = [CAShapeLayer new];
    _titleLabel.layer.mask = _titleLabelLayer;
    _titleLabelLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 250*ratio, 120)].CGPath;
    _colorLabelLayer = [CAShapeLayer new];
    _colorLabel.layer.mask = _colorLabelLayer;
     _colorLabelLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(250*ratio, 30, 250 - 250*ratio, 60) cornerRadius:radius].CGPath;
    _holdLabelLayer = [CAShapeLayer new];
    
    [self.view.layer insertSublayer:_holdLabelLayer atIndex:0];
    _holdLabelLayer.fillColor = [UIColor greenColor].CGColor;
    _holdLabelLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(40 +250*ratio, 180, 250,60) cornerRadius:radius].CGPath;
//      [self.view.layer addSublayer:_holdLabelLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
