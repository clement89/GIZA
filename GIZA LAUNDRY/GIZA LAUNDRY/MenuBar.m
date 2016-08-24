//
//  MenuBar.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 06/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "MenuBar.h"
#import "AppDelegate.h"

@interface MenuBar ()

@end

@implementation MenuBar{


    NSMutableArray *menuItems;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UncommMI 20800mAh PowerBank @Just980rs.(COD+ FreeShipping)ent the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    MYLog(@"Menu bar");
    
    
    menuItems = [[NSMutableArray alloc]initWithArray:@[@"home_cell" , @"request_cell",@"rate_card_cell", @"order_history_cell", @"my_profile_cell",@"logout_cell",@"notifications_cell",@"about_cell"]];
    
    
    
    
    
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

    return [menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [menuItems objectAtIndex:indexPath.row];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    UIImage *cellImage;
    
    if([cellIdentifier isEqualToString:@"my_profile_cell"]){
        
        cell.textLabel.text = @"My Profile";
        cellImage = [UIImage imageNamed:@"slideMenu_ProfileIcon_3X.png"];
        
        
    }else if([cellIdentifier isEqualToString:@"request_cell"]){
        
        cell.textLabel.text = @"Request a Pick up";
        cellImage = [UIImage imageNamed:@"slideMenu_RequestPickup_Icon_3X.png"];
        
    }else if([cellIdentifier isEqualToString:@"rate_card_cell"]){
        
        cell.textLabel.text = @"Rate Card";
        cellImage = [UIImage imageNamed:@"slideMenu_RateCard_Icon_3X.png"];
        
    }else if([cellIdentifier isEqualToString:@"order_history_cell"]){
        
        cell.textLabel.text = @"Order History";
        cellImage = [UIImage imageNamed:@"slideMenu_OrderHistory_Icon_3X.png"];
        
    }
    else if([cellIdentifier isEqualToString:@"home_cell"]){
        
        cell.textLabel.text = @"Home";
        cellImage = [UIImage imageNamed:@"home_3x.png"];
        
    }else if([cellIdentifier isEqualToString:@"logout_cell"]){
        
        
        BOOL isLogedIn = [[NSUserDefaults standardUserDefaults]boolForKey:@"y2kLoggedIn"];
        
        if(isLogedIn){
            
            cell.textLabel.text = @"Logout";
            
        }else{
            
            cell.textLabel.text = @"Login";
            
        }        
        cellImage = [UIImage imageNamed:@"slideMenu_Logout_Icon_3X.png"];
        
    }else if([cellIdentifier isEqualToString:@"notifications_cell"]){
        
        
        cell.textLabel.text = @"Notifications";
        cellImage = [UIImage imageNamed:@"notification_icon.png"];
        
        
    }else if([cellIdentifier isEqualToString:@"about_cell"]){
        
        cell.textLabel.text = @"About Us";
        cellImage = [UIImage imageNamed:@"aboutus_icon.png"];
        
    }
    
    
    
    
    cell.imageView.image = cellImage;
    
    
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *cellIdentifier = cell.reuseIdentifier;
    
    if([cellIdentifier isEqualToString:@"logout_cell"]){
        
        
        
        
        BOOL isLogedIn = [[NSUserDefaults standardUserDefaults]boolForKey:@"y2kLoggedIn"];
        
        if(isLogedIn){
            

            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:@"Are you sure, you want to logout?"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Ok",nil];
            alert.tag = 25;
            [alert show];
            alert=nil;
            return;
            
            
            
        }else{
            
            
            
            //[[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"kaccess_tocken"];
            
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"kaccess_tocken"];
            
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *filePath = [documentsPath stringByAppendingFormat:@"/ProfileInfo.plist"];
            NSError *error;
            BOOL success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed profile data...");
                
            }
            
            filePath = [documentsPath stringByAppendingFormat:@"/AddresList.plist"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed address data...");
                
            }
            
            filePath = [documentsPath stringByAppendingFormat:@"/notificationsList.plist"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"notifications address data...");
                
            }
            
            
            filePath = [documentsPath stringByAppendingFormat:@"/dp.jpg"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed dp data...");
                
            }
            
            filePath = [documentsPath stringByAppendingFormat:@"/rateCardInfo.plist"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed ratecard data data...");
                
            }
            
            
            //
            
            
            
            
            
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"y2kLoggedIn"];
            [((AppDelegate*) [[UIApplication sharedApplication] delegate]) isUserLoggedIn];
            
            
        }
        
        
        
       
        
        
    }
    
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 160;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    MYLog(@"fucked uppp");
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 160)];
    
    UIImageView *backgroundImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sliderMenu_TopImage.jpg"]];
    backgroundImg.frame = CGRectMake(0, 0, tableView.frame.size.width, 160);
    
    
    
    [view addSubview:backgroundImg];
    
    
    
    
//    
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    
//    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, 200, 30)];
//    nameLabel.text = [NSString stringWithFormat:@"%@ %@",[def valueForKey:@"kfirstName"],[def valueForKey:@"ksecondName"]];
//    [view addSubview:nameLabel];
//    
//    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 130, 200, 30)];
//    numberLabel.text = [NSString stringWithFormat:@"+%@ %@",[def valueForKey:@"kcountry_code"],[def valueForKey:@"kphone_number"]];
//    [view addSubview:numberLabel];
//    
    
    return view;
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertLogOut clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertLogOut.tag == 25)
    {
        if (buttonIndex==1)
        {
            
            //[[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"kaccess_tocken"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"kaccess_tocken"];

            
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *filePath = [documentsPath stringByAppendingFormat:@"/ProfileInfo.plist"];
            NSError *error;
            BOOL success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed profile data...");
                
            }
            
            filePath = [documentsPath stringByAppendingFormat:@"/AddresList.plist"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed address data...");
                
            }

            
            filePath = [documentsPath stringByAppendingFormat:@"/notificationsList.plist"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed notifications data...");
                
            }

            filePath = [documentsPath stringByAppendingFormat:@"/dp.jpg"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed dp data...");
                
            }
            
            filePath = [documentsPath stringByAppendingFormat:@"/rateCardInfo.plist"];
            success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
                MYLog(@"removed ratecard data data...");
                
            }
            
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"y2kLoggedIn"];
            [((AppDelegate*) [[UIApplication sharedApplication] delegate]) isUserLoggedIn];
            
            
        }
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

@end
