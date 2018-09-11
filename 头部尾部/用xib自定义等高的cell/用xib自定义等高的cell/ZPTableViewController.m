//
//  ZPTableViewController.m
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPTableViewController.h"
#import "ZPDeal.h"
#import "ZPTableViewCell.h"
#import "ZPLoadMoreFooterView.h"
#import "ZPPageView.h"

@interface ZPTableViewController ()

@property (nonatomic, strong) NSMutableArray *deals;

@end

@implementation ZPTableViewController

#pragma mark ————— 懒加载 —————
-(NSMutableArray *)deals
{
    if (_deals == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dic in dictArray)
        {
            ZPDeal *deal = [ZPDeal dealWithDict:dic];
            [tempArray addObject:deal];
        }
        
        _deals = tempArray;
    }
    
    return _deals;
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     设置表格的头部视图(tableHeaderView)：
     UITableView控件的tableHeaderView和tableFooterView属性指的是整个表格的头部和尾部视图，在设置控件为上述两个属性的时候不管设置的宽度是多少，实际显示的宽度都与表格的宽度一样。
     */
    ZPPageView *pageView = [ZPPageView pageView];
    pageView.imageNames = [NSArray arrayWithObjects:@"2c97690e72365e38e3e2a95b934b8dd2", @"5ee372ff039073317a49af5442748071", @"9b437cdfb3e3b542b5917ce2e9a74890", @"37e4761e6ecf56a2d78685df7157f097", @"2010e3a0c7f88c3f5f5803bf66addd93", nil];
    pageView.frame = CGRectMake(0, 0, 100, pageView.frame.size.height);
    self.tableView.tableHeaderView = pageView;
    
    /**
     设置表格的尾部视图(tableFooterView)：
     */
    self.tableView.tableFooterView = [ZPLoadMoreFooterView footerView];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMore:) name:@"loadMore" object:nil];
}

#pragma mark ————— 加载更多对象 —————
/**
 点击“点击按钮加载”按钮触发的方法
 */
- (void)loadMore:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ZPDeal *deal = [[ZPDeal alloc] init];
        deal.icon = [NSString stringWithFormat:@"53453be0d2dd458c057286d17f6b9306"];
        deal.title = @"油炸龙虾";
        deal.price = @"280";
        deal.buyCount = @"20";
        
        [self.deals addObject:deal];
        
        [self.tableView reloadData];
    });
    
    //加载完毕的时候结束加载
    ZPLoadMoreFooterView *footer = (ZPLoadMoreFooterView *)self.tableView.tableFooterView;
    [footer endLoading];
}

#pragma mark ————— UITableViewDataSource —————
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZPTableViewCell *cell = [ZPTableViewCell cellWithTableView:tableView];
    cell.deal = [self.deals objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark ————— 移除通知 —————
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
