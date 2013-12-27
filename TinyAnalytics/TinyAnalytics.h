//
// Created by Arvid Gerstmann on 27/12/13.
// Copyright (c) 2013 Arvid Gerstmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TinyAnalytics : NSObject

@property (nonatomic, strong) NSString *trackingID;

+ (id)sharedInstance;

- (id)analyticsWithTrackingID:(NSString *)tracking;

- (void)trackPageView:(NSString *)tag;

@end