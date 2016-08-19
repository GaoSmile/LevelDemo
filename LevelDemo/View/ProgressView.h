//
//  ProgressView.h
//  UITest
//
//  Created by betsy on 15/12/31.
//  Copyright (c) 2015年 xb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,assign) CGFloat progress;
//@property (nonatomic,assign) NSInteger cornerRadius;
//@property (nonatomic,assign) NSInteger borderWidth;

//底背景色
@property (nonatomic,strong) UIColor *basicTintColor;
//底部文字颜色
@property (nonatomic,strong) UIColor * basicTextColor;
//进度轨迹颜色
@property (nonatomic,strong) UIColor * trackTintColor;
//进度轨迹字体颜色
@property (nonatomic,strong) UIColor * trackTextColor;

@end
