//
//  APIHandler.h
//  GIZA LAUNDRY
//
//  Created by Clement on 11/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



#define COUNTRYCODE_API @"/RechargeAplication/rest/rechargeservice/getCountryCodeOnIPAddress"

//http://algiza.codeaweb.net/api/

#define TEMP_REGISTER_API @"http://algiza.codeaweb.net/api/v1/user/temp-register"


#define SEND_OTP_API @"http://algiza.codeaweb.net/api/v1/user/send-otp"


#define CHECK_OTP_API @"http://algiza.codeaweb.net/api/v1/user/check-otp"



#define REGISTER_API @"http://algiza.codeaweb.net/api/v1/user/register"


#define REGISTER_MOBILE__API @"http://algiza.codeaweb.net/api/v1/user/register-device"


#define LOGIN_API @"http://algiza.codeaweb.net/api/v1/user/login"


#define FORGOT_PASS_API @"http://algiza.codeaweb.net/api/v1/user/forgot-password"

#define RATE_CARD_API @"http://algiza.codeaweb.net/api/v1/order/rate-cards"


#define GET_ADDRESS_API @"http://algiza.codeaweb.net/api/v1/user/my-address"


#define MY_ORDER_API @"http://algiza.codeaweb.net/api/v1/order/my-orders"


#define ADD_ADDRESS_API @"http://algiza.codeaweb.net/api/v1/user/add-address"


#define UPDATE_ADDRESS_API @"http://algiza.codeaweb.net/api/v1/user/update-address/"


#define GET_PROFILE_API @"http://algiza.codeaweb.net/api/v1/user/my-profile"


#define UPDATE_PASSWORD_API @"http://algiza.codeaweb.net/api/v1/user/change-password"


#define CONFORM_ORDER_API @"http://algiza.codeaweb.net/api/v1/order/request"


#define UPDATE_ORDER_API @"http://algiza.codeaweb.net/api/v1/order/update-request/"


#define SET_DEFAULT_ADDRESS_API @"http://algiza.codeaweb.net/api/v1/user/save-default-address"


#define DELETE_ADDRESS_API @"http://algiza.codeaweb.net/api/v1/user/delete-address/"


#define UPDATE_PROFILE_API @"http://algiza.codeaweb.net/api/v1/user/update-profile"


#define GET_ZONE_API @"http://algiza.codeaweb.net/api/v1/common/zone-list?country_id="


#define GET_NOTIFICATIONS_API @"http://algiza.codeaweb.net/api/v1/user/my-notifications"


#define CANCEL_ORDER @"http://algiza.codeaweb.net/api/v1/order/cancel-order/"

@protocol APIHandlerDelegate <NSObject>

@optional

- (void) ProcessAPIData :(id)response APIName:(NSString *)APIName;
- (void) APIReponseWithError:(NSDictionary *)response;
- (void) APIReponseWithErrorArray:(NSArray *)error;

- (void) APIReponseWithErrorDetail:(NSDictionary *)response APIName:(NSString *)APIName;

@end


@interface APIHandler : NSObject{


    // Delegate to respond back
    
    id <APIHandlerDelegate>delegate;
    

}

@property (nonatomic,strong) id delegate;


-(void)tempRegisteUser :(NSDictionary *)parametersDict;
-(void)sendOTP :(NSDictionary *)parametersDict;
-(void)checkOTP :(NSDictionary *)parametersDict;
-(void)registeUser :(NSDictionary *)parametersDict;
-(void)loginUser :(NSDictionary *)parametersDict;
-(void)registerMobile :(NSDictionary *)parametersDict;
-(void)forgotPassword :(NSDictionary *)parametersDict;
-(void)getRateCard;
-(void)getMyOders;
-(void)getAddresses;
-(void)saveAddress :(NSDictionary *)parametersDict;
-(void)updateAddress :(NSDictionary *)parametersDict;
-(void)getMyProfile;
-(void)updatePassword :(NSDictionary *)parametersDict;
-(void)conformOrder :(NSDictionary *)parametersDict;
-(void)setDefaultAddress :(NSDictionary *)parametersDict;
-(void)deleteAddress :(NSDictionary *)parametersDict;
-(void)updateProfile :(NSDictionary *)parametersDict;
-(void)getZoneList:(NSDictionary *)parametersDict;
-(void)getNotificationsList;
-(void)cancelOrder:(NSString *)orderID;
-(void)updateOrder :(NSDictionary *)parametersDict orderId:(NSString *)orderId;
@end
