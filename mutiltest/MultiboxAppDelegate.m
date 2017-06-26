//
//  MultiboxAppDelegate.m
//  mutiltest
//
//  Created by Lizzie Szemis on 2/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiboxAppDelegate.h"
#import "SheepViewController.h"
#import "SnowViewController.h"
#import "BeeViewController.h"
#import "VehicleViewController.h"
#import "FishViewController.h"
#import "SpaceViewController.h"
#import "RocketViewController.h"
#import "CoverViewController.h"
#import "ChristmasViewController.h"
#import "RaceViewController.h"
#import "HouseViewController.h"

@implementation MultiboxAppDelegate

@synthesize window = _window;
@synthesize sheepView, snowView, beeView, vehicleView, fishView, rocketView, coverView, christmasView, raceView, houseView;
@synthesize totalScreenNumber;
@synthesize viewArray1 = _viewArray1;
@synthesize viewArray2 = _viewArray2;

  
-(void)switchRandom:(NSString *)testlabel{
    
    NSInteger countScreen = ([_viewArray1 count]);
    int finalScreen = arc4random() % countScreen;
    
    if (finalScreen == (totalScreenNumber - 1) && countScreen == totalScreenNumber){
        finalScreen--;
    }

    NSString *outputLable = [_viewArray1 objectAtIndex:finalScreen];
    NSString *outputOption = outputLable;
    
    outputLable = [NSString stringWithFormat:@"%@%@",outputLable,@"ViewController"];
  
    if(countScreen == 1){
        _viewArray1 = [_viewArray2 mutableCopy];    
        [_viewArray2 removeAllObjects];
        [_viewArray1 addObject:outputOption];
    }else{
        [_viewArray1 removeObject:outputOption];
        [_viewArray2 addObject:outputOption];
    }
  
    //outputOption = @"Rocket";
    //outputLable = @"RocketViewController";

    //outputOption = @"Space";
    //outputLable = @"SpaceViewController";
    
    //outputOption = @"Sheep";
    //outputLable = @"SheepViewController";

    //outputOption = @"Bee";
    //outputLable = @"BeeViewController";

    //outputOption = @"Vehicle";
    //outputLable = @"VehicleViewController";

    //outputOption = @"Fish";
    //outputLable = @"FishViewController";

    //outputOption = @"Snow";
    //outputLable = @"SnowViewController";
    
    //outputOption = @"Cover";
    //outputLable = @"CoverViewController";
 
    //outputOption = @"Christmas";
    //outputLable = @"ChristmasViewController";
  
    //outputOption = @"Race";
    //outputLable = @"RaceViewController";

    //outputOption = @"House";
    //outputLable = @"HouseViewController";
    
    if([outputOption isEqual: @"Sheep"]){
        SheepViewController *testView = [[SheepViewController alloc]initWithNibName:outputLable bundle:nil];
        self.sheepView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }   
    
    if([outputOption isEqual: @"Snow"]){
        SnowViewController *testView = [[SnowViewController alloc]initWithNibName:outputLable bundle:nil];
        self.snowView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }   
    
    if([outputOption isEqual: @"Bee"]){
        BeeViewController *testView = [[BeeViewController alloc]initWithNibName:outputLable bundle:nil];
        self.beeView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }
    
    if([outputOption isEqual: @"Vehicle"]){
        VehicleViewController *testView = [[VehicleViewController alloc]initWithNibName:outputLable bundle:nil];
        self.vehicleView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }
    
    if([outputOption isEqual: @"Fish"]){
        FishViewController *testView = [[FishViewController alloc]initWithNibName:outputLable bundle:nil];
        self.fishView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }
    
    if([outputOption isEqual: @"Space"]){
        SpaceViewController *testView = [[SpaceViewController alloc]initWithNibName:outputLable bundle:nil];
        self.spaceView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }
    
    if([outputOption isEqual: @"Rocket"]){
        RocketViewController *testView = [[RocketViewController alloc]initWithNibName:outputLable bundle:nil];
        self.rocketView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }
    
    if([outputOption isEqual: @"Christmas"]){
        ChristmasViewController *testView = [[ChristmasViewController alloc]initWithNibName:outputLable bundle:nil];
        self.christmasView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }
    
    if([outputOption isEqual: @"Race"]){
        RaceViewController *testView = [[RaceViewController alloc]initWithNibName:outputLable bundle:nil];
        self.raceView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];    
    }
    
    if([outputOption isEqual: @"House"]){
        HouseViewController *testView = [[HouseViewController alloc]initWithNibName:outputLable bundle:nil];
        self.houseView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        testView.view.layer.name = outputOption;
        [_window addSubview:testView.view];
        [UIView commitAnimations];
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    _viewArray1 = [[NSMutableArray alloc] init];
    _viewArray2 = [[NSMutableArray alloc] init];
    
    [_window makeKeyAndVisible];

    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 0.0);
    [_window setTransform:myTransform];

    [_viewArray1 addObject:@"Snow"];
    [_viewArray1 addObject:@"Sheep"];
    [_viewArray1 addObject:@"Bee"];
    [_viewArray1 addObject:@"Vehicle"];
    [_viewArray1 addObject:@"Fish"];
    [_viewArray1 addObject:@"Space"];
    [_viewArray1 addObject:@"Christmas"];
    [_viewArray1 addObject:@"Race"];
    [_viewArray1 addObject:@"House"];
    
    totalScreenNumber = ((int)[_viewArray1 count]);

    [self switchCover];
    
    // Override point for customization after application launch.
    return YES;
}


-(void)switchCover{

        CoverViewController *testView = [[CoverViewController alloc]initWithNibName:@"CoverViewController" bundle:nil];
        self.coverView = testView;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
        [_window addSubview:testView.view];
        [UIView commitAnimations];
        self.coverView = nil;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
