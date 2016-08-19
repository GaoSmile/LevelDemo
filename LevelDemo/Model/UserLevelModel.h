//
//  UserLevelModel.h
//  Tourist
//
//  Created by HG_hupfei on 16/1/8.
//  Copyright © 2016年 HG_hupfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLevelModel : NSObject

@property (nonatomic, copy) NSString *ID;
//用户id
@property (nonatomic, copy) NSString *userid;
//等级
@property (nonatomic, assign) NSInteger level;
//等级名称
@property (nonatomic, copy) NSString *levelname;
//备注
@property (nonatomic, copy) NSString *beizhu;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *updatetime;
 /*当前积分*/
@property (nonatomic, assign) NSInteger currentJf;

/*******扩展字段开始********/

/** 头像路径  */
@property (nonatomic, copy) NSString *headimgPath;

//昵称
@property (nonatomic, copy) NSString *nickname;

/*升级到下一级需要的积分数量*/
@property (nonatomic, assign) NSUInteger nextLevelNeedJf;
/** 完善资料状态：0 未完善，1 完善 */
@property (nonatomic, assign) NSInteger wszlState;

/** 认证状态：0 未认证，1 已认证 */
@property (nonatomic, assign) NSInteger rzState;

/** 会员状态：1 普通会员，2 非会员 3 年费会员*/
@property (nonatomic, assign) NSInteger hyState;

/** 当天点亮状态：0 未点亮，1 已点亮  */
//@property (nonatomic, assign) NSInteger dlState;

@end
