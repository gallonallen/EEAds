//
//  EEAdBannerView.h
//  HASA Quarterly
//
//  Created by Sean Allen on 7/11/13.
//  Copyright (c) 2013 Enyalios Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GAI.h"

enum adBannerCycleModes{
    kAdBannerCycleModeNormal,
    kAdBannerCycleModeRandom
};

@interface EEAdBannerView : UIImageView {
    // Google analytics add tracking
//    id<GAITracker> tracker;
    
    NSDictionary *adBannerDictionary;
    NSTimer      *adBannerTimer;

    double adBannerDisplayTime;
    BOOL   adBannerCycleMode;
    
}

@property (nonatomic) double adBannerDisplayTime;
@property (nonatomic) BOOL   adBannerCycleMode;

- (void)loadAdBanner;
- (void)unloadAdBanner;

@end
