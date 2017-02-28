//
//  ViewController.m
//  RMCQTemperatureHygrometer
//
//  Created by 刘超 on 14-3-26.
//  Copyright (c) 2014年 刘超. All rights reserved.
//

#import "ViewController.h"
#import "EFCircularSlider.h"
#import "N9MTimerShaft.h"
@interface ViewController (){
	EFCircularSlider* minuteSlider;
}

@end

@implementation ViewController
@synthesize myThermometer;
@synthesize humidityRegulation;
@synthesize currentHumidity;
@synthesize currentTemperature;
@synthesize temperatureRegulation;
@synthesize isSwith;
@synthesize sunButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.myThermometer.delegate=self;
	self.isSwith=NO;
	self.view.backgroundColor = [UIColor colorWithRed:31/255.0f green:61/255.0f blue:91/255.0f alpha:1.0f];
    CGRect minuteSliderFrame = CGRectMake(110, 160, 210, 210);
    minuteSlider = [[EFCircularSlider alloc] initWithFrame:minuteSliderFrame];
    minuteSlider.unfilledColor = [UIColor colorWithRed:23/255.0f green:47/255.0f blue:70/255.0f alpha:1.0f];
    minuteSlider.filledColor = [UIColor colorWithRed:155/255.0f green:211/255.0f blue:156/255.0f alpha:1.0f];
    [minuteSlider setInnerMarkingLabels:@[@"10",  @"20", @"30", @"40", @"50", @"60",@"70", @"80", @"90", @"100", @"110", @"120", @"130", @"140", @"150"]];
    minuteSlider.labelFont = [UIFont systemFontOfSize:14.0f];
    minuteSlider.lineWidth = 10;
    minuteSlider.minimumValue = 0;
    minuteSlider.maximumValue = 150;
    minuteSlider.labelColor = [UIColor colorWithRed:76/255.0f green:111/255.0f blue:137/255.0f alpha:1.0f];
    minuteSlider.handleType = doubleCircleWithOpenCenter;
    minuteSlider.handleColor = minuteSlider.filledColor;
	[self.view addSubview:minuteSlider];
    [minuteSlider addTarget:self action:@selector(minuteDidChange:) forControlEvents:UIControlEventValueChanged];
	[minuteSlider release];
	N9MTimerShaft*timerShaft=[[N9MTimerShaft alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
	[self.view addSubview:timerShaft];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)minuteDidChange:(EFCircularSlider*)slider {
    int newVal = (int)slider.currentValue < 150 ? (int)slider.currentValue : 0;
	NSLog(@"neval%d",newVal);
	NSString*hygrometer=[NSString stringWithFormat:@"%d",newVal];
	[self.humidityRegulation setText:hygrometer];
	
}
-(void)changesRegulationTemperature:(float)celsius{
	NSString*value=[NSString stringWithFormat:@"%f",celsius];
	[self.temperatureRegulation setText:value];
}

- (IBAction)chengThermomentervalue:(UIButton*)sender {
	UIButton*button=sender;
	if (myThermometer) {
		int x = arc4random() % 50;
		[myThermometer changeTemperatureCelsius:x];
		NSString*value=[NSString stringWithFormat:@"%d",x];
		[button setTitle:value forState:UIControlStateNormal];
		[self.currentTemperature setText:value];
	}
	
}

- (IBAction)sunSwitch:(id)sender {
	if (!isSwith) {
		isSwith=YES;
		[self.sunButton setBackgroundImage:[UIImage imageNamed:@"light_swith-OFF"] forState:UIControlStateNormal];
	}else{
		isSwith=NO;
		[self.sunButton setBackgroundImage:[UIImage imageNamed:@"light_swith_NO"] forState:UIControlStateNormal];
	}
}

- (IBAction)changHygrometerValue:(id)sender {
	UIButton*button=sender;
	int x = arc4random() % 150;
	NSString*value=[NSString stringWithFormat:@"%d",x];
	[button setTitle:value forState:UIControlStateNormal];
	[self.currentHumidity setText:value];
}

@end
