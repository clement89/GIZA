//
//  RateCardViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 10/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "RateCardViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"



@interface RateCardViewController ()

@end

@implementation RateCardViewController{
    
    
    APIHandler *handler;
    NSDictionary *rateCardList;
    UIRefreshControl  * refreshControl;
    NSArray *listItems;
    
    
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
    

    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/rateCardInfo.plist"];
    
    
    NSDictionary *savedData =  [[NSDictionary alloc]initWithContentsOfFile:filePath];
    
    MYLog(@"savedData -- %@",savedData);
    
    if(savedData.count == 0){
        
        
        
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"Loading rate card"];
        
        
        [handler getRateCard];
        
        
        
    }else{
        
        rateCardList = savedData;
        
        
        listItems = [rateCardList valueForKey:@"Dry Cleaning"];
        
    }

    
    
    
    
    
    refreshControl = [[UIRefreshControl alloc]init];
    
    //refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating feeds..."]; //to give the attributedTitle
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
    
    
    
    //Add header ....
    

    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    
    view.backgroundColor = [UIColor grayColor];
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"DRY CLEANING", @"IRONING", @"WASHING", nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(10, 10, self.tableView.frame.size.width-20, 30);
    
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    
    segmentedControl.selectedSegmentIndex = 0;
    
    segmentedControl.tintColor = [UIColor whiteColor];//[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0];
    
    
    [view addSubview:segmentedControl];
    
    
    self.tableView.tableHeaderView = view;
    
    
    
    


}


- (void)refreshTable {
    //TODO: refresh your data
    
   
    [handler getRateCard];
    
    
    
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
    
    return [listItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rate_card_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    NSDictionary *itemDict = [listItems objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = [itemDict valueForKey:@"rate_card_name"];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textColor = [UIColor blackColor];
    
    
    
    cell.detailTextLabel.text = [itemDict valueForKey:@"amount"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0];

    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}







- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    
    MYLog(@"MySegmentControlAction - %ld",(long)segment.selectedSegmentIndex);
    
    
    //segment.selectedSegmentIndex = segment.selectedSegmentIndex;
    
    segment.selectedSegmentIndex = segment.selectedSegmentIndex;
    
    if(segment.selectedSegmentIndex == 0)
    {
        // code for the first button
        
        listItems = [rateCardList valueForKey:@"Dry Cleaning"];
        [self.tableView reloadData];
        
        
    }else if(segment.selectedSegmentIndex == 1){
    
        listItems = [rateCardList valueForKey:@"Iron Service"];
        [self.tableView reloadData];
    
    
    }else if(segment.selectedSegmentIndex == 2){
        
        listItems = [rateCardList valueForKey:@"Laundry Cleaning"];
        [self.tableView reloadData];
        
    }
    
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





#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    [SVProgressHUD dismiss];
    
    
    if([APIname isEqualToString:@"RATE_CARD"]){
        
        [refreshControl endRefreshing];
        
        
        rateCardList = response;
        
        
        
        
        //Write data to file if we got somethig.
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [path objectAtIndex:0];
        NSString *filePath = [documentFolder stringByAppendingFormat:@"/rateCardInfo.plist"];
        
        MYLog(@"filepath -- %@",filePath);
        
        if([rateCardList writeToFile: filePath atomically:YES]){
            
            MYLog(@"write to file success")
            
            
        }else{
            
            MYLog(@"write to file failed...")
        }

        
        
        
        listItems = [rateCardList valueForKey:@"Dry Cleaning"];
        [self.tableView reloadData];
        
        
       
        
        
        
    }
    
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
}






@end
