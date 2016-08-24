//
//  Dashboard.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 06/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "Dashboard.h"
#import "SWRevealViewController.h"
#import "RequestPickUpController.h"

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone6Plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE


@interface Dashboard (){



}

@end

@implementation Dashboard{



}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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
    
    
    MYLog(@"Dash board");
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    
   
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 5, 200 , 34)];
    [titleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = titleImageView;
    
    
    
    
    
    
    
    
    
    
    float targetHeight = self.navigationController.navigationBar.frame.size.height;
    
    MYLog(@"targetHeight - %f",self.navigationController.navigationBar.frame.size.width);
    
    UIButton *goToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    goToTop.frame = CGRectMake(0, self.view.frame.size.height-(70+targetHeight+20), self.view.frame.size.width, 70);
    [goToTop setTitle:@"REQUEST A PICK UP" forState:UIControlStateNormal];
    
    [goToTop setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    [goToTop addTarget:self action:@selector(requestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [goToTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToTop.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    goToTop.titleLabel.font = [UIFont systemFontOfSize:18];
    
    

    
    UIImageView *rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"requestQuote_2X.png"]];
    rightImageView.frame = CGRectMake(10,15 , 40, 40);
    
    
    [goToTop addSubview:rightImageView];
    
    
    UIImageView *lefttImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowWhite_2X.png"]];
    lefttImageView.frame = CGRectMake((goToTop.frame.size.width- 50), 15 , 40, 40);
    
    
    [goToTop addSubview:lefttImageView];
    
    
    [self.view addSubview:goToTop];
    
    
    self.tableView.scrollEnabled = NO;
    
    
}

-(void)requestAction:(UIButton*)sender
{
    
    MYLog(@"requestAction");
    
    RequestPickUpController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestPickUpController"];
    [self.navigationController pushViewController:controller animated:YES];
    
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

    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(isiPhone)
    {
        
        if (isiPhone6Plus)
        {
            return 202;
        }
        else if (isiPhone6)
        {
            return 180;
        }
        else if (isiPhone5)
        {
            
            return 150;
        }
        else
        {
            //iphone 3.5 inch screen
            
            return 120;
        }
    }
    else
    {
        //[ipad]
    }
    
    
    return 150;
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dash_board_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.row == 0){
        
         cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"dash_board_itrm_1.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    }else if(indexPath.row == 1){
        
         cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"dashboard_item_2.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    }else if(indexPath.row == 2){
    
         cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"dashboard_item_3.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
    
    
    
    
}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
