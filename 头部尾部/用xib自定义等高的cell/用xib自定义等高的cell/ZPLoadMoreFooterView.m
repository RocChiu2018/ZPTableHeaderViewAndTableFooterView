//
//  ZPLoadMoreFooterView.m
//  用xib自定义等高的cell
//
//  Created by apple on 16/6/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPLoadMoreFooterView.h"

@interface ZPLoadMoreFooterView()

@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (weak, nonatomic) IBOutlet UIView *loadingMoreView;

@end

@implementation ZPLoadMoreFooterView

+ (instancetype)footerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 如果想让UIActivityIndicatorView控件（菊花）显示的时候就开始有动画（转圈），则在xib文件中应该把控件的Behavior的Animating打上勾。
 */
- (IBAction)clickLoadMoreButton:(id)sender
{
    self.loadMoreButton.hidden = YES;
    self.loadingMoreView.hidden = NO;
    
    /**
     发布通知：
     object:后面的参数为nil，意味着匿名发布通知。
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadMore" object:nil];
}

-(void)endLoading
{
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(stopLoading) userInfo:nil repeats:NO];
}

-(void)stopLoading
{
    self.loadMoreButton.hidden = NO;
    self.loadingMoreView.hidden = YES;
}

@end
