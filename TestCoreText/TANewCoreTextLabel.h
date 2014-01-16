//
//  TANewCoreTextLabel.h
//  TestCoreText
//
//  Created by lx on 14-1-16.
//  Copyright (c) 2014年 Talon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface TANewCoreTextLabel : UILabel
{
    CTFrameRef textFrame;
    NSMutableAttributedString *attributedString;
}
@property (copy, nonatomic) NSString *showText;
@property (nonatomic) CGFloat adjustWidth;
@property (nonatomic) CGSize adjustSize;

- (void)updateFrameWithAttributedString;

-(void)setTextCharacterSpacing:(int)characterSpacing Range:(NSRange)Range;
//设置行间距、段间距
-(void)setTextStyleLinesSpacing:(CGFloat)LinesSpacing ParagraphSpacing:(CGFloat)ParagraphSpacing Range:(NSRange)Range;
//设置行间距、段间距、首行缩进值
-(void)setTextStyleLinesSpacing:(CGFloat)LinesSpacing ParagraphSpacing:(CGFloat)ParagraphSpacing FirstLineHeadIndent:(CGFloat)firstHeadIndent Range:(NSRange)Range;
//设置文本字体
-(void)setTextFont:(UIFont *)textFont Range:(NSRange)Range;
//设置字体颜色
-(void)setTextColor:(UIColor *)textColor Range:(NSRange)Range;
//设置下划线
-(void)setUnderLineRange:(NSRange)Range;

@end
