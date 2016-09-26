//
//  AddAddressViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 13/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "AddAddressViewController.h"
#import "SVProgressHUD.h"


@implementation AddAddressViewController{

    APIHandler *handler;
    UITextField *activeTextField;
    NSMutableDictionary *addressDict;
    MKMapView *myMapView;
    CLLocationManager *locationManager;
    NSArray *zoneList;
    UIPickerView *pickrView;
    
    BOOL isAddresFromMap;
    NSDictionary *locationDict;
    
    MKPointAnnotation *previousPoint;
    
}


@synthesize isEdit,oldAddressDict;


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    
    
    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    
    
    ///////////////////
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLLocationAccuracyKilometer;
    
    // showing user location with the blue dot
    
    
    [locationManager requestWhenInUseAuthorization];
    
    myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width , 250)];
    
    
    [myMapView setShowsUserLocation:YES];
    
    myMapView.delegate = self;
    
    // getting user coordinates
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D  coordinate = [location coordinate];
    
    
    // showing them in the mapView
    myMapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    
    [locationManager startUpdatingLocation];
    
    
    
//    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
//                                          initWithTarget:self action:@selector(handleLongPress:)];
//    lpgr.minimumPressDuration = 1.0; //user needs to press for 2 seconds
//    [myMapView addGestureRecognizer:lpgr];
    
    /////////////////////////

    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-InnerPages_BackgroundImage.jpg"]] ];
    
    
    
    
    
    
    
    
    UIButton *goToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    goToTop.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    [goToTop setTitle:@"SAVE" forState:UIControlStateNormal];
    
    [goToTop setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    [goToTop addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [goToTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToTop.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    goToTop.titleLabel.font = [UIFont systemFontOfSize:18];

    
    self.tableView.tableFooterView = goToTop;
    
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
    [handler getZoneList:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:173] forKey:@"country_id"]];
    
    
    
    if(isEdit){
    
        addressDict = [[NSMutableDictionary alloc]initWithDictionary:oldAddressDict];
        
    }else{
    
        addressDict = [[NSMutableDictionary alloc]init];
    
    }
    
    
    // picker customization..
    
    pickrView = [[UIPickerView alloc] init];
    pickrView.delegate = self;
    pickrView.dataSource = self;
    pickrView.showsSelectionIndicator = YES;
    
    
    
    [addressDict setValue:[NSString stringWithFormat: @"%@", @"0.0"] forKey:@"latitude"];
    [addressDict setValue:[NSString stringWithFormat: @"%@", @"0.0"] forKey:@"longitude"];
    
    
    
    
}



//- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
//        return;
//    
//    CGPoint touchPoint = [gestureRecognizer locationInView:myMapView];
//    CLLocationCoordinate2D touchMapCoordinate = [myMapView convertPoint:touchPoint toCoordinateFromView:myMapView];
//    
//    CLLocation *theLocation = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
//    [self getAddressFromLatLon:theLocation];
//    
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    [point setCoordinate:(touchMapCoordinate)];
//    
//    
//    
//    
//    [myMapView addAnnotation:point];
//    
//    
//    
//    
//    if(previousPoint){
//    
//        [myMapView removeAnnotation:previousPoint];
//    }
//    
//    
//    previousPoint = point;
//    
//   
//    
//    
//}

