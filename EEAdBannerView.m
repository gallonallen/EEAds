//
//  EEAdBannerView.m
//  HASA Quarterly
//
//  Created by Sean Allen on 7/11/13.
//  Copyright (c) 2013 Enyalios Enterprises. All rights reserved.
//

#import "EEAdBannerView.h"

@interface EEAdBannerView()

- (void)initializeAdArrayFromPlist;
- (void)cycleAd;
- (void)adBannerTimerExpired;

@end

@implementation EEAdBannerView

@synthesize adBannerCycleMode   = _adBannerCycleMode;
@synthesize adBannerDisplayTime = _adBannerDisplayTime;
- (id)init
{
    if (self = [super init]) {
        //Google analytics ad tracking
//        tracker = [[GAI sharedInstance] defaultTracker];
        
        [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height , 320, 50)];
        
        [self setUserInteractionEnabled:NO];
        self.adBannerCycleMode = kAdBannerCycleModeNormal;
        self.adBannerDisplayTime = 30.0;
        
        [self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]];
        [self initializeAdArrayFromPlist];
    }
    return self;
}

- (void)loadAdBanner
{
    // If the ad dictionary is empty do not show the banner
    if (adBannerDictionary.count == 0) {
        NSLog(@"<EEAdBannerView> loadAdBanner Error: no ads to load");
        return;
    }
    
    // refresh ad
    [self cycleAd];
    
    // start the timer
    adBannerTimer = [NSTimer scheduledTimerWithTimeInterval:self.adBannerDisplayTime
                                                     target:self
                                                   selector:@selector(adBannerTimerExpired)
                                                   userInfo:nil
                                                    repeats:NO];
    
    // slide the ad banner onto the screen
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, 320, 50)];
                     }];

}

- (void)unloadAdBanner
{
    // Cancel the ad banner timer
    [adBannerTimer invalidate];
    
    // slide the ad banner off of the screen
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, 50)];
                     }];
}

- (void)cycleAd
{
    if (self.adBannerCycleMode == kAdBannerCycleModeNormal) {
        [self setTag:[self tag] + 1];
    }
    else {
        [self setTag:arc4random()%4 + 1];
    }
    
    if ([self tag] > adBannerDictionary.count || [self tag] < 1) {
        [self setTag:1];
    }
    NSString *key = [NSString stringWithFormat:@"ad%d", [self tag]];
    [self setImage:[UIImage imageNamed:[[adBannerDictionary objectForKey:key] objectAtIndex:0]]];
}

- (void)initializeAdArrayFromPlist
{
    NSString *error;
    NSString *adBannerPlistPath = [[NSBundle mainBundle] pathForResource:@"EEAdBanners" ofType:@"plist"];
    NSPropertyListFormat format;
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:adBannerPlistPath];
    
    NSDictionary *tempDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML
                                                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                                        format:&format
                                                                              errorDescription:&error];
    if (!tempDict) {
        NSLog(@"<EEAdBannerView> initializeAdArrayFromPlist Error: %@, Format: %d", error, format);
        return;
    }
    adBannerDictionary = tempDict;
    [self setUserInteractionEnabled:YES];
}

- (void)adBannerTimerExpired
{
    [self cycleAd];
    adBannerTimer = [NSTimer scheduledTimerWithTimeInterval:self.adBannerDisplayTime
                                                     target:self
                                                   selector:@selector(adBannerTimerExpired)
                                                   userInfo:nil
                                                    repeats:NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSString *key = [NSString stringWithFormat:@"ad%d", [self tag]];
    
    //Google analytics ad tracking
//    [tracker sendEventWithCategory:@"uiAction" withAction:@"adTap" withLabel:[[adBannerDictionary objectForKey:key] objectAtIndex:0] withValue:nil];
    
    // Open ad link
    NSURL *url = [NSURL URLWithString:[[adBannerDictionary objectForKey:key] objectAtIndex:1]];
    if (url) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
