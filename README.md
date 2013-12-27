TinyAnalytics
=============

A lightweight library for Google Analytics.
TinyAnalytics has been started, because the iOS Google Analytics SDK currently doesn't support the ARM64 architecture, used in the new A7 processor (used in the new iPhone 5s, iPad Air and iPad Mini Retina).

## Installation

#### CocoaPods (recommended!)

Just add
```
pod 'TinyAnalytics'
```
to your `Podfile`.

#### Classic Way

If you prefer the classic way, add the content of the `TinyAnalytics` directory to your project.
This library depends on [AFNetworking](https://github.com/AFNetworking/AFNetworking) (Version 2.0+), make sure to add it to your dependancies as well.


## Usage

Register the TinyAnalytics library with your Google Analytics ID in your `didFinishLaunchingWithOptions:` method of your `UIApplicationDelegate`.

```
#import "TinyAnalytics.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Your custom init code comes here.
    [[TinyAnalytics sharedInstance] analyticsWithTrackingID:@"UA-xxxxxxxx-x"];
    
    [self.window makeKeyAndVisible];
    return YES;
}
```

When you want to track a screen, just call the `TinyAnalytics` singleton method `trackScreenView`.

```
#import "TinyAnalytics.h"

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [TinyAnalytics sharedInstance] trackScreenView:@"MyViewController"];
}
```


## Contact

This library was written by Arvid Gerstmann.
You can find me on:

- [Website](http://arvid-gerstmann.de)
- [Github](https://github.com/leandros)
- [Twitter](http://twitter.com/leandros_ger)
- [Google+](https://plus.google.com/+ArvidGerstmann)

## License

TinyAnalytics is available under the MIT license. See the LICENSE file for more info.