-(void)saveAction:(UIButton*)sender
{
    
    MYLog(@"activeTextField.tag - %ld",(long)activeTextField.tag);

    
    if(activeTextField.tag == 1){
        
        [addressDict setValue:activeTextField.text forKey:@"building_no"];
        
    }else if(activeTextField.tag == 2){
        
        [addressDict setValue:activeTextField.text forKey:@"street"];
        
        
    }else if(activeTextField.tag == 3){
        
        
        [addressDict setValue:activeTextField.text forKey:@"zone_id"];
        
    }else if(activeTextField.tag == 4){
        
        [addressDict setValue:activeTextField.text forKey:@"notes"];
        
        
    }
    
    
    
    MKCoordinateRegion region = myMapView.region;
    CGFloat lattitude = region.center.latitude;
    CGFloat longitude = region.center.longitude;
    
    MYLog(@"lalalala %f  lololo %f",lattitude,longitude);
    
    // Center of the screen as lat/long
    // region.center.latitude
    // region.center.longitude
    
    // width and height of viewing area as lat/long
    // region.span.latitudeDelta
    // region.span.longitudeDelta
    
    
    

//    [addressDict setValue:[NSString stringWithFormat: @"%f", lattitude] forKey:@"latitude"];
//    [addressDict setValue:[NSString stringWithFormat: @"%f", longitude] forKey:@"longitude"];
    
    
    
    
    [addressDict setValue:@"173" forKey:@"country_id"];
    

    
 
    
    MYLog(@"address Dict - %@",addressDict);
    
    
    
    
    
    
    if(![addressDict valueForKey:@"building_no"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Building Number."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        return;
        
        
    }else if(![addressDict valueForKey:@"street"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Street."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        return;
        
    }else if(![addressDict valueForKey:@"zone_id"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Zone Number."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        return;
        
    }else if(![addressDict valueForKey:@"notes"]){
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter note."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
        return;
        
    }
    
    
    
    
    
    if(isEdit){
        
        [addressDict setValue:[oldAddressDict valueForKey:@"id"] forKey:@"id"];
        
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"Updating Address"];
        
        [handler updateAddress:addressDict];
    
    }else{
    
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"Saving Address"];
        [handler saveAddress:addressDict];
    
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    if(indexPath.section == 5){
        
        return 250;
        
    }
    
    
    
    return 50;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"MyCell%ld", (long)indexPath.section];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    
    
    if (cell == nil)
        
    {

        
        MYLog(@"new");
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

       
    
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        UITextField *addresFieldText = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width - 20, 30)];
        
        addresFieldText.tag = indexPath.section+1;
        
        addresFieldText.autocorrectionType = UITextAutocorrectionTypeNo;
        [addresFieldText setClearButtonMode:UITextFieldViewModeWhileEditing];
        addresFieldText.delegate = self;
        
        
        
        
        
        /////////////////////////
        
        UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                                CGRectMake(0,0, self.tableView.frame.size.width, 44)]; //should code with variables to support view resizing
        
        UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked)];
        
        UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        UIBarButtonItem *cancelButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClicked)];
        
        //using default text field delegate method here, here you could call
        //myTextField.resignFirstResponder to dismiss the views
        
        [myToolbar setItems:[NSArray arrayWithObjects:doneButton,flexibleItem,cancelButton, nil] animated:NO];
        
        
        
        
        
        if(indexPath.section == 2){
            
            
            
            addresFieldText.inputView = pickrView;
            addresFieldText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            
            
            addresFieldText.inputAccessoryView = myToolbar;
            
        
        }
        
        
        if(isEdit ){
        
        
            if(indexPath.section == 0){
                
                
                
                addresFieldText.text = [oldAddressDict valueForKey:@"building_no"];
                
                
            }else if(indexPath.section == 1){
                
                
                addresFieldText.text = [oldAddressDict valueForKey:@"street"];
                
                
                
            }else if(indexPath.section == 2){
                
                
                
                
               //picker view
                
                
                
            }else if(indexPath.section == 3){
                
                
                
                addresFieldText.text = [oldAddressDict valueForKey:@"notes"];
                
                
                
            }else if(indexPath.section == 4){
                
                
                //Button
                
                
                
            }else if(indexPath.section == 5){
                
                
                
                //Map
                
                
                
            }

            
            
            
        
        }else{
        
            
            
            
            if(indexPath.section == 0){
                
                
                
                addresFieldText.placeholder = @"Building number";
                [addresFieldText setKeyboardType:UIKeyboardTypePhonePad];
                
                
            }else if(indexPath.section == 1){
                
                addresFieldText.placeholder = @"Street";
                [addresFieldText setKeyboardType:UIKeyboardTypePhonePad];
                
                
                
            }else if(indexPath.section == 2){
                
                
                addresFieldText.placeholder = @"Zone Number";
                [addresFieldText setKeyboardType:UIKeyboardTypePhonePad];
                
            }else if(indexPath.section == 3){
                
                
                
                addresFieldText.placeholder = @"Note";
                [addresFieldText setKeyboardType:UIKeyboardTypeASCIICapable];
                
            }
        
        
        }
        
        
        MYLog(@"11");
        
        
