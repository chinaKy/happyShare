//
//  Root2ViewController.m
//  InformPub
//
//  Created by Linf on 15/6/11.
//  Copyright (c) 2015年 Linf. All rights reserved.
//

#import "RootMainViewController.h"
#import "ShopHomePageViewController.h"
#import "ShopSearchViewController.h"
#import "ShopCartViewController.h"
#import "ShopPersonViewController.h"

@interface RootMainViewController ()   <RDVTabBarControllerDelegate>

@end

@implementation RootMainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViewControllers];
}

#pragma mark Private_M
- (void)setupViewControllers {
    //主页
    ShopHomePageViewController * homePage = [[ShopHomePageViewController alloc] init];
    BaseNavigationController * homeNav = [[BaseNavigationController alloc] initWithRootViewController:homePage];
    //查找
    ShopSearchViewController * search = [[ShopSearchViewController alloc] init];
    BaseNavigationController * searchNav = [[BaseNavigationController alloc] initWithRootViewController:search];
    //购物车
    ShopCartViewController * cart = [[ShopCartViewController alloc] init];
    BaseNavigationController * cartNav = [[BaseNavigationController alloc] initWithRootViewController:cart];
    //个人中心
    ShopPersonViewController *person=[[ShopPersonViewController alloc]init];
    BaseNavigationController *personNav=[[BaseNavigationController alloc]initWithRootViewController:person];
    
    [self setViewControllers:@[homeNav, searchNav, cartNav,personNav]];
    
    [self customizeTabBarForController];
    self.delegate = self;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 1.0f)];
    line.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    [self.tabBar addSubview:line];
    
}

- (void)customizeTabBarForController {
    
    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    
    NSArray *tabBarItemImages = @[@"home", @"sale", @"user",@"user"];
    NSArray *tabBarItemTitle = @[@"首页",@"查找",@"购物车",@"个人中心"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        if (index == 1 && _unReadMessageNum > 0) {
            [item setBadgeValue:[NSString stringWithFormat:@"%ld", (long)_unReadMessageNum]];
        }
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        NSString *selectedImage = [NSString stringWithFormat:@"%@_selected", [tabBarItemImages objectAtIndex:index]];
        NSString *normalImage = [NSString stringWithFormat:@"%@_normal", [tabBarItemImages objectAtIndex:index]];
        UIImage *selectedimage = IMAGE(selectedImage);
        UIImage *unselectedimage = IMAGE(normalImage);
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = tabBarItemTitle[index];
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:14],
                                           NSForegroundColorAttributeName: [UIColor colorWithHexString:@"0xb6b6b6"],
                                           };
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:14],
                                         NSForegroundColorAttributeName: [UIColor colorWithHexString:@"0x00a0e9"],
                                         };
        index++;
    }
}

@end
