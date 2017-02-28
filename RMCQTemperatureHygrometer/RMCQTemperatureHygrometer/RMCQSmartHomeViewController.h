//
//  RMCQSmartHomeViewController.h
//  RMCQTemperatureHygrometer
//
//  Created by 刘超 on 14-3-27.
//  Copyright (c) 2014年 刘超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMCQThermometer.h"
@interface RMCQSmartHomeViewController : UIViewController<RMCQThermometerDelegate>{
	RMCQThermometer*thermometer;
	UIButton*thermometerButton;
	UIButton*hygrometerButton;
	UIButton*swithButton;
	BOOL isSwith;
	UILabel*currentHumidity;
	UILabel*HumidityRegulation;
	UILabel*currentTemperature;
	UILabel*TemperatureRegulation;
	float temperatureValue;
	float humidityValue;

}
@property(nonatomic,retain)RMCQThermometer*thermometer;
@property(nonatomic,retain)UIButton*thermometerButton;
@property(nonatomic,retain)UIButton*hygrometerButton;
@property(nonatomic,retain)UIButton*swithButton;
@property(nonatomic,assign)BOOL isSwith;
@property(nonatomic,retain)UILabel*currentHumidity;
@property(nonatomic,retain)UILabel*HumidityRegulation;
@property(nonatomic,retain)UILabel*currentTemperature;
@property(nonatomic,retain)UILabel*TemperatureRegulation;
@property(nonatomic,assign)float temperatureValue;
@property(nonatomic,assign)float humidityValue;
-(void)currentTemperaturevalueForCelsius:(float)celsius;//当前温度接口
-(void)currentHumidityValueForHumidity:(float)Humidity;//当前湿度接口
-(float)temperatureValueRegulation;//调控温度接口
-(float)humidityValueRegulation;//调控湿度接口
@end