//        if(isAddresFromMap){
//            
//            MYLog(@"locationDict - %@",locationDict);
//            
//            
//            if(indexPath.section == 0){
//                
//                
//                addresFieldText.text = [locationDict valueForKey:@"full_name"];
//                [addressDict setValue:[locationDict valueForKey:@"full_name"] forKey:@"full_name"];
//                
//                
//                
//            }else if(indexPath.section == 4){
//                
//                
//                
//                addresFieldText.text = [locationDict valueForKey:@"street"];
//                [addressDict setValue:[locationDict valueForKey:@"street"] forKey:@"street"];
//
//                
//                
//                
//            }else if(indexPath.section == 6){
//                
//                
//                
//                addresFieldText.text = [locationDict valueForKey:@"address"];
//                [addressDict setValue:[locationDict valueForKey:@"address"] forKey:@"address1"];
//
//                
//                
//            }
//            
//            
//        }
        if(indexPath.section == 4){
            
            
            //Add button here....
            
        }
        else if(indexPath.section == 5){

            
            [cell addSubview:myMapView];
            
            
        }else{
        
            [cell addSubview:addresFieldText];
            
        }
        
        
    }
    else
    {
        
        
        
        
        MYLog(@"old");
        
//        UITextField *addresFieldText = [cell viewWithTag:indexPath.section+1];
//        
//        if(isAddresFromMap){
//            
//            MYLog(@"locationDict - %@",locationDict);
//            
//            
//            if(indexPath.section == 0){
//                
//                MYLog(@"11");
//                addresFieldText.placeholder = @"";
//                addresFieldText.text = [locationDict valueForKey:@"full_name"];
//                [addressDict setValue:[locationDict valueForKey:@"full_name"] forKey:@"full_name"];
//
//                
//                
//                
//            }else if(indexPath.section == 4){
//                
//                
//                MYLog(@"11");
//                addresFieldText.placeholder = @"";
//                addresFieldText.text = [locationDict valueForKey:@"street"];
//                [addressDict setValue:[locationDict valueForKey:@"street"] forKey:@"street"];
//
//                
//                
//                
//            }else if(indexPath.section == 6){
//                
//                
//                MYLog(@"11");
//                addresFieldText.placeholder = @"";
//                addresFieldText.text = [locationDict valueForKey:@"address"];
//                [addressDict setValue:[locationDict valueForKey:@"address"] forKey:@"address1"];
//
//                
//                
//            }
//            
//            
//        }
//
        
        
        
        
    }
    
    return cell;
}


#pragma mark - TextField Delegates

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    activeTextField = textField;

}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.tag == 1){
        
        [addressDict setValue:textField.text forKey:@"building_no"];
    
    
    }else if(textField.tag == 2){
        
        [addressDict setValue:textField.text forKey:@"street"];
        
        
    }else if(textField.tag == 3){
        
        

        
        
        
    }else if(textField.tag == 4){
        
        [addressDict setValue:textField.text forKey:@"notes"];
        
        
    }
    



}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    MYLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}




- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    MYLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    
    
    
    if (currentLocation != nil) {
        //longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    
    
    
    //[self getAddressFromLatLon:newLocation];
}

#pragma mark - mapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [myMapView setRegion:mapRegion animated: YES];
}


//- (void) getAddressFromLatLon:(CLLocation *)bestLocation
//{
//
//    
//    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]initWithCapacity:5];
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
//    [geocoder reverseGeocodeLocation:bestLocation
//                   completionHandler:^(NSArray *placemarks, NSError *error)
//     {
//         if (error){
//             MYLog(@"Geocode failed with error: %@", error);
//             return;
//         }
//         CLPlacemark *placemark = [placemarks objectAtIndex:0];
//         
//         MYLog(@"Name %@",placemark.name);
//         MYLog(@"Street %@",placemark.thoroughfare);
//         MYLog(@"locality %@",placemark.locality);
//         MYLog(@"postalCode %@",placemark.postalCode);
//         MYLog(@"subLocality %@",placemark.subLocality);
//         
//         MYLog(@"subThoroughfare %@",placemark.subThoroughfare);
//         
//         isAddresFromMap = YES;
//         
//         [returnDict setValue:placemark.name forKey:@"full_name"];
//         [returnDict setValue:placemark.thoroughfare forKey:@"street"];
//         [returnDict setValue:[NSString stringWithFormat:@"%@ , %@",placemark.locality,placemark.subLocality] forKey:@"address"];
//
//         
//         
//         
//         
//         locationDict = returnDict;
//         
//         
//         
//         [addressDict setValue:[NSString stringWithFormat: @"%f", bestLocation.coordinate.latitude] forKey:@"latitude"];
//         [addressDict setValue:[NSString stringWithFormat: @"%f", bestLocation.coordinate.longitude] forKey:@"longitude"];
//         
//         
//         
//         NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:0 inSection:0];
//         NSIndexPath* rowToReload1 = [NSIndexPath indexPathForRow:0 inSection:4];
//         
//         NSIndexPath* rowToReload2 = [NSIndexPath indexPathForRow:0 inSection:6];
//         
//         
//         NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload,rowToReload1,rowToReload2, nil];
//         
//         [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
//         
//         
//         
//     }];
//    
//    
//
//    
//}

