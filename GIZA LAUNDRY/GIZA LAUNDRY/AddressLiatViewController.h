//
//  AddressLiatViewController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 10/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"

@interface AddressLiatViewController : UITableViewController<APIHandlerDelegate> {


}

@property (nonatomic,strong) NSMutableArray *AddressListArray ;

@end
