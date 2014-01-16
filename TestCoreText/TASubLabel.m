//
//  TASubLabel.m
//  TestCoreText
//
//  Created by lx on 14-1-16.
//  Copyright (c) 2014年 Talon. All rights reserved.
//

#import "TASubLabel.h"

@implementation TASubLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setTheAttributedString
{
    NSLog(@"%lu",(unsigned long)[self.showText length]);
        [super setTextColor:[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0] Range:NSMakeRange(0, [self.showText length])];
        [super setTextFont:[UIFont systemFontOfSize:17] Range:NSMakeRange(0, [self.showText length])];
//        for (ASResourceTagData *resourceTagData in _saveResource.resourceTagDataArray) {
//            int loc=[resourceTagData.resourceTagDataLocation intValue];
//            int len=[resourceTagData.resourceTagDataLength intValue];
//            [self setTextColor:[UIColor colorWithRed:232.0/255.0 green:66.0/255.0 blue:86.0/255 alpha:1.0] Range:NSMakeRange(loc,len)];
//        }
//    
        [super setTextStyleLinesSpacing:TEXT_LINES_SPACEING ParagraphSpacing:TEXT_PARAGRAPH_SPACING FirstLineHeadIndent:FIRST_LINE_HEAD_INDENT Range:NSMakeRange(0, [self.showText length])];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
