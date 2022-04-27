//
//  JCProgressView.m
//  testDemo
//
//  Created by jcmac on 2022/4/21.
//

#import "JCProgressView.h"
#define kMaXTime 20.f
@interface JCProgressView()
///绘制进度层
@property(nonatomic,strong)CAShapeLayer *progressShapeLayer;
///遮罩层
@property(nonatomic,strong)CALayer *maskLayer;
///绘制UI计时器
@property (nonatomic) CADisplayLink *displayLink;
///时间
@property (nonatomic,assign) CGFloat drawTime;
///显示时间的Label
@property (nonatomic,strong) UILabel *timeLabel;
///背景
@property (nonatomic,strong) UIView *bgView;
@property(nonatomic,assign)NSInteger type;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@end
@implementation JCProgressView

- (void)setType:(NSInteger)type{
    _type = type;
}
- (void)setProgress:(CGFloat)progress{
    
    if (_type == 2) {
        if (progress == 0) {
            self.progressShapeLayer.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressShapeLayer.strokeEnd = 0;
            });
        }else{
            self.progressShapeLayer.hidden = NO;
            self.progressShapeLayer.strokeEnd = progress;
        }
        
    } else {
        if (progress == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.maskLayer removeFromSuperlayer];
                self.maskLayer = nil;
                [self.gradientLayer removeFromSuperlayer];
                self.gradientLayer = nil;
            });
        }else {
            CGRect rect = self.maskLayer.bounds;
            rect.size.width = progress * self.bounds.size.width;
            self.maskLayer.frame = rect;
        }
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f%%",progress *100];
}

- (void)start{
    if (!_displayLink) {
        [self displayLink];
    }else {
        self.displayLink.paused = NO;
    }
}
- (void)pause{
    _displayLink.paused = YES;
}
- (void)stop{
    _drawTime = 0;
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}


- (void)updateProgress{
    _drawTime += 1.0f/kMaXTime;
    self.progress =  _drawTime/ kMaXTime;
    if (_drawTime >= kMaXTime) {
        self.progress = 1.0f;
//        [self.displayLink invalidate];
//        self.displayLink = nil;
    }
}


- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        if (type == 2) {
            [self testDemo2];
        } else {
            [self testDemo3];
        }
    }
    return self;
}

#pragma mark - demo 3
-(void)testDemo3{
    self.backgroundColor = [UIColor clearColor];
    [self bgView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[
        (__bridge id)[UIColor grayColor].CGColor,
        (__bridge id)[UIColor blueColor].CGColor,
        (__bridge id)[UIColor orangeColor].CGColor,
        (__bridge id)[UIColor purpleColor].CGColor,
        (__bridge id)[UIColor yellowColor].CGColor];
    gradientLayer.startPoint = (CGPoint){.0};
    gradientLayer.endPoint = (CGPoint){1.0};
    [self.layer addSublayer:gradientLayer];
    _gradientLayer = gradientLayer;
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = (CGRect){.0, .0, .0, gradientLayer.bounds.size.height};
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    gradientLayer.mask = maskLayer;
    self.maskLayer = maskLayer;
    self.maskLayer.cornerRadius = gradientLayer.frame.size.height *0.5;
    self.maskLayer.masksToBounds = YES;
}

#pragma mark - demo 2
-(void)testDemo2{
    self.backgroundColor = [UIColor clearColor];
    [self bgView];
   [self.layer addSublayer:self.maskLayer];
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    self.layer.masksToBounds = YES;
    _progressShapeLayer.path=[self drawPath].CGPath;
    _progressShapeLayer.hidden = YES;
    [self timeLabel];
}


- (UIBezierPath *)drawPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    [path moveToPoint:CGPointMake(0,viewH)];
    [path addLineToPoint:CGPointMake(viewW,viewH)];
    path.lineCapStyle = kCGLineCapRound;
    [path stroke];
    return path;
}


- (CALayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = @[
            (__bridge id)[UIColor grayColor].CGColor,
            (__bridge id)[UIColor blueColor].CGColor,
            (__bridge id)[UIColor orangeColor].CGColor,
            (__bridge id)[UIColor purpleColor].CGColor,
            (__bridge id)[UIColor yellowColor].CGColor];
        gradientLayer.startPoint = (CGPoint){.0};
        gradientLayer.endPoint = (CGPoint){1.0};
        _maskLayer.frame = gradientLayer.bounds;
    //    grain.frame = CGRectMake(0, 0, 0, gradientLayer.bounds.size.height);
       [_maskLayer addSublayer:gradientLayer];
       [_maskLayer setMask:self.progressShapeLayer];
    }
    return _maskLayer;
}
- (CAShapeLayer *)progressShapeLayer{
    if (!_progressShapeLayer) {
        _progressShapeLayer = [CAShapeLayer layer];
         _progressShapeLayer.frame = self.bounds;
        _progressShapeLayer.fillColor =[[UIColor clearColor] CGColor];
        _progressShapeLayer.strokeColor=[UIColor redColor].CGColor;
         _progressShapeLayer.lineCap = kCALineCapSquare;
        _progressShapeLayer.lineWidth = 60;
         _progressShapeLayer.strokeEnd = 0;
    }
    return _progressShapeLayer;
}


- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_timeLabel];
        
        [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return _timeLabel;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
        if (@available(iOS 10.0, *)) {
            _displayLink.preferredFramesPerSecond = 20;
        } else {
            _displayLink.frameInterval = 20;
            // Fallback on earlier versions
        }
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}
- (UIView *)bgView{
    if (!_bgView) {
        UIView *testView = [[UIView alloc] initWithFrame:self.bounds];
        testView.backgroundColor = [[UIColor colorWithRed:48/255.0 green:149/255.0 blue:215/255.0 alpha:1] colorWithAlphaComponent:0.3];
        testView.layer.cornerRadius = testView.frame.size.height * 0.5;
        testView.layer.masksToBounds = YES;
        [self addSubview:testView];
        _bgView = testView;
    }
    return _bgView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
