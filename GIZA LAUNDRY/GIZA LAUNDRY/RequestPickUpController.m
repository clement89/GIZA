//
//  RequestPickUpController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 10/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "RequestPickUpController.h"
#import "SWRevealViewController.h"
#import "AddressLiatViewController.h"
#import "AddAddressViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "SignUpViewController.h"
//#import "Dashboard.m"

@interface RequestPickUpController ()

@end

@implementation RequestPickUpController{

    UIPickerView *pickrView;
    UIDatePicker  *datePicker;
    
    UIDatePicker  *dateDelivery;
    
    UITextField *activeTextField;
    
    
    NSArray *addressList;
    
    NSDictionary *defaultAddresDict;
    APIHandler *handler;
    
    NSMutableDictionary *paramsDict;
    
    BOOL isFriday;
    
    UITextField *pickUpSlot;
    UITextField *deleverySlot;

}
@synthesize isUpdate,updateItem;

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
    
    
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-InnerPages_BackgroundImage.jpg"]] ];
    
    
    
    
    
//    //Footer
//    
//    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 70)];
//    [footerView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
//    self.tableView.tableFooterView = footerView;
//    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
//    [self.tableView setContentInset:(UIEdgeInsetsMake(0, 0, -500, 0))];
//    
//    [self.navigationController.view addSubview:self.view];

    
    //float targetHeight = self.navigationController.navigationBar.frame.size.height;
    
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    
    UIButton *goToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    //goToTop.frame = CGRectMake(0, self.view.frame.size.height-(44+targetHeight+20), self.view.frame.size.width, 44);
    
    goToTop.frame = CGRectMake(0, height-(44+34+30), width, 44);
    
    
    
    [goToTop setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    
    
    if(isUpdate){
        [goToTop setTitle:@"UPDATE" forState:UIControlStateNormal];
        [goToTop addTarget:self action:@selector(updateOrder) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
    
        [goToTop setTitle:@"CONFIRM" forState:UIControlStateNormal];
        [goToTop addTarget:self action:@selector(conformOrder) forControlEvents:UIControlEventTouchUpInside];
    
    }
    
    
    
    [goToTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToTop.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    goToTop.titleLabel.font = [UIFont boldSystemFontOfSize:20];//[UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self.view addSubview:goToTop];
    
    
    
    
    
    
    
    //Add header ....
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width, 30)];
    titleLabel.text = @"REQUEST A PICK UP";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    
    self.tableView.tableHeaderView = headerView;
    
    
    
    
    
    
    
    // picker customization..
    
    pickrView = [[UIPickerView alloc] init];
    pickrView.delegate = self;
    pickrView.dataSource = self;
    pickrView.showsSelectionIndicator = YES;
    
    //date picker ...
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(onDatePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    NSDate* currentTime = [NSDate date];
    [datePicker setMinimumDate:[currentTime dateByAddingTimeInterval:43200]];//min time +12:00 for the current date
    [datePicker setMaximumDate:[currentTime dateByAddingTimeInterval:2592000]]; // max day (+ 30 )
    
    dateDelivery = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [dateDelivery setDatePickerMode:UIDatePickerModeDate];
    [dateDelivery addTarget:self action:@selector(onDateDelivaryValueChanged) forControlEvents:UIControlEventValueChanged];
    [dateDelivery setMinimumDate:[currentTime dateByAddingTimeInterval:43200*4]];//min time +12:00 for the current date
    [dateDelivery setMaximumDate:[currentTime dateByAddingTimeInterval:2592000*2]]; // max day (+ 30 )
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
    
    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    
    
    
    
    
    
    NSArray  *savedData =  [[NSArray alloc]initWithContentsOfFile:filePath];//[[NSDictionary alloc]initWithContentsOfFile:filePath];
    
    MYLog(@"savedData -- %@",savedData);
    
    if(savedData.count == 0){
        
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
//        [SVProgressHUD showWithStatus:@"Loading Addresses"];
        
        [handler getAddresses];
     
        
    }else{
        
        addressList = savedData;
        
    }
    
    
    paramsDict = [[NSMutableDictionary alloc]initWithCapacity:5];

    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"kReloadRow"
                                               object:nil];
    
    
    

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)conformOrder
{
    
    
//address_id : 4
//pickup_date : 2016-06-03
//time_slot_id : 1
//delivery_date: 2016-06-05
//delivery_time_slot_id:4
    
    
    MYLog(@"paramsDict - %@",paramsDict);
    
    if(![paramsDict valueForKey:@"address_id"]){
    
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select an address."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
    
    
    }else if(![paramsDict valueForKey:@"pickup_date"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select Pick up date."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        
        
    }else if(![paramsDict valueForKey:@"time_slot_id"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select Pick up time."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
    }else if(![paramsDict valueForKey:@"delivery_date"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select delivery date."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        
        
    }else if(![paramsDict valueForKey:@"delivery_time_slot_id"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select delivery time."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
    }else{
    
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"Confirming order"];
        
        [handler conformOrder:paramsDict];
    
    
    }
    
    
    
    
    
    
}

-(void)updateOrder
{
//    address_id : 4
//    pickup_date : 2016-06-03
//    time_slot_id : 1
//delivery_date: 2016-06-05
//delivery_time_slot_id:4
    
    MYLog(@"paramsDict - %@",paramsDict);
    
    if(![paramsDict valueForKey:@"address_id"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select an address."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        
    }else if(![paramsDict valueForKey:@"pickup_date"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select Pick up date."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        
        
    }else if(![paramsDict valueForKey:@"time_slot_id"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select Pick up time."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
    }else if(![paramsDict valueForKey:@"delivery_date"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select delivery date."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        
        
    }else if(![paramsDict valueForKey:@"delivery_time_slot_id"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select delivery time."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
    }else{
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"Updating order"];
        
        [handler updateOrder:paramsDict orderId:[updateItem valueForKey:@"id"]];
        
        
    }
    
    
    
    
    
    
}




- (void)reloadTable {
    
    MYLog(@"reloadTable");
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
    
    
    
 
    
    NSArray  *savedData =  [[NSArray alloc]initWithContentsOfFile:filePath];//[[NSDictionary alloc]initWithContentsOfFile:filePath];
    
    MYLog(@"savedData -- %@",savedData);
    
    addressList = savedData;
    
    
    [self.tableView reloadData];
    
//
//    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:0 inSection:1];
//    NSIndexPath* rowToReload1 = [NSIndexPath indexPathForRow:1 inSection:1];
//
//    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload,rowToReload1, nil];
//    
//    [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];


}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0){
    
    
        return 3;
        
        
    }else{
    
        return 2;
    
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 1 ){
    
        if(indexPath.row == 1){
        
            return 180;
        }
    }
    
    return 50;
    
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        MYLog(@"new one");
        
        
        
        
        if(indexPath.section == 0){
            
            
            if(indexPath.row == 0){
                
                cell.textLabel.text = @"Schedule";
                cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
                
                
            }else if(indexPath.row == 1){
                
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3-20, 30)];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = @"Pick Up";
                [cell.contentView addSubview: label];
                
                
                
                UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                                        CGRectMake(0,0, self.tableView.frame.size.width, 44)]; //should code with variables to support view resizing
                
                UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked)];
                
                UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                
                
                UIBarButtonItem *cancelButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClicked)];
                
                //using default text field delegate method here, here you could call
                //myTextField.resignFirstResponder to dismiss the views
                
                [myToolbar setItems:[NSArray arrayWithObjects:doneButton,flexibleItem,cancelButton, nil] animated:NO];
                
                
                
                UITextField *dateField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3-10, 0, self.view.frame.size.width/3+5, 30)];
                
                if(isUpdate){
                
                    dateField.text = [updateItem valueForKey:@"pickup_date"];
                
                    [paramsDict setValue:[updateItem valueForKey:@"pickup_date"] forKey:@"pickup_date"];
                    
                    
                    
                }else{
                    
                    
                    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
                    [df2 setDateFormat:@"dd LLLL"];
                    NSString *dayStr =  [df2 stringFromDate:[NSDate date]];
                    
                    dateField.text = dayStr;
                
                }
                
                dateField.inputView = datePicker;
                dateField.delegate = self;
                dateField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
                
                dateField.tag = 1;
                
                dateField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                
                dateField.font = [UIFont systemFontOfSize:15];
                
                dateField.inputAccessoryView = myToolbar;
                UIImageView *paddingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendericon.png"]];
                //dateField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 2, 3);
                
                paddingView.frame = CGRectMake(00.0, 0.0, 20, 20);
                paddingView.contentMode = UIViewContentModeScaleAspectFit;
                
                // paddingView.contentMode = UIViewContentModeCenter;
                dateField.leftView = paddingView;
                dateField.leftViewMode = UITextFieldViewModeAlways;
                [[dateField valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
                
                [cell.contentView addSubview: dateField];
                
                
                
                
                
                UITextField *timeField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3*2, 0, self.view.frame.size.width/3-4, 30)];
                timeField.placeholder = @"time";
                timeField.inputView = pickrView;
                timeField.delegate = self;
                timeField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
                
                timeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                
                timeField.tag = 11;
                
                
                if(isUpdate){
                    
                    timeField.text = [updateItem valueForKey:@"pickup_slot"];
                    
                    [paramsDict setValue:[updateItem valueForKey:@"time_slot_id"] forKey:@"time_slot_id"];
                    
                }else{
                
                    timeField.text = @"";
                
                }
                
                
                timeField.inputAccessoryView = myToolbar;
                [[timeField valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
                
                
                UIImageView *paddingView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowdown.png"]];
                //dateField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 2, 3);
                
                paddingView2.frame = CGRectMake(00.0, 0.2, 15, 15);
                paddingView2.contentMode = UIViewContentModeScaleAspectFit;
                
                // paddingView.contentMode = UIViewContentModeCenter;
                timeField.rightView = paddingView2;
                timeField.rightViewMode = UITextFieldViewModeAlways;
                
                
                pickUpSlot = timeField;
                
                
                [cell.contentView addSubview: pickUpSlot];
                
                
                
                
                
            }else if(indexPath.row == 2){
                
                
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3-20, 30)];
                label.textAlignment = NSTextAlignmentCenter;
                
                label.text = @"Delivery";
                [cell.contentView addSubview: label];
                
                
                
                
                
                UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                                        CGRectMake(0,0, self.tableView.frame.size.width, 44)]; //should code with variables to support view resizing
                
                UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked)];
                UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                UIBarButtonItem *cancelButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClicked)];
                
                //using default text field delegate method here, here you could call
                //myTextField.resignFirstResponder to dismiss the views
                
                [myToolbar setItems:[NSArray arrayWithObjects:doneButton,flexibleItem,cancelButton, nil] animated:NO];
                
                
                
                
                
                
                UITextField *dateField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3-10, 0, self.view.frame.size.width/3+5, 30)];
                
                if(isUpdate){
                    
                    dateField.text = [updateItem valueForKey:@"delivery_date"];
                    
                    [paramsDict setValue:[updateItem valueForKey:@"delivery_date"] forKey:@"delivery_date"];
                    
                    
                    
                }else{
                    
                    
                    NSDate *now = [NSDate date];
                    int daysToAdd = 2;
                    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
                
                    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
                    [df2 setDateFormat:@"dd LLLL"];
                    NSString *dayStr =  [df2 stringFromDate:newDate1];
                    
                    dateField.text = dayStr;
                }
                
                
                dateField.inputView = dateDelivery;
                dateField.delegate = self;
                dateField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
                
                dateField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                
                dateField.tag = 2;
                
                
                dateField.font = [UIFont systemFontOfSize:15];
                
                dateField.inputAccessoryView = myToolbar;
                UIImageView *paddingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendericon.png"]];
                //dateField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 2, 3);
                
                paddingView.frame = CGRectMake(00.0, 0.0, 20, 20);
                paddingView.contentMode = UIViewContentModeScaleAspectFit;
                
                // paddingView.contentMode = UIViewContentModeCenter;
                dateField.leftView = paddingView;
                dateField.leftViewMode = UITextFieldViewModeAlways;
                [[dateField valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
                
                [cell.contentView addSubview: dateField];
                
                
                
                
                
                
                
                UITextField *timeField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3*2, 0, self.view.frame.size.width/3-4, 30)];
                
                
                if(isUpdate){
                    
                    timeField.text = [updateItem valueForKey:@"delivery_slot"];
                    
                    [paramsDict setValue:[updateItem valueForKey:@"delivery_time_slot_id"] forKey:@"delivery_time_slot_id"];
                    
                }else{
                    
                    timeField.placeholder = @"time";
                    
                }
                
                
                
                timeField.inputView = pickrView;
                timeField.delegate = self;
                timeField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
                
                timeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                
                timeField.tag = 12;
                
                
                timeField.inputAccessoryView = myToolbar;
                [[timeField valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
                
                
                UIImageView *paddingView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowdown.png"]];
                //dateField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 2, 3);
                
                paddingView2.frame = CGRectMake(00.0, 0.2, 15, 15);
                paddingView2.contentMode = UIViewContentModeScaleAspectFit;
                
                // paddingView.contentMode = UIViewContentModeCenter;
                timeField.rightView = paddingView2;
                timeField.rightViewMode = UITextFieldViewModeAlways;
                
                deleverySlot = timeField;
                
                
                [cell.contentView addSubview: deleverySlot];
                
                
                
                
                
                
            }
            
            
        }
        else{
            
            
            if(indexPath.row == 0){
                
                cell.textLabel.text = @"Address";
                cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
                
                
                NSString *buttonTitle;
                
                
                
                
                
                if(addressList.count == 0){
                    
                    
                    buttonTitle = @"Add Addresses";
                    
                    
                }else{
                    
                    buttonTitle = @"View Addresses";
                }
                
                
                MYLog(@"buttonTitle - %@",buttonTitle);
                
                
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.tag = 1;
                [button addTarget:self action:@selector(viewAddressButtonClicked:) forControlEvents:UIControlEventTouchDown];
                [button setTitle:buttonTitle forState:UIControlStateNormal];
                button.frame = CGRectMake(self.tableView.frame.size.width - 150, 0.0, 140, 40.0);
                
                [button setTitleColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
                
                [cell addSubview:button];
                
                
                
                
            }else{
                
                
                
                
                UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width-70, 80)];
                addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
                
                addressLabel.numberOfLines = 0;
                addressLabel.font=[UIFont systemFontOfSize:15];
                
                addressLabel.textColor = [UIColor blackColor];
                
                [addressLabel setText:@""];
                
                
                addressLabel.tag = 2;
                
                
                if(isUpdate){
                
                    
                    
                    NSDictionary* tempDict = [updateItem valueForKey:@"address"];
                    
                    
                   
                    
                    
                    
                    
                    NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",[tempDict valueForKey:@"full_name"],[tempDict valueForKey:@"building_no"],[tempDict valueForKey:@"street"],[tempDict valueForKey:@"zone_number"],[tempDict valueForKey:@"notes"]];
                    
                    
                    
                    
                    NSString *strLatitude = [tempDict valueForKey:@"latitude"];
                    NSString *strLongitude = [tempDict valueForKey:@"longitude"];
                    
                    if([strLatitude length]> 5 || [strLongitude length] > 5)
                    {
                        
                        str = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"address1"]];
                        
                        
                    }
                    
                    
                    MYLog(@"str - %@",str);
                    
                    
                    [addressLabel setText:str];
                    
                    
                    //
                    
                    [paramsDict setValue:[tempDict valueForKey:@"id"] forKey:@"address_id"];
                    
                    /*
                    
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                    
                    [button setBackgroundImage:[UIImage imageNamed:@"EditAddress.png"] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(editAddressButtonClicked:) forControlEvents:UIControlEventTouchDown];
                    
                    button.frame = CGRectMake(self.tableView.frame.size.width - 70, 50, 27, 27);
                    
                    
                    
                    [cell.contentView addSubview:button];
                    
                     */
                    
                    
                    isUpdate = NO;
                    
                
                
                }else{
                
                    for(int i = 0; i<[addressList count]; i ++){
                        
                        
                        NSDictionary *tempDict = [addressList objectAtIndex:i];
                        
                        
                        int isDefault = [[tempDict valueForKey:@"is_default"]intValue];
                        
                        if(isDefault == 1){
                            
                            
                            
                            defaultAddresDict = tempDict;
                            
                            
                            NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",[tempDict valueForKey:@"full_name"],[tempDict valueForKey:@"building_no"],[tempDict valueForKey:@"street"],[tempDict valueForKey:@"zone_number"],[tempDict valueForKey:@"notes"]];
                            
                            
                            NSString *strLatitude = [tempDict valueForKey:@"latitude"];
                            NSString *strLongitude = [tempDict valueForKey:@"longitude"];
                            
                            if([strLatitude length]> 5 || [strLongitude length] > 5)
                            {
                                
                                str = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"address1"]];
                                
                                
                            }
                            
                            
                            MYLog(@"str - %@",str);

                            [addressLabel setText:str];
                            
                            //
                            
                            [paramsDict setValue:[defaultAddresDict valueForKey:@"id"] forKey:@"address_id"];
                            
                            
                            /*
                            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                            
                            [button setBackgroundImage:[UIImage imageNamed:@"EditAddress.png"] forState:UIControlStateNormal];
                            
                            [button addTarget:self action:@selector(editAddressButtonClicked:) forControlEvents:UIControlEventTouchDown];
                            
                            button.frame = CGRectMake(self.tableView.frame.size.width - 70, 50, 27, 27);
                            
                            
                            
                            [cell.contentView addSubview:button];
                             */
                            
                            
                            
                        }
                        
                        
                    }
                
                
                }
                
                
                
                
                [cell addSubview:addressLabel];
                
                
                
            }
            
            
            
            
        }

        
        
        
    }else{
        
        MYLog(@"old one");
        
        if(indexPath.section == 1){
            
            
            if(indexPath.row == 0){
                
                UIButton * buttonN = (UIButton *)[cell viewWithTag:1];
                
                
                
                NSString *buttonTitle;
                if(addressList.count == 0){
                    
                    buttonTitle = @"Add Addresses";
                    
                }else{
                    
                    buttonTitle = @"View Addresses";
                }
                
                
                MYLog(@"buttonTitle - %@",buttonTitle);
                
               
                
                [buttonN setTitle:buttonTitle forState:UIControlStateNormal];
            
            
            }else{
                
                
                
                UILabel *addressLabel = (UILabel *)[cell viewWithTag:2];
                
                
                
                for(int i = 0; i<[addressList count]; i ++){
                    
                    
                    NSDictionary *tempDict = [addressList objectAtIndex:i];
                    
                    
                    int isDefault = [[tempDict valueForKey:@"is_default"]intValue];
                    
                    if(isDefault == 1){
                        
                        
                        
                        defaultAddresDict = tempDict;
                        
                        
                        
                        NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",[tempDict valueForKey:@"full_name"],[tempDict valueForKey:@"building_no"],[tempDict valueForKey:@"street"],[tempDict valueForKey:@"zone_number"],[tempDict valueForKey:@"notes"]];
                        
                        
                        
                        
                        NSString *strLatitude = [tempDict valueForKey:@"latitude"];
                        NSString *strLongitude = [tempDict valueForKey:@"longitude"];
                        
                        if([strLatitude length]> 5 || [strLongitude length] > 5)
                        {
                            
                            str = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"address1"]];
                            
                            
                        }
                        
                        
                        MYLog(@"str - %@",str);

                        
                        
                        
                        MYLog(@"str - %@",str);
                        
                        [addressLabel setText:str];
                        //
                        
                        [paramsDict setValue:[defaultAddresDict valueForKey:@"id"] forKey:@"address_id"];
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                if([addressList count] == 0){
                    
                    [addressLabel setText:@""];
                    [paramsDict removeObjectForKey:@"address_id"];
                    
                    
                }

                
                
                
                
            
            
            }
        
        
        
        }
    
    
    
    }
    
    // Configure the cell...
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    

    
    
    
    return cell;
}


