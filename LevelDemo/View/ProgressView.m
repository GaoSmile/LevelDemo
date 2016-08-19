//
//  ProgressView.m
//  UITest
//
//  Created by betsy on 15/12/31.
//  Copyright (c) 2015年 xb. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()
//上层 View 和Label
@property (nonatomic,strong) UIView *upperView;
@property (nonatomic,strong) UILabel *upperLabel;

//下层 View 和Label
@property (nonatomic,strong) UIView *lowerView;
@property (nonatomic,strong) UILabel *lowerLabel;
@end

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        [self createSubview];
//        [self setFrame:frame];
    }
    return self;
}

//添加子视图
-(void)createSubview{
    UIView * lowerView = [[UIView alloc]init];
    lowerView.backgroundColor = [UIColor whiteColor];
    [self addSubview: lowerView];
    self.lowerView = lowerView;
    self.lowerView.clipsToBounds = YES;
    
    
    UILabel * lowerLabel = [[UILabel alloc]init];
    [self addSubview:lowerLabel];
    self.lowerLabel = lowerLabel;
    self.lowerLabel.clipsToBounds = YES;
    self.lowerLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIView * upperView = [[UIView alloc]init];
    upperView.backgroundColor =[UIColor blueColor];
    [self addSubview:upperView];
    self.upperView = upperView;
    self.upperView.clipsToBounds = YES;
    
    UILabel * upperLabel = [[UILabel alloc]init];
    upperLabel.textColor = [UIColor whiteColor];
    [self.upperView addSubview:upperLabel];
    self.upperLabel = upperLabel;
    self.upperLabel.clipsToBounds = YES;
    self.upperLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void)setTrackTintColor:(UIColor *)trackTintColor{
    _trackTintColor = trackTintColor;
    self.upperView.backgroundColor = trackTintColor;
}
-(void)setTrackTextColor:(UIColor *)trackTextColor{
    _trackTextColor = trackTextColor;
    self.upperLabel.textColor = trackTextColor;
}
-(void)setBasicTextColor:(UIColor *)basicTextColor{
    _basicTextColor = basicTextColor;
    self.lowerLabel.textColor = basicTextColor;
}
-(void)setBasicTintColor:(UIColor *)basicTintColor{
    _basicTintColor = basicTintColor;
    self.lowerView.backgroundColor = basicTintColor;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (_progress >= 0) {
        CGFloat upperViewWidth = self.width*_progress;
        self.upperView.frame = CGRectMake(0, 0, upperViewWidth, self.height);
    }
}
-(void)setText:(NSString *)text{
    self.upperLabel.text = text;
    self.lowerLabel.text = text;
}
-(void)setTextFont:(UIFont *)textFont{
    self.upperLabel.font = textFont;
    self.lowerLabel.font = textFont;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.layer.cornerRadius = self.frame.size.height/2;
    self.upperView.layer.cornerRadius = self.frame.size.height/2;
    self.lowerLabel.layer.cornerRadius = self.frame.size.height/2;
    
    self.lowerView.frame = CGRectMake(0, 0, width, height);
    self.lowerLabel.frame = CGRectMake(width*1/4, 0, width*3/4, height);
    
    CGFloat upperViewWidth;
    if (_progress >= 0) {
        upperViewWidth = self.width*_progress;
    }else {
        upperViewWidth = width;
    }
    self.upperView.frame = CGRectMake(0, 0, upperViewWidth, height);
    self.upperLabel.frame = CGRectMake(width*1/4, 0, width*3/4, height);
}



@end
