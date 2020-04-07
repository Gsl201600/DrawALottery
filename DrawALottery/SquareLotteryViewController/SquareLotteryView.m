//
//  SquareLotteryView.m
//  DrawALottery
//
//  Created by Yostar on 2020/4/7.
//  Copyright © 2020 Yostar. All rights reserved.
//

#import "SquareLotteryView.h"

@interface SquareLotteryView ()

//保存奖品图片
@property (nonatomic, strong) NSArray *imageArr;
//保存按钮
@property (nonatomic, strong) NSMutableArray *btnArr;
//定时器
@property (nonatomic, strong) NSTimer *timer;
//记录上一个按钮
@property (nonatomic, assign) int selectedIndex;
//当前圈数
@property (nonatomic, assign) int currentCircle;
//当前按钮
@property (nonatomic, assign) int num;
//抽奖按钮
@property (nonatomic, strong) UIButton *lotteryBtn;

@property (nonatomic, assign) int count;
@property (nonatomic, assign) int random;

@end

@implementation SquareLotteryView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArr{
    if (self = [super initWithFrame:frame]) {
        self.btnArr = [NSMutableArray arrayWithCapacity:6];
        self.imageArr = imageArr;
        //创建抽奖UI
        [self configLotteryUI];
    }
    return self;
}

- (void)configLotteryUI{
    CGFloat viewWidth = self.frame.size.width;
    CGFloat btnWidth = viewWidth/3;
    int t = 0;
    
    for (int i = 0; i < 9; i++) {
        int count = i/3;
        int num = i%3;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(num * btnWidth, count * btnWidth, btnWidth, btnWidth);
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i + 100;
        if (i == 4) {
            [btn setTitle:@"抽奖" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.layer.cornerRadius = btnWidth/2;
            btn.backgroundColor = [UIColor orangeColor];
            [btn addTarget:self action:@selector(lotteryButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            t--;
            self.lotteryBtn = btn;
        }else{
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, btnWidth - 8, btnWidth - 8)];
            imageView.image = [UIImage imageNamed:self.imageArr[t]];
            [btn addSubview:imageView];
        }
        t++;
        [self addSubview:btn];
        [self.btnArr addObject:btn];
    }
    [self.btnArr removeObjectAtIndex:4];
    [self.btnArr exchangeObjectAtIndex:3 withObjectAtIndex:4];
    [self.btnArr exchangeObjectAtIndex:4 withObjectAtIndex:7];
    [self.btnArr exchangeObjectAtIndex:5 withObjectAtIndex:6];
}

//抽奖按钮的点击事件
- (void)lotteryButtonDidClicked:(UIButton *)button{
    self.lotteryBtn.enabled = NO;
    UIButton *curBtn = self.btnArr[self.selectedIndex];
    curBtn.backgroundColor = [UIColor whiteColor];
    if (button.tag == 104) {
        self.selectedIndex = 0;
        self.currentCircle = 0;
        self.count = 0;
        //起始位置
        self.num = arc4random()%8;
        //设置随机结束位置
        int random = arc4random()%8;
        //圈数设置成随机数
        self.circel = arc4random()%3 + 3;
        self.random = self.imageArr.count - self.num + random + self.imageArr.count * self.circel;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(changeButtonBackground) userInfo:nil repeats:YES];
    }
}

- (void)changeButtonBackground{
    if (self.count > self.random) {
        [self.timer invalidate];
        self.timer = nil;
        self.lotteryBtn.enabled = YES;
        NSLog(@"<<<%d", self.selectedIndex);
        return;
    }
    UIButton *btn1 = self.btnArr[self.selectedIndex];
    btn1.backgroundColor = [UIColor whiteColor];
    UIButton *btn = self.btnArr[self.num];
    self.selectedIndex = self.num;
    btn.backgroundColor = [UIColor orangeColor];
    if (self.num == self.imageArr.count - 1) {
        self.num = 0;
        self.currentCircle++;
    }else{
        self.num++;
    }
    self.count++;
}

@end
