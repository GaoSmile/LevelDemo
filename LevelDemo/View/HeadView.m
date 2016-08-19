//
//  headView.m
//  UITest
//
//  Created by betsy on 16/1/5.
//  Copyright (c) 2016年 xb. All rights reserved.
//

#import "HeadView.h"
#import "ProgressView.h"
#import "LvView.h"
//#import "MemberVC.h"
#import "TextButton.h"

@interface HeadView()
@property(nonatomic,strong) UIImageView * userIcon;
@property(nonatomic,strong) UILabel * userNameLabel;
@property(nonatomic,strong) UIButton * lvBtn;
@property(nonatomic,strong) ProgressView * progressView;
@property(nonatomic,strong) UILabel * detailLabel;
@property(nonatomic,strong) UIView * yellowView;
@property(nonatomic,strong) LvView * lvView;

@end
@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //用户图标
        _userIcon = [[UIImageView alloc]init];
        _userIcon.layer.cornerRadius = 20;
        _userIcon.layer.borderColor = [[UIColor whiteColor] CGColor];
        _userIcon.layer.borderWidth = 1;
        _userIcon.clipsToBounds = YES;
        [self addSubview:_userIcon];
        
        //昵称Label
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        _userNameLabel.textColor = [UIColor colorWithRed:0.369 green:0.376 blue:0.404 alpha:1.000];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_userNameLabel];
        
        //等级数 button 不可点击
        _lvBtn = [[UIButton alloc]init];
        _lvBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_lvBtn setTitleColor:[UIColor colorWithRed:0.769 green:0.647 blue:0.161 alpha:1.000] forState:UIControlStateNormal];
        [_lvBtn setBackgroundImage:[UIImage imageNamed:@"level"] forState:UIControlStateNormal];
        _lvBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _lvBtn.userInteractionEnabled = NO;
        [self addSubview:_lvBtn];
        
        //添加进度条
        _progressView = [[ProgressView alloc]init];
        self.progressView = _progressView;
        
        [self addSubview:_progressView];
        [_progressView setProgress:0];
        _progressView.backgroundColor = [UIColor colorWithRed:0.686 green:0.647 blue:0.506 alpha:1.000];
        _progressView.textFont = [UIFont systemFontOfSize:9];
        _progressView.trackTextColor = [UIColor blackColor];
        _progressView.trackTintColor = kBaseColor;
        
        
        //升级积分提示文本
        //昵称Label
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont boldSystemFontOfSize:8];
        _detailLabel.textColor = [UIColor colorWithRed:0.573 green:0.533 blue:0.431 alpha:1.000];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_detailLabel];
        /**
         -------------------------黄线-----------------------
         */
        //黄色横线
        _yellowView = [[UIView alloc]init];
        self.yellowView = _yellowView;
        _yellowView.backgroundColor = kBaseColor;
        [self addSubview:_yellowView];
        
        //会员等级加速图文简介
        _lvView = [[LvView alloc]init];
        _lvView.backgroundColor = [UIColor colorWithRed:0.973 green:0.910 blue:0.686 alpha:1.000];
        [self addSubview:_lvView];
        
        //文字按钮
        TextButton * textbutton1 = [[TextButton alloc]init];
        [textbutton1 addTarget:self];
        [textbutton1 setButtonType:TextButtonType1];
        [self addSubview:textbutton1];
        textbutton1.clickTag = 1;
        self.textButton1 = textbutton1;
        self.textButton1.hidden = YES;
        self.textButton1.label.text = @"普通用户升级速度缓慢";
        
        TextButton * textbutton2 = [[TextButton alloc]init];
        [textbutton2 addTarget:self];
        [self addSubview:textbutton2];
        textbutton2.clickTag = 2;
        textbutton2.hidden = YES;
        self.textButton2 = textbutton2;
        self.textButton1.hidden = YES;
        [textbutton2 setButtonType:TextButtonType2];
        self.textButton2.label.text = @"普通会员升级加速1.2倍";
        
        TextButton * textbutton3 = [[TextButton alloc]init];
        [textbutton3 addTarget:self];
        [self addSubview:textbutton3];
        [textbutton3 setButtonType:TextButtonType3];
        textbutton3.hidden = YES;
        textbutton3.clickTag = 3;
        self.textButton3 = textbutton3;
        self.textButton1.hidden = YES;
        self.textButton3.label.text = @"年费会员升级加速1.5倍";
        /**
         ----------------------------约束---------------------------------
         */
        // 用户头像
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(5);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        //用户昵称
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userIcon.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        // 等级label
        [self.lvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userIcon.mas_right).offset(10);
            make.top.equalTo(self.userNameLabel.mas_bottom).offset(2);
            make.size.mas_equalTo(CGSizeMake(30, 13));
        }];
        // 进度条
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.centerY.equalTo(self.userNameLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(130, 13));
        }];
        // 解释 label
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.progressView.mas_bottom).offset(5);
            make.width.equalTo(_progressView);
            make.height.equalTo(@10);
            make.left.equalTo(_progressView.mas_left);
        }];
        
        [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@1);
            make.top.equalTo(self.userIcon.mas_bottom).offset(5);
        }];
        
        [self.lvView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yellowView.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lvView.userLevelModel = self.userLevelModel;
    
//    [_userIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,[NSString thumbImage:self.userLevelModel.headimgPath thumbFlag:0]]] placeholderImage:[UIImage imageNamed:@"avatar"]];
    [_userIcon setImage:[UIImage imageNamed:@"me"]];
//    _userNameLabel.text = self.userLevelModel.nickname;
    _userNameLabel.text = @"小玲子"; //死数据
    [_userNameLabel sizeToFit];
    
//    [_lvBtn setTitle:[NSString stringWithFormat:@"LV%ld",(long)self.userLevelModel.level] forState:UIControlStateNormal];
    [_lvBtn setTitle:[NSString stringWithFormat:@"LV%d",100] forState:UIControlStateNormal];
    NSInteger sumJf = self.userLevelModel.currentJf+self.userLevelModel.nextLevelNeedJf;
    _progressView.text = [NSString stringWithFormat:@"%d/%d",self.userLevelModel.currentJf,sumJf];
//    CGFloat a = self.userLevelModel.currentJf*1.0/sumJf;
    CGFloat a = 0.3; // 死数据
    [_progressView setProgress:a];
    
//    _detailLabel.text = [NSString stringWithFormat:@"距离%d级还差%ld积分",self.userLevelModel.level+1,(unsigned long)self.userLevelModel.nextLevelNeedJf];
    _detailLabel.text = @"距离101级还差500积分"; //假数据

}

- (void)setUserLevelModel:(UserLevelModel *)userLevelModel {
    _userLevelModel = userLevelModel;
    if (!_userLevelModel) {
        return;
    }
    [self configUI];
}

@end


