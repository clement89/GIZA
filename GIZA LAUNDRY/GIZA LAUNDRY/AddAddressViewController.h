//
//  AddAddressViewController.h
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 13/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"
#import <MapKit/MapKit.h>

@interface AddAddressViewController : UITableViewController<APIHandlerDelegate,UIAlertViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate, UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{


}


@property (nonatomic,strong) NSDictionary *oldAddressDict ;

@property (nonatomic,assign) BOOL isEdit ;


@end
