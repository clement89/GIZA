//
//  OrderHistoryViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 10/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "SWRevealViewController.h"
#import "OrderDetailsViewController.h"
#import "SVProgressHUD.h"



@interface OrderHistoryViewController ()

@end

@implementation OrderHistoryViewController{

    APIHandler *handler;
    NSArray *myOrdersArray;
    UIRefreshControl  * refreshControl;

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
    
    

    CGFloat xValue = (([UIScreen mainScreen].bounds.size.width)/2)-75;
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xValue, 5, 150 , 45)];[titleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = titleImageView;
    
    
    //Add header....
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width, 30)];
    titleLabel.text = @"ORDER HISTORY";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    self.tableView.tableHeaderView = headerView;
    
    
    
    //Get data.....
    
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentFolder = [path objectAtIndex:0];
//    NSString *filePath = [documentFolder stringByAppendingFormat:@"/myOrdersInfo.plist"];
//    
//    
//    NSArray *savedData =  [[NSArray alloc]initWithContentsOfFile:filePath];
//    
//    MYLog(@"savedData -- %@",savedData);
//
    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;

    
//    if(savedData.count == 0){
//        
//        
//        
//        
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
//        [SVProgressHUD showWithStatus:@"Loading my orders"];
//        
//        
//        [handler getMyOders];
//        
//        
//        
//    }else{
//        
//        myOrdersArray = savedData;
//        
//        
//        
//    }
//
    
    
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Loading my orders"];
    
    
    [handler getMyOders];
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-InnerPages_BackgroundImage.jpg"]] ];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [myOrdersArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dictItem = [myOrdersArray objectAtIndex:indexPath.section];
    
    
    
    UITableViewCell *cell;
    
    if(indexPath.row==0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"order_history_cell"];
        

        UILabel *name = (UILabel *)[cell viewWithTag:1 ];
        NSString *text = [NSString stringWithFormat:@"OrderID: #%@",[dictItem valueForKey:@"id"]];//@"OrderID: #123";
        
        
        
        if ([name respondsToSelector:@selector(setAttributedText:)])
        {
            
            // Create the attributes
            const CGFloat fontSize = 13;
            NSDictionary *attrs = @{
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],
                                    NSForegroundColorAttributeName:[UIColor blackColor]
                                    };
            NSDictionary *subAttrs = @{
                                       NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                                       };
            
            // Range of " 2012/10/14 " is (8,12). Ideally it shouldn't be hardcoded
            // This example is about attributed strings in one label
            // not about internationalization, so we keep it simple :)
            const NSRange range = NSMakeRange(9,[text length]-9);
            
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:subAttrs];
            [attributedText setAttributes:attrs range:range];
            
            // Set it in our UILabel and we are done!
            [name setAttributedText:attributedText];
            
            
            MYLog(@"OK");
            
        }
        
        
        
        UILabel *status = (UILabel *)[cell viewWithTag:2 ];

        text = [NSString stringWithFormat:@"Status: %@",[dictItem valueForKey:@"order_status"]];//@"Status: In Transit";
        
        
        if ([status respondsToSelector:@selector(setAttributedText:)])
        {
            
            // Create the attributes
            const CGFloat fontSize = 13;
            NSDictionary *attrs = @{
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],
                                    NSForegroundColorAttributeName:[UIColor blackColor]
                                    };
            NSDictionary *subAttrs = @{
                                       NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                                       };
            
            // Range of " 2012/10/14 " is (8,12). Ideally it shouldn't be hardcoded
            // This example is about attributed strings in one label
            // not about internationalization, so we keep it simple :)
            const NSRange range = NSMakeRange(7,[text length]-7);
            
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:subAttrs];
            [attributedText setAttributes:attrs range:range];
            
            // Set it in our UILabel and we are done!
            [status setAttributedText:attributedText];
            
            MYLog(@"OK");
            
        }

        
        
        


    
    
    }
    else   if(indexPath.row==1){
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"order_history_cell2"];
        
        MYLog(@"OK   --- %@",[dictItem valueForKey:@"pickup_date"]);
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd LLLL"];
        
        NSDateFormatter *tempFormatter=[[NSDateFormatter alloc]init];
        [tempFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *delivery_date = [tempFormatter dateFromString:[dictItem valueForKey:@"pickup_date"]];
        
        NSString *formattedDate = [df stringFromDate:delivery_date];
        
        
        UILabel *name = (UILabel *)[cell viewWithTag:3 ];
        NSString *text = [NSString stringWithFormat:@"Date: %@",formattedDate];//@"Date: 5 May";
        if ([name respondsToSelector:@selector(setAttributedText:)])
        {
            
            // Create the attributes
            const CGFloat fontSize = 13;
            NSDictionary *attrs = @{
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],
                                    NSForegroundColorAttributeName:[UIColor blackColor]
                                    };
            NSDictionary *subAttrs = @{
                                       NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                                       };
            
            // Range of " 2012/10/14 " is (8,12). Ideally it shouldn't be hardcoded
            // This example is about attributed strings in one label
            // not about internationalization, so we keep it simple :)
            const NSRange range = NSMakeRange(5,[text length]-5);
            
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:subAttrs];
            [attributedText setAttributes:attrs range:range];
            
            // Set it in our UILabel and we are done!
            [name setAttributedText:attributedText];
            
            MYLog(@"OK");
            
        }

        UIButton *detailsButton = (UIButton * )[cell viewWithTag:4];
        
        [detailsButton addTarget:self action:@selector(viewDetailsButtonClicked:) forControlEvents:UIControlEventTouchDown];
        
        
        
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}



-(void)viewDetailsButtonClicked:(UIButton*)sender
{
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    OrderDetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailsViewController"];
    
    
    
    
    NSDictionary *orderDict = [myOrdersArray objectAtIndex:indexPath.section];
    
    
    controller.orderStatus = [orderDict valueForKey:@"order_status"];
    
    [self.navigationController pushViewController:controller animated:YES];

}



#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    [SVProgressHUD dismiss];
    
    
    if([APIname isEqualToString:@"MY_ORDERS"]){
        
        [refreshControl endRefreshing];
        
        
        myOrdersArray = response;
        
        
        
        
        //Write data to file if we got somethig.
//        
//        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentFolder = [path objectAtIndex:0];
//        NSString *filePath = [documentFolder stringByAppendingFormat:@"/myOrdersInfo.plist"];
//        
//        [myOrdersArray writeToFile: filePath atomically:YES];
        
        
        
        
        
        [self.tableView reloadData];
        
        
        
        
        
        
    }
    
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
}





@end
