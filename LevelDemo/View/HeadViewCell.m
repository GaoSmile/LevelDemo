//
//  HeadViewCell.m
//  Tourist
//
//  Created by hupfei on 16/1/6.
//  Copyright © 2016年 HG_hupfei. All rights reserved.
//

#import "HeadViewCell.h"
#import "HeadView.h"
#import "ProgressView.h"
#import "LvView.h"
//#import "MemberVC.h"


@interface HeadViewCell ()
{
    HeadView *_headView;
}
@end

@implementation HeadViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headView = [[HeadView alloc] init];
        _headView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Width*3/4);
        _headView.backgroundColor = [UIColor colorWithRed:0.973 green:0.910 blue:0.686 alpha:1.000];
        [self.contentView addSubview:_headView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headView.userLevelModel = self.userLevelModel;
}
@end
