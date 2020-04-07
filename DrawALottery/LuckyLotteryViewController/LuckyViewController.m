//
//  LuckyViewController.m
//  DrawALottery
//
//  Created by Yostar on 2019/9/25.
//  Copyright © 2019 Yostar. All rights reserved.
//

#import "LuckyViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LuckyViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *rotaryImageView;
@property (nonatomic, copy) NSString *resultStr;

@property (nonatomic, strong) UIImageView *pointerImageView;

@end

@implementation LuckyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"幸运转盘";
    
    [self configLuckyUI];
}

- (void)configLuckyUI{
    UIImage *image = [UIImage imageNamed:@"lanren"];
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat rate = 1;
    
    if (image.size.width > ScreenWidth) {
        rate = ScreenWidth/width;
        width = ScreenWidth;
        height = height * ScreenWidth/image.size.width;
    }
    
    self.rotaryImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - width)/2, (ScreenHeight - height)/2, width, height)];
    self.rotaryImageView.image = image;
    [self.view addSubview:self.rotaryImageView];
    
    UIImage *image1 = [UIImage imageNamed:@"arrow"];
    //由于只需显示图片的前1/3部分，所以需要处理
    CGRect rect = CGRectMake(0, 0, image1.size.width/3, image1.size.height);
    //设置图片需要显示的区域
    CGImageRef imageRef = CGImageCreateWithImageInRect(image1.CGImage, rect);
    UIImage *subImage = [UIImage imageWithCGImage:imageRef];
    self.pointerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - subImage.size.width * rate)/2, (ScreenHeight - subImage.size.height * rate)/2, subImage.size.width * rate, subImage.size.height * rate)];
    self.pointerImageView.image = subImage;
    self.pointerImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.pointerImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.pointerImageView addGestureRecognizer:tap];
}

- (void)tapAction{
    self.pointerImageView.userInteractionEnabled = NO;
    //圈数
    int random = arc4random()%2 + 5;
    //获奖的概率 80%的概率 就是0-80
    int randomNum = arc4random()%100;
    //角度  由于是转盘转动 所以按转盘的角度  从左开始计算
    NSInteger turnAngle;
    CGFloat perAngle = M_PI/180.0;
    if (randomNum >= 85 && randomNum < 90) {
        // 150 --- 210
        turnAngle = arc4random()%59 + 150 + 360 * random;
        self.resultStr = @"恭喜你获得了5元话费";
    }else if (randomNum >= 90 && randomNum < 95){
        //210 --- 270
        turnAngle = arc4random()%59 + 210 + 360 * random;
        self.resultStr = @"恭喜你获得了30M流量";
    }else if (randomNum >= 95 && randomNum < 96){
        //30 --- 90
        turnAngle = arc4random()%59 + 30 + 360 * random;
        self.resultStr = @"恭喜你获得了20元话费";
    }else if (randomNum >= 96 && randomNum < 97){
        // 90 --- 150
        turnAngle = arc4random()%59 + 90 + 360 * random;
        self.resultStr = @"恭喜你获得了iPad mini 4";
    }else if (randomNum >= 97){
        // 270 --- 330
        turnAngle = arc4random()%59 + 270 + 360 * random;
        self.resultStr = @"恭喜你获得了iPhone 7";
    }else{
        int a = arc4random()%60;
        if (a >= 30) {
            // 330 --- 360
            turnAngle = a + 300 + 360 * random;
        }else{
            // 0 --- 30
            turnAngle = a + 360 * random;
        }
        self.resultStr = @"恭喜你获得了10M流量";
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:turnAngle * perAngle];
    animation.duration = 3;
    animation.cumulative = YES;
    animation.delegate = self;
    //由快变慢
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.rotaryImageView.layer addAnimation:animation forKey:@"rotationAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:self.resultStr preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pointerImageView.userInteractionEnabled = YES;
        
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
