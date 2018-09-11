//
//  ZPTableViewCell.m
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPTableViewCell.h"
#import "ZPDeal.h"

@interface ZPTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation ZPTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"deal";
    
    ZPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZPTableViewCell class]) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(void)setDeal:(ZPDeal *)deal
{
    _deal = deal;
    
    self.iconView.image = [UIImage imageNamed:deal.icon];
    self.titleLabel.text = deal.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@", deal.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买", deal.buyCount];
}

@end
