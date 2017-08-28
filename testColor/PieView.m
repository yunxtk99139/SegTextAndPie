//
//  PieView.m
//  testColor
//
//  Created by 朱云 on 8/26/17.
//  Copyright © 2017 qibu. All rights reserved.
//

#import "PieView.h"
@interface PieView(){
    NSArray* _endPercentages;
    UIView* _contentView;
    CAShapeLayer *_pieLayer;
}
@property (nonatomic,copy) NSArray   *colors;
@property (nonatomic,copy) NSArray   *datas;
@property (nonatomic,copy) NSArray   *titles;
@end

@implementation PieView
- (instancetype)initFrame:(CGRect)frame Datas:(NSArray*)data color:(NSArray*)colors titles:(NSArray*)titles{
    self = [super initWithFrame:frame];
    if(self){
        _datas = data;
        _colors = colors;
        _titles = titles;
        _padding = 10;
        _fontSize = 12.0f;
        [self initData:data];
    }
    return self;
}
- (void)initData:(NSArray*)data{
    NSMutableArray* temp = [[NSMutableArray alloc] init];
    __block  CGFloat sum = 0;
   [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       sum += [obj floatValue];
   }];
    NSAssert(sum, @"sum ==0");
    __block CGFloat currentTotal = 0;
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          currentTotal += [obj floatValue] ;
        [temp addObject:@(currentTotal/ sum)];
    }];
    _endPercentages = [temp copy];
}
- (void)initUI{
    [_contentView removeFromSuperview];
    _contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_contentView];
    
    _pieLayer = [CAShapeLayer layer];
    [_contentView.layer addSublayer:_pieLayer];
}
- (void)maskChart{
    CGFloat minimal = (CGRectGetWidth(self.bounds) < CGRectGetHeight(self.bounds)) ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    CGFloat _outerCircleRadius  = minimal ;
    CGFloat radius =_outerCircleRadius*1;
    CGFloat borderWidth = _outerCircleRadius*2 ;
    CAShapeLayer *maskLayer = [self newCircleLayerWithRadius:radius
                                                 borderWidth:borderWidth
                                                   fillColor:[UIColor clearColor]
                                                 borderColor:[UIColor blackColor]
                                             startPercentage:0
                                               endPercentage:1];
    
    _pieLayer.mask = maskLayer;
}
- (CAShapeLayer *)newCircleLayerWithRadius:(CGFloat)radius
                               borderWidth:(CGFloat)borderWidth
                                 fillColor:(UIColor *)fillColor
                               borderColor:(UIColor *)borderColor
                           startPercentage:(CGFloat)startPercentage
                             endPercentage:(CGFloat)endPercentage{
    CAShapeLayer *circle = [CAShapeLayer layer];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
    circle.fillColor   = fillColor.CGColor;
    circle.strokeColor = borderColor.CGColor;
    circle.strokeStart = startPercentage;
    circle.strokeEnd   = endPercentage;
    circle.lineWidth   = borderWidth;
    circle.path        = path.CGPath;
    return circle;
}

- (CGFloat)startPercentageForItemAtIndex:(NSUInteger)index{
    if(index == 0){
        return 0;
    }
    return [_endPercentages[index - 1] floatValue];
}

- (CGFloat)endPercentageForItemAtIndex:(NSUInteger)index{
    return [_endPercentages[index] floatValue];
}

- (CGFloat)ratioForItemAtIndex:(NSUInteger)index{
    return [self endPercentageForItemAtIndex:index] - [self startPercentageForItemAtIndex:index];
}

