//
//  RMCQThermometer.h
//  RMCQTemperatureHygrometer
//
//  Created by 刘超 on 14-3-26.
//  Copyright (c) 2014年 刘超. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RMCQThermometerDelegate;
@interface RMCQThermometer : UIControl
@property (nonatomic, strong) UIFont* labelFontWidth;
@property(nonatomic,strong) UIFont *laelFontHeight;
@property (nonatomic, strong) UIColor* labelColor;
@property(nonatomic,assign)float celsiusValue;
@property(nonatomic,assign) float PointerValue;
@property(nonatomic,assign)id<RMCQThermometerDelegate>delegate;
-(void)changeTemperatureCelsius:(float)celsius;
-(void)initTemperatureRegulationValueForCelsius:(float)celsius;
@end
@protocol RMCQThermometerDelegate
-(void)changesRegulationTemperature:(float)celsius;
-(void)endgesRegulationTemperature:(float)celsius;
@end