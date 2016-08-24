//
//  MyProfileViewController.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 13/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "MyProfileViewController.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "ChangePasswordViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation MyProfileViewController{

    
    APIHandler *handler;
    NSDictionary *profileInfo;
    NSMutableDictionary *profileData;
    UITextField *activeTextField;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 25, 30);
        [btn setImage:[UIImage imageNamed:@"sidebar_icon.png"] forState:UIControlStateNormal];
        [btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [self.navigationItem setLeftBarButtonItem:sidebarButton animated:YES];
        
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
    
    
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    
    
    
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 5, 200 , 34)];
    [titleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = titleImageView;

    
    ///////////////////////////////////////////////

    
    UIButton *goToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    goToTop.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    [goToTop setTitle:@"SAVE" forState:UIControlStateNormal];
    
    [goToTop setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    
    [goToTop addTarget:self action:@selector(updateProfile) forControlEvents:UIControlEventTouchUpInside];
    
    [goToTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToTop.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    goToTop.titleLabel.font = [UIFont systemFontOfSize:18];
    
    UIBarButtonItem *temp  = [[UIBarButtonItem alloc]initWithCustomView:goToTop];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    negativeSpacer.width = -16; // it was -6 in iOS 6
    
    [self setToolbarItems:[NSArray arrayWithObjects:negativeSpacer,temp, nil]];


    
    
    
    
    //Add camerabutton
    
    
    
    handler = [[APIHandler alloc]init];
    handler.delegate = self;
    
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/ProfileInfo.plist"];
    
    
    NSDictionary *savedData =  [[NSDictionary alloc]initWithContentsOfFile:filePath];
    
    MYLog(@"savedData -- %@",filePath);
    
    if(savedData.count == 0){
        
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"Loading my profile"];
        
        
        [handler getMyProfile];
    
        
        
        
    }else{
    
        
        profileInfo = savedData;
    
    }

    
    
    
    
    profileData = [[NSMutableDictionary alloc]initWithCapacity:4];
    
    
    
    
    
        
    
    
    //Add header ....
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.width-100)];
    _imageView.backgroundColor = [UIColor lightGrayColor];
    
    

    
    
   
    if ([profileInfo valueForKey:@"profile_image"])
    {
        
        
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"/dp.jpg"];
            UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
        
        
            MYLog(@"savedData -- %@",getImagePath);
        
            if(img){
        
                MYLog(@"savedData -- %@",getImagePath);
        
                _imageView.image = img;
        
        
            }else{
        
                _imageView.image =[UIImage imageNamed:@"profile-placeholder.png"];
                
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        NSString *prof_img_url = [profileInfo valueForKey:@"profile_image"];
                        
                        MYLog(@" in flag url %@",prof_img_url);
                        
                        NSURL *url = [NSURL URLWithString:prof_img_url];
                        NSData *data = [NSData dataWithContentsOfURL:url];
                        UIImage *img = [[UIImage alloc] initWithData:data];
                        
                        _imageView.image = img;
                        
                        
                        
                        
                    });
                });
            
            
            }
        
        
        
        
        
        
        
        
