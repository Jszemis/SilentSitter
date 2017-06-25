//
//  SpaceViewController.h
//  mutiltest
//
//  Created by Lizzie Szemis on 15/10/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Planet.h"


@interface SpaceViewController : UIViewController <UIGestureRecognizerDelegate> {
    CADisplayLink *gameloop;
    NSTimer *zoomPlanetTimer;
}

@property (nonatomic,strong) IBOutlet Planet *RedPlanet;
@property (nonatomic,strong) IBOutlet Planet *BluePlanet;
@property (nonatomic,strong) IBOutlet Planet *PurplePlanet;
@property (nonatomic,strong) IBOutlet Planet *GreyPlanet;
@property (nonatomic,strong) IBOutlet Planet *GreenPlanet;
@property (nonatomic,strong) IBOutlet Planet *YellowPlanet;
@property (nonatomic,strong) IBOutlet UIButton *Solar;
@property (nonatomic,strong) IBOutlet UIImageView *EarthPlanet;
@property (nonatomic,strong) IBOutlet UIImageView *Space;

-(void)PlanetVisibility:(float) parMinX :(float) parMaxX :(float) parMinY :(float) parMaxY :(float) parMinX2 :(float) parMaxX2 :(float) parMinY2 :(float) parMaxY2 :(Planet*) parPlanet;
-(void)UpdatePlanetVisibility;
-(IBAction)clickHomePlanet:(id)sender;
-(void)removePlanetLayers;
-(void)zoomPlanet;
    
@end