//
//  libsHeader.h
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#ifndef libsHeader_h
#define libsHeader_h


#ifdef  __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import "UIColor+JCColorCategory.h"
#import "NSString+JCMethond.h"
#import "WBViewControllerManager.h"
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif

#endif /* libsHeader_h */
