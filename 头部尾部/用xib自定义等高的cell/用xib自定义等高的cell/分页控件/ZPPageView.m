//
//  ZPPageView.m
//  分页
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 好的封装自定义控件的做法一般是给外界创建此自定义控件的时候以最大的自由度，即不管外界是使用代码的方式还是使用xib的方式都能够成功创建。要完成上述的目的，就要在此自定义控件类中都要写上以代码的方式创建的时候要调用的initWithFrame方法和以xib的方式创建的时候要调用的awakeFromNib方法。如果此自定义控件拥有xib文件的话，则还应该在上述的两个方法中都调用此自定义控件上面的子控件的初始化方法，在初始化方法中设置它的子控件的某些属性，在上述的情况下，为了防止外界使用代码的方式创建此自定义控件，除了撰写上述的代码外还应该重写drawRect方法，在此方法里撰写某些代码（在此方法中目前不知道应该写什么代码，但是知道应该在此方法中撰写某些代码，此问题留待以后再解决）。只有按照上述的原则撰写代码，外界才能不管使用何种方式都能成功创建此自定义控件。
 */
#import "ZPPageView.h"

@interface ZPPageView() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZPPageView

#pragma mark ————— 外界代码创建的时候调用的方法 —————
/**
 在其他类中用代码的方式创建此自定义控件的时候就会调用此方法，如果此自定义控件包含xib文件的话就要在此方法中调用此自定义控件上的子控件的初始化方法。
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

#pragma mark ————— 外界xib创建的时候调用的方法 —————
/**
 在其他类中用xib的方式创建此自定义控件的时候就会调用此方法，如果此自定义控件包含xib文件的话就要在此方法中调用此自定义控件上的子控件的初始化方法。
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

#pragma mark ————— 子控件的初始化方法 —————
/**
 在此方法中设置子控件的一些属性。
 */
- (void)setup
{
    self.scrollView.backgroundColor = [UIColor blueColor];
    
    //程序一启动的时候就开启定时器
    [self startTimer];
}

#pragma mark ————— 自定义控件的绘制方法 —————
/**
 当此自定义控件显示到屏幕上时，系统就会自动调用此方法进行绘制；
 如果外界用代码的方式创建此自定义控件，并且这个自定义控件包含xib文件，就应该重写这个方法并且在这个方法里面撰写某些代码（目前不知道应该写什么代码，但是知道应该在此方法中撰写某些代码，此问题留待以后再解决）。
 */
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    NSLog(@"write some code");
}

#pragma mark —————创建此自定义控件的类方法 —————
/**
 加载xib文件。
 */
+(instancetype)pageView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

#pragma mark ————— 设置图片数组属性 —————
-(void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    /**
     为了防止用户多次调用此方法，造成多个不必要的imageView的叠加，应该在叠加新的imageView之前尽数删除之前的；
     makeObjectsPerformSelector方法的意思是让调用此方法的所有对象都执行后面的括号内的方法。
     */
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //根据图片名创建对应的imageView
    for (int i = 0; i < imageNames.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:i]];
        [self.scrollView addSubview:imageView];
    }
    
    //设置总页数
    self.pageControl.numberOfPages = imageNames.count;
    
    //设置圆点是否隐藏
    if (imageNames.count <= 1)
    {
        self.pageControl.hidden = YES;
    }else
    {
        self.pageControl.hidden = NO;
    }
    
    //当单页的时候自动隐藏的另一种写法
//    self.pageControl.hidesForSinglePage = YES;
}

#pragma mark ————— 设置当前页的圆点颜色属性 —————
-(void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentColor;
}

#pragma mark ————— 设置其他页的圆点颜色的属性 —————
-(void)setOtherColor:(UIColor *)otherColor
{
    _otherColor = otherColor;
    
    self.pageControl.pageIndicatorTintColor = otherColor;
}

#pragma mark ————— 设置子控件的尺寸 —————
/**
 不论用代码创建还是用xib创建此自定义控件，系统都会调用此方法，一般在此方法中设置此自定义控件内部的子控件的尺寸。
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //UIScrollView控件的显示层的尺寸要和它的父控件的尺寸一样
    self.scrollView.frame = self.bounds;
    
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    //设置UIPageControl控件的尺寸
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 20;
    CGFloat pageControlX = scrollW - pageControlW;
    CGFloat pageControlY = scrollH - pageControlH;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    //去掉UIScrollView控件上面的两个滚动条
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置UIScrollView控件上面的UIImageView控件的坐标
    for (int i = 0; i < self.scrollView.subviews.count; i++)
    {
        UIImageView *imageView = [self.scrollView.subviews objectAtIndex:i];
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
    }
    
    //设置UIScrollView控件的内容层的大小
    self.scrollView.contentSize = CGSizeMake(scrollW * self.scrollView.subviews.count, 0);
    
    //开启UIScrollView控件的分页功能
    self.scrollView.pagingEnabled = YES;
}

#pragma mark ————— UIScrollViewDelegate —————
/**
 UIScrollView控件的内容层只要处在滚动状态的话就会不停的调用这个方法；
 在此代理方法内设置UIPageControl控件的当前页。
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int i = (int) (scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);  //四舍五入
    self.pageControl.currentPage = i;
}

/**
 当用户的手指刚一拖拽UIScrollView控件的内容层时就会调用这个方法；
 为了避免用户的手指长时间点击轮播图不动而等手指离开的时候轮播图又快速轮播的情况，当用户点击轮播图的时候应该停止定时器，等用户抬起手指的时候再开启定时器。
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 用户用手指拖拽UIScrollView控件，使控件开始滚动，然后用户手指离开控件的那一刻就会调用这个方法；
 在此方法中开启定时器。
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark ————— 开启定时器 —————
-(void)startTimer
{
    /**
     创建定时器的方法1：
     用这个方法生成的定时器系统会自动保留的，不会出了这个方法就自动销毁的，并且新生成的这个定时器系统会自动启动。
     */
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    /**
     创建定时器的方法2：
     用这个方法生成的定时器系统不会自动保留，只要出了这个方法的作用域就会被销毁；
     用这个方法生成的定时器系统不会自动启动的，需要手动启动。
     */
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    [timer fire];
    
    /**
     在主线程中某一时刻只能执行一个任务。当用户拖拽UITextView控件的时候，系统会优先执行这个任务，此时定时器的任务就会停掉，如果想在主线程执行其他任务的时候定时器任务也不停掉的话就应该把定时器任务加入到mainRunLoop中，这样的话主线程在一段时间内执行其他任务，在一段时间内执行定时器任务，两个任务交替执行。这里的“一段时间”是非常短的时间，所以看上去就是两个任务在同时执行了。
     */
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark ————— 停止定时器 —————
-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;  //把定时器置空
}

#pragma mark ————— 轮播图滚动 —————
-(void)nextPage
{
    NSInteger page = self.pageControl.currentPage + 1;
    
    if (page == self.pageControl.numberOfPages)
    {
        page = 0;
    }
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = page * self.scrollView.frame.size.width;
    
    [self.scrollView setContentOffset:offset animated:YES];  //UIScrollView控件自带动画
}

@end
