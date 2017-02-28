//
//  N9MTimerShaftScrollView.m
//  N9MPad
//
//  Created by 刘超 on 14-8-5.
//  Copyright (c) 2014年 frank. All rights reserved.
//

#import "N9MTimerShaftScrollView.h"

@implementation N9MTimerShaftScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        self.labelFontWidth=[UIFont systemFontOfSize:25.0f];
        self.laelFontHeight=[UIFont systemFontOfSize:25.0f];
        self.pagingEnabled=YES;
		self.showsHorizontalScrollIndicator=NO;
		self.showsVerticalScrollIndicator=NO;
		self.scrollsToTop=NO;
		self.contentSize=CGSizeMake(320, 0);
		UIView*aView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		[aView setBackgroundColor:[UIColor redColor]];
		[self addSubview:aView];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
	
	_unitConut=(24*60*60)/(60*60*12);
	_scaleCount=(24*60*60)/(60*60*1);
	 NSInteger startpointX=0;//刻度尺的起点横坐标
	float timerShaftWidth=(self.frame.size.width)*_unitConut;
	float scaleWidth=timerShaftWidth/_scaleCount;
	[self drawRectSliderStartpointAbscissa:startpointX timeSliderWidth:timerShaftWidth addScaleWidth:scaleWidth addScaleCount:_scaleCount addSliderShortScaleCount:4];
}
-(void)updateScaleValudeForHour:(NSInteger)hour addSliderShortScaleCount:(NSInteger)count{
	self.hour=hour;
	self.shortScaleCount=count;
}
-(void)drawRectSliderStartpointAbscissa:(float)abscissa timeSliderWidth:(float)sliderWidth addScaleWidth:(float)scaleWidth addScaleCount:(NSInteger)scaleCount addSliderShortScaleCount:(NSInteger)shortScaleCount{
	 
	float sliderY=self.frame.size.height-14;
	CGContextRef context=UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);//线条颜色
	CGContextMoveToPoint(context,0+abscissa,sliderY+14); //线条起始点
	CGContextAddLineToPoint(context,sliderWidth+abscissa,sliderY+14);//线条结束点
	CGContextStrokePath(context);//结束，也就是开始画
	CGContextSetLineWidth(context, 3.0);//线的宽度
    for (int i=0; i<scaleCount+1; i++) {
		CGPoint pointA;
        pointA.x=scaleWidth*i+abscissa;
        pointA.y=sliderY;
        CGPoint pointB;
        pointB.x=scaleWidth*i+abscissa;
        pointB.y=sliderY+14;
        CGContextMoveToPoint(context,pointA.x,pointA.y); //线条起始点
        CGContextAddLineToPoint(context,pointB.x,pointB.y);//线条结束点
        CGContextStrokePath(context);//结束，也就是开始画
        NSString*title;
        if (i<10) {
            title=[NSString stringWithFormat:@"0%d",i];
        }else{
            title=[NSString stringWithFormat:@"%d",i];
        }
		CGPoint pointC;
        pointC.x=scaleWidth*i+abscissa-7;
        pointC.y=self.frame.size.height*1/2-5;
		if (i==0) {
			pointC.x=scaleWidth*i+abscissa-2;
		}else if (i==scaleCount){
			pointC.x=scaleWidth*i+abscissa-15;
		}
       [self drawThermometersLablesStartpoint:pointC LableTitle:title];
        if (i!=scaleCount) {
            for (int j=0; j<shortScaleCount; j++) {
                float minScaleWidth=scaleWidth/(shortScaleCount+1);
                CGPoint pointC;
                pointC.x=scaleWidth*i+minScaleWidth*(j+1)+abscissa;
                pointC.y=sliderY+7;
                CGPoint pointD;
                pointD.x=scaleWidth*i+minScaleWidth*(j+1)+abscissa;
                pointD.y=sliderY+14;
                CGContextMoveToPoint(context,pointC.x,pointC.y); //线条起始点
                CGContextAddLineToPoint(context,pointD.x,pointD.y);//线条结束点
                CGContextStrokePath(context);//结束，也就是开始画
            }
        }
    }
}

-(void)drawThermometersLablesStartpoint:(CGPoint)point LableTitle:(NSString*)title{
    
    NSDictionary*attributes=@{NSFontAttributeName: [UIFont systemFontOfSize:15] ,NSForegroundColorAttributeName:[UIColor whiteColor]};
	
    CGRect labelLocation=CGRectMake(point.x, point.y, [self widthOfString:title withFont:self.labelFontWidth], [self widthOfString:title withFont:self.laelFontHeight]);
	if ( [[UIDevice currentDevice].systemVersion doubleValue]>=7.0) {
		[title drawInRect:labelLocation withAttributes:attributes];
	}else{
		[title drawInRect:labelLocation withFont:self.labelFontWidth];
		[[UIColor whiteColor]set];
	}
	
}
- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont*)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
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
