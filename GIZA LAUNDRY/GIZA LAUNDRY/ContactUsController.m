//
//  ContactUsController.m
//  GIZA LAUNDRY
//
//  Created by Clement on 13/09/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "ContactUsController.h"
#import "SWRevealViewController.h"


@implementation ContactUsController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 25, 30);
        [btn setImage:[UIImage imageNamed:@"sidebar_icon.png"] forState:UIControlStateNormal];
        [btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [self.navigationItem setLeftBarButtonItem:sidebarButton animated:YES];
        
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
    
    
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 5, 200 , 34)];
    [titleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = titleImageView;
    
    
    
    
    
    
    
    
    //Add header....
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width, 30)];
    titleLabel.text = @"CONTACT US";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    self.tableView.tableHeaderView = headerView;
    
    
    
}






@end
