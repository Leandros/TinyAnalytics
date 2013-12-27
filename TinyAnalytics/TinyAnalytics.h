#import <Foundation/Foundation.h>

@interface TinyAnalytics : NSObject

@property(nonatomic, strong) NSString *trackingID;

/**
* Returns singleton.
*
* @return The TinyAnalytics singleton.
*/
+ (id)sharedInstance;

/**
* Init the TinyAnalytics singleton with the trackingID from Google Analytics.
*
* @param tracking The TrackingID from your Google Analytics Property.
* @return the TinyAnalytics singleton.
*/
- (id)analyticsWithTrackingID:(NSString *)tracking;

/**
* Track the current screen.
*
* @param tag The name of the screen.
*/
- (void)trackScreenView:(NSString *)tag;

@end