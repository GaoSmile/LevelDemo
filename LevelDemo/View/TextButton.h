//
//  TextButton.h
//  Tourist
//
//  Created by jason on 16/1/12.
//  Copyright © 2016年 HG_hupfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"


typedef NS_ENUM(NSInteger, TextButtonType){
    TextButtonType1,
    TextButtonType2,
    TextButtonType3
};

/**
 *自定义可以点击带文字的按钮 （开通会员）
 */
@interface TextButton : UIImageView
@property(nonatomic,strong) UILabel * label ;
@property(nonatomic,strong) UIButton * button ;
@property(nonatomic,assign) NSUInteger clickTag;
@property(nonatomic, weak)HeadView* delegate;

- (void)addTarget:(id)target;
-(void)setButtonType:(TextButtonType)type;

//@property (nonatomic,copy) void(^ClickedBlockToOpenMember)();
@end
