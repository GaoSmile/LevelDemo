//
//  LvView.m
//  UITest
//
//  Created by betsy on 16/1/4.
//  Copyright (c) 2016年 xb. All rights reserved.
//

#import "LvView.h"
#import "headView.h"
#import "TextButton.h"

#define KIphone6p kScreen_Width==414
#define KIphone6  kScreen_Width==375
#define KIphone6p_R 800
#define KIphone6_R 700
#define KIphone5s_R 600

@class IMageButton;

@protocol IMageButtomDelegate <NSObject>

-(void)clickImageButton:(IMageButton *)button;

@end


@interface  IMageButton()
@property(nonatomic,strong) UIImageView * imageView;
@property(nonatomic,strong) UILabel * label;
@property(nonatomic,assign) BOOL isSelected;
@property(nonatomic,strong) id<IMageButtomDelegate> delegate;
@end

@implementation IMageButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isSelected = NO;
        
        UIImageView * imageView = [[UIImageView alloc]init];
        self.imageView = imageView;
        self.imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        
        UILabel * label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.label = label;
        self.label.numberOfLines = 2;
        self.label.font = [UIFont systemFontOfSize:8];
//        self.label.text=@"普通会员加速1.7中";
        
        UITapGestureRecognizer * tapGs = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        [self addGestureRecognizer:tapGs];
        
    }
    return self;
    
}
-(void)setViewType:(LvViewType)type{
    if (type == LvViewType1) {
        self.label.text=@"我\n慢速中";
    }else if (type == LvViewType2){
        self.label.text=@"普通会员\n加速1.2倍";
    }else{
        self.label.text=@"年费会员\n加速1.5倍";
    }
}
-(void)tapView{
    if ([self.delegate respondsToSelector:@selector(clickImageButton:)]) {
        [self.delegate clickImageButton:self];
    }
    
}


-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        self.label.textColor = [UIColor whiteColor];
    }else{
        self.label.textColor = [UIColor blackColor];
    }
}

-(void)layoutSubviews{
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(self.mas_height).multipliedBy(0.6667);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.imageView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
}


@end

#pragma mark---------

@interface LvView()<IMageButtomDelegate>
@property (strong,nonatomic) NSMutableArray  * array;

//可点击带有文字节点视图
@property(weak,nonatomic) IMageButton * button1;
@property(weak,nonatomic) IMageButton * button2;
@property(weak,nonatomic) IMageButton * button3;

//节点视图中IMageView中心点对应在本视图坐标系中的位置
@property(assign,nonatomic) CGPoint converPoint1;
@property(assign,nonatomic) CGPoint converPoint2;
@property(assign,nonatomic) CGPoint converPoint3;

//被点击的图片按钮
@property(weak,nonatomic) IMageButton * selectedButton;

//距离最远时 动画路径
@property (strong,nonatomic) UIBezierPath * path1;
@property (strong,nonatomic) UIBezierPath * path2;

//创建底层窗口
@property  (strong,nonatomic) UIView * blowView;

//创建window

@end

@implementation LvView

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        IMageButton *button1 = [[IMageButton alloc]init];
        [button1 setViewType:LvViewType1];
        button1.tag = 1;
        button1.delegate = self;
//        button1.isSelected = YES;
//        self.selectedButton = button1;
        [self addSubview:button1];
        button1.imageView.image = [UIImage imageNamed:@"avatar"];
        ;
        
        IMageButton *button2 = [[IMageButton alloc]init];
        [button2 setViewType:LvViewType2];
        button2.tag = 2;
        button2.delegate = self;
        [self addSubview:button2];
        button2.imageView.image = [UIImage imageNamed:@"avatar"];
        //        UIImage *image1 = [UIImage imageNamed:@"right_gray"];
        //        UIImage *image2 = [UIImage imageNamed:@"confirm_green"];
        //        UIImage *image3 = [UIImage imageNamed:@"buy"];
        //        UIImage *image4 = [UIImage imageNamed:@"record"];
        //        UIImage *image5 = [UIImage imageNamed:@"gray"];
        //        UIImage *image6 = [UIImage imageNamed:@"yellow"];
        //        UIImage *image7 = [UIImage imageNamed:@"avatar"];
        //
        //        //-----------提示用户点击的动画
        //        button2.imageView.animationImages = @[image1,image2,image3,image4,image5,image6,image7];
        //        button2.imageView.animationDuration = 2;
        //        [button2.imageView startAnimating];
        
        IMageButton *button3 = [[IMageButton alloc]init];
        [button3 setViewType:LvViewType3];
        button3.tag = 3;
        button3.delegate = self ;
        button3.imageView.image = [UIImage imageNamed:@"avatar"];
        [self addSubview:button3];
        
        [self.array addObjectsFromArray:@[button1,button2,button3]];
        self.button1 = button1;
        self.button2 = button2;
        self.button3 = button3;
        
        UIImageView * imageView = [[UIImageView alloc]init];
