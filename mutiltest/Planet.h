//
//  Planet.h
//  mutiltest
//
//  Created by Lizzie Szemis on 16/10/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define degreesToRadians(x) (M_PI * x / 180.0)
@class Planet;
@class RocketViewController;

@interface Planet : UIButton{
    RocketViewController *rocketView;
}

@property (strong, nonatomic) RocketViewController *rocketView;

-(void)DrawEllipse:(float) parCenterX :(float) parCenterY :(float) parHieght :(float) parWidth :(float) parAngle :(float)parDuration;
- (IBAction)clickPlanet:(id)sender;
-(void)addRocketViewController;

@end
