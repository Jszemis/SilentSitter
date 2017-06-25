//
//  Planet.m
//  mutiltest
//
//  Created by Lizzie Szemis on 16/10/12.
//
//

#import "Planet.h"
#import "RocketViewController.h"

@implementation Planet

@synthesize rocketView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)DrawEllipse:(float) parCenterX :(float) parCenterY :(float) parHieght :(float) parWidth :(float) parAngle :(float)parDuration{
    
    float WestX = parCenterX - parWidth * cos(degreesToRadians(parAngle));
    float WestY = parCenterY - parWidth * sin(degreesToRadians(parAngle));
    
    float NorthX = parCenterX + parHieght * sin(degreesToRadians(parAngle));
    float NorthY = parCenterY - parHieght * cos(degreesToRadians(parAngle));
    
    float EastX = parCenterX + parWidth * cos(degreesToRadians(parAngle));
    float EastY = parCenterY + parWidth * sin(degreesToRadians(parAngle));
    
    float SouthX = parCenterX - parHieght * sin(degreesToRadians(parAngle));
    float SouthY = parCenterY + parHieght * cos(degreesToRadians(parAngle));
    
    float NorthWestX = WestX + parHieght * sin(degreesToRadians(parAngle));
    float NorthWestY = WestY - parHieght * cos(degreesToRadians(parAngle));
    
    float NorthEastX = NorthX + parWidth * cos(degreesToRadians(parAngle));
    float NorthEastY = NorthY + parWidth * sin(degreesToRadians(parAngle));
    
    float SouthEastX = EastX - parHieght * sin(degreesToRadians(parAngle));
    float SouthEastY = EastY + parHieght * cos(degreesToRadians(parAngle));
    
    float SouthWestX = SouthX - parWidth * cos(degreesToRadians(parAngle));
    float SouthWestY = SouthY - parWidth * sin(degreesToRadians(parAngle));
    
    UIBezierPath *linePath;
    linePath = [UIBezierPath bezierPath];
    
    [linePath moveToPoint:CGPointMake(WestX, WestY)];
    [linePath addQuadCurveToPoint:CGPointMake(SouthX, SouthY) controlPoint:CGPointMake(SouthWestX, SouthWestY)];
    [linePath addQuadCurveToPoint:CGPointMake(EastX, EastY) controlPoint:CGPointMake(SouthEastX, SouthEastY)];
    [linePath addQuadCurveToPoint:CGPointMake(NorthX, NorthY) controlPoint:CGPointMake(NorthEastX, NorthEastY)];
    [linePath addQuadCurveToPoint:CGPointMake(WestX, WestY) controlPoint:CGPointMake(NorthWestX, NorthWestY)];    

    CAKeyframeAnimation *hookAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    hookAnimation.path = linePath.CGPath;
    hookAnimation.rotationMode = Nil;
    hookAnimation.duration = parDuration;
    hookAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:hookAnimation forKey:@"hookAnimation"];
    
}

- (IBAction) clickPlanet: (id) sender {

    [NSTimer scheduledTimerWithTimeInterval:1.2
                                     target:self
                                   selector:@selector(addRocketViewController)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)addRocketViewController{

    NSString *outputLable = @"RocketViewController";
    RocketViewController *testView = [[RocketViewController alloc]initWithNibName:outputLable bundle:nil];
    self.rocketView = testView;
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.5];
     //   [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.window cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.window cache:YES];
    testView.view.layer.name = @"rocketship";
    [self.superview addSubview:testView.view];
    [UIView commitAnimations];
    [testView RocketLandscape:self.titleLabel.text];
    
}


@end