#pragma mark action methods


-(void)doneButtonClicked
{
    
    
    if(activeTextField.tag == 1){

        NSDate *chosenDate = [datePicker date];
        
        
        NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
        [df1 setDateFormat:@"YYYY-MM-dd"];
        
        NSString *formattedDate1 = [df1 stringFromDate:chosenDate];
        
        MYLog(@"formattedDate1 - %@",formattedDate1);
        
        [paramsDict setValue:formattedDate1 forKey:@"pickup_date"];
        
        MYLog(@"paramsDict - %@",paramsDict);
        
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd LLLL"];
        
        
        
        NSString *formattedDate = [df stringFromDate:chosenDate];
        
        
        
        activeTextField.text = formattedDate;
        

        
    }else if(activeTextField.tag == 2){
        
        
        NSDate *chosenDate = [dateDelivery date];
        
        
        NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
        [df1 setDateFormat:@"YYYY-MM-dd"];
        
        NSString *formattedDate1 = [df1 stringFromDate:chosenDate];
        
        MYLog(@"formattedDate1 - %@",formattedDate1);
        
        [paramsDict setValue:formattedDate1 forKey:@"delivery_date"];
        
        MYLog(@"paramsDict - %@",paramsDict);
        
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd LLLL"];
        
        
        
        NSString *formattedDate = [df stringFromDate:chosenDate];
        
        
        
        activeTextField.text = formattedDate;



    }

    
    [activeTextField resignFirstResponder];
    
    
}
-(void)cancelButtonClicked
{
    [activeTextField resignFirstResponder];
    
    
}



