//
//  JCStreamUsageVC.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/4/16.
//  Copyright © 2019年 JCTrustYourself. All rights reserved.
//

#import "JCStreamUsageVC.h"

@interface JCStreamUsageVC ()<NSStreamDelegate>
@property(nonatomic,strong)NSMutableData *testData;
@end

@implementation JCStreamUsageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setup{
    NSInputStream *_inputStream = [[NSInputStream alloc] initWithFileAtPath:@""];
    _inputStream.delegate = self;
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    
}



/*
 NSStreamEventNone = 0,
NSStreamEventOpenCompleted = 1UL << 0,
NSStreamEventHasBytesAvailable = 1UL << 1,
NSStreamEventHasSpaceAvailable = 1UL << 2,
NSStreamEventErrorOccurred = 1UL << 3,
NSStreamEventEndEncountered = 1UL << 4
*/
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    NSInputStream *_inputStream = (NSInputStream *)aStream;
    
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:
            if (!_testData) {
                _testData = [NSMutableData  data];
            }
            uint8_t buf[1024];
            NSInteger _len = 0;
            _len = [_inputStream read:buf maxLength:1024];
            if (_len) {
                [_testData appendBytes:(const void *)buf length:_len];
            
            }
            
            break;
            
        default:
            break;
    }
    
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
