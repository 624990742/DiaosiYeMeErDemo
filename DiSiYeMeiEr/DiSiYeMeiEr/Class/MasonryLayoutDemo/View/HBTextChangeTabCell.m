//
//  HBTextChangeTabCell.m
//  HBTextShowAndPackUp
//
//  Created by Mac on 2020/10/11.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "HBTextChangeTabCell.h"
#import "NSString+LeeLabelAddtion.h"
#import <Masonry.h>
#import "YYKit.h"
#import "UIView+YYAdd.h"

/************************字体*******************************/
//平方字体
#define     YRY_FONT_TEXT_Regular       @"PingFangSC-Regular"
//粗体
#define     YRY_FONT_TEXT_Medium        @"PingFangSC-Medium"
//
#define     YRY_FONT_TEXT_Light         @"PingFangSC-Light"
//字体大小
#define FONT(__SIZE)       [UIFont fontWithName:YRY_FONT_TEXT_Regular size: __SIZE]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//大标题标题黑色
#define     Color_label_DataTitle        RGBA(52, 52, 52, 1)
/**
系统高度，宽度 bounds
*/
#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)
#define WEAKSELF typeof(self) __weak weakSelf = self
@interface HBTextChangeTabCell ()
@property (nonatomic ,strong)UIView *contentBaseView;
@property (nonatomic ,strong)YYLabel *contentLabel;
@end
@implementation HBTextChangeTabCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //添加子视图
        [self setInitViewUI];
    }
    return self;
}
-(void)setModel:(HBTextChangeModel *)model{
    _model = model;
    NSString *desc = model.content;
    if (desc) {
        //计算文本高度
        CGFloat height = [desc heightWithStrAttri:@{NSFontAttributeName:FONT(15), NSForegroundColorAttributeName: Color_label_DataTitle,NSParagraphStyleAttributeName:[self paragraphStyle]} withLabelWidth:SCREEN_WIDTH];
        if (height > 67) { //超过3行
            if (model.showAll) {
                //拼接再算高度
                height = [[NSString stringWithFormat:@"%@...收起",desc] heightWithStrAttri:@{NSFontAttributeName:FONT(15), NSForegroundColorAttributeName: Color_label_DataTitle,NSParagraphStyleAttributeName:[self paragraphStyle]} withLabelWidth:SCREEN_WIDTH];
                
                [self.contentBaseView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(height+5);
                }];
                self.contentLabel.truncationToken = nil;
                [self setShowTextWithDesc:desc];
            } else {
                
                [self.contentBaseView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_lessThanOrEqualTo(67);
                }];
                [self setAdjustableTextWithDesc:desc];
            }
        } else {
            [self.contentBaseView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height+10);
            }];
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:desc attributes:@{ NSFontAttributeName:FONT(15), NSParagraphStyleAttributeName : [self paragraphStyle]}];
            self.contentLabel.attributedText = text;
        }
    }
}
- (void)setShowTextWithDesc:(NSString *)desc
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@...收起",desc] attributes:@{ NSFontAttributeName:FONT(15), NSParagraphStyleAttributeName : [self paragraphStyle]}];
    
    WEAKSELF;
    //设置高亮色和点击事件
    [text setTextHighlightRange:[[text string] rangeOfString:@"收起"] color:[UIColor colorWithHexString:@"#0099FF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        weakSelf.model.showAll = NO;
        if (self.updateMessageCellBlock) {
            self.updateMessageCellBlock(@"");
        }

    }];
    self.contentLabel.attributedText = text;
}

- (NSMutableParagraphStyle *)paragraphStyle {
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 5.f;
    return para;
}

- (void)setAdjustableTextWithDesc:(NSString *)desc
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:desc attributes:@{ NSFontAttributeName:FONT(15), NSParagraphStyleAttributeName : [self paragraphStyle]}];
    self.contentLabel.attributedText = text;
    
    WEAKSELF;
    NSMutableAttributedString *showAll = [[NSMutableAttributedString alloc] initWithString:@"...展开" attributes:nil];
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithHexString:@"#009900"]];
    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
        weakSelf.model.showAll = YES;
        if (self.updateMessageCellBlock) {
            self.updateMessageCellBlock(@"");
        }
    };
    
    NSRange range = [showAll.string rangeOfString:@"展开"];
    [showAll setColor:[UIColor colorWithHexString:@"#0099FF"] range:range];
    [showAll setTextHighlight:hi range:range];
    showAll.font = FONT(15);
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = showAll;
    [seeMore sizeToFit];
//    seeMore.height += 2.f;
    
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:FONT(15) alignment:YYTextVerticalAlignmentTop];
    self.contentLabel.truncationToken = truncationToken;
}
#pragma mark ==========添加子视图==========
-(void)setInitViewUI{
    [self.contentView addSubview:self.contentBaseView];
    [self.contentBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
    

    self.contentLabel = [[YYLabel alloc] init];
    self.contentLabel.font = FONT(15.f);
    self.contentLabel.textColor = Color_label_DataTitle;
    self.contentLabel.numberOfLines = 0;
    [self.contentBaseView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.contentBaseView);
    }];
}
#pragma mark ==========getter==========
-(UIView *)contentBaseView{
    if (!_contentBaseView) {
        _contentBaseView = ({
            UIView *view = [UIView new];//初始化控件
            view.backgroundColor = [UIColor whiteColor];
            view ;
        }) ;
    }
    return _contentBaseView ;
}
@end
