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
    

    CGFloat xValue = (([UIScreen mainScreen].bounds.size.width)/2)-75;
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xValue, 5, 150 , 45)];[titleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = titleImageView;
    
    
    
    
    
    
    
    
    //Add header....
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 150)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 50)];
    titleLabel.text = @"  CONTACT US";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    
    [headerView addSubview:titleLabel];
    
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, width-40, 100)];
    detailLabel.text = @"Having an issue with the app or an order? Feel free to contact us !";
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:detailLabel];
    
    self.tableView.tableHeaderView = headerView;
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        
        return @"Call Us";
        
    }else if (section == 1){
        
        return @"Email Us";
        
    }else{
        
        return @"Visit Us";
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contact_us_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    UIButton *acceceryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    acceceryButton.frame = CGRectMake(0, 0, 30, 30);

    
    // Set a target and selector for the accessoryView UIControlEventTouchUpInside
    
    
    if(indexPath.section == 0){
        
        [acceceryButton setImage:[UIImage imageNamed:@"call_us.png"] forState:UIControlStateNormal];
        [acceceryButton addTarget:self action:@selector(someAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.textLabel.text = @"4444 8687, 3344 3323";
        
    
    
    }else if(indexPath.section == 1){
    
        [acceceryButton setImage:[UIImage imageNamed:@"mail_us.png"] forState:UIControlStateNormal];
        [acceceryButton addTarget:self action:@selector(someAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.textLabel.text = @"INFO@ALGIZAGROUP.COM";
    
    }else{
    
        [acceceryButton setImage:[UIImage imageNamed:@"visit_us.png"] forState:UIControlStateNormal];
        [acceceryButton addTarget:self action:@selector(someAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.textLabel.text = @"WWW.ALGIZAGROUP.COM";
    
    
    }
    
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryView = acceceryButton;
    
    
    

    
    
    return cell;
    
}


-(void)someAction:(UIButton*)sender
{
    
    
}

@end
