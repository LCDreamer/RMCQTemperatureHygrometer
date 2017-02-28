//
//  RMCQThermometer.m
//  RMCQTemperatureHygrometer
//
//  Created by 刘超 on 14-3-26.
//  Copyright (c) 2014年 刘超. All rights reserved.
//

#import "RMCQThermometer.h"
#import <QuartzCore/QuartzCore.h>
#define RADIUS 30
#define POINTER_RADIUS 15
#define RulerCount 7
@implementation RMCQThermometer
@synthesize celsiusValue;
@synthesize PointerValue;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.labelFontWidth=[UIFont systemFontOfSize:10.0f];
        self.laelFontHeight=[UIFont systemFontOfSize:10.0f];
        self.labelColor= [UIColor whiteColor];
		self.PointerValue=self.frame.size.height*6/8;
    }
    return self;
}
-(void)dealloc{
	[super dealloc];
	
}
- (void)drawRect:(CGRect)rect
{
	/*---------------绘制温度计底部红色部分，包括一个圆和一个矩形 -------------------------*/
    CGContextRef context=UIGraphicsGetCurrentContext();
	UIColor*aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    CGContextAddArc(context, (self.frame.size.width)/2,(self.frame.size.height-self.frame.size.width)+self.frame.size.width/2, RADIUS, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill); //绘制路径
	
	CGContextFillRect(context, CGRectMake((self.frame.size.width/2)-RADIUS/2, self.frame.size.height*6/8, RADIUS, self.frame.size.width/2));
	CGContextDrawPath(context, kCGPathFill); //绘制路径
	
	
	/*---------------画尺子部分-------------------------*/
	CGContextRef contextRuler=UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(contextRuler, [[UIColor yellowColor] CGColor]);
	CGContextFillRect(contextRuler, CGRectMake((self.frame.size.width/2)-RADIUS/2, self.frame.size.height*1/10, RADIUS , self.frame.size.height*6/8-self.frame.size.height*1/10));
	 CGContextStrokePath(contextRuler);
	
	/*---------------顶部的半圆尺子顶部的圆-------------------------*/
	CGContextRef contextSemicircle=UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(contextSemicircle, [[UIColor whiteColor] CGColor]);
	CGContextAddArc(contextSemicircle,(self.frame.size.width)/2,self.frame.size.height*1/10 -RADIUS/2, RADIUS/2, 0, 2*M_PI, 0); //添加一个圆
	
	CGContextDrawPath(contextSemicircle, kCGPathFill); //绘制路径
	CGContextFillRect(contextRuler, CGRectMake((self.frame.size.width)/2-(RADIUS/2), self.frame.size.height*1/10 -RADIUS/2, RADIUS ,RADIUS/2));
	CGContextStrokePath(contextRuler);
	
	/*---------------绘制尺子刻度-------------------------*/
	CGPoint startpoint;
	float startpointX=(self.frame.size.width/2)-RADIUS/2-5;
	startpoint.x=startpointX;
	float startpointY= self.frame.size.height*6/8-self.frame.size.height*1/10;
	startpoint.y=startpointY;
	float scaleWidth = (self.frame.size.height*6/8-self.frame.size.height*1/10)/RulerCount;
	float rulerstarLength=self.frame.size.height*6/8;
	[self drawRectThermometerscaleStartpoint:startpoint ScaleWidth:scaleWidth addScaleCount:4 addRulerstarLength:rulerstarLength];
	
	[self drawtheActualTemperatureForValue:self.celsiusValue];
	
	CGContextRef contextPointer=UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(contextPointer, [[UIColor greenColor] CGColor]);
    CGContextSetLineWidth(contextPointer, 3.0);//线的宽度
    CGContextAddArc(contextPointer, (self.frame.size.width)/2,(self.frame.size.height-self.frame.size.width)+self.frame.size.width/2, POINTER_RADIUS, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(contextPointer, kCGPathFill); //绘制路径
	CGContextFillRect(contextPointer, CGRectMake((self.frame.size.width/2)-POINTER_RADIUS/2, self.frame.size.height*6/8, POINTER_RADIUS, self.frame.size.width/2-20));
	CGContextDrawPath(contextPointer, kCGPathFill); //绘制路径
	
	/*---------------画尺子部分-------------------------*/
	CGContextRef contextb = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(contextb, 1.0);//线的宽度
    aColor = [UIColor whiteColor];//blue蓝色
    CGContextSetFillColorWithColor(contextb, aColor.CGColor);//填充颜色
    aColor = [UIColor greenColor];
    CGContextSetStrokeColorWithColor(contextb, aColor.CGColor);//线框颜色
    CGContextAddRect(contextb,CGRectMake((self.frame.size.width/2)-POINTER_RADIUS/2, self.frame.size.height*1/10, POINTER_RADIUS , self.frame.size.height*6/8-self.frame.size.height*1/10));//画方框
    CGContextDrawPath(contextb, kCGPathFillStroke);//绘画路径
	
	
	/*---------------画尺子部分-------------------------*/
	
	CGContextRef contextRulerPointer=UIGraphicsGetCurrentContext();
	if (self.PointerValue<=self.frame.size.height*6/8&&self.PointerValue>=self.frame.size.height*1/10) {
		CGContextSetFillColorWithColor(contextRulerPointer, [[UIColor greenColor] CGColor]);
		CGContextFillRect(contextRulerPointer, CGRectMake((self.frame.size.width/2)-POINTER_RADIUS/2, self.PointerValue, POINTER_RADIUS , self.frame.size.height*6/8-self.PointerValue));
	}else{
		CGContextSetFillColorWithColor(contextRulerPointer, [[UIColor whiteColor] CGColor]);
		CGContextFillRect(contextRulerPointer, CGRectMake((self.frame.size.width/2)-POINTER_RADIUS/2, self.frame.size.height*1/10, POINTER_RADIUS , self.frame.size.height*6/8-self.frame.size.height*1/10));
	}
	
	CGContextStrokePath(contextRulerPointer);
	
	
	
}
-(void)drawRectThermometerscaleStartpoint:(CGPoint)startpoint ScaleWidth:(float)width addScaleCount:(NSInteger)n addRulerstarLength:(float)starLength{
	float startpointX=startpoint.x;
//	float startpointY=startpoint.y;
	CGContextRef contextRulerScale=UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(contextRulerScale, [UIColor whiteColor].CGColor);//线条颜色
	CGContextSetLineWidth(contextRulerScale, 2.0);//线的宽度
	for (int i=0; i<RulerCount+1; i++) {
		CGPoint pointA;
		pointA.x=startpointX; //width*i+abscissa;
        pointA.y=starLength-width*i;
        CGPoint pointB;
        pointB.x=startpointX-20;
        pointB.y=starLength-width*i;
		CGContextMoveToPoint(contextRulerScale,pointA.x,pointA.y); //线条起始点
        CGContextAddLineToPoint(contextRulerScale,pointB.x,pointB.y);//线条结束点
        CGContextStrokePath(contextRulerScale);//结束，也就是开始画
		NSString*title;
		if (i<2) {
			title=[NSString stringWithFormat:@"-%d",(2-i)*10];
		}else{
			if (i==2) {
				title=[NSString stringWithFormat:@"%d℃",(i-2)*10];
			}else{
				title=[NSString stringWithFormat:@"%d",(i-2)*10];
			}
			
		}
		[self drawThermometersLablesStartpoint:pointB LableTitle:title];
		for (int j=0; j<n+1; j++) {
			if (i>=1) {
				float minScaleWidth=width/(n+1);
				CGPoint pointC;
				pointC.x=startpointX;
				pointC.y=starLength-(width*i-minScaleWidth*j);
				CGPoint pointD;
				pointD.x=startpointX-5;
				pointD.y=starLength-(width*i-minScaleWidth*j);
				CGContextMoveToPoint(contextRulerScale,pointC.x,pointC.y); //线条起始点
				CGContextAddLineToPoint(contextRulerScale,pointD.x,pointD.y);//线条结束点
				CGContextStrokePath(contextRulerScale);//结束，也就是开始画
			}
		}
	}
}
-(void)drawThermometersLablesStartpoint:(CGPoint)point LableTitle:(NSString*)title{
    
    NSDictionary*attributes=@{NSFontAttributeName: [UIFont systemFontOfSize:10] ,NSForegroundColorAttributeName:[UIColor whiteColor]};
	
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
-(void)drawtheActualTemperatureForValue:(float)celsius{
	float scaleWidth = (self.frame.size.height*6/8-self.frame.size.height*1/10)/RulerCount;
	if (celsius>=0&&celsius<=50) {
		float actualLength=(scaleWidth*(RulerCount-2)*(celsius/50));
		CGPoint strarpoint;
		strarpoint.y=self.frame.size.height*6/8-(scaleWidth*2+actualLength);
		strarpoint.x=(self.frame.size.width/2)-RADIUS/2;
		CGContextRef contextRuler=UIGraphicsGetCurrentContext();
		CGContextSetFillColorWithColor(contextRuler, [[UIColor redColor] CGColor]);
		CGContextFillRect(contextRuler, CGRectMake(strarpoint.x, strarpoint.y, RADIUS ,scaleWidth*2+actualLength));
		CGContextStrokePath(contextRuler);
	}else if (celsius<0&&celsius>=-20){
		float abccelsius=fabsf(celsius);
		float actualLength=(scaleWidth*2)*(abccelsius/20);
		CGPoint strarpoint;
		strarpoint.y=self.frame.size.height*6/8-(scaleWidth*2-actualLength);
		strarpoint.x=(self.frame.size.width/2)-RADIUS/2;
		CGContextRef contextRuler=UIGraphicsGetCurrentContext();
		CGContextSetFillColorWithColor(contextRuler, [[UIColor redColor] CGColor]);
		CGContextFillRect(contextRuler, CGRectMake(strarpoint.x, strarpoint.y, RADIUS ,scaleWidth*2-actualLength));
		CGContextStrokePath(contextRuler);
	}
	
}
-(void)initTemperatureRegulationValueForCelsius:(float)celsius{
	float scaleWidth = (self.frame.size.height*6/8-self.frame.size.height*1/10)/RulerCount;
	if (celsius>=0&&celsius<=50) {
		float actualLength=(scaleWidth*(RulerCount-2)*(celsius/50));
		CGPoint strarpoint;
		strarpoint.y=self.frame.size.height*6/8-(scaleWidth*2+actualLength);
		strarpoint.x=(self.frame.size.width/2)-RADIUS/2;
		self.PointerValue=strarpoint.y;
	}else if (celsius<0&&celsius>=-20){
		float abccelsius=fabsf(celsius);
		float actualLength=(scaleWidth*2)*(abccelsius/20);
		CGPoint strarpoint;
		strarpoint.y=self.frame.size.height*6/8-(scaleWidth*2-actualLength);
		strarpoint.x=(self.frame.size.width/2)-RADIUS/2;
		self.PointerValue=strarpoint.y;
	}
	
}
-(void)changeTemperatureCelsius:(float)celsius{
	self.celsiusValue=celsius;
	[self setNeedsDisplay];
}
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint point=[touch locationInView:self];
	if (point.y<=self.frame.size.height*6/8&&point.y>=self.frame.size.height*1/10) {
		self.PointerValue=point.y;
		[self setNeedsDisplay];
	}
    [self obtainTemperatureValuesForSlidingDistance:point.y addIsEnd:NO];
    return [super beginTrackingWithTouch:touch withEvent:event];
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint point=[touch locationInView:self];
	if (point.y<=self.frame.size.height*6/8&&point.y>=self.frame.size.height*1/10) {
		self.PointerValue=point.y;
		self.PointerValue=point.y;
		[self setNeedsDisplay];
	}
	[self obtainTemperatureValuesForSlidingDistance:point.y addIsEnd:YES];
    return [super endTrackingWithTouch:touch withEvent:event];
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint point=[touch locationInView:self];
	if (point.y<=self.frame.size.height*6/8&&point.y>=self.frame.size.height*1/10) {
		self.PointerValue=point.y;
		[self setNeedsDisplay];
	}
	[self obtainTemperatureValuesForSlidingDistance:point.y addIsEnd:NO];
    return [super continueTrackingWithTouch:touch withEvent:event];
}
-(void)obtainTemperatureValuesForSlidingDistance:(float)distance addIsEnd:(BOOL)isEnd{
	float scaleWidth = (self.frame.size.height*6/8-self.frame.size.height*1/10)/RulerCount;
	if (distance<=self.frame.size.height*1/10+scaleWidth*5&&distance>=self.frame.size.height*1/10) {
		float a=distance-self.frame.size.height*1/10;
		float d=scaleWidth*5-a;
		float c=d/(scaleWidth*5);
		float celsius=50*c;
		if (delegate) {
			[delegate changesRegulationTemperature:celsius];
			if (isEnd) {
				[delegate endgesRegulationTemperature:celsius];
			}
		}
		
		NSLog(@"**************celsius%f",celsius);
	}else if (distance>self.frame.size.height*1/10+scaleWidth*5&&distance<=self.frame.size.height*6/8){
		float a=distance-self.frame.size.height*1/10-scaleWidth*5;
		float b=a/(scaleWidth*2);
		float celsius=20*(b);
		if (delegate) {
			[delegate changesRegulationTemperature:-celsius];
			if (isEnd) {
				[delegate endgesRegulationTemperature:-celsius];
			}
		}
		NSLog(@"**************celsius-%f",celsius);
	}
}
@end
