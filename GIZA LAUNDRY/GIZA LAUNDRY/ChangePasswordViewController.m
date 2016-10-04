//
//  ChangePasswordViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 17/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SVProgressHUD.h"

@implementation ChangePasswordViewController{
    
    APIHandler *handler;

}


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    UINavigationBar *nav = self.navigationController.navigationBar;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
    
    
    CGFloat navigationBarHeight = nav.frame.origin.y + nav.frame.size.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarHeight, 0, 0, 0);
    
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.origin = CGPointMake(tableViewFrame.origin.x, navigationBarHeight);
    tableViewFrame.size = CGSizeMake(tableViewFrame.size.width, tableViewFrame.size.height - navigationBarHeight*2);
    self.tableView.frame = tableViewFrame;
    
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"regBackground.png"]];
    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissView:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)submitButtonClicked:(id)sender {
    
    
    if([_currentPassText.text isEqualToString:_passwordNewText.text]){
    
                UIAlertView *alert = [[UIAlertView alloc]
                                     initWithTitle:@"Error"
                                      message:@"Old password and new password won't be the same."
                                      delegate:nil
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil];
                [alert show];
                alert=nil;
                return;
    
    }else{
    
        NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:_currentPassText.text,@"currentpassword",_passwordNewText.text,@"newpassword", nil];
        
        MYLog(@"paramDict - %@",paramDict);
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"Updating password"];
        
        [handler updatePassword:paramDict];
    
    }
    
    
    
   
    
    
}

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    [SVProgressHUD dismiss];
    
    if([response count]>0){
        
        //need status to show this alert....
        
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"Recharge failed"
//                              message:@"Purchase receipt corrupt."
//                              delegate:nil
//                              cancelButtonTitle:@"Ok"
//                              otherButtonTitles:nil];
//        [alert show];
//        alert=nil;
//        return;
        
       
        
        
    }
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
}





@end
