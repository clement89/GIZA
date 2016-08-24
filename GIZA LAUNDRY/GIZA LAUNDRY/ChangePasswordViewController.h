//
//  ChangePasswordViewController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 17/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"


@interface ChangePasswordViewController : UITableViewController <APIHandlerDelegate>{


}

@property (weak, nonatomic) IBOutlet UITextField *currentPassText;


@property (strong, nonatomic) IBOutlet UITextField *passwordNewText;


@end
