//
//  ZPDeal.m
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPDeal.h"

@implementation ZPDeal

+ (instancetype)dealWithDict:(NSDictionary *)dictionary
{
    ZPDeal *deal = [[self alloc] init];
    
    //KVC
    [deal setValuesForKeysWithDictionary:dictionary];
    
    return deal;
}

@end
