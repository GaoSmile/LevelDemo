//
//  LvView.h
//  UITest
//
//  Created by betsy on 16/1/4.
//  Copyright (c) 2016年 xb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLevelModel.h"

typedef NS_ENUM(NSInteger, LvViewType){
    LvViewType1,
    LvViewType2,
    LvViewType3
};

@protocol LvViewDelegate <NSObject>

@end
@interface IMageButton : UIView;
-(void)setViewType:(LvViewType)type;

@end

@interface LvView : UIView
@property (nonatomic,strong) UserLevelModel *userLevelModel;
//可移动的遮盖图片
@property (nonatomic,weak) UIImageView * imageView;

@property (nonatomic,assign) NSUInteger socre;


@end

