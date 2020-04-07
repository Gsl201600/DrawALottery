//
//  MyTabBarController.m
//  DrawALottery
//
//  Created by Yostar on 2019/9/25.
//  Copyright © 2019 Yostar. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configMyTabBar];
}

- (void)configMyTabBar{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:3];
    NSArray *titlesArr = @[@"幸运转盘", @"方形转盘", @"撕衣服"];
    NSArray *controllerArr = @[@"LuckyViewController", @"SquareLotteryViewController", @"TornClothesViewController"];
    for (int i = 0; i < controllerArr.count; i++) {
        Class cla = NSClassFromString(controllerArr[i]);
        UIViewController *controller = [[cla alloc] init];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:controller];
        navC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titlesArr[i] image:nil selectedImage:nil];
        [tempArr addObject:navC];
    }
    self.viewControllers = tempArr;
}

@end
