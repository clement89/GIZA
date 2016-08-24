//
//  LoginViewController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 07/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"

@interface LoginViewController : UITableViewController <APIHandlerDelegate,UITextFieldDelegate>{



}

@property (weak, nonatomic) IBOutlet UITextField *emailText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;






@end