//        NSString *prof_img_url = [profileInfo valueForKey:@"profile_image"];
//        
//        MYLog(@" in flag url %@",prof_img_url);
//        
//        
//        NSURL *profurl=[NSURL URLWithString:prof_img_url];
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:profurl];
//        
//        
//        __unsafe_unretained typeof(self) weakSelf = self;//creating a weak reference to self
//        
//        [_imageView setImageWithURLRequest:request
//                          placeholderImage:[UIImage imageNamed:@"profile-placeholder.png"]
//                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                       
//                                       [weakSelf->_imageView setImage:image];
//                                       [weakSelf->_imageView setNeedsLayout];
//                                       
//                                       
//                                       
////                                       NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////                                       NSString *documentFolder = [path objectAtIndex:0];
////                                       NSString *filePath = [documentFolder stringByAppendingFormat:@"/dp.jpg"];
////                                       
////                                       MYLog(@"filepath -- %@",filePath);
////                                       
////                                       NSData *data = UIImageJPEGRepresentation(image, 1.0);
////                                       
////                                       
////                                       if([data writeToFile:filePath atomically:YES]){
////                                           
////                                           MYLog(@"write to file success")
////                                           
////                                           
////                                       }else{
////                                           
////                                           MYLog(@"write to file failed...")
////                                       }
//                                       
//                                       
//                                       
//                                   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error) {
//                                       
//                                       MYLog(@"Error in flag url %@",error);
//                                       
//                                   }];
//        
        
        
        
        
        
        
    }else{
        
                _imageView.image =[UIImage imageNamed:@"profile-placeholder.png"];
        
            
    }

    
    
    
    
    
    
    
    
    self.tableView.tableHeaderView = _imageView;
    

   
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // UITableViewCell *cell ;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        NSLog(@"new one");
        

        
        // Configure the cell...
        
        
        
        
        
        
        if(indexPath.row == 0){
            
            cell.backgroundColor=[UIColor grayColor];
            
            
            
            CGRect rectOfCellInTableView = [tableView rectForRowAtIndexPath: indexPath];
            
            CGRect rectOfCellInSuperview = [tableView convertRect: rectOfCellInTableView toView: tableView.superview];
            
            
            
            
            UIView *hairline=[[UIView alloc] initWithFrame:CGRectMake(0, rectOfCellInSuperview.origin.y-7.5,self.tableView.frame.size.width, 5)];
            
            hairline.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0];
            
            [self.tableView addSubview:hairline];
            
            
            
            UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width-cell.frame.size.height*2,rectOfCellInSuperview.origin.y-cell.frame.size.height/2*1.4-5,cell.frame.size.height*1.4,cell.frame.size.height*1.4)];
            
            [self.tableView addSubview:addButton];
            
            
            
            UIImage *btnImage = [UIImage imageNamed:@"cameraIcon.png"];
            
            [addButton setImage:btnImage forState:UIControlStateNormal];
            
            [addButton addTarget:self
             
                          action:@selector(selectPhoto:)
             
                forControlEvents:UIControlEventTouchUpInside];
            
            addButton.contentMode = UIViewContentModeScaleAspectFit;
            
            
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
            
            if(profileInfo){
                
                title.text = [[NSString stringWithFormat:@"%@ %@",[profileInfo valueForKey:@"first_name"],[profileInfo valueForKey:@"last_name"]]uppercaseString];
            }

            
            
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont boldSystemFontOfSize:15];
            title.tag = 10;
            
            [cell addSubview:title];
            
            
        }
        
        
        
        if(indexPath.row == 5){
            
            
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            button.tag = indexPath.row;
            
            [button addTarget:self action:@selector(changePassButtonClicked:) forControlEvents:UIControlEventTouchDown];
            
            [button setTitle:@"Change Password" forState:UIControlStateNormal];
            
            button.tintColor = [UIColor blackColor];
            
            button.frame = CGRectMake(self.tableView.frame.size.width - 150, 0.0, 140, 40.0);
            
            
            
            //[button setTitleColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            
            
            [cell.contentView addSubview:button];
            
            
            
            
            
        }else{
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            UITextField *profileFieldText = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, self.tableView.frame.size.width - 20, 30)];
            
            
            
            profileFieldText.autocorrectionType = UITextAutocorrectionTypeNo;
            
            [profileFieldText setClearButtonMode:UITextFieldViewModeWhileEditing];
            
            profileFieldText.delegate = self;
            
            
            profileFieldText.tag = indexPath.row;
            
            if(indexPath.row == 3){
                
                profileFieldText.enabled = NO;
                
                
            }
            
            if(profileInfo){
                
                if(indexPath.row == 1){
                    
                    
                    
                    profileFieldText.text = [profileInfo valueForKey:@"first_name"];
                    
                    
                }else if(indexPath.row == 2){
                    
                    
                    
                    profileFieldText.text = [profileInfo valueForKey:@"last_name"];
                    
                    
                    
                    
                    
                }else if(indexPath.row == 3){
                    
                    
                    
                    
                    
                    profileFieldText.text = [profileInfo valueForKey:@"email"];
                    
                    
                }else if(indexPath.row == 4){
                    
                    
                    profileFieldText.text = [profileInfo valueForKey:@"phone_no"];
//                    [profileFieldText setKeyboardType:UIKeyboardTypePhonePad];
                    
                    
                    
                }

                
            }
            
            
            
            if (indexPath.row!=0) {
                
                [cell addSubview:profileFieldText];
                
                
                
            }
            
        }
        

        

       
    }
    
    else
        
    {
        
        
        
        if(profileInfo){
            
            
            NSLog(@"old one %ld",(long)indexPath.row);
            
            
            if(indexPath.row == 0){
                
                UILabel *titleLabel = [cell viewWithTag:10];
                titleLabel.text = [[NSString stringWithFormat:@"%@ %@",[profileInfo valueForKey:@"first_name"],[profileInfo valueForKey:@"last_name"]]uppercaseString];
                
                
                
            }else if(indexPath.row == 1){
                
                UITextField *profileFieldText = (UITextField *)[cell viewWithTag:1];
                
                profileFieldText.text = [profileInfo valueForKey:@"first_name"];
                
                
            }else if(indexPath.row == 2){
                
                
                UITextField *profileFieldText = (UITextField *)[cell viewWithTag:2];
                profileFieldText.text = [profileInfo valueForKey:@"last_name"];
                
                
            }else if(indexPath.row == 3){
                
                UITextField *profileFieldText = (UITextField *)[cell viewWithTag:3];
                
                profileFieldText.text = [profileInfo valueForKey:@"email"];
                
                
                
            }else if(indexPath.row == 4){
                
                UITextField *profileFieldText = (UITextField *)[cell viewWithTag:4];
                profileFieldText.text = [profileInfo valueForKey:@"phone_no"];
                
                
                
            }
            
            
            
        }
        

        
        
        
    }
    
    
    
   
    return cell;
    
    
    
}


