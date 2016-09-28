//
//  APIHandler.m
//  GIZA LAUNDRY
//
//  Created by Clement on 11/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "APIHandler.h"

@implementation APIHandler

@synthesize delegate;

-(void)tempRegisteUser :(NSDictionary *)parametersDict{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:TEMP_REGISTER_API parameters:parametersDict error:nil];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            [delegate APIReponseWithErrorArray:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"TEMP_REGISTRATION"];
        }
        
        
        
    }];
    [dataTask resume];
    
    
    
}


-(void)sendOTP :(NSDictionary *)parametersDict{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:SEND_OTP_API parameters:parametersDict error:nil];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"OTP"];
        }
        
        
        
    }];
    [dataTask resume];
    
    
    
}


-(void)registeUser :(NSDictionary *)parametersDict{
    
    

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    

    NSURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:REGISTER_API parameters:parametersDict error:nil];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"REGISTRATION"];
        }
        
        
        
    }];
    [dataTask resume];
    
    
    
}


-(void)loginUser :(NSDictionary *)parametersDict{
    

    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:LOGIN_API parameters:parametersDict error:nil];
    
    
    //NSString *tocken = [NSString stringWithFormat:@""];
    
    
    //[request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"] forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"LOGIN"];
        }
    }];
    [dataTask resume];
    
    
    
    
}

-(void)registerMobile :(NSDictionary *)parametersDict{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:REGISTER_MOBILE__API parameters:parametersDict error:nil];
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"RE_MOBILE"];
        }
    }];
    [dataTask resume];
    
    
    
    
}


-(void)forgotPassword :(NSDictionary *)parametersDict{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:FORGOT_PASS_API parameters:parametersDict error:nil];
    
    
    //NSString *tocken = [NSString stringWithFormat:@""];
    
    
    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"] forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"FORGOT"];
        }
    }];
    [dataTask resume];
    
    
    
    
}







-(void)getRateCard{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:RATE_CARD_API];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    MYLog(@"tocken - %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]);
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"RATE_CARD"];
        }
    }];
    [dataTask resume];
    
    
    
}

-(void)getAddresses{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:GET_ADDRESS_API];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    MYLog(@"tocken - %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]);
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"ADDRESSES"];
        }
    }];
    [dataTask resume];
    
    
    
}


-(void)getMyOders{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:MY_ORDER_API];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    MYLog(@"tocken - %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]);
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"MY_ORDERS"];
        }
    }];
    [dataTask resume];
    
    
    
}

-(void)getMyProfile{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:GET_PROFILE_API];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    MYLog(@"tocken - %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]);
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"MY_PROFILE"];
        }
    }];
    [dataTask resume];
    
    
    
}




-(void)saveAddress :(NSDictionary *)parametersDict{
    
    
    
    MYLog(@"parametersDict -- %@",parametersDict);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:ADD_ADDRESS_API parameters:parametersDict error:nil];
    
    
    //NSString *tocken = [NSString stringWithFormat:@""];
    
    

    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"ADD_ADDRESS"];
        }
    }];
    [dataTask resume];
    
    
    
    
}


-(void)updateAddress :(NSDictionary *)parametersDict{
    
    
    
    MYLog(@"parametersDict -- %@",parametersDict);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",UPDATE_ADDRESS_API,[parametersDict valueForKey:@"id"]];
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:parametersDict error:nil];
    
    
    //NSString *tocken = [NSString stringWithFormat:@""];
    
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"UPDATE_ADDRESS"];
        }
    }];
    [dataTask resume];
    
    
    
    
}


-(void)updatePassword :(NSDictionary *)parametersDict{
    
    
    
    MYLog(@"parametersDict -- %@",parametersDict);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:UPDATE_PASSWORD_API parameters:parametersDict error:nil];
    
    
    //NSString *tocken = [NSString stringWithFormat:@""];
    
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"ADD_ADDRESS"];
        }
    }];
    [dataTask resume];
    
    
    
    
}


-(void)conformOrder :(NSDictionary *)parametersDict{
    
    
    
    MYLog(@"parametersDict -- %@",parametersDict);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:CONFORM_ORDER_API parameters:parametersDict error:nil];
    
    
    //NSString *tocken = [NSString stringWithFormat:@""];
    
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithErrorArray:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"CONFORM_ORDER"];
        }
    }];
    [dataTask resume];
    
    
    
    
}


-(void)setDefaultAddress :(NSDictionary *)parametersDict{
    
    
    
    MYLog(@"parametersDict -- %@",parametersDict);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:SET_DEFAULT_ADDRESS_API parameters:parametersDict error:nil];
    
    
    
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"SET_DEFAULT"];
        }
    }];
    [dataTask resume];
    
    
    
    
}

-(void)deleteAddress :(NSDictionary *)parametersDict{
    
    
    
    MYLog(@"parametersDict -- %@",parametersDict);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@",DELETE_ADDRESS_API,[parametersDict valueForKey:@"id"]] parameters:nil error:nil];
    
    
    
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithErrorDetail:responseObject APIName:@"DELETE_ADDRESS"];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"DELETE_ADDRESS"];
        }
    }];
    [dataTask resume];
    
    
    
    
}


-(void)updateProfile :(NSDictionary *)parametersDict{
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"profileImage.jpg"];
    
    
    MYLog(@"savedImagePath -- %@",savedImagePath);
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:UPDATE_PROFILE_API parameters:parametersDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:savedImagePath] name:@"profile_image" fileName:@"profileImage.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          //[progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {

                          [delegate APIReponseWithError:responseObject];
                          
                      } else {
                          
                          [delegate ProcessAPIData:responseObject APIName:@"UPDATE_PROFILE"];
                          
                      }
                  }];
    
    [uploadTask resume];
        
    
}


-(void)getZoneList:(NSDictionary *)parametersDict{
    
    
    MYLog(@"parametersDict -- %@",parametersDict);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@%@",GET_ZONE_API,[parametersDict valueForKey:@"country_id"]] parameters:nil error:nil];
    
    
//    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
//    
//    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"ZONE_LOST"];
        }
    }];
    [dataTask resume];
    
    
}


-(void)getNotificationsList{
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:GET_NOTIFICATIONS_API parameters:nil error:nil];
    
    
    //NSString *tocken = [NSString stringWithFormat:@""];
    
    
    NSString *tocken = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"kaccess_tocken"]];
    [request setValue:tocken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [delegate APIReponseWithError:responseObject];
            
        } else {//Success
            
            [delegate ProcessAPIData:responseObject APIName:@"NOTIFICATIONS LIST"];
        }
    }];
    [dataTask resume];
    
    
    
    
}




@end
