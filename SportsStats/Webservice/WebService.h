//
//  WebService.h
//  UPCA
//
//  Created by Mac on 11/05/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import <Foundation/Foundation.h>

typedef void (^WebserviceRequestSuccessHandler)(AFHTTPRequestOperation *operation, id responseObject);

typedef void (^WebserviceRequestFailureHandler)(AFHTTPRequestOperation  *operation, id error);

typedef void (^WebserviceRequestXMLSuccessHandler)(AFHTTPRequestOperation  *operation);
typedef void (^WebserviceRequestXMLFailureHandler)(AFHTTPRequestOperation  *operation, NSError *error);


#pragma Testing Url
//Local
//#define BASE_URL  @"http://192.168.1.84:8029/AGAPTService.svc/"
//#define BASE_Image_URL @"http://192.168.1.84:8030/bcciapp/"

//Live
#define BASE_URL  @"http://13.126.151.253:9001/AGAPTSERVICE.svc/"
#define BASE_Image_URL @"http://13.126.151.253:9000/bcciapp/"


#define URL_FOR_RESOURCE(RESOURCE) [NSString stringWithFormat:@"%@%@",BASE_URL,RESOURCE]



@interface WebService : AFHTTPRequestOperationManager

+ (WebService *)service;

@end