//        [imageView setCornerRadius:20 BorderColor:[UIColor clearColor]];
        imageView.layer.cornerRadius = 20;
        imageView.layer.borderColor = [[UIColor clearColor] CGColor];
        imageView.layer.borderWidth = 1;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        NSLog(@"center :%@",NSStringFromCGPoint(self.button2.center));
        self.backgroundColor = [UIColor colorWithRed:0.973 green:0.910 blue:0.686 alpha:1.000];
        
        [self configUI];
    }
    return self;
}
- (void)configUI{
    self.selectedButton.isSelected = NO;
    [_imageView setImage:[UIImage imageNamed:@"me"]];
    if (self.userLevelModel.hyState == 1) {
        // 普通会员
        self.selectedButton = self.button2;
        self.imageView.center = self.converPoint2;
        self.selectedButton.isSelected = YES;
        HeadView * headView = (HeadView*)self.superview;
        headView.textButton2.hidden = NO ;
        [headView.textButton2.button setTitle:@"续费" forState:UIControlStateNormal];

    } else if (self.userLevelModel.hyState == 3) {
        // 年费会员
        self.selectedButton = self.button3;
        self.imageView.center = self.converPoint3;
        self.selectedButton.isSelected = YES;
        HeadView * headView = (HeadView*)self.superview;
        headView.textButton3.hidden = NO ;
        [headView.textButton3.button setTitle:@"续费" forState:UIControlStateNormal];

    } else {
        // 非会员
        self.selectedButton = self.button1;
        self.imageView.center = self.converPoint1;
        self.selectedButton.isSelected = YES;
        HeadView * headView = (HeadView*)self.superview;
        headView.textButton1.hidden = NO ;

    }
}

- (void)setUserLevelModel:(UserLevelModel *)userLevelModel {
    _userLevelModel = userLevelModel;
    if (!_userLevelModel) {
        return;
    }
    [self configUI];
}