-(void)editAddressButtonClicked:(UIButton*)sender
{
  
    AddAddressViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAddressViewController"];
    
    
    controller.isEdit = YES;
    controller.oldAddressDict = defaultAddresDict;
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
}



-(void)viewAddressButtonClicked:(UIButton*)sender
{
    
    
    
    
    if([sender.titleLabel.text isEqualToString:@"Add Addresses"]){
    
    
        
        if([[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]){
        
            AddAddressViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAddressViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        
        }else{
        
            AddAddressViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAddressViewController"];
            [self.navigationController pushViewController:controller animated:YES];
            
//            SignUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
//            
//            
//            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
//            
//            [self presentViewController:navigationController animated:YES completion:^{}];
        
        }

        
        
        
        
    }else if([sender.titleLabel.text isEqualToString:@"View Addresses"]){
        
        AddressLiatViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressLiatViewController"];
//        controller.AddressListArray  = [[NSMutableArray alloc]initWithArray:addressList];
        
        [self.navigationController pushViewController:controller animated:YES];
    
    
    }
    
    

    
}





#pragma mark textField deligats


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField setFont:[UIFont boldSystemFontOfSize:15]];

    activeTextField = textField;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{



    if(activeTextField.tag == 1){
        
        NSDate *chosenDate = [datePicker date];
        
        
        NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
        [df1 setDateFormat:@"YYYY-MM-dd"];
        
        NSString *formattedDate1 = [df1 stringFromDate:chosenDate];
        
        MYLog(@"formattedDate1 - %@",formattedDate1);
        
        [paramsDict setValue:formattedDate1 forKey:@"pickup_date"];
        
        
        MYLog(@"paramsDict - %@",paramsDict);
        
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd LLLL"];
        
        
        
        NSString *formattedDate = [df stringFromDate:chosenDate];
        
        
        
        
        
        
        activeTextField.text = formattedDate;
        
        
        
    }else if(activeTextField.tag == 2){
        
        
        
        NSDate *chosenDate = [dateDelivery date];
        
        
        NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
        [df1 setDateFormat:@"YYYY-MM-dd"];
        
        NSString *formattedDate1 = [df1 stringFromDate:chosenDate];
        
        MYLog(@"formattedDate1 - %@",formattedDate1);
        
        [paramsDict setValue:formattedDate1 forKey:@"delivery_date"];
        
        
        MYLog(@"paramsDict - %@",paramsDict);
        
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd LLLL"];
        
        
        
        NSString *formattedDate = [df stringFromDate:chosenDate];
        
        
        
        
        
        
        activeTextField.text = formattedDate;
        
        
    }


}


