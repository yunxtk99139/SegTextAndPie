
//
//  PieCtl.m
//  testColor
//
//  Created by 朱云 on 8/26/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import "PieCtl.h"
#import "PieView.h"
@interface PieCtl ()
@property (nonatomic,strong) PieView *pView;
@end

@implementation PieCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pView = [[PieView alloc] initFrame:CGRectMake(20, ([UIScreen mainScreen].bounds.size.height-250)/2, [UIScreen mainScreen].bounds.size.width-40, 250) Datas:@[@5,@8,@10,@15] color:@[[UIColor greenColor],[UIColor brownColor],[UIColor orangeColor],[UIColor blackColor]] titles:@[@"test",@"test1111",@"dsfsdf3",@"你好a"]];
    [self.view addSubview:_pView];
    _pView.backgroundColor= [UIColor grayColor];
    _pView.fontSize = 18;
    _pView.padding = 15;
    [_pView strokeChart];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
