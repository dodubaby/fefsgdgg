//
//  PDLocationManager.m
//  PDKitchen
//
//  Created by bright on 15/1/27.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDLocationManager.h"


@interface PDLocationManager()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *manager;

@property (nonatomic,copy) PDLocationDidUpdateLocation onLocationSuccess;
@property (nonatomic,copy) PDLocationDidFail onLocationFailure;

@end

@implementation PDLocationManager

+(PDLocationManager *)sharedInstance{
    static dispatch_once_t once;
    static PDLocationManager * __singleton = nil;
    dispatch_once( &once, ^{ __singleton = [[PDLocationManager alloc] init]; } );
    return __singleton;
}


- (void)setDidUpdateLocationBlock:(PDLocationDidUpdateLocation)block{

    if (block) {
        _onLocationSuccess = [block copy];
    }
}

- (void)setDidFailBlock:(PDLocationDidFail)block{

    if (block) {
        _onLocationFailure = [block copy];
    }
}

-(void)startUpdate{

    self.manager = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy  = kCLLocationAccuracyNearestTenMeters;
    self.manager.delegate = self;

    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL sel = @selector(requestWhenInUseAuthorization);
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined && [self.manager respondsToSelector:sel]) {
        [self.manager performSelector:sel];
    } else {
        [self.manager startUpdatingLocation];
    }
#else
    [self.manager startUpdatingLocation];
#pragma clang diagnostic pop
#pragma clang diagnostic pop
#endif
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    self.onLocationSuccess(locations.lastObject);
    
    [self.manager stopUpdatingLocation];
    self.manager.delegate = nil;
    self.manager = nil;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

    self.onLocationFailure(error);
    
    [self.manager stopUpdatingLocation];
    self.manager.delegate = nil;
    self.manager = nil;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self.manager startUpdatingLocation];
}

@end
