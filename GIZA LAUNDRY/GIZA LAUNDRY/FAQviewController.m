//
//  FAQviewController.m
//  GIZA LAUNDRY
//
//  Created by Clement on 11/09/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "FAQviewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

@implementation FAQviewController{

    NSMutableArray *FAQArray;
    NSInteger selectedRowIndex;
    BOOL isRowSelected;


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
    
    
    
    
    
    
    //Create json array
    
    selectedRowIndex = -1;
    FAQArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    for(int i = 0; i<5; i++){
    
        NSDictionary *itemDict;
        
        if(i == 0){
        
        
            itemDict = [NSDictionary dictionaryWithObjectsAndKeys:@"WHAT DOES THIS APP DO?",@"question",@"You can Request for a Laundry Pick up and get your clothes cleaned and delivered to you in 48 hours.",@"answer", nil];
            
        }else if(i == 1){
            
            
            itemDict = [NSDictionary dictionaryWithObjectsAndKeys:@"HOW DO I REQUEST A PICK UP?",@"question",@"Just click Request a pick up and set your desired time, date and address for your pick up and drop off.",@"answer", nil];
            
        }else if(i == 2){
            
            
            itemDict = [NSDictionary dictionaryWithObjectsAndKeys:@"CAN I CHANGE MY PICK UP/ DROP OFF TIME?",@"question",@"Yes, visit order history and make your necessary changes at the minimum of two hours prior to your pick up/ drop off time.",@"answer", nil];
        }else if(i == 3){
            
            
            itemDict = [NSDictionary dictionaryWithObjectsAndKeys:@"HOW IS THE PAYMENT DONE?",@"question",@"Its CASH ON DELIVERY. Just pay when you get your laundry cleaned!You can soon make your payments via Credit/ Debit cards.",@"answer", nil];
        }else if(i == 4){
            
            
            itemDict = [NSDictionary dictionaryWithObjectsAndKeys:@"WHAT IS THE MINIMUM ORDER AND HOW MUCH IS THE DELIVERY FEE?",@"question",@"The minimum order for request is as low as QAR 15.There is a delivery fee of QAR 5 for any orders under QAR 100",@"answer", nil];
        }
        
        
        
        
        [FAQArray addObject:itemDict];
    
    }
    
    
    
    
       
    
    
    
    
    
    
    
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
    
    if(isRowSelected){
    
        return 6;

    }else{
        return 5;

    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row == selectedRowIndex){
    
        return 120;

    
    }else{
    
        return 60;

    }
    
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"faq_item_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    
    
    if(selectedRowIndex != indexPath.row){
    
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        
        NSDictionary *itemDict = [FAQArray objectAtIndex:indexPath.row];

        cell.textLabel.text = [itemDict valueForKey:@"question"];
        cell.textLabel.numberOfLines = 0;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        NSDictionary *itemDict = [FAQArray objectAtIndex:indexPath.row-1];
        
        cell.textLabel.text = [itemDict valueForKey:@"answer"];
        cell.textLabel.numberOfLines = 0;
    
    }
    
        
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(isRowSelected){
        
        
        
        isRowSelected = NO;
        
        
        NSIndexPath *deletingIndexpath = [NSIndexPath indexPathForRow:selectedRowIndex inSection:0];
        
        selectedRowIndex = -1;
        
        
        [self.tableView beginUpdates];
                
        [self.tableView deleteRowsAtIndexPaths:@[deletingIndexpath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];

    
    
    }else{
    
        isRowSelected = YES;
        selectedRowIndex = indexPath.row+1;
        
        NSIndexPath *insertingIndexpath = [NSIndexPath indexPathForRow:selectedRowIndex inSection:0];
        
        
        
        
        [self.tableView beginUpdates];
        
        
        [self.tableView insertRowsAtIndexPaths:@[insertingIndexpath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
        
    
    }
    
    
    
    

}






@end
