//
//  SquareLotteryView.h
//  DrawALottery
//
//  Created by Yostar on 2020/4/7.
//  Copyright © 2020 Yostar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SquareLotteryView : UIView

//循环的圈数
@property (nonatomic, assign) int circel;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArr;

@end

NS_ASSUME_NONNULL_END
