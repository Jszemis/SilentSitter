//
//  SnowViewController.h
//  mutiltest
//
//  Created by Lizzie Szemis on 5/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnowViewController : UIViewController <UIGestureRecognizerDelegate> {
    float skierX;
    int startSkiing;
    int skijumpStatus;
    int skijumpNumber;
    int disableGesture;
    
    NSTimer *skierTimer;
    NSTimer *skijumpTimer;
    NSTimer *skicollisionTimer;
    NSTimer *skislopeTimer;
}

@property float skierX;
@property int startSkiing;
@property int skijumpStatus;
@property int skijumpNumber;
@property int skijumpTotalNumber;
@property int disableGesture;
@property (nonatomic,strong) IBOutlet UIImageView *skierImage;
@property (nonatomic,strong) IBOutlet UIImageView *skijumpImage;
@property (nonatomic,strong) IBOutlet UIImageView *skislopeImage;

-(void)skiCollison: (id) sender;
-(void)skierMove: (id) sender;
-(void)skierLand: (id) sender;
-(void)skijumpMove: (id) sender;
-(void)skiSlopeMove: (id) sender;
-(void)skierSkid: (id) sender;
-(IBAction)swapViews;

@end