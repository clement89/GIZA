//
//  RequestPickUpController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 10/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"

@interface RequestPickUpController : UITableViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIAlertViewDelegate, APIHandlerDelegate>{
    
    
    
    BOOL isUpdate;
    NSDictionary * updateItem;


}
@property(nonatomic,retain)NSDictionary * updateItem;
@property(nonatomic,assign)BOOL isUpdate;

@end
