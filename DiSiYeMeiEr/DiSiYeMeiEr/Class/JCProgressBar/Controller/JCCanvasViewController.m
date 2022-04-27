//
//  JCCanvasViewController.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/27.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCCanvasViewController.h"
#import "JCProgressView.h"
#define kMaxTime  20.0
@interface JCCanvasViewController ()
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign) CGFloat timerTime;
@property (strong, nonatomic) JCProgressView *progressView;
@end

@implementation JCCanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setType:(NSInteger)type{
    _type = type;
    
    if (type == 1) {
        [self testDemo1];
    } else if (type == 2){
        [self testDemo2];
    }
}


#pragma mark - 绘制二
- (void)testDemo2{
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(50, 300, self.view.frame.size.width - 100, 30)];
    testView.backgroundColor = [[UIColor colorWithRed:48/255.0 green:149/255.0 blue:215/255.0 alpha:1] colorWithAlphaComponent:0.3];
    testView.layer.cornerRadius = testView.frame.size.height * 0.5;
    testView.layer.masksToBounds = YES;
    [self.view addSubview:testView];
    
    JCProgressView *progressView = [[JCProgressView alloc] initWithFrame:CGRectMake(50, 300,self.view.frame.size.width - 100, 30)];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    [self startTime];
}

#pragma mark - NSTimer

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)updateTimer{
    _timerTime += 0.1;
    if (_timerTime >= kMaxTime) {
        ///时间到了如果都没做完 直接判定
        self.progressView.progress = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.progress = 0;
        });
        [self stopTime];
    }
}

/** 开始计时 */
- (void)startTime{
    [self timer];
    [self.progressView start];
    
}
/** 暂时计时器 */
- (void)pauseTime{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self.progressView pause];
}
/** 停止计时器 */
- (void)stopTime{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self.progressView stop];
}


#pragma mark - 绘制一

-(void)testDemo1{
   //创建path
   UIBezierPath *path = [UIBezierPath bezierPath];
   // 添加路径[1条点(100,100)到点(200,100)的线段]到path
   [path moveToPoint:CGPointMake(10 , 300)];
   [path addLineToPoint:CGPointMake(200, 300)];
   // 将path绘制出来
   [path stroke];
   //遮罩层
    CAShapeLayer *_progressLayer = [CAShapeLayer layer];
   _progressLayer.frame = self.view.bounds;
   _progressLayer.fillColor =[[UIColor clearColor] CGColor];
   _progressLayer.strokeColor=[UIColor redColor].CGColor;
   _progressLayer.lineCap = kCALineCapRound;
   _progressLayer.lineWidth = 20;
   //渐变图层
   CALayer * grain = [CALayer layer];
   CAGradientLayer *gradientLayer =[CAGradientLayer layer];
   UIColor * fixColor=[UIColor blueColor];
   UIColor * preColor=[UIColor whiteColor];
   gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
   [gradientLayer setColors:[NSArray arrayWithObjects:(id)[preColor CGColor],(id)[fixColor CGColor], nil]];
   // 设置颜色的分割点
   [gradientLayer setLocations:@[@0.01,@1]];
   // 开始点
   [gradientLayer setStartPoint:CGPointMake(0, 0)];
   // 结束点
   [gradientLayer setEndPoint:CGPointMake(1, 1)];
   [grain addSublayer:gradientLayer];
   [grain setMask:_progressLayer];
   [self.view.layer addSublayer:grain];
    
   //增加动画
   CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
   pathAnimation.duration = 1;
   pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
   pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
   pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
   pathAnimation.autoreverses=NO;
   //pathAnimation.repeatCount = INFINITY;
   [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
   _progressLayer.path=path.CGPath;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
