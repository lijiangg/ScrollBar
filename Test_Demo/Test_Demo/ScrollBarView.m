//
//  ScrollBarView.m
//  Test_Demo
//
//  Created by 李李江 on 2019/2/28.
//  Copyright © 2019 李李江. All rights reserved.
//

#import "ScrollBarView.h"

@implementation ScrollBarView {
    CGFloat barHeight;
    CGFloat barWidth;
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_scrollView addSubview:self.barRectView];
    [self.barRectView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isEqual:_parasiticScrollView] && [keyPath isEqualToString:@"contentOffset"]) {
        CGRect frame = self.barRectView.frame;
        if (_direction == ScrollBarViewDirectionVertical) {
            //垂直方向
            frame.origin.y = _parasiticScrollView.contentOffset.y * self.frame.size.height / _contentSize.height;
        }else {
            //水平方向
           frame.origin.x = _parasiticScrollView.contentOffset.x * self.frame.size.width/_contentSize.width ;
        }
        
        self.barRectView.frame = frame;
    }
}

- (void)drawView {
    
    if (_direction == ScrollBarViewDirectionVertical) {
        //垂直方向
        barHeight = 0;
        if (_contentSize.height != 0) {
            barHeight = _parasiticScrollView.frame.size.height/_contentSize.height * self.frame.size.height;
        }
        self.barRectView.frame = CGRectMake(0, 0, self.frame.size.width, barHeight);
    }else {
        //水平方向
        barWidth = 0;
        if (_contentSize.width != 0) {
            barWidth = _parasiticScrollView.frame.size.width/_contentSize.width * self.frame.size.width;
        }
        self.barRectView.frame = CGRectMake(0, 0, barWidth, self.frame.size.width);
    }
    
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:self];
    if (CGRectContainsPoint(_barRectView.frame, point)) {
        return;
    }
    if (_direction == ScrollBarViewDirectionVertical) {
        //垂直方向
        if (point.y >= self.frame.size.height - barHeight) {
            //下边界处理
            point.y = point.y - barHeight;
        }
        [_parasiticScrollView setContentOffset:CGPointMake(0, point.y * _contentSize.height / self.frame.size.height) animated:YES];
       
    }else {
        //水平方向
        if (point.x >= self.frame.size.width - barWidth) {
            //右边边界处理
            point.x = point.x - barWidth;
        }
        [_parasiticScrollView setContentOffset:CGPointMake(point.x * _contentSize.width / self.frame.size.width, 0) animated:YES];
    }
    
}

- (void)pan:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint point = CGPointMake([sender translationInView:self].x + _barRectView.frame.origin.x, [sender translationInView:self].y + _barRectView.frame.origin.y);
        NSLog(@"%f %f",point.x,point.y);
        if (_direction == ScrollBarViewDirectionVertical) {
            //垂直方向
            if (point.y < 0) {
                //上边边界处理
                point.y = 0;
            }
            if (point.y > self.frame.size.height - barHeight) {
                //下边界处理
                point.y = self.frame.size.height - barHeight;
            }
            _parasiticScrollView.contentOffset = CGPointMake(0, point.y * _contentSize.height / self.frame.size.height);
            
        }else {
            //水平方向
            if (point.x < 0) {
                //左边边界处理
                point.x = 0;
            }
            if (point.x >= self.frame.size.width - barWidth) {
                //右边边界处理
                point.x = self.frame.size.width - barWidth;
            }
            _parasiticScrollView.contentOffset = CGPointMake(point.x * _contentSize.width / self.frame.size.width, 0);
        }
        // 复位,表示相对上一次
        [sender setTranslation:CGPointZero inView:self];
    }
    
}

- (void)setParasiticScrollView:(UIScrollView *)parasiticScrollView {
    [_parasiticScrollView removeObserver:self forKeyPath:@"contentOffset"];
    _parasiticScrollView = parasiticScrollView;
    [_parasiticScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}



- (UIView *)barRectView {
    if (!_barRectView) {
        _barRectView = [UIView new];
        _barRectView.backgroundColor = [UIColor grayColor];
        _barRectView.layer.cornerRadius = 5;
    }
    return _barRectView;
}


- (void)dealloc {
    [_parasiticScrollView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
