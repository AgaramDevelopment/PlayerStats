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

#pragma Local URL
//#define BASE_URL  @"http://119.226.98.154:8002/FanZone/FanEngagement.svc/"     //@"http://www.dindiguldragons.com:8002/FanZone/FanEngagement.svc/"

#pragma Testing Url
//Local
//#define BASE_URL  @"http://192.168.1.84:8029/AGAPTService.svc/"
//#define BASE_Image_URL @"http://192.168.1.84:8030/bcciapp/"

//Live
#define BASE_URL  @"http://13.126.151.253:9001/AGAPTSERVICE.svc/"
#define BASE_Image_URL @"http://13.126.151.253:9000/bcciapp/"

//#ifdef DEBUG
//#define push_type   @"dev"
//#else
//#define push_type   @"pro"
//#endif

#define URL_FOR_RESOURCE(RESOURCE) [NSString stringWithFormat:@"%@%@",BASE_URL,RESOURCE]



@interface WebService : AFHTTPRequestOperationManager

+ (WebService *)service;

//-(void)getCheckrequeststatus:(NSString *) checkrequest
//          requestsenduserid :(NSString *) requestsenduserid
//                   sessionID:(NSString *) sessionid
//                     success:(WebserviceRequestSuccessHandler)success
//                     failure:(WebserviceRequestFailureHandler)failure;

//-(void)cancelRequest;
//
//
//-(void)BattingWagonWheel :(NSString *)list :(NSString *)playercode :(NSString *)matchcode:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//                  failure:(WebserviceRequestFailureHandler)failure;
//
//-(void)Battingpitchmap :(NSString *)list :(NSString *)playercode :(NSString *)matchcode:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//                failure:(WebserviceRequestFailureHandler)failure;
//
//-(void)sessionsummary :(NSString *)list :(NSString *)matchcode :(NSString *)matchstatus:(NSString *)dayno:(NSString *)sessionno:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//               failure:(WebserviceRequestFailureHandler)failure;
//-(void)matchtypesummary :(NSString *)list :(NSString *)matchcode :(NSString *)matchstatus success:(WebserviceRequestSuccessHandler)success
//                 failure:(WebserviceRequestFailureHandler)failure;
//-(void)SingledaySession :(NSString *)list :(NSString *)matchcode :(NSString *)matchtype :(NSString *)sessionNo :(NSString *)innNo success:(WebserviceRequestSuccessHandler)success
//                 failure:(WebserviceRequestFailureHandler)failure;
//
//-(void)LoadFieldingSummaryByInnins :(NSString *)list :(NSString *)matchStatus  :(NSString *)matchcode:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//                            failure:(WebserviceRequestFailureHandler)failure;
//
//-(void)GetVideoPathFile :(NSString *)list : (NSString *) batsmanCode : (NSString *) matchCode: (NSString *) inns: (NSString *) value: (NSString *) batOrBowl success:(WebserviceRequestSuccessHandler)success
//                 failure:(WebserviceRequestFailureHandler)failure;

@end
