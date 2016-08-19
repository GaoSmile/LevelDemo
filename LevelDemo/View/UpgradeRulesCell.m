//
//  UpgradeRulesCell.m
//  Tourist
//
//  Created by hupfei on 16/1/7.
//  Copyright © 2016年 HG_hupfei. All rights reserved.
//

#import "UpgradeRulesCell.h"
#import "RTLabel.h"

@implementation UpgradeRulesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        RTLabel *rulesText = [[RTLabel alloc] initWithFrame:CGRectMake(15, 10, kScreen_Width-30, 0)];
        rulesText.text = @"1-10级1000分升一级; 10-20级每2000分升一级\n20-30每3000分升一级; 30-40级每4000分升一级\n<font color='#FBDD4F'>普通会员享受1.2倍加速, 年费会员享受1.5倍加速</font>";
        rulesText.font = [UIFont systemFontOfSize:12];
        rulesText.height = rulesText.optimumSize.height;
        [self addSubview:rulesText];
        
    }
    return self;
}

+(CGFloat)cellHeightWithContent {
    
    return 70;

}

@end
