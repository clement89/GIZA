//
//  NotificationsViewController.m
//  GIZA LAUNDRY
//
//  Created by Clement on 06/07/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "NotificationsViewController.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"


@implementation NotificationsViewController{

    NSArray *notificationsArray;

    APIHandler *handler;
}



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
    
    
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/notificationsList.plist"];
    
    MYLog(@"filepath -- %@",filePath);
    
    
    notificationsArray =  [[NSArray alloc]initWithContentsOfFile:filePath];
    
    
    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Loading Notifications"];
    
    [handler getNotificationsList];
    

    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    MYLog(@" cell - ");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MYLog(@" cell - ");
    return [notificationsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 80;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYLog(@" cell - ");
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noti_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    NSDictionary *dictItem = [notificationsArray objectAtIndex:indexPath.row];
    
    
    
    UILabel *titleLabel = [cell viewWithTag:1];
    
    UILabel *dateLabel = [cell viewWithTag:2];
    
    UILabel *detailLabel = [cell viewWithTag:3];
    
    
    
    titleLabel.text = [dictItem valueForKey:@"type"];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
//    cell.textLabel.textColor = [UIColor blackColor];
    
    dateLabel.text = [dictItem valueForKey:@"created_at"];
    
    detailLabel.text = [dictItem valueForKey:@"description"];
    //cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    //cell.detailTextLabel.adjustsFontSizeToFitWidth=YES;
    cell.detailTextLabel.minimumScaleFactor=0.5;
    
    
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.detailTextLabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
    
    
}

#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    [SVProgressHUD dismiss];
    
    notificationsArray = response;
    [self.tableView reloadData];
    
    
    
    //Write data to file if we got somethig.
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/notificationsList.plist"];
    
    MYLog(@"filepath -- %@",filePath);
    
    if([response writeToFile: filePath atomically:YES]){
        
        MYLog(@"write to file success")
        
        
    }else{
        
        MYLog(@"write to file failed...")
    }
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    [SVProgressHUD dismiss];
    MYLog(@" Error - %@",error);
}




@end
