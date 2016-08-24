//
//  ForgotPassViewController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 07/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"

@interface ForgotPassViewController : UITableViewController <APIHandlerDelegate>{


}


@property (weak, nonatomic) IBOutlet UITextField *emailText;


@end
