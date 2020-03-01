//
//  TextFilterAbilityVC.m
//  DiSiYeMeiEr
//
//  Created by JCTrustYourself on 2017/11/23.
//  Copyright © 2017年 JCTrustYourself. All rights reserved.
//

#import "TextFilterAbilityVC.h"
#import "JCLimitManager.h"
#import "NSString+JCCustomString.h"

#define MaxNumberOfDescriptionChars 9


@interface TextFilterAbilityVC ()<TextFieldLimitDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UITextField *textField;
@property (nonatomic, strong) JCLimitManager *manager;
@end

@implementation TextFilterAbilityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"输入框的键盘优化";
    
    
    
   UITextField *testTextField = [[UITextField alloc] init];
    testTextField.placeholder = @"测试";
    testTextField.delegate = self;
    testTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:testTextField];
    
    [testTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(200);
        make.size.mas_offset(CGSizeMake(200, 40));
    }];
    self.textField = testTextField;
    [self.textField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    
    
    
//    _manager = [[TextFieldLimitManager alloc] init];
//    [_manager limitTextField:self.textfield bytesLength:MaxNumberOfDescriptionChars];
//    _manager.limitDelegate = self;
}


#pragma mark - 方法一
/*
- (void)changedTextField:(UITextField *)textField{
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if ([toBeString jc_lengthForChineseAndEnglish] > MaxNumberOfDescriptionChars) {
                textField.text = [toBeString substringToIndex:MaxNumberOfDescriptionChars];
                NSLog(@"最多只能输入40中文!");
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{

        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if ([toBeString jc_lengthForChineseAndEnglish] > MaxNumberOfDescriptionChars) {
            textField.text = [toBeString substringToIndex:MaxNumberOfDescriptionChars];
            NSLog(@"最多只能输入80字符");
        }
    }
}*/


#pragma mark - 方法二
/*
- (void)changedTextField:(UITextField *)textField{
    NSString *toBeString = textField.text;
    int maxLengh = 8;
    toBeString = [toBeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *message = [NSString stringWithFormat:@"当前内容最多限制%d个字符",maxLengh];
    NSStringEncoding stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingEUC_CN);
    UITextRange *markedTextRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:markedTextRange.start offset:0];
    //高亮状态跳过
    if (position) {
        return;
    }
    NSData *data = [toBeString dataUsingEncoding:NSUTF8StringEncoding];

    if ([toBeString jc_lengthForChineseAndEnglish] > maxLengh) {
        NSData *  lastData =  [data subdataWithRange:NSMakeRange(maxLengh-3, 2)];
        NSString *str1 = [[NSString alloc] initWithData:lastData encoding:stringEncoding];

        NSData *  lastData3 =  [data subdataWithRange:NSMakeRange(maxLengh-2, 2)];
        NSString *str3 = [[NSString alloc] initWithData:lastData3 encoding:stringEncoding];

        NSData *  lastData2 =  [data subdataWithRange:NSMakeRange(maxLengh-1, 2)];
        NSString *str2 = [[NSString alloc] initWithData:lastData2 encoding:stringEncoding];

        NSData *  lastData4 =  [data subdataWithRange:NSMakeRange(maxLengh-4, 2)];
        NSString *str4 = [[NSString alloc] initWithData:lastData4 encoding:stringEncoding];


        if (([str1 jc_isChinese]&&![str3 jc_isChinese] && [str2 jc_isChinese]) ||(![str1 jc_isChinese]&&![str3 jc_isChinese] && [str2 jc_isChinese]) || ([str1 jc_isChinese]&[str3 jc_isChinese] && [str2 jc_isChinese]&&![str4 jc_isChinese])) {
            data = [data subdataWithRange:NSMakeRange(0, maxLengh-1)];;
        }else{
            data = [data subdataWithRange:NSMakeRange(0, maxLengh)];
        }

        NSString *str = [[NSString alloc] initWithData:data encoding:stringEncoding];
        textField.text = str;
    }
    if (data.length > maxLengh) {
        //判断最后剩一个字符是中文还是英文
        NSData *  lastData = [data subdataWithRange:NSMakeRange(maxLengh, 2)];
        NSString *str1 = [[NSString alloc] initWithData:lastData encoding:stringEncoding];
        if ([str1 jc_isChinese]) {
            data = [data subdataWithRange:NSMakeRange(0, maxLengh-1)];
        }else{
            data = [data subdataWithRange:NSMakeRange(0, maxLengh)];
        }
        NSString *str = [[NSString alloc] initWithData:data encoding:stringEncoding];
        textField.text = str;
    }
}*/


#pragma mark - 方法三
- (void)changedTextField:(UITextField *)textField {
    if (MaxNumberOfDescriptionChars == 0)
        return;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[textField textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {                      // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
        //可以计算文字长度。否则此时计算出来的字符长度可能不正确
        
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分(感觉输入中文的时候才有)
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //中文和字符一起检测  中文是两个字符
            if ([toBeString jc_getStringLenthOfBytes] > MaxNumberOfDescriptionChars) {
                textField.text = [toBeString jc_subBytesOfstringToIndex:MaxNumberOfDescriptionChars];
            }
        }
    } else {
        if ([toBeString jc_getStringLenthOfBytes] > MaxNumberOfDescriptionChars) {
            textField.text = [toBeString jc_subBytesOfstringToIndex:MaxNumberOfDescriptionChars];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