#pragma mark datepicker methods




-(void)onDatePickerValueChanged
{
    
    NSDate *chosenDate = [datePicker date];
    

    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"YYYY-MM-dd"];
    
     NSString *formattedDate1 = [df1 stringFromDate:chosenDate];
    
    MYLog(@"formattedDate1 - %@",formattedDate1);
    
    [paramsDict setValue:formattedDate1 forKey:@"pickup_date"];
    
    
    MYLog(@"paramsDict - %@",paramsDict);
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd LLLL"];
    

    
    NSString *formattedDate = [df stringFromDate:chosenDate];
    
 
    
    activeTextField.text = formattedDate;
    
    //

    
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"EEEE"];
    NSString *dayStr =  [df2 stringFromDate:chosenDate];
    MYLog(@"dayStr - %@",dayStr);
    
    if([dayStr isEqualToString:@"Friday"]){
        pickUpSlot.text = @"";
        [paramsDict removeObjectForKey:@"pickup_slot"];
        isFriday = YES;
        [pickrView reloadAllComponents];
    }else{
    
        isFriday = NO;
    }
    
    
    
    
}


-(void)onDateDelivaryValueChanged
{
    
    NSDate *chosenDate = [dateDelivery date];
    
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"YYYY-MM-dd"];
    
    NSString *formattedDate1 = [df1 stringFromDate:chosenDate];
    
    MYLog(@"formattedDate1 - %@",formattedDate1);
    
    [paramsDict setValue:formattedDate1 forKey:@"delivery_date"];
    
    
    MYLog(@"paramsDict - %@",paramsDict);
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd LLLL"];
    
    
    
    NSString *formattedDate = [df stringFromDate:chosenDate];
    
    
    
    activeTextField.text = formattedDate;
    
    
    
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"EEEE"];
    NSString *dayStr =  [df2 stringFromDate:chosenDate];
    MYLog(@"dayStr - %@",dayStr);
    
    if([dayStr isEqualToString:@"Friday"]){
        deleverySlot.text = @"";
        [paramsDict removeObjectForKey:@"delivery_slot"];
        isFriday = YES;
        [pickrView reloadAllComponents];
    }else{
    
        isFriday = NO;
    }
    
    
    
    
}






