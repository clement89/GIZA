//
//  RegisterViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 07/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController{

    APIHandler *handler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView:)];
    cancel.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = cancel;
    
    //Using Auto Layout
  //  CGFloat navigationBarHeight = self.topLayoutGuide.length;
    
    //Not using Auto Layout
    UINavigationBar *nav = self.navigationController.navigationBar;
    CGFloat navigationBarHeight = nav.frame.origin.y + nav.frame.size.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarHeight, 0, 0, 0);
    
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.origin = CGPointMake(tableViewFrame.origin.x, navigationBarHeight);
    tableViewFrame.size = CGSizeMake(tableViewFrame.size.width, tableViewFrame.size.height - navigationBarHeight*2);
    self.tableView.frame = tableViewFrame;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    self.tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reg.png"]];
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    _firstNameText.delegate = self;
    _lastNameText.delegate = self;
    _eMailText.delegate = self;
    _phoneNumberText.delegate = self;
    _passwordText.delegate = self;
    
    
    
}


// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissView:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)registerButtonClicked:(id)sender {
    
    
    if([_firstNameText.text length] == 0){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter First Name!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        return;
    
    }else if([_lastNameText.text length] == 0){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Last Name!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        return;
        
    }else if([_eMailText.text length] == 0){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        return;
        
    }else if([_phoneNumberText.text length] == 0){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Phone Number!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        return;
        
    }else if([_passwordText.text length] == 0){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Password!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        return;
        
    }
    
    
    
    
    
    
    
    NSDictionary *registerInfoDict = [[NSDictionary alloc]initWithObjectsAndKeys:_firstNameText.text,@"first_name",_lastNameText.text,@"last_name",_eMailText.text,@"email",_phoneNumberText.text,@"phone_number",_passwordText.text,@"password", nil];
    
    MYLog(@"registerInfoDict - %@",registerInfoDict);
    
    [handler registeUser:registerInfoDict];
    

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Loading"];
    
    
    
    
    
}


- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    
    
    if([response count]>0){
        
        
        if([APIname isEqualToString:@"REGISTRATION"]){
            
            
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            
            [def setObject:[response valueForKey:@"access_token"] forKey:@"kaccess_tocken"];
            
            
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"y2kLoggedIn"];
            
            
            
            //Register mobile ....
            
            
            NSString* device_id = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            NSString *device_token = [[NSUserDefaults standardUserDefaults]valueForKey:@"kgcm_key"];
            NSString *os_version = [[UIDevice currentDevice] systemVersion];
            
            
            
            NSDictionary *deviceInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:device_id,@"device_id",device_token,@"device_token",@"IOS",@"os",os_version,@"os_version", nil];
            MYLog(@"deviceInfoDict - %@",deviceInfoDict);
            
            
            
            [handler registerMobile:deviceInfoDict];

            
            
            
        
        
        }
        else if([APIname isEqualToString:@"RE_MOBILE"]){
            
            [SVProgressHUD dismiss];

            

            [((AppDelegate*) [[UIApplication sharedApplication] delegate]) isUserLoggedIn];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    
    
    
    }


}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    MYLog(@" Error - %@",error);
    
    [SVProgressHUD dismiss];
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