-(void)changePassButtonClicked:(UIButton*)sender
{
    
    
    ChangePasswordViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
   
    
}

-(void)updateProfile
{
    
    if(activeTextField.tag == 1){
        
        [profileData setValue:activeTextField.text forKey:@"first_name"];
        
        
    }else if(activeTextField.tag == 2){
        
        [profileData setValue:activeTextField.text forKey:@"last_name"];
        
        
    }else if(activeTextField.tag == 4){
        
        [profileData setValue:activeTextField.text forKey:@"phone_no"];
        
        
    }
    
    
    
    if(![profileData valueForKey:@"first_name"]){
        
        [profileData setValue:[profileInfo valueForKey:@"first_name"] forKey:@"first_name"];
        
    }
    
    if(![profileData valueForKey:@"last_name"]){
        
        [profileData setValue:[profileInfo valueForKey:@"last_name"] forKey:@"last_name"];
        
    }
    
    if(![profileData valueForKey:@"phone_no"]){
        
        [profileData setValue:[profileInfo valueForKey:@"phone_no"] forKey:@"phone_no"];
        
    }
    
    
    MYLog(@"profileData - %@",profileData);
//    
//    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.5);
//    
//    [profileData setObject:imageData forKey:@"profile_image"];
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"profileImage.jpg"];
    
    
    MYLog(@"savedImagePath -- %@",savedImagePath);

    
    
    UIImage *image = self.imageView.image; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);

    
    
    
    if([imageData writeToFile:savedImagePath atomically:NO]){
        
        MYLog(@"write to file success")
        
        
    }else{
        
        MYLog(@"write to file failed...")
    }
    
    
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"Updating profile"];
    
    [handler updateProfile:profileData];
    
    
    
}

#pragma mark - TextField Delegates

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    CGPoint pointInTable = [textField.superview convertPoint:textField.frame.origin toView:self.tableView];
    CGPoint contentOffset = self.tableView.contentOffset;
    
    contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height-100);
    
    NSLog(@"contentOffset is: %@", NSStringFromCGPoint(contentOffset));
    
    [self.tableView setContentOffset:contentOffset animated:YES];
    
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if ([textField.superview.superview isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = (UITableViewCell*)textField.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
    }
    
    return YES;
}




// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    activeTextField = textField;
    
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.tag == 1){
        
        [profileData setValue:textField.text forKey:@"first_name"];
        
        
    }else if(textField.tag == 2){
        
        [profileData setValue:textField.text forKey:@"last_name"];
        
        
    }else if(textField.tag == 4){
        
        [profileData setValue:textField.text forKey:@"phone_no"];
        
        
    }
    
    
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}





#pragma mark image picker




