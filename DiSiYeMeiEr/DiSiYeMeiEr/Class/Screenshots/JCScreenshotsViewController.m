//
//  JCScreenshotsViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/2/24.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "JCScreenshotsViewController.h"
#import "JCShowView.h"
@interface JCScreenshotsViewController ()
@property(nonatomic,strong)JCShowView *showView;
@end

@implementation JCScreenshotsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

  JCShowView *imageViewSecond = [[JCShowView alloc] initWithFrame:CGRectMake(130, 280, 150, 150)];
    imageViewSecond.bgImage.layer.cornerRadius = 15.f;
    imageViewSecond.bgImage.layer.masksToBounds = YES;
  [self.view addSubview:imageViewSecond];
 self.showView = imageViewSecond;
 [self.showView.btn addTarget:self action:@selector(showImgClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)showImgClick{
    
    UIImage *img = [self screenshotsImageFromView:self.showView];//截屏
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(saveScreeshImage:didFinishSavingWithError:contextInfo:), NULL);//保存到相册
    
}




//对某个view进行截图
-(UIImage *)screenshotsImageFromView:(UIView *)view {
    
    JCShowView *showView  = (JCShowView *)view;
    CGRect screenRect = [showView bounds];
    NSInteger scale = 1;
    if ([[UIScreen mainScreen]respondsToSelector:@selector(scale)]) {
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5) {
            scale = 2.0;
        }
        if (tmp > 2.5) {
            scale=3.0;
        }
    }
    if (scale > 1.5) {
        //        UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, scale);
        //这里的屏幕高度需要设置成NSInteger类型的否则截图底部会有白线
        NSInteger screenH = [[NSNumber numberWithDouble:screenRect.size.height] integerValue];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(screenRect.size.width, screenH), NO, scale);
    } else {
        UIGraphicsBeginImageContext(screenRect.size);
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    showView.backgroundColor = [UIColor blackColor];
    [showView.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    showView.backgroundColor = [UIColor whiteColor];
    return image;
}



- (void)saveScreeshImage:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    if(error != NULL) {
        [self showAleartView:@"保存失败"];
    }else{
        [self showAleartView:@"保存成功"];
    }
}


- (void)showAleartView:(NSString *)titleStr{
  
    UIAlertView *alerty = [[UIAlertView  alloc] initWithTitle:titleStr message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alerty show];
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
