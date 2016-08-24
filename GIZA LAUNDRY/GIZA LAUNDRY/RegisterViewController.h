//
//  RegisterViewController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 07/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"




@interface RegisterViewController : UITableViewController <APIHandlerDelegate , UITextFieldDelegate>{


}


@property (weak, nonatomic) IBOutlet UITextField *firstNameText;

@property (weak, nonatomic) IBOutlet UITextField *lastNameText;

@property (weak, nonatomic) IBOutlet UITextField *eMailText;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;


@end
