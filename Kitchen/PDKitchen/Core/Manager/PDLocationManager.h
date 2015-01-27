//
//  PDLocationManager.h
//  PDKitchen
//
//  Created by bright on 15/1/27.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^PDLocationDidUpdateLocation)(CLLocation *currentLocation);
typedef void(^PDLocationDidFail)(NSError *error);

@interface PDLocationManager : NSObject

+(PDLocationManager *)sharedInstance;

- (void)setDidUpdateLocationBlock:(PDLocationDidUpdateLocation)block;
- (void)setDidFailBlock:(PDLocationDidFail)block;

-(void)startUpdate;

@end
