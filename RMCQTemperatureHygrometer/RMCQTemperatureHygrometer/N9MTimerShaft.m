//
//  N9MTimerShaft.m
//  N9MPad
//
//  Created by 刘超 on 14-8-5.
//  Copyright (c) 2014年 frank. All rights reserved.
//

#import "N9MTimerShaft.h"

@implementation N9MTimerShaft

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		UIImageView*backGround=[[UIImageView alloc]initWithFrame:CGRectMake(20, self.frame.size.height*1/4, self.frame.size.width-40, self.frame.size.height*1/2)];
		[backGround setImage:[UIImage imageNamed:@"timeslider_timershaft_backgroud.png"]];
		backGround.multipleTouchEnabled = YES;
		backGround.userInteractionEnabled = YES;
		[self addSubview:backGround];
		_timerShaftScrollView=[[N9MTimerShaftScrollView alloc]initWithFrame:CGRectMake(40,self.frame.size.height*1/4, self.frame.size.width-80, self.frame.size.height*1/2)];
		[_timerShaftScrollView setBackgroundColor:[UIColor clearColor]];
		
		[self addSubview:_timerShaftScrollView];
		NSLog(@"%f",_timerShaftScrollView.frame.size.width);
		_timerShaftScrollView.contentSize=CGSizeMake(320, 0);
		_timerShaftScrollView.contentOffset=CGPointMake(240, 0);
    }
    return self;
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
