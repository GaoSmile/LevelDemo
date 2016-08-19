//
//  headView.h
//  UITest
//
//  Created by betsy on 16/1/5.
//  Copyright (c) 2016年 xb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLevelModel.h"

@class TextButton ;

@interface HeadView : UIView

@property (nonatomic,strong)TextButton * textButton1 ;
@property (nonatomic,strong)TextButton * textButton2 ;
@property (nonatomic,strong)TextButton * textButton3 ;

@property (nonatomic,strong) UserLevelModel *userLevelModel;
@end

