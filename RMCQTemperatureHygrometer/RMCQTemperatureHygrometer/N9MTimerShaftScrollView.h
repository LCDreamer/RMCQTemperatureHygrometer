//
//  N9MTimerShaftScrollView.h
//  N9MPad
//
//  Created by 刘超 on 14-8-5.
//  Copyright (c) 2014年 frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface N9MTimerShaftScrollView : UIScrollView
@property(nonatomic,assign)NSInteger unitConut;//有几个单元，每一个单元是(self.frame.size.width)
@property(nonatomic,assign)NSInteger scaleCount;//有多少个单位刻度
@property (nonatomic, strong) UIFont* labelFontWidth;
@property(nonatomic,strong)UIFont*laelFontHeight;
@property (nonatomic, strong) UIColor* labelColor;
@property(nonatomic,assign)NSInteger hour;
@property(nonatomic,assign)NSInteger shortScaleCount;
@end