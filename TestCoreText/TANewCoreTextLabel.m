//
//  TANewCoreTextLabel.m
//  TestCoreText
//
//  Created by lx on 14-1-16.
//  Copyright (c) 2014年 Talon. All rights reserved.
//

#import "TANewCoreTextLabel.h"

@implementation TANewCoreTextLabel
{
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _adjustWidth = CGRectGetWidth(frame);

    }
    return self;
}
- (void)dealloc
{
    if (textFrame) {
        CFRelease(textFrame), textFrame = NULL;
    }
}
// Don't use this method for origins. Origins always depend on the height of the rect.
CGPoint CGPointFlipped(CGPoint point, CGRect bounds)
{
	return CGPointMake(point.x, CGRectGetMaxY(bounds) - point.y);
}

CGRect CGRectFlipped(CGRect rect, CGRect bounds)
{
	return CGRectMake(CGRectGetMinX(rect),
                      CGRectGetMaxY(bounds) - CGRectGetMaxY(rect),
                      CGRectGetWidth(rect),
                      CGRectGetHeight(rect));
}
- (void)drawRect:(CGRect)rect
{
    if (textFrame) {
        @autoreleasepool {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,rect.size.height);
            CGContextConcatCTM(context, flipVertical);
            CGContextSetTextDrawingMode(context, kCGTextFill);
            
            // 获取CTFrame中的CTLine
            CFArrayRef lines = CTFrameGetLines(textFrame);
            CGPoint origins[CFArrayGetCount(lines)];
            CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
            CTFrameDraw(textFrame,context);
        }
    }
}
-(void)setShowText:(NSString *)string
{
    _showText=[string copy];
    attributedString=[[NSMutableAttributedString alloc] initWithString:string];

    [self setTheAttributedString];
    [self updateFrameWithAttributedString];
    [self setNeedsDisplay];

}
-(float)getHeightAndSetByShowText:(NSString *)string AndFrame:(CGRect)showFrame
{
    _adjustWidth = CGRectGetWidth(showFrame);
    _showText=[string copy];
    attributedString=[[NSMutableAttributedString alloc] initWithString:string];
    //加载attributedString
    [self setTheAttributedString];
    //更新设置
    [self updateFrameWithAttributedString];
    //刷新界面
    [self setNeedsDisplay];
    //设置自身Frame
    [self setFrame:CGRectMake(showFrame.origin.x, showFrame.origin.y, showFrame.size.width, _adjustSize.height)];
    return _adjustSize.height;
    
}

- (void)updateFrameWithAttributedString
{
    if (textFrame) {
        CFRelease(textFrame), textFrame = NULL;
    }
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CFRange fitCFRange = CFRangeMake(0,0);
    CGSize maxSize = CGSizeMake(_adjustWidth, CGFLOAT_MAX);
    CGSize sz = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0,0),NULL,maxSize,&fitCFRange);
    _adjustSize = sz;
    CGRect rect = (CGRect){CGPointZero, sz};
    CGPathAddRect(path, NULL, rect);
    
    textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    CGPathRelease(path);
    CFRelease(framesetter);
}
#pragma mark --
#pragma mark set the style call me in handleTheEffect
-(void)setTheAttributedString
{
    
}

//设置字间距
-(void)setTextCharacterSpacing:(int)characterSpacing Range:(NSRange)Range
{
    long number =(long)characterSpacing;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedString addAttribute: (id)kCTKernAttributeName value: (id)CFBridgingRelease(num) range:Range];
}
//设置行间距、段间距
-(void)setTextStyleLinesSpacing:(CGFloat)LinesSpacing ParagraphSpacing:(CGFloat)ParagraphSpacing Range:(NSRange)Range
{
    //创建文本对齐方式
    CTTextAlignment alignment = kCTTextAlignmentJustified;
    if (self.textAlignment == NSTextAlignmentCenter) {
        alignment = kCTCenterTextAlignment;
    }
    if (self.textAlignment == NSTextAlignmentRight) {
        alignment = kCTRightTextAlignment;
    }
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    //设置文本行间距
    CGFloat lineSpace = LinesSpacing;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacing = ParagraphSpacing;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(paragraphSpacing);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //创建设置数组
    CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings , sizeof(settings)/sizeof(CTParagraphStyleSetting));
    
    //给文本添加设置
    [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(id)CFBridgingRelease(style) range:Range];
}

//设置行间距、段间距、首行缩进值
-(void)setTextStyleLinesSpacing:(CGFloat)LinesSpacing ParagraphSpacing:(CGFloat)ParagraphSpacing FirstLineHeadIndent:(CGFloat)firstHeadIndent Range:(NSRange)Range
{
    //创建文本对齐方式
    CTTextAlignment alignment = kCTTextAlignmentJustified;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        alignment = kCTCenterTextAlignment;
    }
    if (self.textAlignment == NSTextAlignmentRight) {
        alignment = kCTRightTextAlignment;
    }
    
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    
    CTParagraphStyleSetting firstLineHeadIndent;
    firstLineHeadIndent.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    firstLineHeadIndent.valueSize = sizeof(firstHeadIndent);
    firstLineHeadIndent.value =&firstHeadIndent;
    
    CGFloat maxlineSpace = LinesSpacing;
    CTParagraphStyleSetting maxlineSpaceStyle;
    maxlineSpaceStyle.spec = kCTParagraphStyleSpecifierMaximumLineSpacing;
    maxlineSpaceStyle.valueSize = sizeof(maxlineSpace);
    maxlineSpaceStyle.value =&maxlineSpace;
    
    CGFloat minlineSpace = LinesSpacing;
    CTParagraphStyleSetting minlineSpaceStyle;
    minlineSpaceStyle.spec = kCTParagraphStyleSpecifierMinimumLineSpacing;
    minlineSpaceStyle.valueSize = sizeof(minlineSpace);
    minlineSpaceStyle.value =&minlineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacing = ParagraphSpacing;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(paragraphSpacing);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //创建设置数组/
    CTParagraphStyleSetting settings[ ] ={alignmentStyle, firstLineHeadIndent,/*lineSpaceStyle,*/ maxlineSpaceStyle, minlineSpaceStyle, paragraphSpaceStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings , sizeof(settings)/sizeof(CTParagraphStyleSetting));
    
    //给文本添加设置
    [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(id)CFBridgingRelease(style) range:Range];
    
}


//设置文本字体
-(void)setTextFont:(UIFont *)textFont Range:(NSRange)Range
{
    CTFontRef helveticaBold = CTFontCreateWithName((__bridge CFStringRef)textFont.fontName,textFont.pointSize,NULL);
    [attributedString addAttribute:(id)kCTFontAttributeName value:(id)CFBridgingRelease(helveticaBold) range:Range];
}
//设置字体颜色
-(void)setTextColor:(UIColor *)textColor Range:(NSRange)Range
{
    [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(textColor.CGColor) range:Range];
}
//设置下划线
-(void)setUnderLineRange:(NSRange)Range
{
    [attributedString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:Range];
}

@end
