//
//  TAViewController.m
//  TestCoreText
//
//  Created by lx on 14-1-16.
//  Copyright (c) 2014年 Talon. All rights reserved.
//

#import "TAViewController.h"
#import "TASubLabel.h"
@interface TAViewController ()
{
    TANewCoreTextLabel *Custumlabel;
    NSMutableAttributedString *containAttrStr;

}
@end

@implementation TAViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *text
    = @"有传节目播出后，邓紫棋身价已经从20万元上涨到40万元。邓紫棋的好表现甚至连林忆莲也“妒忌”。昨日有香港媒体报道称，湖南卫视以100万元人民币一集的天价，邀请林忆莲在中段加入《我是歌手2》，不过林忆莲提出要让邓紫棋走人作为条件。不过截至发稿前，湖南卫视方面都尚未有回应。 (记者 何珊)";
    //    NSString *text1
    //    = @"";
    //    NSString *text2
    //    = @"";
    

    CGRect frame = CGRectMake(26, 44, 268, 100);
    TASubLabel *aaa=[[TASubLabel alloc] initWithFrame:frame];
//    Custumlabel = [[TANewCoreTextLabel alloc] initWithFrame:frame];
//    Custumlabel.delegate = self;
//    Custumlabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aaa];
    
    frame = aaa.frame;
    aaa.showText = text;
    frame.size = aaa.adjustSize;
    aaa.frame = frame;
    aaa.backgroundColor=[UIColor blueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
