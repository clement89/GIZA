//
//  MyOrdersViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 19/09/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "SWRevealViewController.h"
#import "RequestPickUpController.h"
#import "SVProgressHUD.h"


@interface MyOrdersViewController ()

@end

@implementation MyOrdersViewController{

    APIHandler *handler;
    NSArray *myOrdersArray;
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
    

    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-InnerPages_BackgroundImage.jpg"]] ];

    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Loading my orders"];
    
    
    [handler getMyOders];
    
    
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

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    NSDictionary *orderItemDict = [myOrdersArray objectAtIndex:indexPath.section];
    BOOL canCancel = [[[orderItemDict objectForKey:@"can_cancel"] stringValue] isEqualToString:@"1"]? YES : FALSE;
    BOOL canEdit = [[[orderItemDict objectForKey:@"can_edit_delivery"] stringValue] isEqualToString:@"1"]? YES : FALSE;
    

    
    if(canEdit || canCancel){
    
        return 140;
    }else{
    
        return 180;
    }
    
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_orders_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if(cell == nil){
    
        MYLog(@"nilll mann");
    
    }
    
    
    
    NSDictionary *orderItemDict = [myOrdersArray objectAtIndex:indexPath.section];
    BOOL canCancel = [[[orderItemDict objectForKey:@"can_cancel"] stringValue] isEqualToString:@"1"]? YES : FALSE;
    BOOL canEdit = [[[orderItemDict objectForKey:@"can_edit_delivery"] stringValue] isEqualToString:@"1"]? YES : FALSE;
    
    
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    
    
    CGFloat width = (mainWidth/2)-30;
    
    UITextField *timeField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, width, 40)];
    timeField.text = @"8AM-9AM";
    timeField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    
    timeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    timeField.borderStyle = UITextBorderStyleLine;

    timeField.layer.cornerRadius = 1.0f;
    timeField.layer.masksToBounds = YES;
    timeField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    timeField.layer.borderWidth = 1.0f;
    
    
    
    UIImageView *paddingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time.png"]];
    
    paddingView.frame = CGRectMake(0, 0, 30, 30);
    paddingView.contentMode = UIViewContentModeScaleAspectFit;
    
    timeField.leftView = paddingView;
    timeField.leftViewMode = UITextFieldViewModeAlways;

    
    
    [cell.contentView addSubview: timeField];
    
    ///////////////////////
    
    UITextField *dateField = [[UITextField alloc]initWithFrame:CGRectMake(width+40, 10, width, 40)];
    dateField.text = @"2016-09-06";
    dateField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    
    dateField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    dateField.borderStyle = UITextBorderStyleLine;
    
    dateField.layer.cornerRadius = 1.0f;
    dateField.layer.masksToBounds = YES;
    dateField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    dateField.layer.borderWidth = 1.0f;
    
    

    
    
    UIImageView *paddingView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date.png"]];
    
    paddingView1.frame = CGRectMake(0, 0, 30, 30);
    paddingView1.contentMode = UIViewContentModeScaleAspectFit;
    
    dateField.leftView = paddingView1;
    dateField.leftViewMode = UITextFieldViewModeAlways;

    [cell.contentView addSubview: dateField];
    
    
    ///////////////
    
    UILabel *idLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, cell.contentView.frame.size.width-40, 20)];
    
    idLabel.text = @"ORDER ID";
    idLabel.font = [UIFont systemFontOfSize:16];
    
    idLabel.backgroundColor = [UIColor clearColor];
    idLabel.textColor = [UIColor blackColor];
    idLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [cell.contentView addSubview: idLabel];
    
    ///////////////
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, cell.contentView.frame.size.width-40, 20)];
    
    numberLabel.text = @"2529";
    numberLabel.font = [UIFont boldSystemFontOfSize:17];
    
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.textColor = [UIColor blackColor];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [cell.contentView addSubview: numberLabel];
    
    
    ///////////////
    
    UILabel *statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, cell.contentView.frame.size.width-40, 20)];
    
    statusLabel.text = @"Ready to Deliver";
    statusLabel.font = [UIFont systemFontOfSize:15];
    
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.textColor = [UIColor blackColor];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [cell.contentView addSubview:statusLabel];
    
    
    ///////////////
    
    if(canEdit){
        
        UIButton *updateButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [updateButton setFrame:CGRectMake(10.0, 130.0, width, 40)];
        [updateButton setBackgroundColor:[UIColor orangeColor]];
        [updateButton setTitle:@"UPDATE" forState:UIControlStateNormal];
        [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [updateButton addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:updateButton];

    
    }
    
    
    
    ///////////////
    
    if(canCancel){
        
        UIButton *cancelButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(width+40, 130.0, width, 40)];
        [cancelButton setBackgroundColor:[UIColor orangeColor]];
        [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:cancelButton];
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    return cell;
}


-(void)updateAction:(id) sender
{

    
    
    MYLog(@"updateAction");
    
    RequestPickUpController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestPickUpController"];
    [self.navigationController pushViewController:controller animated:YES];
}



-(void)cancelAction:(id) sender
{



}



#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    [SVProgressHUD dismiss];
    
    
    if([APIname isEqualToString:@"MY_ORDERS"]){
        
        
        
        myOrdersArray = response;
        
        [self.tableView reloadData];
        
        
        
        
        
        
    }
    
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
}

@end