#pragma mark pickerView deligats




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [zoneList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    
    NSDictionary *zoneDict = [zoneList objectAtIndex:row];
    
    
    title = [zoneDict valueForKey:@"zone_name"];
    
    activeTextField.text = title;
    
    
    [addressDict setValue:[zoneDict valueForKey:@"id"] forKey:@"zone_id"];
    
    MYLog(@"addressDict %@",addressDict);
    
    
    return title;
}


#pragma mark action methods


-(void)doneButtonClicked
{
    [activeTextField resignFirstResponder];
    
    
}
-(void)cancelButtonClicked
{
    [activeTextField resignFirstResponder];
    
    
}


#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertLogOut clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    MYLog(@"kl");
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    [SVProgressHUD dismiss];
    
    
    if([APIname isEqualToString:@"ADD_ADDRESS"]){
        
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [path objectAtIndex:0];
        NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
        

        
        
        NSMutableArray  *savedData =  [[NSMutableArray alloc]initWithContentsOfFile:filePath];//[[NSDictionary alloc]initWithContentsOfFile:filePath];
        
        MYLog(@"savedData -- %@",savedData);
        
        if(savedData.count == 0){
            
            
            NSArray *addressArray = [[NSArray alloc]initWithObjects:response, nil];
            
            if([addressArray writeToFile:filePath atomically:YES]){
                
                MYLog(@"write to file success")
                
                
            }else{
                
                MYLog(@"write to file failed...")
            }
            
            
        }else{
        
        
            [savedData addObject:response];
            
            if([savedData writeToFile:filePath atomically:YES]){
                
                MYLog(@"write to file success")
                
                
            }else{
                
                MYLog(@"write to file failed...")
            }

        
        
        }
        
        
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Success"
                                      message:@"Address added successfully."
                                      delegate:self
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil];
                [alert show];
                alert=nil;

        
        
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadRow" object:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadAddressList" object:self];
        
        
        
        
    }else if([APIname isEqualToString:@"UPDATE_ADDRESS"]){
        
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [path objectAtIndex:0];
        NSString *filePath = [documentFolder stringByAppendingFormat:@"/AddresList.plist"];
        
        
        
        
        NSMutableArray  *savedData =  [[NSMutableArray alloc]initWithContentsOfFile:filePath];//[[NSDictionary alloc]initWithContentsOfFile:filePath];
        
        MYLog(@"savedData old - %@",savedData);
        
        
        for(int i = 0; i<[savedData count]; i ++){
        
        
            NSDictionary *tempDict = [savedData objectAtIndex:i];
            
            if([[[tempDict valueForKey:@"id"] stringValue] isEqualToString:[[oldAddressDict valueForKey:@"id"]stringValue]]){
                
                
                [savedData replaceObjectAtIndex:i withObject:response];
                
                
                
            }
            
        
        }
        
        
        MYLog(@"savedData new - %@",savedData);
        
        if([savedData writeToFile:filePath atomically:YES]){
            
            MYLog(@"write to file success")
            
            
        }else{
            
            MYLog(@"write to file failed...")
        }
        
       
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Success"
                              message:@"Address updated successfully."
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        [alert show];
        alert=nil;
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadRow" object:self];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadAddressList" object:self];
    
    
    }else if([APIname isEqualToString:@"ZONE_LOST"]){
        
        
        
        zoneList = response;
    
    
    
    }
    
    
    
    
    
    
    
}


-(void)APIReponseWithError:(NSArray *)error{
    
    
    [SVProgressHUD dismiss];
    
    
    MYLog(@" Error - %@",error);
    
    
//    if([error count]> 0){
//        
//        
//        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:[[error objectAtIndex:0] valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [errorAlert show];
//        
//    }
    
    
    
    
}





@end
