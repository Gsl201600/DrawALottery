//
//  TornClothesViewController.m
//  DrawALottery
//
//  Created by Yostar on 2019/9/25.
//  Copyright © 2019 Yostar. All rights reserved.
//

#import "TornClothesViewController.h"

@interface TornClothesViewController ()

@property (nonatomic, assign) BOOL isTouch;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TornClothesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"撕衣服";
    
    UIImageView *imageViewBottom = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageViewBottom.image = [UIImage imageNamed:@"g3_back"];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"g3_up"];
    self.imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageViewBottom];
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取手指
    UITouch *touch = [touches anyObject];
    // 判断手指是否在触摸
    if (touch.view == self.imageView) {
        self.isTouch = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isTouch) {
        // 开启上下文
        UIGraphicsBeginImageContext(self.imageView.bounds.size);
        // 将图片绘制到图形上下文
//        [self.imageView drawRect:self.imageView.bounds];
        [self.imageView.image drawInRect:self.imageView.bounds];
        // 清空手指触摸的位置
        // 拿到手指,根据手指的位置,让对应的位置成为透明
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:touch.view];
        CGRect rect = CGRectMake(point.x - 25, point.y - 25, 50, 50);
        // 清空rect
        CGContextClearRect(UIGraphicsGetCurrentContext(), rect);
        
        // 取出会之后的图片赋值给imageView
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭图形上下文
        UIGraphicsEndImageContext();
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.isTouch = NO;
}

@end
