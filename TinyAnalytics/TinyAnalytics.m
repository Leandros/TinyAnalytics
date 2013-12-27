#import "TinyAnalytics.h"
#import <AFNetworking/AFNetworking.h>

NSString *const gaBaseUrl = @"http://www.google-analytics.com/collect";

@implementation TinyAnalytics {

}

@synthesize trackingID;

+ (id)sharedInstance {
    static TinyAnalytics *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (id)analyticsWithTrackingID:(NSString *)tracking {
    [self setTrackingID:tracking];
    return self;
}

- (void)trackScreenView:(NSString *)tag {
    if (!trackingID) {
        [NSException raise:@"NoTrackingIDException" format:@"Please set a trackingID"];
    }

    NSMutableDictionary *mutablePayload = [[NSMutableDictionary alloc] init];
    [mutablePayload setValue:@1 forKey:@"v"];
    [mutablePayload setValue:trackingID forKey:@"tid"];
    [mutablePayload setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"cid"];
    [mutablePayload setValue:@"appview" forKey:@"t"];
    [mutablePayload setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] forKey:@"an"];
    [mutablePayload setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] forKey:@"av"];
    [mutablePayload setValue:tag forKey:@"cd"];

    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [operationManager POST:gaBaseUrl parameters:mutablePayload
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully tracked Screen %@", tag);
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to track Screen: %@", error);
    }];
}

@end