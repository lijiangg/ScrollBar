//
//  ScrollBarView.h
//  Test_Demo
//
//  Created by 李李江 on 2019/2/28.
//  Copyright © 2019 李李江. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ScrollBarViewDirectionDefault,
    ScrollBarViewDirectionHorizontal,
    ScrollBarViewDirectionVertical,
} ScrollBarViewDirection;
NS_ASSUME_NONNULL_BEGIN

@interface ScrollBarView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *barRectView;

@property (assign, nonatomic) ScrollBarViewDirection direction;

//寄生scrollview
@property (strong, nonatomic) UIScrollView *parasiticScrollView;
//滚动条范围
@property (nonatomic) CGSize contentSize;

- (void)drawView;
@end

NS_ASSUME_NONNULL_END
