//
//  SquareLotteryViewController.m
//  DrawALottery
//
//  Created by Yostar on 2019/9/25.
//  Copyright © 2019 Yostar. All rights reserved.
//

#import "SquareLotteryViewController.h"
#import "SquareLotteryView.h"

@interface SquareLotteryViewController ()


@end

@implementation SquareLotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"方形转盘";
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 8; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d.jpg", i+1]];
    }
    
    SquareLotteryView *squareLotteryView = [[SquareLotteryView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.2, self.view.frame.size.width*0.6, self.view.frame.size.width*0.6) imageArray:arr];
    squareLotteryView.circel = 1;
    [self.view addSubview:squareLotteryView];
}



@end