- (void)selectPhoto:(UIButton *)sender {
    
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"My Title"
                                 message:@"Select you Choice"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* librery = [UIAlertAction
                         actionWithTitle:@"Phote library"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             
                             MYLog(@"selectPhoto");
                             
                             UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                             picker.delegate = self;
                             picker.allowsEditing = YES;
                             picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                             
                             [self presentViewController:picker animated:YES completion:NULL];

                             
                             
                         }];
    
    UIAlertAction* camera = [UIAlertAction
                         actionWithTitle:@"Camera"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             
                             UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                             picker.delegate = self;
                             picker.allowsEditing = YES;
                             picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                             
                             [self presentViewController:picker animated:YES completion:NULL];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [view addAction:librery];
    [view addAction:camera];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
    
    
    
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark APIHandler methods

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIname{
    
    
    MYLog(@"respomse  ----- %@  ------ %@",APIname,response);
    
    [SVProgressHUD dismiss];
    
    
    if([APIname isEqualToString:@"MY_PROFILE"]){
        
        
        //in both case do the same.....
        
    }else if([APIname isEqualToString:@"UPDATE_PROFILE"]){
        
    
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Profile updated successfully."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];

    
    
    }
    
    
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]initWithDictionary:response];
    
    //[temp setValue:@"" forKey:@"profile_image"];
    
    
    
    if([[temp valueForKey:@"profile_image"] isKindOfClass:[NSNull class]]){
        
        
        MYLog(@"yoyoo");
    
        [temp removeObjectForKey:@"profile_image"];
    
    }
    
    
    profileInfo = temp;
    
    MYLog(@"tempArray - %@",temp);
    
    
    //Write data to file if we got somethig.
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"/ProfileInfo.plist"];
    
    MYLog(@"filepath -- %@",filePath);
    
    
    if([temp writeToFile:filePath atomically:YES]){
        
        MYLog(@"write to file success")
        
        
    }else{
        
        MYLog(@"write to file failed...")
    }
    
    
    [self.tableView reloadData];
    
    
    
    
    
    if ([profileInfo valueForKey:@"profile_image"])
    {
        
        
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                NSString *prof_img_url = [profileInfo valueForKey:@"profile_image"];
                
                MYLog(@" in flag url %@",prof_img_url);
                
                NSURL *url = [NSURL URLWithString:prof_img_url];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *img = [[UIImage alloc] initWithData:data];
                
                _imageView.image = img;
                
                
                
        
                                               NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                               NSString *documentFolder = [path objectAtIndex:0];
                                               NSString *filePath = [documentFolder stringByAppendingFormat:@"/dp.jpg"];
        
                                               MYLog(@"filepath -- %@",filePath);
        
                                               NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        
        
                                               if([imageData writeToFile:filePath atomically:YES]){
        
                                                   MYLog(@"write to file success")
        
        
                                               }else{
                                                   
                                                   MYLog(@"write to file failed...")
                                               }
                
                
                
            });
        });
        
        
        
        
        
        
        
        
//        NSURL *profurl = [NSURL URLWithString:prof_img_url];
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:profurl];
        
//        __unsafe_unretained typeof(self) weakSelf = self;//creating a weak reference to self
//        
//        [_imageView setImageWithURLRequest:request
//                          placeholderImage:[UIImage imageNamed:@"profile-placeholder.png"]
//                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                       
//                                       [weakSelf->_imageView setImage:image];
//                                       [weakSelf->_imageView setNeedsLayout];
//                                       
//                                       
//                                       
//                                       
//                                       
//                                       
//                                       NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                                       NSString *documentFolder = [path objectAtIndex:0];
//                                       NSString *filePath = [documentFolder stringByAppendingFormat:@"/dp.jpg"];
//                                       
//                                       MYLog(@"filepath -- %@",filePath);
//                                       
//                                       NSData *data = UIImageJPEGRepresentation(image, 1.0);
//
//                                       
//                                       if([data writeToFile:filePath atomically:YES]){
//                                           
//                                           MYLog(@"write to file success")
//                                           
//                                           
//                                       }else{
//                                           
//                                           MYLog(@"write to file failed...")
//                                       }
//                                       
//                                       
//                                       
//                                   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error) {
//                                       
//                                       MYLog(@"Error in flag url %@",error);
//                                       
//                                   }];
        
        
        
    }else{
    
        _imageView.image =[UIImage imageNamed:@"profile-placeholder.png"];
    
    }

    
    
    
}


-(void)APIReponseWithError:(NSDictionary *)error{
    
    
    [SVProgressHUD dismiss];
    
    
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Failed to update profile. Please try again."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];

    
    MYLog(@" Error - %@",error);
}


@end
