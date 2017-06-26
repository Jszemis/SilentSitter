//
//  RocketViewController.h
//  mutiltest
//
//  Created by Lizzie Szemis on 17/10/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RocketViewController : UIViewController
<UIAccelerometerDelegate, CAAnimationDelegate> {
    
    CAShapeLayer *arrivePlanet;
    CGPoint delta;
    CGPoint translation;
    int starCounter;
    NSString *planetMainColour;
    UIAccelerometer *spaceshipAccelerometer;
    NSTimer *zoomSpaceshipTimer;
    NSTimer *planetArriveTimer;
    NSTimer *createStarsTimer;
    NSTimer *planetEarthLeaveTimer;
    NSTimer *SpaceshipShadowTimer;
    
}

@property (nonatomic, strong) IBOutlet UIImageView *Astronaut;
@property (nonatomic, strong) IBOutlet UIImageView *Rocket;
@property (nonatomic, strong) IBOutlet UIImageView *liftOff;
@property (nonatomic, strong) IBOutlet UIImageView *PlanetLanding;
@property (nonatomic, strong) IBOutlet UIImageView *PlanetLandingBackground;
@property (nonatomic, strong) IBOutlet UIImageView *SpaceshipShadow;

-(void)createStars;
-(void)startAccelerometer;
- (void)accelerometer:(UIAccelerometer *)acel
        didAccelerate:(UIAcceleration *)acceleration;
-(void)RocketLandscape:(NSString*)planetColour;
-(void)planetEarthLeave:(id)sender;
-(void)planetArrive:(id)sender;
-(void)spaceShipCloseDoor;
-(void)moveStars;

@end




