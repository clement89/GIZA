//
//  ForgotPassViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 07/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "ForgotPassViewController.h"

@interface ForgotPassViewController ()

@end

@implementation ForgotPassViewController{


    APIHandler *handler;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *nav = self.navigationController.navigationBar;
    CGFloat navigationBarHeight = nav.frame.origin.y + nav.frame.size.height;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarHeight, 0, 0, 0);
    
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.origin = CGPointMake(tableViewFrame.origin.x, navigationBarHeight);
    tableViewFrame.size = CGSizeMake(tableViewFrame.size.width, tableViewFrame.size.height - navigationBarHeight*2);
    self.tableView.frame = tableViewFrame;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main.png"]];
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)forgotPassButtonClicked:(id)sender {
    
    
    NSDictionary *loginInfoDict = [[NSDictionary alloc]initWithObjectsAndKeys:_emailText.text,@"email", nil];
    
    MYLog(@"registerInfoDict - %@",loginInfoDict);
    
    [handler forgotPassword:loginInfoDict];
    
    
    
    
}



- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    if([response count]>0){
        
        
        
        if([response valueForKey:@"message"]){
            
            
            [[[UIAlertView alloc] initWithTitle:@"Message" message:[response valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            
        }
        
        
    }
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    MYLog(@" Error - %@",error);
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
