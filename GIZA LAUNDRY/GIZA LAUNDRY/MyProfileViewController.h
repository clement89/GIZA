//
//  MyProfileViewController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 13/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"

@interface MyProfileViewController : UITableViewController<APIHandlerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>{


}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