//实现协议方法
-(void)clickImageButton:(IMageButton *)button{
    switch (button.tag) {
        case 1:{
            if (self.selectedButton.tag!=1) {
                self.selectedButton.isSelected = NO;
                self.selectedButton = button;
                [self.button2.imageView startAnimating];
                self.selectedButton.isSelected = YES;
                HeadView *  headView= (HeadView *)self.superview;
                headView.textButton2.hidden = YES;
                headView.textButton3.hidden = YES;
                [UIView animateWithDuration:0.4 animations:^{
                    self.imageView.center = self.converPoint1;
                } completion:^(BOOL finished) {
                    headView.textButton1.hidden = NO ;
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        headView.textButton1.transform = CGAffineTransformMakeScale(0.7, 0.7);
                        headView.textButton1.transform = CGAffineTransformMakeScale(1.4, 1.4);
                        headView.textButton1.transform = CGAffineTransformMakeScale(1, 1);
                    }];
                }];
            }
        }
            break;
        case 2:
        {
            if (self.selectedButton.tag!=2) {
                self.selectedButton.isSelected = NO;
                self.selectedButton = button;
                [button.imageView stopAnimating];
                self.selectedButton.isSelected = YES;
                HeadView *  headView= (HeadView *)self.superview;
                headView.textButton1.hidden = YES;
                headView.textButton3.hidden = YES;
                [UIView animateWithDuration:0.4 animations:^{
                    self.imageView.center = self.converPoint2;
                } completion:^(BOOL finished) {
                    headView.textButton2.hidden = NO ;
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        headView.textButton2.transform = CGAffineTransformMakeScale(0.7, 0.7);
                        headView.textButton2.transform = CGAffineTransformMakeScale(1.4, 1.4);
                        headView.textButton2.transform = CGAffineTransformMakeScale(1, 1);
                    } ];
                }];
            }
        }
            break;
        case 3:
        {
            if (self.selectedButton.tag!=3) {
                self.selectedButton.isSelected = NO;
                self.selectedButton = button;
                self.selectedButton.isSelected = YES;
                [self.button2.imageView startAnimating];
                HeadView *  headView= (HeadView *)self.superview;
                headView.textButton2.hidden = YES;
                headView.textButton1.hidden = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    self.imageView.center = self.converPoint3;
                } completion:^(BOOL finished) {
                    headView.textButton3.hidden = NO ;
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        headView.textButton3.transform = CGAffineTransformMakeScale(0.7, 0.7);
                        headView.textButton3.transform = CGAffineTransformMakeScale(1.4, 1.4);
                        headView.textButton3.transform = CGAffineTransformMakeScale(1, 1);
                    } ];
                    
                }];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)layoutSubviews{
    
    self.button1.imageView.layer.cornerRadius = 20;
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        NSInteger kLeft = 0;
        NSInteger kBottom = 0;
        if (KIphone6p) {
            kLeft = 30;
            kBottom = -95;
        }else if (KIphone6) {
            kLeft = 30;
            kBottom = -65;
        }else{
            kLeft = 30;
            kBottom = -30;
        }
        make.left.equalTo(self.mas_left).offset(kLeft);
        make.bottom.equalTo(self.mas_bottom).offset(kBottom);
        make.width.equalTo(@40);
        make.height.equalTo(@60);
    }];
    self.button2.imageView.layer.cornerRadius = 20;
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        NSInteger kOffsetY = 0;
        if (KIphone6p) {
            kOffsetY = -16;
        }else if (KIphone6) {
            kOffsetY = -2;
        }else{
            kOffsetY = 10;
        }
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(kOffsetY);
        make.width.equalTo(@40);
        make.height.equalTo(@60);
    }];
    
    self.button3.imageView.layer.cornerRadius = 20;
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        NSInteger kOffsetRight = 0;
        NSInteger kOffsetTop = 0;
        if (KIphone6p) {
            kOffsetRight = -25;
            kOffsetTop = 22;
        }else if (KIphone6) {
            kOffsetRight = -25;
            kOffsetTop = 24;
        }else{
            kOffsetRight = -25;
            kOffsetTop = 26;
        }
        
        make.right.equalTo(self.mas_right).offset(kOffsetRight);
        make.top.equalTo(self.mas_top).offset(kOffsetTop);
        make.width.equalTo(@40);
        make.height.equalTo(@60);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.button1.mas_centerX);
        make.centerY.equalTo(self.button1.mas_centerY).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //本方法基本上调用一次 故很多操作放在里面（不知是否合适）
    
    CGPoint point1 = [self.button1.imageView convertPoint:self.button1.imageView.center toView:self];
    self.converPoint1 = point1;
    
    CGPoint point2 = [self.button2.imageView convertPoint:self.button2.imageView.center toView:self];
    self.converPoint2 = point2;
    
    CGPoint point3 = [self.button3.imageView convertPoint:self.button3.imageView.center toView:self];
    self.converPoint3 = point3;
    
    CGRect  rect1 = [self.button1 convertRect:self.button1.bounds toView:self.superview];
    CGRect  rect2 = [self.button2 convertRect:self.button2.bounds toView:self.superview];
    CGRect  rect3 = [self.button3 convertRect:self.button3.bounds toView:self.superview];
    
    HeadView * headView = (HeadView*)self.superview;
    headView.textButton1.frame = CGRectMake(rect1.origin.x-18,rect1.origin.y-58, 72, 55);
    headView.textButton2.frame = CGRectMake(rect2.origin.x +rect2.size.width/2 -38,rect2.origin.y-58, 72, 55);
    headView.textButton3.frame = CGRectMake(rect3.origin.x +rect3.size.width -60,rect3.origin.y-58, 72, 55);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,250/255.0,213/255.0,49/255.0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    
    //    二次曲线函数
    CGContextMoveToPoint(context, 0, 128);
//    NSLog(@"%f", self.button1.centerY);

    if (KIphone6p) {
        CGContextAddArcToPoint(context, self.converPoint3.x - 100, self.converPoint3.y + 100, self.frame.size.width, 25, KIphone6p_R);
    }else if(KIphone6){
        CGContextAddArcToPoint(context, self.converPoint3.x - 100, self.converPoint3.y + 100, self.frame.size.width, 25, KIphone6_R);
    }else
        CGContextAddArcToPoint(context, self.converPoint3.x - 100, self.converPoint3.y + 100, self.frame.size.width, 25, KIphone5s_R);
    NSLog(@"%@", NSStringFromCGRect(self.frame));
    //    NSLog(@"%@", NSStringFromCGRect());
    //三次曲线
    ////    CGContextAddCurveToPoint(context, self.button1.center.x,self.button1.center.y, self.button2.center.x, self.button2.center.y, self.frame.size.width, 30);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
    CGContextStrokePath(context);
}


@end
