//
//  OrderDetailsViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 10/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "OrderDetailsViewController.h"

@implementation OrderDetailsViewController{

    BOOL completedFlag;


}

@synthesize orderStatus;


- (void)viewDidLoad {
    [super viewDidLoad];
    
   

    CGFloat xValue = (([UIScreen mainScreen].bounds.size.width)/2)-75;
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xValue, 5, 150 , 45)];[titleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = titleImageView;

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    
    //Add header....
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width, 30)];
    titleLabel.text = @"STATUS";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    self.tableView.tableHeaderView = headerView;


    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-InnerPages_BackgroundImage.jpg"]] ];

    
    MYLog(@"historyArray - %@",orderStatus);
    
    completedFlag = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"history_detail_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
   
    
    
    
    
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    
    if(indexPath.row == 0){
    
        cell.textLabel.text = [@"Order Placed" uppercaseString];
        
    
    }else if(indexPath.row == 1){
    
        cell.textLabel.text = [@"Accepted" uppercaseString];
    
    }else if(indexPath.row == 2){
        
        cell.textLabel.text = [@"Picked Up" uppercaseString];//@"PICKED UP";
        
    }else if(indexPath.row == 3){
        
        cell.textLabel.text = [@"PROCESSING" uppercaseString];//@"PROCESSING";
        
    }else if(indexPath.row == 4){
        
        cell.textLabel.text = [@"Ready To Deliver" uppercaseString];//@"READY TO DELIVER";
        
    }else if(indexPath.row == 5){
        
        cell.textLabel.text = [@"Delivered" uppercaseString];//@"DELIVERED";
        
    }
    
    
    
    
    
    if(completedFlag){
    
        UIImage *cellImage;
        cellImage = [UIImage imageNamed:@"orangeRound_3X.png"];
        
        cell.imageView.image = cellImage;
        
   
    }
    
    
    CGSize itemSize = CGSizeMake(20, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    if([orderStatus isEqualToString:@"Order Delivery Accepted"]){
    
        orderStatus = @"Ready To Deliver";
    
    }
    
    
    if([orderStatus isEqualToString:@"Order Pickup Accepted"]){
        
        orderStatus = @"Accepted";
        
    }
    
    
    
    
    if([[orderStatus uppercaseString]isEqualToString:cell.textLabel.text]){
        
        completedFlag = NO;
        
        
    }

    
    
    
    
    
    //cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}





@end