- (void)strokeChart{
     [self initUI];
    CGFloat minimal = (CGRectGetWidth(self.bounds) < CGRectGetHeight(self.bounds)) ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    CGFloat _outerCircleRadius  = minimal / 6;
    for (int i = 0; i < _datas.count; i++) {
        CGFloat startPercentage = [self startPercentageForItemAtIndex:i];
        CGFloat endPercentage   = [self endPercentageForItemAtIndex:i];
        CGFloat radius = _outerCircleRadius;
        CGFloat borderWidth = _outerCircleRadius*2;
        CAShapeLayer *currentPieLayer =	[self newCircleLayerWithRadius:radius
                                                           borderWidth:borderWidth
                                                             fillColor:[UIColor clearColor]
                                                           borderColor:_colors[i]
                                                       startPercentage:startPercentage
                                                         endPercentage:endPercentage];
        [_pieLayer addSublayer:currentPieLayer];
        float radius_start = startPercentage * 360.0;
        float radius_end =  endPercentage * 360.0;
        CGFloat _radius = _outerCircleRadius*2;
        CAShapeLayer* lineLayer = [CAShapeLayer new];
        UIBezierPath* path = [UIBezierPath new];
        CGPoint point1 = [self getPostionX:self.bounds.size.width/2.0 withPostionY:self.bounds.size.height/2.0 withRadius:_radius - 20 withCirAngle:(radius_start + radius_end )/ 2];
        [path moveToPoint:CGPointMake(point1.x, point1.y)];
        // 字符串长度
        NSString *labelTitle = _titles[i];
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize]};
        CGSize size = [labelTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        if (size.width > CGRectGetWidth(self.frame) / 2 - _radius) {
            size.width = CGRectGetWidth(self.frame) / 2 - _radius - 10;
        }
        // 延伸
        CGPoint point2 = [self getPostionX:self.bounds.size.width/2.0 withPostionY:self.bounds.size.height/2.0 withRadius:_radius + 10 withCirAngle:(radius_start + radius_end) / 2];
        // 折线
        CGFloat line_x;
        CGFloat label_x;
;
         if ((radius_start + radius_end )/ 2 < 180) {// 右边的线
            line_x = CGRectGetWidth(self.frame)  - size.width -_padding;
            label_x  = line_x + size.width / 2;
            if (point2.x + size.width +_padding> CGRectGetWidth(self.frame)) {
                point2.x = CGRectGetWidth(self.frame) - size.width- _padding;
            }
        } else {
            line_x = size.width + _padding;
            label_x = size.width - size.width / 2 + _padding ;
            if (point2.x < size.width) {
                point2.x = size.width+_padding;
            }
        }

        [path addLineToPoint:CGPointMake(point2.x, point2.y)];
        [path addLineToPoint:CGPointMake(line_x, point2.y)];
        lineLayer.path = [path CGPath];
        lineLayer.strokeColor = ((UIColor *)_colors[i]).CGColor;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        [_pieLayer addSublayer:lineLayer];
        
        CATextLayer* textLayer = [CATextLayer new];
        [_pieLayer addSublayer:textLayer];
        textLayer.bounds = CGRectMake(0, 0, size.width,size.height);
        textLayer.position = CGPointMake(label_x, point2.y);
        textLayer.string = labelTitle;
        textLayer.font = (__bridge CFTypeRef _Nullable)(@"Helvetica");//字体的名字 不是 UIFont
        textLayer.fontSize = _fontSize;//字体的
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.foregroundColor =((UIColor *)_colors[i]).CGColor;
    }
    [self maskChart];
    [self addAnimationIfNeeded];
}
- (void)addAnimationIfNeeded{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration  = 1.5;
        animation.fromValue = @0;
        animation.toValue   = @1;
//        animation.delegate  = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.removedOnCompletion = YES;
        [_pieLayer.mask addAnimation:animation forKey:@"circleAnimation"];
}

//角度变化和正常的角度坐标系不同，起点0对应角度坐标系的90度。270对应180度，并且顺时针方向增加
- (CGPoint)getPostionX:(CGFloat)cirX withPostionY:(CGFloat)cirY withRadius:(CGFloat)radiu withCirAngle:(CGFloat)cirAngle
{
    CGPoint point;
    CGFloat posX = 0.0;
    CGFloat posY = 0.0;
    CGFloat arcAngle = M_PI * cirAngle / 180.0;
    if (cirAngle < 90) {
        posX = cirX +  sin(arcAngle) * radiu;
        posY = cirY -  cos(arcAngle)  * radiu;
    } else if (cirAngle == 90) {
        posX = cirX + radiu;
        posY = cirY ;
    } else if (cirAngle > 90 && cirAngle < 180) {
        arcAngle = M_PI * (180 - cirAngle) / 180.0;
        posX = cirX + sin(arcAngle) * radiu;
        posY = cirY + cos(arcAngle) * radiu;
    } else if (cirAngle == 180) {
        posX = cirX;
        posY = cirY  + radiu;
    } else if (cirAngle > 180 && cirAngle < 270) {
        arcAngle = M_PI * (cirAngle - 180) / 180.0;
        posX = cirX - sin(arcAngle)  * radiu;
        posY = cirY + cos(arcAngle)* radiu;
    } else if (cirAngle == 270) {
        posX = cirX  - radiu;
        posY = cirY;
    } else {
        arcAngle = M_PI * (360 - cirAngle) / 180.0;
        posX = cirX  - sin(arcAngle)  * radiu;
        posY = cirY  - cos(arcAngle) * radiu;
    }
    point.x = posX;
    point.y = posY;
    return point;
}


@end
