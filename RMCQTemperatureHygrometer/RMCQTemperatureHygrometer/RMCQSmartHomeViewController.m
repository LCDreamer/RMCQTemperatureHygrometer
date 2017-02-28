//
//  RMCQSmartHomeViewController.m
//  RMCQTemperatureHygrometer
//
//  Created by 刘超 on 14-3-27.
//  Copyright (c) 2014年 刘超. All rights reserved.
//

#import "RMCQSmartHomeViewController.h"
#import "EFCircularSlider.h"
#import "N9MTimerShaft.h"
@interface RMCQSmartHomeViewController (){
	EFCircularSlider* minuteSlider;
	EFCircularSlider* hourSlider;
}

@end

@implementation RMCQSmartHomeViewController
@synthesize thermometer;
@synthesize hygrometerButton;
@synthesize thermometerButton;
@synthesize swithButton;
@synthesize isSwith;
@synthesize TemperatureRegulation;
@synthesize HumidityRegulation;
@synthesize currentHumidity;
@synthesize currentTemperature;
@synthesize temperatureValue;
@synthesize humidityValue;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc{
	[super dealloc];
	[thermometer release];
	[minuteSlider release];
	[thermometerButton release];
	[hygrometerButton release];
	[swithButton release];
	[TemperatureRegulation release];
	[HumidityRegulation release];
	[currentTemperature release];
	[currentHumidity release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:31/255.0f green:61/255.0f blue:91/255.0f alpha:1.0f];
    CGRect minuteSliderFrame = CGRectMake(110, 160, 210, 210);
    minuteSlider = [[EFCircularSlider alloc] initWithFrame:minuteSliderFrame];
    minuteSlider.unfilledColor = [UIColor colorWithRed:23/255.0f green:47/255.0f blue:70/255.0f alpha:1.0f];
    minuteSlider.filledColor = [UIColor greenColor];//[UIColor colorWithRed:155/255.0f green:211/255.0f blue:156/255.0f alpha:1.0f];
    [minuteSlider setInnerMarkingLabels:@[@"10",  @"20", @"30", @"40", @"50", @"60",@"70", @"80", @"90", @"100", @"110", @"120", @"130", @"140", @"150"]];
    minuteSlider.labelFont = [UIFont systemFontOfSize:14.0f];
    minuteSlider.lineWidth = 10;
    minuteSlider.minimumValue = 0;
    minuteSlider.maximumValue = 150;
    minuteSlider.labelColor = [UIColor colorWithRed:76/255.0f green:111/255.0f blue:137/255.0f alpha:1.0f];
    minuteSlider.handleType = doubleCircleWithOpenCenter;
    minuteSlider.handleColor = minuteSlider.filledColor;
	[minuteSlider humidityConvertedToCircleForCoordinatepoints:80];
	minuteSlider.isSlider=YES;
	[self.view addSubview:minuteSlider];
    [minuteSlider addTarget:self action:@selector(minuteDidChange:) forControlEvents:UIControlEventValueChanged];
	
	CGRect hourSliderFrame = CGRectMake(140, 190, 150, 150);
    hourSlider = [[EFCircularSlider alloc] initWithFrame:hourSliderFrame];
    hourSlider.unfilledColor =[UIColor colorWithRed:23/255.0f green:47/255.0f blue:70/255.0f alpha:1.0f];
    hourSlider.filledColor = [UIColor redColor];//[UIColor colorWithRed:98/255.0f green:243/255.0f blue:252/255.0f alpha:1.0f];
    [hourSlider setInnerMarkingLabels:@[@"10",  @"20", @"30", @"40", @"50", @"60",@"70", @"80", @"90", @"100", @"110", @"120", @"130", @"140", @"150"]];
    hourSlider.labelFont = [UIFont systemFontOfSize:10.0f];
    hourSlider.lineWidth = 10;
    hourSlider.snapToLabels = YES;
    hourSlider.minimumValue = 0;
    hourSlider.maximumValue = 150;
	hourSlider.isSlider=NO;
    hourSlider.labelColor = [UIColor colorWithRed:127/255.0f green:229/255.0f blue:255/255.0f alpha:1.0f];
    hourSlider.handleType = bigCircle;
    hourSlider.handleColor = hourSlider.filledColor;
    [self.view addSubview:hourSlider];
	
	
	thermometer=[[RMCQThermometer alloc]initWithFrame:CGRectMake(self.view.frame.size.width*1/30, self.view.frame.size.height*1/3, self.view.frame.size.width*1/3, self.view.frame.size.height*3/5+50)];
	thermometer.delegate=self;
	[thermometer initTemperatureRegulationValueForCelsius:-5];
	[thermometer setBackgroundColor:[UIColor colorWithRed:31/255.0f green:61/255.0f blue:91/255.0f alpha:1.0f]];
//	[thermometer setTintColor:[UIColor colorWithRed:31/255.0f green:61/255.0f blue:91/255.0f alpha:1.0f]];
	[self.view addSubview:thermometer];

	thermometerButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*1/30, self.view.frame.size.height*9/10, 100, 50)];
	[thermometerButton setTitle:@"当前温度" forState:UIControlStateNormal];
	[thermometerButton addTarget:self action:@selector(chengThermomentervalue:) forControlEvents:UIControlEventTouchUpInside];

	[self.view addSubview:thermometerButton];
	
	hygrometerButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/5, self.view.frame.size.height*9/10, 100, 50)];
	[hygrometerButton setTitle:@"当前湿度" forState:UIControlStateNormal];
	[hygrometerButton addTarget:self action:@selector(changHygrometerValue:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:hygrometerButton];
	
	swithButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*1/3, 50, self.view.frame.size.width*1/3, self.view.frame.size.width*1/3)];
	[swithButton setBackgroundImage:[UIImage imageNamed:@"light_swith_NO"] forState:UIControlStateNormal];
	[swithButton addTarget:self action:@selector(lightSwith:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:swithButton];
	
	for (int i=0; i<4; i++) {
		UILabel*hygrometer=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/3-70, self.view.frame.size.height*3/5+20*i+70, 100, 30)];
		hygrometer.tag=i;
		if (i==0) {
			[hygrometer setText:@"当前湿度:"];
		}else if (i==1){
			[hygrometer setText:@"调控湿度:"];
		}else if (i==2){
			[hygrometer setText:@"当前温度:"];
		}else if (i==3){
			[hygrometer setText:@"调控温度:"];
		}
		
		[self.view addSubview:hygrometer];
		[hygrometer release];
	}
	
	
	for (int i=0; i<4; i++) {
		CGRect frame=CGRectMake(self.view.frame.size.width*2/3+5, self.view.frame.size.height*3/5+20*i+70, 100, 30);
		if (i==0) {
			currentHumidity=[[UILabel alloc]initWithFrame:frame];
			[self.view addSubview:currentHumidity];
			
		}else if (i==1){
			HumidityRegulation=[[UILabel alloc]initWithFrame:frame];
			[HumidityRegulation setText:@"0.0"];
			[self.view addSubview:HumidityRegulation];
		}else if (i==2){
			currentTemperature=[[UILabel alloc]initWithFrame:frame];
			[self.view addSubview:currentTemperature];
			
		}else if (i==3){
			TemperatureRegulation=[[UILabel alloc]initWithFrame:frame];
			[TemperatureRegulation setText:@"0.0"];
			[self.view addSubview:TemperatureRegulation];
			
		}
	}
	
	N9MTimerShaft*timerShaft=[[N9MTimerShaft alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
	[self.view addSubview:timerShaft];
    // Do any additional setup after loading the view.
}
-(void)minuteDidChange:(EFCircularSlider*)slider {
    int newVal = (int)slider.currentValue < 150 ? (int)slider.currentValue : 0;
	NSLog(@"neval%d",newVal);
	self.humidityValue=newVal;
	NSString*hygrometer=[NSString stringWithFormat:@"%d",newVal];
	[HumidityRegulation setText:hygrometer];

	
}
-(void)changesRegulationTemperature:(float)celsius{
	NSString*value=[NSString stringWithFormat:@"%0.2f",celsius];
	[TemperatureRegulation setText:value];
	self.temperatureValue=celsius;

}
-(void)endgesRegulationTemperature:(float)celsius{
	NSString*value=[NSString stringWithFormat:@"%0.2f",celsius];
	NSLog(@"+++++++++++++%@",value);
//	[TemperatureRegulation setText:value];
//	self.temperatureValue=celsius;
}
- (void)chengThermomentervalue:(UIButton*)sender {
	UIButton*button=sender;
	if (thermometer) {
		int x = arc4random() % 50;
		[thermometer changeTemperatureCelsius:x];
		NSString*value=[NSString stringWithFormat:@"%d",x];
		[button setTitle:value forState:UIControlStateNormal];
		[currentTemperature setText:value];
	}
	
}
- (void)changHygrometerValue:(id)sender {
	UIButton*button=sender;
	int x = arc4random() % 150;
	
	NSString*value=[NSString stringWithFormat:@"%d",x];
	[hourSlider humidityConvertedToCircleForCoordinatepoints:x];
	[button setTitle:value forState:UIControlStateNormal];
	[currentHumidity setText:value];
//	[self. setText:value];
}
-(void)currentTemperaturevalueForCelsius:(float)celsius{
	if (thermometer) {
		[thermometer changeTemperatureCelsius:celsius];
	}
}
-(void)currentHumidityValueForHumidity:(float)Humidity
{
	
}
-(float)temperatureValueRegulation{
	return self.temperatureValue;
}
-(float)humidityValueRegulation{
	return self.humidityValue;
}
- (void)lightSwith:(UIButton*)sender {
	if (!isSwith) {
		isSwith=YES;
		[self.swithButton setBackgroundImage:[UIImage imageNamed:@"light_swith-OFF"] forState:UIControlStateNormal];
	}else{
		isSwith=NO;
		[self.swithButton setBackgroundImage:[UIImage imageNamed:@"light_swith_NO"] forState:UIControlStateNormal];
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
