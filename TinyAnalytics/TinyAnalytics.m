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
            NSLog(@"Successfully tracked screen %@", tag);
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to track screen: %@", error);
    }];
}

- (void)trackTransaction:(NSString *)transactionID
              affliation:(NSString *)affliation
                 revenue:(NSNumber *)revenue
                shipping:(NSNumber *)shipping
                     tax:(NSNumber *)tax
            currencyCode:(NSString *)currencyCode {
    if (!trackingID) {
        [NSException raise:@"NoTrackingIDException" format:@"Please set a trackingID"];
    }

    NSMutableDictionary *mutablePayload = [[NSMutableDictionary alloc] init];
    [mutablePayload setValue:@1 forKey:@"v"];
    [mutablePayload setValue:trackingID forKey:@"tid"];
    [mutablePayload setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"cid"];
    [mutablePayload setValue:@"transaction" forKey:@"t"];
    [mutablePayload setValue:transactionID forKey:@"ti"];
    [mutablePayload setValue:affliation forKey:@"ta"];
    [mutablePayload setValue:revenue forKey:@"tr"];
    [mutablePayload setValue:shipping forKey:@"ts"];
    [mutablePayload setValue:tax forKey:@"tt"];
    if (currencyCode) {
        [mutablePayload setValue:currencyCode forKey:@"cu"];
    }

    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [operationManager POST:gaBaseUrl parameters:mutablePayload
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully tracked transaction.");
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to track transaction: %@", error);
    }];
}

- (void)trackItem:(NSString *)transactionID
             name:(NSString *)name
              SKU:(NSString *)SKU
        cateogory:(NSString *)category
            price:(NSNumber *)price
         quantity:(NSNumber *)quantity
     currencyCode:(NSString *)currencyCode {
    if (!trackingID) {
        [NSException raise:@"NoTrackingIDException" format:@"Please set a trackingID"];
    }

    NSMutableDictionary *mutablePayload = [[NSMutableDictionary alloc] init];
    [mutablePayload setValue:@1 forKey:@"v"];
    [mutablePayload setValue:trackingID forKey:@"tid"];
    [mutablePayload setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"cid"];
    [mutablePayload setValue:@"item" forKey:@"t"];
    [mutablePayload setValue:transactionID forKey:@"ti"];
    [mutablePayload setValue:name forKey:@"in"];
    [mutablePayload setValue:price forKey:@"ip"];
    [mutablePayload setValue:quantity forKey:@"iq"];
    [mutablePayload setValue:SKU forKey:@"ic"];
    [mutablePayload setValue:category forKey:@"iv"];
    if (currencyCode) {
        [mutablePayload setValue:currencyCode forKey:@"cu"];
    }


    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [operationManager POST:gaBaseUrl parameters:mutablePayload
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully tracked product.");
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to track product: %@", error);
    }];
}

- (void)trackSocialInteraction:(NSString *)network action:(NSString *)action target:(NSString *)target {
    if (!trackingID) {
        [NSException raise:@"NoTrackingIDException" format:@"Please set a trackingID"];
    }

    NSMutableDictionary *mutablePayload = [[NSMutableDictionary alloc] init];
    [mutablePayload setValue:@1 forKey:@"v"];
    [mutablePayload setValue:trackingID forKey:@"tid"];
    [mutablePayload setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"cid"];
    [mutablePayload setValue:@"social" forKey:@"t"];
    [mutablePayload setValue:action forKey:@"sa"];
    [mutablePayload setValue:network forKey:@"sn"];
    if (target) {
        [mutablePayload setValue:target forKey:@"st"];
    } else {
        [mutablePayload setValue:@"/" forKey:@"st"];
    }

    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [operationManager POST:gaBaseUrl parameters:mutablePayload
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully tracked social interaction.");
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to track social interaction: %@", error);
    }];
}

- (void)trackAppEvent:(NSString *)action category:(NSString *)category {
    if (!trackingID) {
        [NSException raise:@"NoTrackingIDException" format:@"Please set a trackingID"];
    }

    NSMutableDictionary *mutablePayload = [[NSMutableDictionary alloc] init];
    [mutablePayload setValue:@1 forKey:@"v"];
    [mutablePayload setValue:trackingID forKey:@"tid"];
    [mutablePayload setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"cid"];
    [mutablePayload setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] forKey:@"an"];
    [mutablePayload setValue:@"event" forKey:@"t"];
    [mutablePayload setValue:category forKey:@"ec"];
    [mutablePayload setValue:action forKey:@"ea"];

    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [operationManager POST:gaBaseUrl parameters:mutablePayload
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully tracked app event.");
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to track app event: %@", error);
    }];
}

- (void)trackException:(BOOL)isFatal description:(NSString *)description {
    if (!trackingID) {
        [NSException raise:@"NoTrackingIDException" format:@"Please set a trackingID"];
    }

    NSMutableDictionary *mutablePayload = [[NSMutableDictionary alloc] init];
    [mutablePayload setValue:@1 forKey:@"v"];
    [mutablePayload setValue:trackingID forKey:@"tid"];
    [mutablePayload setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"cid"];
    [mutablePayload setValue:@"exception" forKey:@"t"];
    if (description) {
        [mutablePayload setValue:description forKey:@"exd"];
    }
    [mutablePayload setValue:isFatal ? @1 : @0 forKey:@"exf"];

    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [operationManager POST:gaBaseUrl parameters:mutablePayload
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully tracked exception.");
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to track exception: %@", error);
    }];
}


@end