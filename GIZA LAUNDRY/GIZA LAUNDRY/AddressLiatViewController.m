//
//  AddressLiatViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 10/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "AddressLiatViewController.h"
#import "SVProgressHUD.h"
#import "AddAddressViewController.h"


@implementation AddressLiatViewController{
    
    APIHandler *handler;
    
    
}

@synthesize AddressListArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-InnerPages_BackgroundImage.jpg"]] ];
    

    
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
    
    UIButton *goToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    goToTop.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    [goToTop setTitle:@"ADD ADDRESS" forState:UIControlStateNormal];
    
    [goToTop setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    [goToTop addTarget:self action:@selector(addAddressClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [goToTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToTop.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    goToTop.titleLabel.font = [UIFont systemFontOfSize:18];
    //[self.view addSubview:goToTop];
    
    UIBarButtonItem *temp  = [[UIBarButtonItem alloc]initWithCustomView:goToTop];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    negativeSpacer.width = -16; // it was -6 in iOS 6
    
    [self setToolbarItems:[NSArray arrayWithObjects:negativeSpacer,temp, nil]];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"kReloadAddressList"
                                               object:nil];
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Loading Addresses"];
    
    [handler getAddresses];
    

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)reloadTable {
    
    
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
    
    AddressListArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    
    [self.tableView reloadData];
    
    
    
}

-(void)addAddressClicked
{
    
    
    AddAddressViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAddressViewController"];
    controller.isEdit = NO;
    [self.navigationController pushViewController:controller animated:YES];
    
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [AddressListArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    if(indexPath.row == 0){
        
        return 47;
        
    }else{
        
        
        return 118;
    }

    
    
    
    
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell;
    
    // Configure the cell...
    
    
    NSDictionary *addressDict = [AddressListArray objectAtIndex:indexPath.section];
    
       
    if(indexPath.row == 0){
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"address_heading_cell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        titleLabel.text = @"Address";
        
        UILabel *buttenLabel = [cell.contentView viewWithTag:2];
        buttenLabel.text = @"Default";
        
        
        UISwitch *onoff = [cell.contentView viewWithTag:3];
        
        int isDefault = [[addressDict valueForKey:@"is_default"]intValue];
        
        if(isDefault == 1){
        
            [onoff setOn:YES];
        
        }else{
            
            [onoff setOn:NO];
        
        }
        
        [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
        
        
    
    }else{
    
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"address_detail_cell" forIndexPath:indexPath];
        
        
        UILabel *addressLabel = [cell.contentView viewWithTag:1];
        
        
        
//        NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",[addressDict valueForKey:@"building_no"],[addressDict valueForKey:@"street"],[addressDict valueForKey:@"zone_number"],[addressDict valueForKey:@"notes"]];
        
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",[addressDict valueForKey:@"full_name"],[addressDict valueForKey:@"building_no"],[addressDict valueForKey:@"street"],[addressDict valueForKey:@"zone_number"],[addressDict valueForKey:@"notes"]];
                                                                               
        
        
        
        NSString *strLatitude = [addressDict valueForKey:@"latitude"];
        NSString *strLongitude = [addressDict valueForKey:@"longitude"];
        
        if([strLatitude length]> 5 || [strLongitude length] > 5)
        {
            str = [NSString stringWithFormat:@"%@",[addressDict valueForKey:@"address1"]];
        
        
        }
        
        addressLabel.text = str;
        
        
        
        UIButton *editButton  = [cell.contentView viewWithTag:2];
        [editButton addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *deleteButton  = [cell.contentView viewWithTag:3];
        [deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}




- (void) flip: (id) sender {
    
    
//    UISwitch *onoff = (UISwitch *) sender;
//    MYLog(@"%@", onoff.on ? @"On" : @"Off");
    
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    NSMutableDictionary *addressDict = [NSMutableDictionary dictionaryWithDictionary:[AddressListArray objectAtIndex:indexPath.section]];
    
    
    MYLog(@"addressDict - %@",addressDict);
    
    NSString *idStr = [[addressDict valueForKey:@"id"]stringValue];
    
    
    
    [handler setDefaultAddress:[NSDictionary dictionaryWithObjectsAndKeys:idStr,@"id", nil]];
    
    [addressDict setValue:[NSNumber numberWithInt:1] forKey:@"is_default"];
    
    
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:[AddressListArray count]];
    
    
    
    for(int i = 0;  i<[AddressListArray count]; i++){
    
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:[AddressListArray objectAtIndex:i]];
        
        if(![[[tempDict valueForKey:@"id"]stringValue] isEqualToString:idStr]){
            
            MYLog(@"updated");
        
            [tempDict setValue:[NSNumber numberWithInt:0] forKey:@"is_default"];
            
            
            [tempArray addObject:tempDict];
        
        }else{
        
             MYLog(@"updated");
            
            [tempArray addObject:addressDict];
        }
    
    }
    
    
    AddressListArray = tempArray;
    
    MYLog(@"AddressListArray - %@",AddressListArray);
    
    
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
    
    [AddressListArray writeToFile: filePath atomically:YES];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadRow" object:self];
    
    [self.tableView reloadData];

    
    
}
- (void) deleteButtonClicked:(UIButton *) sender {
    
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    NSMutableDictionary *addressDict = [NSMutableDictionary dictionaryWithDictionary:[AddressListArray objectAtIndex:indexPath.section]];
    
    
    MYLog(@"addressDict - %@",addressDict);
    
    NSString *idStr = [[addressDict valueForKey:@"id"]stringValue];
    
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Deleting Address"];
    
    [handler deleteAddress:[NSDictionary dictionaryWithObjectsAndKeys:idStr,@"id", nil]];




}


- (void) editButtonClicked:(UIButton *) sender {
    
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];

    
    
    
    AddAddressViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAddressViewController"];
    controller.isEdit = YES;
    controller.oldAddressDict = [AddressListArray objectAtIndex:indexPath.section];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
    
}



#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    
    
    if([APIname isEqualToString:@"ADDRESSES"]){
        
        
        [SVProgressHUD dismiss];
        
        
        AddressListArray = response;
        
        
        
        
        //Write data to file if we got somethig.
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [path objectAtIndex:0];
        NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
        
        [AddressListArray writeToFile: filePath atomically:YES];
        
        
        
        
        
        [self.tableView reloadData];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadRow" object:self];
        
        
        
    }else if([APIname isEqualToString:@"DELETE_ADDRESS"]){
    
    
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Address deleted successfully!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];

        [handler getAddresses];
    
    }
    
    
    
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    
    [SVProgressHUD dismiss];
    
    
    
    MYLog(@" Error - %@",error);
}

- (void) APIReponseWithErrorDetail:(NSDictionary *)response APIName:(NSString *)APIName{



    if([APIName isEqualToString:@"DELETE_ADDRESS"]){
        
        
        [SVProgressHUD dismiss];

        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:[response valueForKey:@"message"]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        

    
    
    }
}



@end
