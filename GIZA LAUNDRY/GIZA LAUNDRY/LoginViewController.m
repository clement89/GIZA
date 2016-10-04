//
//  LoginViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 07/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ForgotPassViewController.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{

    APIHandler *handler;

}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView:)];
    cancel.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = cancel;
    
    
    
    UINavigationBar *nav = self.navigationController.navigationBar;
    CGFloat navigationBarHeight = nav.frame.origin.y + nav.frame.size.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarHeight, 0, 0, 0);
    
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.origin = CGPointMake(tableViewFrame.origin.x, navigationBarHeight);
    tableViewFrame.size = CGSizeMake(tableViewFrame.size.width, tableViewFrame.size.height - navigationBarHeight*2);
    self.tableView.frame = tableViewFrame;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //self.tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main.png"]];
    
    self.tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registerBackground.png"]];
    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;

    [_passwordText setDelegate:self];
    [_emailText setDelegate:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)forgotPassButtonClicked:(id)sender {
    
    MYLog(@"forgotPassButtonClicked");
    
    ForgotPassViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPassViewController"];
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
}


- (IBAction)LoginButtonClicked:(id)sender {
//    
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"y2kLoggedIn"];
//    [((AppDelegate*) [[UIApplication sharedApplication] delegate]) isUserLoggedIn];

    
    
    NSDictionary *loginInfoDict = [[NSDictionary alloc]initWithObjectsAndKeys:_emailText.text,@"username",_passwordText.text,@"password", nil];
    
    MYLog(@"registerInfoDict - %@",loginInfoDict);
    
    [_passwordText resignFirstResponder];
    [_emailText resignFirstResponder];
    
    [handler loginUser:loginInfoDict];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Loading"];
    
    
    
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)dismissView:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    
    if([response count]>0){
        
        
        
        
        if([APIname isEqualToString:@"LOGIN"]){
            
            

            if([response valueForKey:@"access_token"]){
                
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"y2kLoggedIn"];
                [[NSUserDefaults standardUserDefaults] setObject:[response valueForKey:@"access_token"] forKey:@"kaccess_tocken"];
                
                
                //Register mobile ....
                
                
                NSString* device_id = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
                NSString *device_token = [[NSUserDefaults standardUserDefaults]valueForKey:@"kgcm_key"];
                NSString *os_version = [[UIDevice currentDevice] systemVersion];
                
                
                
                NSDictionary *deviceInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:device_id,@"device_id",device_token,@"device_token",@"IOS",@"os",os_version,@"os_version", nil];
                MYLog(@"deviceInfoDict - %@",deviceInfoDict);
                
                
                
                [handler registerMobile:deviceInfoDict];

                
                
                
                
                
            }else if([response valueForKey:@"message"]){
                
                [SVProgressHUD dismiss];

                
                [[[UIAlertView alloc] initWithTitle:@"Error" message:[response valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                
            }
            
            
            
        }else if([APIname isEqualToString:@"RE_MOBILE"]){
            
            
            [SVProgressHUD dismiss];

            
            [((AppDelegate*) [[UIApplication sharedApplication] delegate]) isUserLoggedIn];
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
    
    
    
    
}

-(void)APIReponseWithErrorArray:(NSArray *)error{
    
    [SVProgressHUD dismiss];
    
    MYLog(@" Error - %@",error);
    
    if([error count]> 0){
        
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:[[error objectAtIndex:0] valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
    }
    
    
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
