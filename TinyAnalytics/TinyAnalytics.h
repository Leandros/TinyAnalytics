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

/**
* Track a transaction hit.
*
* @param transactionID A unique ID representing the transaction. This ID should not collide with other transaction IDs. Required.
* @param affliation An entity with which the transaction should be affiliated (e.g. a particular store). Required.
* @param revenue The total revenue of a transaction, including tax and shipping. Required.
* @param shipping The total cost of shipping for a transaction. Required.
* @param tax The total tax for a transaction. Required.
* @param currencyCode The local currency of a transaction. Defaults to the currency of the view (profile) in which the transactions are being viewed. Can be nil.
*/
- (void)trackTransaction:(NSString *)transactionID
              affliation:(NSString *)affliation
                 revenue:(NSNumber *)revenue
                shipping:(NSNumber *)shipping
                     tax:(NSNumber *)tax
            currencyCode:(NSString *)currencyCode;

/**
* Track a transaction item.
*
* @param transactionID The transaction ID with which the item should be associated. Required.
* @param name The name of the product. Required.
* @param SKU The SKU of a product. Required.
* @param category A category to which the product belongs. Required.
* @param price The price of a product. Required.
* @param quantity The quantity of a product. Required.
* @param currencyCode The local currency of a transaction. Defaults to the currency of the view (profile) in which the transactions are reported. Can be nil.
*/
- (void)trackItem:(NSString *)transactionID
             name:(NSString *)name
              SKU:(NSString *)SKU
        cateogory:(NSString *)category
            price:(NSNumber *)price
         quantity:(NSNumber *)quantity
     currencyCode:(NSString *)currencyCode;

/**
* Track the social interaction.
*
* @param network The social network with which the user is interacting (e.g. Facebook, Google+, Twitter, etc.). Required.
* @param action The social action taken (e.g. Like, Share, +1, etc.). Required.
* @param The content on which the social action is being taken (i.e. a specific article or video). Can be nil.
*/
- (void)trackSocialInteraction:(NSString *)network action:(NSString *)action target:(NSString *)target;

/**
* Track an event.
*
* @param action The event action. Required.
* @param category The event category. Required.
*/
- (void)trackAppEvent:(NSString *)action category:(NSString *)category;

/**
* Track an exception.
*
* @param isFatal Indicates whether the exception was fatal. YES indicates fatal. Required.
* @param description A description of the exception (up to 100 characters). Can be nil.
*/
- (void)trackException:(BOOL)isFatal description:(NSString *)description;
@end