#pragma mark pickerView deligats


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if(isFriday){
        
        return 6;
        
    }else{
        return 11;
    
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString * title = nil;
    NSString *timeSlot;
    
    if(isFriday){
        
        switch(row) {
            
            case 0:
                title = @"4pm - 5pm";
                timeSlot = @"6";
                break;
            case 1:
                title = @"5pm - 6pm";
                timeSlot = @"7";
                break;
            case 2:
                title = @"6pm - 7pm";
                timeSlot = @"8";
                break;
            case 3:
                title = @"7pm - 8pm";
                timeSlot = @"9";
                break;
            case 4:
                title = @"8pm - 9pm";
                timeSlot = @"10";
                break;
            case 5:
                title = @"9pm - 10pm";
                timeSlot = @"11";
                break;
        }

    
    
    
    }else{
    
        switch(row) {
            case 0:
                title = @"8am - 9am";
                timeSlot = @"1";
                break;
            case 1:
                title = @"9am - 10am";
                timeSlot = @"2";
                break;
            case 2:
                title = @"10am - 11am";
                timeSlot = @"3";
                break;
            case 3:
                title = @"11am - 12pm";
                timeSlot = @"4";
                break;
            case 4:
                title = @"3pm - 4pm";
                timeSlot = @"5";
                break;
            case 5:
                title = @"4pm - 5pm";
                timeSlot = @"6";
                break;
            case 6:
                title = @"5pm - 6pm";
                timeSlot = @"7";
                break;
            case 7:
                title = @"6pm - 7pm";
                timeSlot = @"8";
                break;
            case 8:
                title = @"7pm - 8pm";
                timeSlot = @"9";
                break;
            case 9:
                title = @"8pm - 9pm";
                timeSlot = @"10";
                break;
            case 10:
                title = @"9pm - 10pm";
                timeSlot = @"11";
                break;
        }

    
    
    
    }
        activeTextField.text = title;
    
    
    
    if(activeTextField.tag == 11){
        
        [paramsDict setValue:timeSlot forKey:@"time_slot_id"];
        
    }else if(activeTextField.tag == 12){
        
        [paramsDict setValue:timeSlot forKey:@"delivery_time_slot_id"];
        
        
    }

    return title;
}
#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertLogOut clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    MYLog(@"kl");
    
    if (alertLogOut.tag == 29)
    {
//        Dashboard *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
//        
//        
//        [self.navigationController pushViewController:controller animated:NO];
        
        MYLog(@"kl");
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}
#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    [SVProgressHUD dismiss];
    
    if([APIname isEqualToString:@"ADDRESSES"]){
        
        
        
        addressList = response;
        
                
        //Write data to file if we got somethig.
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [path objectAtIndex:0];
        NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
        
        [addressList writeToFile: filePath atomically:YES];
        
        
        
        
        
        [self.tableView reloadData];
        
        
        
        
        
        
    }

    
    if([APIname isEqualToString:@"CONFORM_ORDER"]){
        
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Order has been placed."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        errorAlert.tag = 29;
        [errorAlert show];
        
        
        
    }
    
    
    
}


- (void) APIReponseWithErrorArray:(NSArray *)error{
    
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
    
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Failed to place order.Please try again."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    
    
    
    
    
    

}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
}



@end
