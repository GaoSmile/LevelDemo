//
//  UserLevelVC.m
//  Tourist
//
//  Created by hupfei on 16/1/6.
//  Copyright © 2016年 HG_hupfei. All rights reserved.
//

#import "UserLevelVC.h"
#import "HeadViewCell.h"
#import "ProgressView.h"
#import "LvView.h"
#import "UpgradeRulesCell.h"
//#import "GetMoreKadouDetailCell.h"
#import "UserLevelModel.h"
//#import "SignVc.h"
//#import "EditInfoVC.h"
//#import "ApplicationLvkaVC.h"
//#import "MemberVC.h"
//#import "PostPhotoNoteVC.h"
//#import "PostTravelNotesVC.h"
//#import "EarthVC.h"
//#import "RecordVC.h"

@interface UserLevelVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_userIcon;
    UILabel *_userName;
    UILabel *_lvLabel;
}
@property (nonatomic, strong) NSMutableArray *contentArr;
@property (nonatomic,strong) UserLevelModel *userLevelModel;
@property (nonatomic,assign) BOOL isNeedRefresh;        //点击了完善、申请、开通后需要刷新数据

@end

@implementation UserLevelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进来了吗？");
    self.title = @"等级";
    [self createTableView];
    
    _contentArr = [NSMutableArray new];
    NSArray *arr = @[@[@"每日签到", @"每次签到可获20积分，连续签到收益更多", @"签到"],
                     @[@"完成注册", @"注册成功，获得1000积分", @"领取"],
                     @[@"完善资料", @"完善资料，获得200积分", @"完善"],
                     @[@"认证", @"申请认证成功，获得5000积分", @"申请"],
                     @[@"会员", @"开通会员，获得2000积分", @"开通"],
                     @[@"游记", @"", @"发布"],
                     @[@"图集", @"", @"发布"],
                     @[@"足迹", @"", @"点亮"]];
    [_contentArr addObjectsFromArray:arr];
    
//    UIBarButtonItem *recordItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"记录" style:UIBarButtonItemStyleDone handler:^(id sender) {
//        RecordVC *vc = [RecordVC new];
//        vc.isKadou = NO;
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
//    self.navigationItem.rightBarButtonItem = recordItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toMember) name:@"openMember" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"openMember"
     object:nil];
}

- (void)toMember {
//    MemberVC *vc = [MemberVC new];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark --- UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 7;
    } else
        return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _isNeedRefresh = NO;
    if (indexPath.section == 0) {
        NSString *identrify = @"HeadViewCell";
        HeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identrify];
        if (!cell) {
            cell = [[HeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identrify];
        }
        cell.userLevelModel = self.userLevelModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }  else if (indexPath.section == 1) {
        NSString *identrify = @"UpgradeCell";
        UpgradeRulesCell *cell = [tableView dequeueReusableCellWithIdentifier:identrify];
        if (!cell) {
            cell = [[UpgradeRulesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identrify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        static NSString *identifier = @"GetMoreKadouDetailCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"我是title%d",indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"我是detail%d",indexPath.row];

        return cell;
    }
}

#pragma mark --- UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0 && section != 3) {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        customView.backgroundColor = [UIColor colorWithRed:0.941 green:0.945 blue:0.957 alpha:1.000];
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor colorWithRed:0.941 green:0.945 blue:0.957 alpha:1.000];
        headerLabel.textColor = [UIColor blackColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:13];
        headerLabel.frame = CGRectMake(20, 0, kScreen_Width, 30);
        if (section == 1) {
            headerLabel.text = @"升级规则";
        }else if (section == 2) {
            headerLabel.text = @"获得积分";
        }
        [customView addSubview:headerLabel];
        return customView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else if (section == 1 || section == 2) {
        return 30;
    } else
        return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return indexPath.section == 0 ? kScreen_Width*3/4 : [UpgradeRulesCell cellHeightWithContent];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3 && indexPath.row > 3) {
        NSArray *changeArr = [NSArray new];
        NSArray *arr = _contentArr[indexPath.row+1];
        NSString *contentStr = arr[1];
        if (contentStr.length > 0) {
            if (indexPath.row == 4) {
                changeArr = @[@"游记",@"",@"发布"];
            }else if (indexPath.row == 5) {
                changeArr = @[@"图集",@"",@"发布"];
            }else if (indexPath.row == 6) {
                changeArr = @[@"足迹",@"",@"点亮"];
            }
        }else {
            if (indexPath.row == 4) {
                changeArr = @[@"游记", @"发布一篇游记领取200积分，每日仅限一次\n所发游记超过20人点赞，领取200积分 \n所发游记超过50人点赞，领取300积分\n所发游记超过100人点赞，领取500积分\n所发游记超过500人点赞，领取1500积分", @"发布"];
            }else if (indexPath.row == 5) {
                changeArr = @[@"图集", @"发布一篇图集领取200积分，每日仅限一次\n所发图集超过20人点赞，领取200积分\n所发图集超过50人点赞，领取300积分\n所发图集超过100人点赞，领取500积分\n所发图集超过500人点赞，领取1500积分", @"发布"];
            }else if (indexPath.row == 6) {
                changeArr = @[@"足迹", @"点亮一个国内足迹领取1000积分,每日至多两次\n点亮一个国外足迹可领取2000积分，一天至多两次", @"点亮"];
            }
        }
        [_contentArr replaceObjectAtIndex:indexPath.row+1 withObject:changeArr];
//        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableView reloadData];
    }
}

@end
