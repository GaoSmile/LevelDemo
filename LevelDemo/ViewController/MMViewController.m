//
//  MMViewController.m
//  LevelDemo
//
//  Created by 蜘蜘纺 on 16/8/18.
//  Copyright © 2016年 小玲子. All rights reserved.
//

#import "MMViewController.h"
#import "UserLevelVC.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"哈喽";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviBg"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
    [btn setTitle:@"点我 看等级😄" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(toNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)toNextVC {
    
    UserLevelVC *vc = [[UserLevelVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
