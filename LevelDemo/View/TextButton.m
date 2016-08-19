//
//  TextButton.m
//  Tourist
//
//  Created by jason on 16/1/12.
//  Copyright © 2016年 HG_hupfei. All rights reserved.
//

#import "TextButton.h"

#pragma mark---TextButton 的实现部分

@implementation TextButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [[UIImage imageNamed:@"pop_vip"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 5, 10, 10) resizingMode:UIImageResizingModeTile];
        self.layer.cornerRadius = 4;
        UILabel * label = [[UILabel alloc]init];
        label.textColor = kBaseColor;
        [self addSubview:label];
        self.label =label;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.font = [UIFont systemFontOfSize:8];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:button];
        self.button = button;
        self.button.tintColor = [UIColor whiteColor];
        self.button.backgroundColor = kBaseColor;
        self.button.titleLabel.font = [UIFont systemFontOfSize:8];
        self.button.layer.cornerRadius = 2;
    }
    return self;
}

-(void)setButtonType:(TextButtonType)type{
    if (type == TextButtonType1) {
        self.button.hidden = YES;
//        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.button setTitle:@"开通" forState:UIControlStateNormal];
    }else if (type == TextButtonType2){
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button setTitle:@"开通" forState:UIControlStateNormal];
    }else{
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [self.button setTitle:@"开通" forState:UIControlStateNormal];
    }
}

//开通不同级别会员的实现部分
-(void)clickTextButton:(UIButton *)button{

    HeadView* header = self.delegate;
    NSLog(@"%@", header.textButton1.button.titleLabel.text);
    NSLog(@"%@", header.textButton2.button.titleLabel.text);
    NSLog(@"%@", header.textButton3.button.titleLabel.text);
//    __weak typeof(self)weakSelf = self;
//    if (header.textButton2.button.tag == 2) {
//        weakSelf.ClickedBlockToOpenMember = ^{
//            weakSelf.ClickedBlockToOpenMember();
//        };
//    } else if (header.textButton3.button.tag == 3) {
//        weakSelf.ClickedBlockToOpenMember = ^{
//            weakSelf.ClickedBlockToOpenMember();
//        };
//    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"openMember" object:self userInfo:nil];
}

-(NSUInteger)clickTag{
    return self.button.tag;
}
-(void)setClickTag:(NSUInteger)clickTag{
    self.button.tag = clickTag;
}

- (void)addTarget:(id)target{
    self.delegate = target;
    [self.button addTarget:self action:@selector(clickTextButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutSubviews{
//    self.label.text = @"普通账户升级速度很慢";
//    [self.button setTitle:@"开通" forState:UIControlStateNormal];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(8);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.equalTo(self.mas_height).multipliedBy(0.43);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(5);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@30);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
}

@end
