//
//  ZPPageView.h
//  分页
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 自定义控件类；
 把自定义控件封装起来，不让外界知道这个自定义控件的内部构造，自定义控件类只对外界暴露它的构造方法和一些必要的属性供外界进行调用。
 */
#import <UIKit/UIKit.h>

@interface ZPPageView : UIView

@property (nonatomic, strong) NSArray *imageNames;

/**
 当前圆点的颜色；
 自己在封装第三方库的时候，封装完一版之后上传到github，在发布后面版本的时候如果觉得之前一版的某个属性或者方法应该被废弃的话，则应该效仿苹果的做法，在这个属性或者方法后面缀上"NS_DEPRECATED_IOS"关键字，然后在此关键字的后面写上括号，在括号里面写上这个属性或者方法是从哪个版本开始使用的，到哪个版本被废弃的，两个版本号之间用逗号隔开，如果还想在后面写上文字备注的话，则应该在最后一个版本号后面加上逗号隔开，然后再写文字备注。
 */
@property (nonatomic, strong) UIColor *currentColor NS_DEPRECATED_IOS(2_0, 3_0, "此属性已废弃，建议使用其他属性");
//其他圆点的颜色
@property (nonatomic, strong) UIColor *otherColor;

+(instancetype)pageView;

@end
