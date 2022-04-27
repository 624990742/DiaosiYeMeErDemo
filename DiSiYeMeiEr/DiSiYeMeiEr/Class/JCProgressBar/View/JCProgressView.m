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

@property (nonatomic,strong) UILabel *timeLabel;
@end
@implementation JCProgressView


- (void)setProgress:(CGFloat)progress{
    if (progress == 0) {
        self.progressShapeLayer.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressShapeLayer.strokeEnd = 0;
        });
    }else{
        self.progressShapeLayer.hidden = NO;
        self.progressShapeLayer.strokeEnd = progress;
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
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self testGradent];
    }
    return self;
}

-(void)testGradent{
    self.backgroundColor = [UIColor clearColor];
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
