//
//  ZPDeal.h
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPDeal : NSObject

@property (nonatomic, strong) NSString *buyCount;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)dealWithDict:(NSDictionary *)dictionary;

@end
