//
//  MultiboxAppDelegate.h
//  mutiltest
//
//  Created by Lizzie Szemis on 2/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class SheepViewController;
@class SnowViewController;
@class BeeViewController;
@class VehicleViewController;
@class FishViewController;
@class SpaceViewController;
@class RocketViewController;
@class CoverViewController;
@class ChristmasViewController;
@class RaceViewController;
@class HouseViewController;

@interface MultiboxAppDelegate : UIResponder <UIApplicationDelegate>{ 
    SheepViewController *sheepView;
    SnowViewController *snowView;
    BeeViewController *beeView;
    VehicleViewController *vehicleView;
    FishViewController *fishView;
    RocketViewController *rocketView;
    CoverViewController *coverView;
    ChristmasViewController *christmasView;
    RaceViewController *raceView;
    HouseViewController *houseView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SheepViewController *sheepView;
@property (strong, nonatomic) SnowViewController *snowView;
@property (strong, nonatomic) BeeViewController *beeView;
@property (strong, nonatomic) VehicleViewController *vehicleView;
@property (strong, nonatomic) FishViewController *fishView;
@property (strong, nonatomic) SpaceViewController *spaceView;
@property (strong, nonatomic) RocketViewController *rocketView;
@property (strong, nonatomic) CoverViewController *coverView;
@property (strong, nonatomic) ChristmasViewController *christmasView;
@property (strong, nonatomic) RaceViewController *raceView;
@property (strong, nonatomic) HouseViewController *houseView;
@property (strong, nonatomic) NSMutableArray *viewArray1;
@property (strong, nonatomic) NSMutableArray *viewArray2;
@property int totalScreenNumber; 

-(void)switchRandom:(NSString *)testlabel;
-(void)switchCover;
    
@end
