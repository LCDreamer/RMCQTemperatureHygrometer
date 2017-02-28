//
//  ViewController.h
//  RMCQTemperatureHygrometer
//
//  Created by 刘超 on 14-3-26.
//  Copyright (c) 2014年 刘超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMCQThermometer.h"
@interface ViewController : UIViewController<RMCQThermometerDelegate>{
	BOOL isSwith;
	
}
@property (assign, nonatomic) IBOutlet RMCQThermometer *myThermometer;
- (IBAction)chengThermomentervalue:(id)sender;
- (IBAction)sunSwitch:(id)sender;
@property (assign, nonatomic) IBOutlet UILabel *currentTemperature;
@property (assign, nonatomic) IBOutlet UILabel *currentHumidity;
@property (assign, nonatomic) IBOutlet UILabel *humidityRegulation;
@property (assign, nonatomic) IBOutlet UILabel *temperatureRegulation;
@property (assign, nonatomic) IBOutlet UIButton *avatarImage;
@property (assign, nonatomic) IBOutlet UIButton *sunButton;
@property(nonatomic,assign)BOOL isSwith;
@end
