//
//  WebService.m
//  UPCA
//
//  Created by Mac on 11/05/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "WebService.h"


static const NSString *ServicePost   = @"POST";
static const NSString *ServiceGet    = @"GET";
static const NSString *ServicePut    = @"PUT";
static const NSString *ServiceDelete = @"DELETE";

static const NSString *ServiceContentJSON = @"application/json";
static const NSString *ServiceContentFORM = @"application/x-www-form-urlencoded; charset=UTF-8";
static NSString       *ServiceMimeType    = @"image/jpeg";


@interface WebService ()
{
    NSString *urlString;
}
@end

@implementation WebService

- (id)init {
    self = [super init];
    if (self) {
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/javascript", @"text/plain", @"application/json",@"image/png",nil];
    }
    return self;
}

+ (WebService *)service {
    return [[WebService alloc] init];
}

//-(void)BattingWagonWheel :(NSString *)list :(NSString *)playercode :(NSString *)matchcode:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//           failure:(WebserviceRequestFailureHandler)failure
//{
//    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@",list,playercode,matchcode,innno]];
//    NSLog(@"urlString = %@",urlString);
//
//
//    [self sendRequestWithURLString:urlString
//                     andParameters:nil
//                            method:ServiceGet
//           completionSucessHandler:success
//          completionFailureHandler:failure];
//}
//
//-(void)Battingpitchmap :(NSString *)list :(NSString *)playercode :(NSString *)matchcode:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//                  failure:(WebserviceRequestFailureHandler)failure
//{
//    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@",list,playercode,matchcode,innno]];
//    NSLog(@"urlString = %@",urlString);
//
//
//    [self sendRequestWithURLString:urlString
//                     andParameters:nil
//                            method:ServiceGet
//           completionSucessHandler:success
//          completionFailureHandler:failure];
//}
//
//-(void)sessionsummary :(NSString *)list :(NSString *)matchcode :(NSString *)matchstatus:(NSString *)dayno:(NSString *)sessionno:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//                failure:(WebserviceRequestFailureHandler)failure
//{
//    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@",list,matchcode,matchstatus,dayno,sessionno,innno]];
//    NSLog(@"urlString = %@",urlString);
//
//
//    [self sendRequestWithURLString:urlString
//                     andParameters:nil
//                            method:ServiceGet
//           completionSucessHandler:success
//          completionFailureHandler:failure];
//}
//-(void)matchtypesummary :(NSString *)list :(NSString *)matchcode :(NSString *)matchstatus success:(WebserviceRequestSuccessHandler)success
//               failure:(WebserviceRequestFailureHandler)failure
//{
//    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",list,matchcode,matchstatus]];
//    NSLog(@"urlString = %@",urlString);
//
//
//    [self sendRequestWithURLString:urlString
//                     andParameters:nil
//                            method:ServiceGet
//           completionSucessHandler:success
//          completionFailureHandler:failure];
//}
//
//-(void)SingledaySession :(NSString *)list :(NSString *)matchcode :(NSString *)matchtype :(NSString *)sessionNo :(NSString *)innNo success:(WebserviceRequestSuccessHandler)success
//                 failure:(WebserviceRequestFailureHandler)failure
//{
//    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@",list,matchcode,matchtype,sessionNo,innNo]];
//    NSLog(@"urlString = %@",urlString);
//
//
//    [self sendRequestWithURLString:urlString
//                     andParameters:nil
//                            method:ServiceGet
//           completionSucessHandler:success
//          completionFailureHandler:failure];
//}
//
//
//
//-(void)LoadFieldingSummaryByInnins :(NSString *)list :(NSString *)matchStatus  :(NSString *)matchcode:(NSString *)innno success:(WebserviceRequestSuccessHandler)success
//                            failure:(WebserviceRequestFailureHandler)failure{
//
//    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@",list,matchcode,matchStatus,innno]];
//    NSLog(@"urlString = %@",urlString);
//
//
//    [self sendRequestWithURLString:urlString
//                     andParameters:nil
//                            method:ServiceGet
//           completionSucessHandler:success
//          completionFailureHandler:failure];
//
//
//}
//
//-(void)GetVideoPathFile :(NSString *)list : (NSString *) batsmanCode : (NSString *) matchCode: (NSString *) inns: (NSString *) value: (NSString *) batOrBowl success:(WebserviceRequestSuccessHandler)success
//                 failure:(WebserviceRequestFailureHandler)failure{
//
//    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@",list,batsmanCode,matchCode,inns,value,batOrBowl]];
//    NSLog(@"urlString = %@",urlString);
//
//
//    [self sendRequestWithURLString:urlString
//                     andParameters:nil
//                            method:ServiceGet
//           completionSucessHandler:success
//          completionFailureHandler:failure];
//
//
//}
//
//
//
//
//
//#pragma mark - Helpers
//
//- (void)sendRequestWithURLString:(NSString *)url
//                   andParameters:(NSDictionary *)parameters
//                          method:(const NSString *)method
//         completionSucessHandler:(WebserviceRequestSuccessHandler)sucesshandler
//        completionFailureHandler:(WebserviceRequestFailureHandler)failurehandler
//{
//
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    if (method == ServiceGet)
//    {
//        [self GET:url parameters:nil
//          success:^(AFHTTPRequestOperation *operation, id responseDict)
//         {
//             if (sucesshandler){
//                 //if([responseDict objectForKey:@"error"]){
//                // }
//                 sucesshandler(operation,responseDict);
//             }
//         }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error)
//         {
//             if (failurehandler){
//                 NSLog(@"response ");
//                 failurehandler(operation, error);
//             }
//         }];
//    }
//    else
//    {
//        [self POST:url parameters:parameters
//           success:^(AFHTTPRequestOperation *operation, id responseDict)
//         {
//             if (sucesshandler){
//                 //if([responseDict objectForKey:@"error"]){
//                 //}
//                 sucesshandler(operation,responseDict);
//             }
//         }
//           failure:^(AFHTTPRequestOperation *operation, NSError *error)
//         {
//             if (failurehandler) failurehandler(operation,error);
//         }];
//    }
//}
//
//-(void)cancelRequest
//{
//    [self.operationQueue cancelAllOperations];
//}


@end
