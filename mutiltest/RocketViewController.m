//
//  RocketViewController.m
//  mutiltest
//
//  Created by Lizzie Szemis on 17/10/12.
//
//

#import "RocketViewController.h"
#import "MultiboxAppDelegate.h"

@interface RocketViewController ()

@end

@implementation RocketViewController

@synthesize Rocket;
@synthesize liftOff;
@synthesize PlanetLanding;
@synthesize Astronaut;
@synthesize PlanetLandingBackground;
@synthesize SpaceshipShadow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    self.view.userInteractionEnabled = NO;
    
    delta = CGPointMake(12.0,4.0);
    translation = CGPointMake(0.0,0.0);
    starCounter = 0;

    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(AstronautMove)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:6
                                     target:self
                                   selector:@selector(spaceShipCloseDoor)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:6.5
                                     target:self
                                   selector:@selector(startAccelerometer)
                                   userInfo:nil
                                    repeats:NO];

    
    for( int s = 1; s <= 100; s++){
    
        int createStarRandom = arc4random() % 110;
    
        starCounter++;
        int speedStar = 1;
        
        if(createStarRandom > 0 && createStarRandom <= 5){
            speedStar = 5;
        } else if(createStarRandom > 5 && createStarRandom <= 20){
            speedStar = 4;
        } else if(createStarRandom > 20 && createStarRandom <= 35){
            speedStar = 3;
        } else if(createStarRandom > 35 && createStarRandom <= 60){
            speedStar = 2;
        }
    
        int createStarRandomX = arc4random() % 321;
        int createStarRandomY = arc4random() % 481;
    
        CAShapeLayer *starLayer;
        starLayer = [CAShapeLayer layer];
        starLayer.bounds = CGRectMake(createStarRandomX, createStarRandomY, speedStar,speedStar);
        starLayer.position = CGPointMake(createStarRandomX, createStarRandomY);
        starLayer.contents = (id)([UIImage imageNamed:@"star.png"].CGImage);
        starLayer.name = [NSString stringWithFormat:@"star%i%i%@",speedStar,starCounter,@".png"];
        starLayer.shouldRasterize = YES;
        
        [self.view.layer addSublayer:starLayer];
    }
 
    [self.view bringSubviewToFront:liftOff];
    [self.view bringSubviewToFront:PlanetLanding];    
    [self.view bringSubviewToFront:Astronaut];
    [self.view bringSubviewToFront:Rocket];
 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(RocketEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)RocketEnable{
    
    self.view.userInteractionEnabled = YES;
    
}

-(void)moveStars{
    
    for (CALayer *layer in self.view.layer.sublayers) {
        
        NSString *starName = [layer.name substringWithRange:NSMakeRange(0, 4)];
        NSString *starSpeed = [layer.name substringWithRange:NSMakeRange(4, 1)];
        
        if([starName isEqualToString:@"star"]){

            int moonInitialX = layer.position.x;
            int moonInitialY = layer.position.y;
            
            CGMutablePathRef aPath;
            CGFloat duration = ([starSpeed intValue] - 6) * -10;    
            aPath = CGPathCreateMutable();
            
            CGPathMoveToPoint(aPath, NULL, moonInitialX, moonInitialY);
            CGPathAddLineToPoint(aPath,NULL, moonInitialX, moonInitialY+600);
            
            CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
            
            [arcAnimation setDuration: duration];
            [arcAnimation setAutoreverses: NO];
            arcAnimation.removedOnCompletion = NO;
            arcAnimation.fillMode = kCAFillModeBoth;
            arcAnimation.delegate = self;
            [arcAnimation setPath: aPath];
            
            CFRelease(aPath);
            
            [layer addAnimation: arcAnimation forKey: @"moonAnimation"];
            
        }
        
    }
    
}



-(void)createStars{

    int createStarRandom = arc4random() % 200;
    
    if(createStarRandom < 110){
        
        starCounter++;
        int speedStar = 1;
        
        if(createStarRandom > 0 && createStarRandom <= 5){
            speedStar = 5;
        } else if(createStarRandom > 5 && createStarRandom <= 20){
            speedStar = 4;
        } else if(createStarRandom > 20 && createStarRandom <= 35){
            speedStar = 3;
        } else if(createStarRandom > 35 && createStarRandom <= 60){
            speedStar = 2;
        }
              
        int createStarRandomX = arc4random() % 321;
        
        CAShapeLayer *starLayer;
        starLayer = [CAShapeLayer layer];
        starLayer.bounds = CGRectMake(createStarRandomX, -10, speedStar,speedStar);
        starLayer.position = CGPointMake(createStarRandomX, 0);
        starLayer.contents = (id)([UIImage imageNamed:@"star.png"].CGImage);
        starLayer.name = [NSString stringWithFormat:@"star%i%i%@",speedStar,starCounter,@".png"];

        [self.view.layer addSublayer:starLayer];

        int moonInitialX = createStarRandomX;
        int moonInitialY = -10;
        
        CGMutablePathRef aPath;
        CGFloat duration = (speedStar - 6) * -10;
        
        aPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(aPath, NULL, moonInitialX, moonInitialY);
        CGPathAddLineToPoint(aPath,NULL, moonInitialX, moonInitialY+600);
        
        CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [arcAnimation setDuration: duration];
        [arcAnimation setAutoreverses: NO];
        arcAnimation.removedOnCompletion = NO;
        arcAnimation.fillMode = kCAFillModeBoth;
        arcAnimation.delegate = self;
        [arcAnimation setPath: aPath];
        
        CFRelease(aPath);
        
        [starLayer addAnimation: arcAnimation forKey: @"moonAnimation"];
              
        [self.view bringSubviewToFront:PlanetLanding];
        
        
        
        
    }
    
    [self.view bringSubviewToFront:Rocket];
   
}

-(void)AstronautMove{
    
    float astronautAnimationDuration = 1;
    float astronautRepeat = 4;
    NSArray *astronautArray;
    astronautArray = [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"astronaut-frame1.png"],
                      [UIImage imageNamed:@"astronaut-frame2.png"],
                      [UIImage imageNamed:@"astronaut-frame1.png"],
                      [UIImage imageNamed:@"astronaut-frame3.png"],
                      nil
                      ];
    
    Astronaut.animationImages=astronautArray;
    [Astronaut setAnimationDuration:astronautAnimationDuration];
    [Astronaut setAnimationRepeatCount:astronautRepeat];
    [Astronaut startAnimating];
    
    CGMutablePathRef aPath;
    CGFloat astronautDuration = astronautAnimationDuration * astronautRepeat;
    
    aPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, NULL, -30, 445);
    CGPathAddLineToPoint(aPath,NULL, 100, 445);
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: astronautDuration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
   
    [[Astronaut layer] addAnimation: arcAnimation forKey: @"AstronautAnimation"];
        
    [NSTimer scheduledTimerWithTimeInterval:astronautDuration
                                     target:self
                                   selector:@selector(AstronautJump)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)AstronautJump{
   
    CGMutablePathRef aPath;
    CGFloat astronautjumpDuration = 1;
    
    aPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, NULL, 100, 445);
    CGPathAddCurveToPoint(aPath, NULL, 120, 380, 120, 380, 160, 410);
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: astronautjumpDuration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
    
    [[Astronaut layer] addAnimation: arcAnimation forKey: @"AstronautAnimation"];

}

-(void)startAccelerometer{
    
    spaceshipAccelerometer = [[CMMotionManager alloc] init];
    spaceshipAccelerometer.accelerometerUpdateInterval = 0.015;
    
    [spaceshipAccelerometer startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        
        NSLog(@"spaceshipAccelerometer");
            float rocketHeight = Rocket.frame.size.height / 2;
            float rocketWidth = Rocket.frame.size.width / 2;
        
            if (accelerometerData.acceleration.x>0) delta.x = 1; else delta.x = -1;
            if (accelerometerData.acceleration.y>0) delta.y = -1; else delta.y = 1;
        
            if (Rocket.center.x > 320 - rocketWidth && delta.x == 1){
                delta.x = 0;
            }
        
            if (Rocket.center.x < rocketWidth && delta.x == -1) {
                delta.x = 0;
            }
        
            if (Rocket.center.y > 465 - rocketHeight && delta.y == 1){
                delta.y = 0;
            }
        
            if (Rocket.center.y < 200 && delta.y == -1){
                delta.y = 0;
            }
            
            Rocket.center = CGPointMake(Rocket.center.x + delta.x,Rocket.center.y + delta.y);
    }];
    
    
    CGMutablePathRef aPath;
    CGFloat astronautjumpDuration = 0.1;
    aPath = CGPathCreateMutable();
    CGPathMoveToPoint(aPath, NULL, 10, 10);

    CAKeyframeAnimation* removeAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [removeAnimation setDuration: astronautjumpDuration];
    [removeAnimation setAutoreverses: NO];
    removeAnimation.removedOnCompletion = NO;
    removeAnimation.fillMode = kCAFillModeBoth;
    removeAnimation.delegate = self;
    [removeAnimation setPath: aPath];
    
    CFRelease(aPath);
    [[Astronaut layer] addAnimation: removeAnimation forKey: @"AstronautAnimation"];

    [NSTimer scheduledTimerWithTimeInterval:0.06
                                    target:self
                                  selector:@selector(planetEarthLeave:)
                                  userInfo:nil
                                   repeats:NO];

    [NSTimer scheduledTimerWithTimeInterval:0.04
                                     target:self
                                   selector:@selector(animateRocket:)
                                   userInfo:nil
                                    repeats:NO];

    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(planetArrive:)
                                   userInfo:nil
                                    repeats:NO];

    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(moveStars)
                                   userInfo:nil
                                    repeats:NO];
   
    createStarsTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(createStars)
                                   userInfo:nil
                                    repeats:YES];

    
}

//- (void)accelerometer:(UIAccelerometer *)acel
//        didAccelerate:(UIAcceleration *)acceleration {
//    
//    float rocketHeight = Rocket.frame.size.height / 2;
//    float rocketWidth = Rocket.frame.size.width / 2;
//   
//    if (acceleration.x>0) delta.x = 1; else delta.x = -1;
//    if (acceleration.y>0) delta.y = -1; else delta.y = 1;
//
//    if (Rocket.center.x > 320 - rocketWidth && delta.x == 1){
//        delta.x = 0;
//    }
//        
//    if (Rocket.center.x < rocketWidth && delta.x == -1) {
//        delta.x = 0;
//    }
//    
//    if (Rocket.center.y > 465 - rocketHeight && delta.y == 1){
//        delta.y = 0;
//    }
//    
//    if (Rocket.center.y < 200 && delta.y == -1){
//        delta.y = 0;
//    }
//    
//    Rocket.center = CGPointMake(Rocket.center.x + delta.x,Rocket.center.y + delta.y);
//
//}

-(void)RocketLandscape:(NSString*)planetColour{

    NSString *planetname = [NSString stringWithFormat:@"planet%@%@",planetColour,@"Big.png"];
    PlanetLanding.frame = CGRectMake(35, -250, 250, 250);
    planetMainColour = planetColour;
    
    if([planetColour isEqualToString:@"yellow"]){
        PlanetLanding.frame = CGRectMake(20, -132, 300, 132);
    }
    
    [PlanetLanding setImage:[UIImage imageNamed:planetname]];
    [self.view bringSubviewToFront:PlanetLanding];
      
}

-(void)spaceShipCloseDoor{
    
    [Rocket setImage:[UIImage imageNamed:@"spaceship-Frame02.png"]];
    
}

-(void)animateRocket:(id)sender{
    
    float spaceshipDuration = 0.4;
    NSArray *spaceshipArray;
    spaceshipArray = [[NSArray alloc] initWithObjects:
                  [UIImage imageNamed:@"spaceship-Frame03.png"],
                  [UIImage imageNamed:@"spaceship-Frame04.png"],
                  [UIImage imageNamed:@"spaceship-Frame05.png"],
                  nil
                  ];
    
    Rocket.animationImages=spaceshipArray;
    [Rocket setAnimationDuration:spaceshipDuration];
    [Rocket setAnimationRepeatCount:HUGE_VALF];
    [Rocket startAnimating];
  
}

-(void)planetEarthLeave:(id)sender{
    
    int moonInitialX = liftOff.center.x;
    int moonInitialY = liftOff.center.y;
    
    CGMutablePathRef aPath;
    CGFloat duration = 4;
    
    aPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, NULL, moonInitialX, moonInitialY);
    CGPathAddLineToPoint(aPath,NULL, moonInitialX, moonInitialY+400);
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
    
    [liftOff.layer addAnimation: arcAnimation forKey: @"moonAnimation"];
    
    
}

-(void)planetArrive:(id)sender{
    
    int moonInitialX = PlanetLanding.center.x;
    int moonInitialY = -150;
    
    CGMutablePathRef aPath;
    CGFloat duration = 3;
    
    aPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, NULL, moonInitialX, moonInitialY);
    CGPathAddLineToPoint(aPath,NULL, moonInitialX, moonInitialY+200);
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
    
    [PlanetLanding.layer addAnimation: arcAnimation forKey: @"moonAnimation"];
    
    [NSTimer scheduledTimerWithTimeInterval:4
                                     target:self
                                   selector:@selector(spaceshipLands:)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)spaceshipLands:(id)sender{
 
    [spaceshipAccelerometer stopAccelerometerUpdates];
    
    CGMutablePathRef landingPath;
    CGFloat landingDuration = 2;
    
    landingPath = CGPathCreateMutable();

    CGPathMoveToPoint(landingPath, NULL, Rocket.frame.origin.x + (Rocket.frame.size.width / 2), Rocket.frame.origin.y + (Rocket.frame.size.height / 2));
    CGPathAddLineToPoint(landingPath,NULL, 160, 50);
    
    CAKeyframeAnimation* landingAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [landingAnimation setDuration: landingDuration];
    [landingAnimation setAutoreverses: NO];
    landingAnimation.removedOnCompletion = NO;
    landingAnimation.fillMode = kCAFillModeBoth;
    landingAnimation.delegate = self;
    [landingAnimation setPath: landingPath];
    CFRelease(landingPath);

    [[Rocket layer] addAnimation: landingAnimation forKey: @"LandingAnimation"];
    
    
     zoomSpaceshipTimer = [NSTimer scheduledTimerWithTimeInterval:0.015
                                      target:self
                                    selector:@selector(zoomSpaceship)
                                    userInfo:nil
                                     repeats:YES];
   
     [NSTimer scheduledTimerWithTimeInterval:3
                                     target:self
                                   selector:@selector(spaceshipPlanetLandingBackground)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)zoomSpaceship{

     float spaceshipInitialX = Rocket.frame.origin.x;
     float spaceshipInitialY = Rocket.frame.origin.y;
     float spaceshipImageHieght = Rocket.frame.size.height-1.17;
     float spaceshipImageWidth = Rocket.frame.size.width-0.96;
     Rocket.frame = CGRectMake(spaceshipInitialX, spaceshipInitialY, spaceshipImageWidth, spaceshipImageHieght);

}

-(void)spaceshipPlanetLandingBackground{
    
    
    [planetArriveTimer invalidate];
    [zoomSpaceshipTimer invalidate];
    [createStarsTimer invalidate];
    [planetEarthLeaveTimer invalidate];
    
    NSString *planetbackground = [NSString stringWithFormat:@"planetbackground%@%@",planetMainColour,@".png"];
    
    [PlanetLandingBackground setImage:[UIImage imageNamed:planetbackground]];
    [self.view bringSubviewToFront:PlanetLandingBackground];
    
    Rocket.frame = CGRectMake(130, -150, 96, 117);
    
    CGMutablePathRef landingPath;
    CGFloat landingDuration = 5;
    
    landingPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(landingPath, NULL, 135, -150);
    CGPathAddLineToPoint(landingPath,NULL, 135, 310);
    
    CAKeyframeAnimation* landingAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [landingAnimation setDuration: landingDuration];
    [landingAnimation setAutoreverses: NO];
    landingAnimation.removedOnCompletion = NO;
    landingAnimation.fillMode = kCAFillModeBoth;
    landingAnimation.delegate = self;
    [landingAnimation setPath: landingPath];
    CFRelease(landingPath);
    
    [[Rocket layer] addAnimation: landingAnimation forKey: @"LandingAnimation"];
    
    SpaceshipShadow.frame = CGRectMake(135, 368, 0.01, 0.01);
    
    SpaceshipShadowTimer = [NSTimer scheduledTimerWithTimeInterval:landingDuration/100
                                                            target:self
                                                          selector:@selector(SpaceshipShadowZoom)
                                                          userInfo:nil
                                                           repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:landingDuration + 1
                                     target:self
                                   selector:@selector(spaceShipOpenDoor)
                                   userInfo:nil
                                    repeats:NO];
    
    if([planetMainColour isEqualToString:@"red"]){
        
        for(int i = 0; i <= 4; i++){
        
            int alienredX = 0;
            int alienredY = 0;
            int alienWidth = 0;
            int alienHeight = 0;
            
            if(i ==0){
                //super closest
                alienredX = 255;
                alienredY = 420;
                alienWidth = 64;
                alienHeight = 112;
            }else if(i == 1){
                //closest
                alienredX = 200;
                alienredY = 400;
                alienWidth = 32;
                alienHeight = 56;
            }else if(i == 2){
                //mid
                alienredX = 250;
                alienredY = 350;
                alienWidth = 24;
                alienHeight = 42;
            }else if(i == 3){
                //far away
                alienredX = 280;
                alienredY = 300;
                alienWidth = 16;
                alienHeight = 28;
            }else if(i == 4){
                //far away2
                alienredX = 300;
                alienredY = 303;
                alienWidth = 16;
                alienHeight = 28;
            }
            
            UIImageView *alienred = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alienred-frame6.png"]];
            alienred.frame = CGRectMake(alienredX, alienredY, alienWidth, alienHeight);
            [self.view addSubview:alienred];
            
            float alienredDuration = 10;
            NSArray *alienredArray;
            alienredArray = [[NSArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"alienred-frame1.png"],
                                  [UIImage imageNamed:@"alienred-frame1.png"],
                                  [UIImage imageNamed:@"alienred-frame1.png"],
                                  [UIImage imageNamed:@"alienred-frame2.png"],
                                  [UIImage imageNamed:@"alienred-frame2.png"],
                                  [UIImage imageNamed:@"alienred-frame2.png"],
                                  [UIImage imageNamed:@"alienred-frame3.png"],
                                  [UIImage imageNamed:@"alienred-frame3.png"],
                                  [UIImage imageNamed:@"alienred-frame3.png"],
                                  [UIImage imageNamed:@"alienred-frame4.png"],
                                  [UIImage imageNamed:@"alienred-frame4.png"],
                                  [UIImage imageNamed:@"alienred-frame4.png"],
                                  [UIImage imageNamed:@"alienred-frame5.png"],
                                  [UIImage imageNamed:@"alienred-frame5.png"],
                                  [UIImage imageNamed:@"alienred-frame5.png"],
                                  [UIImage imageNamed:@"alienred-frame6.png"],                                  
                                  [UIImage imageNamed:@"alienred-frame6.png"],
                                  [UIImage imageNamed:@"alienred-frame6.png"],
                                  [UIImage imageNamed:@"alienred-frame7.png"],

                                  [UIImage imageNamed:@"alienred-frame8.png"],
                                  [UIImage imageNamed:@"alienred-frame7.png"],
                                  [UIImage imageNamed:@"alienred-frame8.png"],
                                  [UIImage imageNamed:@"alienred-frame7.png"],
                                  [UIImage imageNamed:@"alienred-frame8.png"],
                                  [UIImage imageNamed:@"alienred-frame7.png"],
                                  [UIImage imageNamed:@"alienred-frame8.png"],
                                  
                                  [UIImage imageNamed:@"alienred-frame6.png"],
                                  nil
                                  ];
            
            alienred.animationImages=alienredArray;
            [alienred setAnimationDuration:alienredDuration];
            [alienred setAnimationRepeatCount:1];
            [alienred startAnimating];
            
        }
    }
    
    
    if([planetMainColour isEqualToString:@"purple"]){
     
        UIImageView *alienpurple = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purplestation-frame28.png"]];
        alienpurple.frame = CGRectMake(216, 202, 82, 172);
        [self.view addSubview:alienpurple];
        
        float alienpurpleDuration = 11;
        NSArray *alienpurpleArray;
        alienpurpleArray = [[NSArray alloc] initWithObjects:
                              [UIImage imageNamed:@"purplestation-frame01.png"],
                              [UIImage imageNamed:@"purplestation-frame02.png"],
                              [UIImage imageNamed:@"purplestation-frame03.png"],
                              [UIImage imageNamed:@"purplestation-frame01.png"],
                              [UIImage imageNamed:@"purplestation-frame02.png"],
                              [UIImage imageNamed:@"purplestation-frame03.png"],
                              [UIImage imageNamed:@"purplestation-frame01.png"],
                              [UIImage imageNamed:@"purplestation-frame02.png"],
                              [UIImage imageNamed:@"purplestation-frame03.png"],
                              [UIImage imageNamed:@"purplestation-frame01.png"],
                              [UIImage imageNamed:@"purplestation-frame02.png"],
                              [UIImage imageNamed:@"purplestation-frame03.png"],
                              [UIImage imageNamed:@"purplestation-frame01.png"],
                              [UIImage imageNamed:@"purplestation-frame02.png"],
                              [UIImage imageNamed:@"purplestation-frame03.png"],
                              [UIImage imageNamed:@"purplestation-frame01.png"],
                              [UIImage imageNamed:@"purplestation-frame02.png"],
                              [UIImage imageNamed:@"purplestation-frame03.png"],
                              [UIImage imageNamed:@"purplestation-frame01.png"],
                              [UIImage imageNamed:@"purplestation-frame02.png"],
                              [UIImage imageNamed:@"purplestation-frame03.png"],
                            
                              [UIImage imageNamed:@"purplestation-frame04.png"],
                              [UIImage imageNamed:@"purplestation-frame05.png"],
                              [UIImage imageNamed:@"purplestation-frame06.png"],
                              [UIImage imageNamed:@"purplestation-frame07.png"],
                              [UIImage imageNamed:@"purplestation-frame08.png"],
                              [UIImage imageNamed:@"purplestation-frame09.png"],
                              [UIImage imageNamed:@"purplestation-frame10.png"],
                              [UIImage imageNamed:@"purplestation-frame11.png"],
                              [UIImage imageNamed:@"purplestation-frame12.png"],
                              [UIImage imageNamed:@"purplestation-frame13.png"],
                              [UIImage imageNamed:@"purplestation-frame14.png"],
                              [UIImage imageNamed:@"purplestation-frame15.png"],
                              [UIImage imageNamed:@"purplestation-frame16.png"],
                              [UIImage imageNamed:@"purplestation-frame17.png"],
                              [UIImage imageNamed:@"purplestation-frame18.png"],
                              [UIImage imageNamed:@"purplestation-frame19.png"],
                              [UIImage imageNamed:@"purplestation-frame20.png"],
                              [UIImage imageNamed:@"purplestation-frame21.png"],
                              [UIImage imageNamed:@"purplestation-frame22.png"],
                              [UIImage imageNamed:@"purplestation-frame24.png"],
                              [UIImage imageNamed:@"purplestation-frame25.png"],
                            
                              [UIImage imageNamed:@"purplestation-frame26.png"],
                              [UIImage imageNamed:@"purplestation-frame27.png"],
                              [UIImage imageNamed:@"purplestation-frame28.png"],
                              [UIImage imageNamed:@"purplestation-frame26.png"],
                              [UIImage imageNamed:@"purplestation-frame27.png"],
                              [UIImage imageNamed:@"purplestation-frame28.png"],
                              [UIImage imageNamed:@"purplestation-frame26.png"],
                              [UIImage imageNamed:@"purplestation-frame27.png"],
                              [UIImage imageNamed:@"purplestation-frame28.png"],
                              [UIImage imageNamed:@"purplestation-frame26.png"],
                              [UIImage imageNamed:@"purplestation-frame27.png"],
                              [UIImage imageNamed:@"purplestation-frame28.png"],
                              [UIImage imageNamed:@"purplestation-frame26.png"],
                              [UIImage imageNamed:@"purplestation-frame27.png"],
                              [UIImage imageNamed:@"purplestation-frame28.png"],
                              [UIImage imageNamed:@"purplestation-frame26.png"],
                              [UIImage imageNamed:@"purplestation-frame27.png"],
                              [UIImage imageNamed:@"purplestation-frame28.png"],
                            
                              nil
                              ];
        
        alienpurple.animationImages=alienpurpleArray;
        [alienpurple setAnimationDuration:alienpurpleDuration];
        [alienpurple setAnimationRepeatCount:1];
        [alienpurple startAnimating];
        
    }
    
    
    
    if([planetMainColour isEqualToString:@"blue"]){
    
        
        UIImageView *alienblueflight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alienblue-frame05.png.png"]];
        alienblueflight.frame = CGRectMake(240, 345, 30, 26);
        [self.view addSubview:alienblueflight];
        
        float alienblueflightDuration = 1.2;
        NSArray *alienblueflightArray;
        alienblueflightArray = [[NSArray alloc] initWithObjects:
                                [UIImage imageNamed:@"alienblue-frame05.png"],
                                [UIImage imageNamed:@"alienblue-frame04.png"],
                                [UIImage imageNamed:@"alienblue-frame03.png"],
                                [UIImage imageNamed:@"alienblue-frame02.png"],
                                [UIImage imageNamed:@"alienblue-frame01.png"],
                                [UIImage imageNamed:@"alienblue-frame02.png"],
                                [UIImage imageNamed:@"alienblue-frame03.png"],
                                [UIImage imageNamed:@"alienblue-frame04.png"],
                            
                            nil
                            ];
        
        alienblueflight.animationImages=alienblueflightArray;
        [alienblueflight setAnimationDuration:alienblueflightDuration];
        [alienblueflight setAnimationRepeatCount:5];
        [alienblueflight startAnimating];
        
        
        
        UIImageView *alienbluecontroller1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alienblue-frame06.png.png"]];
        alienbluecontroller1.frame = CGRectMake(50, 192, 24, 22);
        [self.view addSubview:alienbluecontroller1];
        
        float alienbluecontroller1Duration = 3;
        NSArray *alienbluecontroller1Array;
        alienbluecontroller1Array = [[NSArray alloc] initWithObjects:
                                [UIImage imageNamed:@"alienblue-frame06.png"],
                                [UIImage imageNamed:@"alienblue-frame06.png"],
                                [UIImage imageNamed:@"alienblue-frame06.png"],                     
                                [UIImage imageNamed:@"alienblue-frame07.png"],
                                [UIImage imageNamed:@"alienblue-frame08.png"],
                                     
                                [UIImage imageNamed:@"alienblue-frame09.png"],
                                [UIImage imageNamed:@"alienblue-frame07.png"],
                                [UIImage imageNamed:@"alienblue-frame08.png"],
                                [UIImage imageNamed:@"alienblue-frame09.png"],
                                [UIImage imageNamed:@"alienblue-frame07.png"],
                                     
                                [UIImage imageNamed:@"alienblue-frame07.png"],
                                [UIImage imageNamed:@"alienblue-frame08.png"],
                                [UIImage imageNamed:@"alienblue-frame09.png"],
                                [UIImage imageNamed:@"alienblue-frame06.png"],
                                [UIImage imageNamed:@"alienblue-frame06.png"],
                                     
                                [UIImage imageNamed:@"alienblue-frame06.png"],  
                                [UIImage imageNamed:@"alienblue-frame08.png"],
                                [UIImage imageNamed:@"alienblue-frame08.png"],
                                [UIImage imageNamed:@"alienblue-frame07.png"],
                                [UIImage imageNamed:@"alienblue-frame08.png"],
                                     
                                nil
                                ];
        
        alienbluecontroller1.animationImages=alienbluecontroller1Array;
        [alienbluecontroller1 setAnimationDuration:alienbluecontroller1Duration];
        [alienbluecontroller1 setAnimationRepeatCount:3];
        [alienbluecontroller1 startAnimating];
        
        UIImageView *alienbluecontroller2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alienblue-frame06.png.png"]];
        alienbluecontroller2.frame = CGRectMake(75, 192, 24, 22);
        [self.view addSubview:alienbluecontroller2];
        
        float alienbluecontroller2Duration = 3;
        NSArray *alienbluecontroller2Array;
        alienbluecontroller2Array = [[NSArray alloc] initWithObjects:
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],    
                                    [UIImage imageNamed:@"alienblue-frame07.png"],
                                    [UIImage imageNamed:@"alienblue-frame08.png"],
                                    [UIImage imageNamed:@"alienblue-frame08.png"],
                                     
                                    [UIImage imageNamed:@"alienblue-frame07.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],                                     
                                    [UIImage imageNamed:@"alienblue-frame07.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                     
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],          
                                    [UIImage imageNamed:@"alienblue-frame08.png"],
                                     
                                    [UIImage imageNamed:@"alienblue-frame09.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                    [UIImage imageNamed:@"alienblue-frame08.png"],
                                    [UIImage imageNamed:@"alienblue-frame06.png"],
                                    [UIImage imageNamed:@"alienblue-frame09.png"],
                                     
                                    nil
                                    ];
        
        alienbluecontroller2.animationImages=alienbluecontroller2Array;
        [alienbluecontroller2 setAnimationDuration:alienbluecontroller2Duration];
        [alienbluecontroller2 setAnimationRepeatCount:3];
        [alienbluecontroller2 startAnimating];
        
        
        for(int i = 1; i <= 4; i++){
            
            int splashblueX = 0;
            int splashblueY = 0;
            
            if(i ==1){
                splashblueX = -3;
                splashblueY = 405;
            }else if(i == 2){
                splashblueX = 75;
                splashblueY = 431;
            }else if(i == 3){
                splashblueX = 177;
                splashblueY = 431;
            }else if(i == 4){
                splashblueX = 259;
                splashblueY = 400;
            }
            
            UIImageView *splashblue = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splashblue-frame4.png"]];
            splashblue.frame = CGRectMake(splashblueX, splashblueY, 12, 4);
            [self.view addSubview:splashblue];
    
            int splashblueArray1 = (arc4random() % 8) + 1;
            int splashblueArray2 = (arc4random() % 8) + 1;
            int splashblueArray3 = (arc4random() % 8) + 1;
            int splashblueArray4 = (arc4random() % 8) + 1;
            int splashblueArray5 = (arc4random() % 8) + 1;
            int splashblueArray6 = (arc4random() % 8) + 1;
            int splashblueArray7 = (arc4random() % 8) + 1;
            int splashblueArray8 = (arc4random() % 8) + 1;
            
            
            float splashblueDuration = 2;
            NSArray *splashblueArray;
            splashblueArray = [[NSArray alloc] initWithObjects:
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray1,@".png"]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray2,@".png"]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray3,@".png"]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray4,@".png"]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray5,@".png"]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray6,@".png"]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray7,@".png"]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"splashblue-frame%i%@",splashblueArray8,@".png"]],
                               
                               nil
                             ];
            
            splashblue.animationImages = splashblueArray;
            [splashblue setAnimationDuration:splashblueDuration];
            [splashblue setAnimationRepeatCount:5];
            [splashblue startAnimating];
            
        }
        
    }
    
    if([planetMainColour isEqualToString:@"grey"]){
        
        UIImageView *cosmonaut = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cosmonaut-frame1.png"]];
        cosmonaut.frame = CGRectMake(240, 345, 18, 29);
        [self.view addSubview:cosmonaut];
        
        float cosmonautDuration = 9;
        NSArray *cosmonautArray;
        cosmonautArray = [[NSArray alloc] initWithObjects:
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],                          
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],                          
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame1.png"],
                          [UIImage imageNamed:@"cosmonaut-frame2.png"],
                          [UIImage imageNamed:@"cosmonaut-frame3.png"],
                          [UIImage imageNamed:@"cosmonaut-frame4.png"],
                          [UIImage imageNamed:@"cosmonaut-frame5.png"],
                          [UIImage imageNamed:@"cosmonaut-frame6.png"],
                          [UIImage imageNamed:@"cosmonaut-frame5.png"],
                          [UIImage imageNamed:@"cosmonaut-frame4.png"],
                          [UIImage imageNamed:@"cosmonaut-frame3.png"],
                          [UIImage imageNamed:@"cosmonaut-frame2.png"],
                          [UIImage imageNamed:@"cosmonaut-frame3.png"],
                          [UIImage imageNamed:@"cosmonaut-frame4.png"],
                          [UIImage imageNamed:@"cosmonaut-frame5.png"],
                          [UIImage imageNamed:@"cosmonaut-frame6.png"],
                          [UIImage imageNamed:@"cosmonaut-frame5.png"],
                          [UIImage imageNamed:@"cosmonaut-frame4.png"],
                          [UIImage imageNamed:@"cosmonaut-frame3.png"],
                          [UIImage imageNamed:@"cosmonaut-frame2.png"],
                          nil
                          ];
        
        cosmonaut.animationImages = cosmonautArray;
        [cosmonaut setAnimationDuration:cosmonautDuration];
        [cosmonaut setAnimationRepeatCount:1];
        [cosmonaut startAnimating];
        
        
        UIImageView *cosmonautforeground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cosmonautforeground.png"]];
        cosmonautforeground.frame = CGRectMake(200, 400, 26, 41);
        [self.view addSubview:cosmonautforeground];
        

        CGMutablePathRef landingPath;
        CGFloat landingDuration = 4;
        
        landingPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(landingPath, NULL, 200, 500);
        CGPathAddLineToPoint(landingPath,NULL, 200, 430);
        
        CAKeyframeAnimation* moonbuggyAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [moonbuggyAnimation setDuration: landingDuration];
        [moonbuggyAnimation setAutoreverses: NO];
        moonbuggyAnimation.removedOnCompletion = NO;
        moonbuggyAnimation.fillMode = kCAFillModeBoth;
        moonbuggyAnimation.delegate = self;
        [moonbuggyAnimation setPath: landingPath];
        CFRelease(landingPath);
        
        [[cosmonautforeground layer] addAnimation: moonbuggyAnimation forKey: @"LandingAnimation"];
        
        UIImageView *craterforeground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craterforeground.png"]];
        craterforeground.frame = CGRectMake(151, 454, 100, 100);
        [self.view addSubview:craterforeground];
        
        UIImageView *moonbuggybody = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moonbuggybody.png"]];
        moonbuggybody.frame = CGRectMake(0, 370, 70, 72);
        [self.view addSubview:moonbuggybody];
 
        UIImageView *moonbuggywheel1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moonbuggywheel.png"]];
        moonbuggywheel1.frame = CGRectMake(0, 428, 26, 26);
        [self.view addSubview:moonbuggywheel1];
        
        UIImageView *moonbuggywheel2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moonbuggywheel.png"]];
        moonbuggywheel2.frame = CGRectMake(40, 428, 26, 26);
        [self.view addSubview:moonbuggywheel2];
        

        CGMutablePathRef landingPath2;
        CGFloat landingDuration2 = 6;
        
        landingPath2 = CGPathCreateMutable();
        
        CGPathMoveToPoint(landingPath2, NULL, -50, 400);
        CGPathAddLineToPoint(landingPath2,NULL, 50, 400);
        
        CAKeyframeAnimation* landingAnimation2 = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [landingAnimation2 setDuration: landingDuration2];
        [landingAnimation2 setAutoreverses: NO];
        landingAnimation2.removedOnCompletion = NO;
        landingAnimation2.fillMode = kCAFillModeBoth;
        landingAnimation2.delegate = self;
        [landingAnimation2 setPath: landingPath2];
        CFRelease(landingPath2);
        
        [[moonbuggybody layer] addAnimation: landingAnimation2 forKey: @"LandingAnimation2"];

        CGMutablePathRef landingPath3;
        CGFloat landingDuration3 = 6;
        
        landingPath3 = CGPathCreateMutable();
        
        CGPathMoveToPoint(landingPath3, NULL, -25, 435);
        CGPathAddLineToPoint(landingPath3,NULL, 65, 435);
        
        CAKeyframeAnimation* landingAnimation3 = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [landingAnimation3 setDuration: landingDuration3];
        [landingAnimation3 setAutoreverses: NO];
        landingAnimation3.removedOnCompletion = NO;
        landingAnimation3.fillMode = kCAFillModeBoth;
        landingAnimation3.delegate = self;
        [landingAnimation3 setPath: landingPath3];
        CFRelease(landingPath3);
        
        [[moonbuggywheel1 layer] addAnimation: landingAnimation3 forKey: @"LandingAnimation3"];
        
        
         CGMutablePathRef landingPath4;
         CGFloat landingDuration4 = 6;
         
         landingPath4 = CGPathCreateMutable();
         
        CGPathMoveToPoint(landingPath4, NULL, -75, 435);
        CGPathAddLineToPoint(landingPath4,NULL, 25, 435);
         
         CAKeyframeAnimation* landingAnimation4 = [CAKeyframeAnimation animationWithKeyPath: @"position"];
         
         [landingAnimation4 setDuration: landingDuration4];
         [landingAnimation4 setAutoreverses: NO];
         landingAnimation4.removedOnCompletion = NO;
         landingAnimation4.fillMode = kCAFillModeBoth;
         landingAnimation4.delegate = self;
         [landingAnimation4 setPath: landingPath4];
         CFRelease(landingPath4);
         
         [[moonbuggywheel2 layer] addAnimation: landingAnimation4 forKey: @"LandingAnimation4"];
        
        
        CABasicAnimation *skierRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        skierRotation.fromValue = [NSNumber numberWithFloat:0];
        skierRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        skierRotation.duration = 6;
        [[moonbuggywheel1 layer] addAnimation: skierRotation forKey:@"360"];
        [[moonbuggywheel2 layer] addAnimation: skierRotation forKey:@"360"];
        
    }
    
          
    if([planetMainColour isEqualToString:@"green"]){
      
        int greenmenRandom = (arc4random() % 2) + 1;
       
        UIImageView *greenman = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"greenman%i%@",greenmenRandom,@".png"]]];
        greenman.frame = CGRectMake(100, 400, 50, 100);
        [self.view addSubview:greenman];
        [self.view bringSubviewToFront:greenman];
        
        CGMutablePathRef greenmanPath;
        CGFloat greenmanDuration = 3;
        
        greenmanPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(greenmanPath, NULL, 170, 550);
        CGPathAddLineToPoint(greenmanPath,NULL, 170, 450);
        
        CAKeyframeAnimation* greenmenAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [greenmenAnimation setDuration: greenmanDuration];
        [greenmenAnimation setAutoreverses: NO];
        greenmenAnimation.removedOnCompletion = NO;
        greenmenAnimation.fillMode = kCAFillModeBoth;
        greenmenAnimation.delegate = self;
        [greenmenAnimation setPath: greenmanPath];
        CFRelease(greenmanPath);
        
        [[greenman layer] addAnimation: greenmenAnimation forKey: @"greenmenAnimation"];
      
    }
   
    [self.view bringSubviewToFront:Astronaut];
    [self.view bringSubviewToFront:SpaceshipShadow];
    [self.view bringSubviewToFront:Rocket];
    
    if([planetMainColour isEqualToString:@"yellow"]){
        
        //// DOOR ////
        
        UIImageView *yellowbackdoor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowbackdoor.png"]];
        yellowbackdoor.frame = CGRectMake(236, 300, 24, 70);
        [self.view addSubview:yellowbackdoor];
     
        CGMutablePathRef yellowbackdoorPath;
        CGFloat yellowbackdoorDuration = 5;
        
        yellowbackdoorPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(yellowbackdoorPath, NULL, 248, 340);
        CGPathAddLineToPoint(yellowbackdoorPath,NULL, 248, 270);
        CAKeyframeAnimation* yellowbackdoorAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [yellowbackdoorAnimation setDuration: yellowbackdoorDuration];
        [yellowbackdoorAnimation setAutoreverses: NO];
        yellowbackdoorAnimation.removedOnCompletion = NO;
        yellowbackdoorAnimation.fillMode = kCAFillModeBoth;
        yellowbackdoorAnimation.delegate = self;
        [yellowbackdoorAnimation setPath: yellowbackdoorPath];
        CFRelease(yellowbackdoorPath);
        
        [[yellowbackdoor layer] addAnimation: yellowbackdoorAnimation forKey: @"DoorAnimation"];
        
        UIImageView *yellowforedoor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowforedoor.png"]];
        yellowforedoor.frame = CGRectMake(236, 234, 24, 96);
        [self.view addSubview:yellowforedoor];

        
        //// BAGGAGE CAR ////
        
        for(int i = 4; i > 0; i--){
        
        UIImageView *yellowbaggagecar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowbaggagecar.png"]];
        yellowbaggagecar.frame = CGRectMake(236, 400, 28, 16);
        [self.view addSubview:yellowbaggagecar];
        
        CGMutablePathRef yellowbaggagecarPath;
        CGFloat yellowbaggagecarDuration = 6;
        
        yellowbaggagecarPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(yellowbaggagecarPath, NULL, 340 + (24*i), 360);
        CGPathAddLineToPoint(yellowbaggagecarPath,NULL, 240, 360);
        CGPathAddLineToPoint(yellowbaggagecarPath,NULL, 220, 377);
        CGPathAddLineToPoint(yellowbaggagecarPath,NULL, 120 + (24*i), 377);
        
        CAKeyframeAnimation *yellowbaggagecarAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [yellowbaggagecarAnimation setDuration: yellowbaggagecarDuration];
        [yellowbaggagecarAnimation setAutoreverses: NO];
        yellowbaggagecarAnimation.removedOnCompletion = NO;
        yellowbaggagecarAnimation.fillMode = kCAFillModeBoth;
        yellowbaggagecarAnimation.delegate = self;
        yellowbaggagecarAnimation.calculationMode = kCAAnimationPaced;
        [yellowbaggagecarAnimation setPath: yellowbaggagecarPath];
        CFRelease(yellowbaggagecarPath);
        
        [[yellowbaggagecar layer] addAnimation: yellowbaggagecarAnimation forKey: @"DoorAnimation"];
        [self.view bringSubviewToFront:yellowbaggagecar];
        
        }
        
        //// BAGGAGE ENGINE ////
        
        UIImageView *yellowbaggageengine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowbaggageengine.png"]];
        yellowbaggageengine.frame = CGRectMake(236, 300, 28, 23);
        [self.view addSubview:yellowbaggageengine];
        [self.view bringSubviewToFront:yellowbaggageengine];
        
        CGMutablePathRef yellowbaggageenginePath;
        CGFloat yellowbaggageengineDuration = 6;
        
        yellowbaggageenginePath = CGPathCreateMutable();
        
        CGPathMoveToPoint(yellowbaggageenginePath, NULL, 340, 356);
        CGPathAddLineToPoint(yellowbaggageenginePath,NULL, 240, 356);
        CGPathAddLineToPoint(yellowbaggageenginePath,NULL, 220, 373);
        CGPathAddLineToPoint(yellowbaggageenginePath,NULL, 120, 373);
        
        CAKeyframeAnimation *yellowbaggageengineAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [yellowbaggageengineAnimation setDuration: yellowbaggageengineDuration];
        [yellowbaggageengineAnimation setAutoreverses: NO];
        yellowbaggageengineAnimation.removedOnCompletion = NO;
        yellowbaggageengineAnimation.fillMode = kCAFillModeBoth;
        yellowbaggageengineAnimation.delegate = self;
        yellowbaggageengineAnimation.calculationMode = kCAAnimationPaced;
        
        [yellowbaggageengineAnimation setPath: yellowbaggageenginePath];
        CFRelease(yellowbaggageenginePath);
        
        [[yellowbaggageengine layer] addAnimation: yellowbaggageengineAnimation forKey: @"DoorAnimation"];
        
        [self.view bringSubviewToFront:yellowbaggageengine];
        
        UIImageView *yellowforedoor2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowforedoor2.png"]];
        yellowforedoor2.frame = CGRectMake(258, 328, 62, 52);
        [self.view addSubview:yellowforedoor2];

        //// ASTEROID 1 ////
        
        UIImageView *asteroid1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid-frame1.png"]];
        asteroid1.frame = CGRectMake(220, 100, 64, 48);
        [self.view addSubview:asteroid1];
        
        CABasicAnimation *skierRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        skierRotation.fromValue = [NSNumber numberWithFloat:0];
        skierRotation.toValue = [NSNumber numberWithFloat:(M_PI/4)];
        skierRotation.duration = 12;
        [[asteroid1 layer] addAnimation: skierRotation forKey:@"asteroid1"];
        

        //// ASTEROID 2 ///       
        
        UIImageView *asteroid2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid-frame2.png"]];
        asteroid2.frame = CGRectMake(150, 180, 32, 24);
        [self.view addSubview:asteroid2];
        
   
        CGMutablePathRef asteroid2Path;
        CGFloat asteroid2Duration = 12;
        
        asteroid2Path = CGPathCreateMutable();
        
        CGPathMoveToPoint(asteroid2Path, NULL, 170, 200);
        CGPathAddLineToPoint(asteroid2Path,NULL, 190, 195);
        
        CAKeyframeAnimation *asteroid2Animation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [asteroid2Animation setDuration: asteroid2Duration];
        [asteroid2Animation setAutoreverses: NO];
        asteroid2Animation.removedOnCompletion = NO;
        asteroid2Animation.fillMode = kCAFillModeBoth;
        asteroid2Animation.delegate = self;
        [asteroid2Animation setPath: asteroid2Path];
        CFRelease(asteroid2Path);
        
        [[asteroid2 layer] addAnimation: asteroid2Animation forKey: @"asteroid2"];
        [[asteroid2 layer] addAnimation: skierRotation forKey:@"asteroid1"];
        
        
        //// ASTEROID 3 ///           
        
        UIImageView *asteroid3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid3.png"]];
        asteroid3.frame = CGRectMake(260, 280, 16, 12);
        [self.view addSubview:asteroid3];
        
        CGMutablePathRef asteroid3Path;
        CGFloat asteroid3Duration = 12;
        
        asteroid3Path = CGPathCreateMutable();
        
        CGPathMoveToPoint(asteroid3Path, NULL, 280, 270);
        CGPathAddLineToPoint(asteroid3Path,NULL, 260, 290);
        
        CAKeyframeAnimation *asteroid3Animation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [asteroid3Animation setDuration: asteroid3Duration];
        [asteroid3Animation setAutoreverses: NO];
        asteroid3Animation.removedOnCompletion = NO;
        asteroid3Animation.fillMode = kCAFillModeBoth;
        asteroid3Animation.delegate = self;
        [asteroid3Animation setPath: asteroid3Path];
        CFRelease(asteroid3Path);
        
        [[asteroid3 layer] addAnimation: asteroid3Animation forKey: @"asteroid3"];
        
        
        //// ASTEROID 4 ///
        
        UIImageView *asteroid4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid-frame4.png"]];
        asteroid4.frame = CGRectMake(260, 300, 32, 24);
        [self.view addSubview:asteroid4];
        
        CABasicAnimation *skierRotation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        skierRotation2.fromValue = [NSNumber numberWithFloat:0];
        skierRotation2.toValue = [NSNumber numberWithFloat:-0.25*M_PI];
        skierRotation2.duration = 12;
        [[asteroid4 layer] addAnimation: skierRotation2 forKey:@"asteroid4"];
        
        
        //// ASTEROID 5 ///
        
        UIImageView *asteroid5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid-frame5.png"]];
        asteroid5.frame = CGRectMake(110, 430, 48, 64);
        [self.view addSubview:asteroid5];
         
        CGMutablePathRef asteroid5Path;
        CGFloat asteroid5Duration = 12;
        
        asteroid5Path = CGPathCreateMutable();
        
        CGPathMoveToPoint(asteroid5Path, NULL, 120, 450);
        CGPathAddLineToPoint(asteroid5Path,NULL, 130, 410);
        
        CAKeyframeAnimation *asteroid5Animation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [asteroid5Animation setDuration: asteroid5Duration];
        [asteroid5Animation setAutoreverses: NO];
        asteroid5Animation.removedOnCompletion = NO;
        asteroid5Animation.fillMode = kCAFillModeBoth;
        asteroid5Animation.delegate = self;
        [asteroid5Animation setPath: asteroid5Path];
        CFRelease(asteroid5Path);
        
        [[asteroid5 layer] addAnimation: asteroid5Animation forKey: @"asteroid5"];
        
        //// ASTEROID 5 ///
        
        UIImageView *asteroid6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid-frame6.png"]];
        asteroid6.frame = CGRectMake(150, 430, 32, 24);
        [self.view addSubview:asteroid6];
        
        CABasicAnimation *skierRotation5 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        skierRotation5.fromValue = [NSNumber numberWithFloat:0];
        skierRotation5.toValue = [NSNumber numberWithFloat:M_PI];
        skierRotation5.duration = 12;
        [[asteroid6 layer] addAnimation: skierRotation5 forKey:@"asteroid4"];
        
        //// ASTEROID 7 ///
        
        UIImageView *asteroid7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid-frame6.png"]];
        asteroid7.frame = CGRectMake(30, 380, 32, 24);
        [self.view addSubview:asteroid7];
        
        CGMutablePathRef asteroid7Path;
        CGFloat asteroid7Duration = 12;
        
        asteroid7Path = CGPathCreateMutable();
        
        CGPathMoveToPoint(asteroid7Path, NULL, 50, 400);
        CGPathAddLineToPoint(asteroid7Path,NULL, 65, 430);
        
        CAKeyframeAnimation *asteroid7Animation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [asteroid7Animation setDuration: asteroid7Duration];
        [asteroid7Animation setAutoreverses: NO];
        asteroid7Animation.removedOnCompletion = NO;
        asteroid7Animation.fillMode = kCAFillModeBoth;
        asteroid7Animation.delegate = self;
        [asteroid7Animation setPath: asteroid7Path];
        CFRelease(asteroid7Path);
        
        [[asteroid7 layer] addAnimation: asteroid7Animation forKey: @"asteroid7"];
        
        CABasicAnimation *skierRotation7 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        skierRotation7.fromValue = [NSNumber numberWithFloat:0];
        skierRotation7.toValue = [NSNumber numberWithFloat:M_PI/2];
        skierRotation7.duration = 12;
        [[asteroid7 layer] addAnimation: skierRotation7 forKey:@"asteroid4"];
        
        
        //// ASTEROID 8 ///
        
        UIImageView *asteroid8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid-frame1.png"]];
        asteroid8.frame =CGRectMake(120,480, 64, 48);
        [self.view addSubview:asteroid8];
        
        CABasicAnimation *skierRotation8 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        skierRotation8.fromValue = [NSNumber numberWithFloat:0];
        skierRotation8.toValue = [NSNumber numberWithFloat:M_PI/2];
        skierRotation8.duration = 12;
        [[asteroid8 layer] addAnimation: skierRotation8 forKey:@"asteroid4"];


    }
    
}

-(void)SpaceshipShadowZoom{
    
    float spaceshipShadowInitialX = SpaceshipShadow.frame.origin.x-0.48;
    float spaceshipShadowInitialY = SpaceshipShadow.frame.origin.y-0.08;
    float spaceshipShadowImageHieght = SpaceshipShadow.frame.size.height+0.16;
    float spaceshipShadowImageWidth = SpaceshipShadow.frame.size.width+0.96;

    SpaceshipShadow.frame = CGRectMake(spaceshipShadowInitialX, spaceshipShadowInitialY, spaceshipShadowImageWidth, spaceshipShadowImageHieght);
    
    if(spaceshipShadowImageHieght >= 16){
        [SpaceshipShadowTimer invalidate];
    }

}


-(void)spaceShipOpenDoor{
    
    [Rocket stopAnimating];
    [Rocket setImage:[UIImage imageNamed:@"spaceship-Frame02.png"]];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(astronautExit)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)astronautExit{
    
    [Rocket setImage:[UIImage imageNamed:@"spaceship-Frame06.png"]];
    
    CGMutablePathRef aPath;
    CGFloat astronautjumpDuration = 1;
    
    aPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, NULL, 130, 310);
    CGPathAddCurveToPoint(aPath, NULL, 180, 280, 180, 280, 220, 350);
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: astronautjumpDuration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
    
    [[Astronaut layer] addAnimation: arcAnimation forKey: @"AstronautAnimation"];
    
    [NSTimer scheduledTimerWithTimeInterval:1.1
                                     target:self
                                   selector:@selector(astronautWave)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:astronautjumpDuration + 3
                                     target:self
                                   selector:@selector(swapViews)
                                   userInfo:nil
                                    repeats:NO];
    
    
    
}

-(void)astronautWave{
    
    float astronautWaveDuration = 1;
    NSArray *astronautWaveArray;
    astronautWaveArray = [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"astronaut-frame4.png"],
                      [UIImage imageNamed:@"astronaut-frame5.png"],
                      [UIImage imageNamed:@"astronaut-frame6.png"],
                      [UIImage imageNamed:@"astronaut-frame7.png"],
                      [UIImage imageNamed:@"astronaut-frame8.png"],
                      [UIImage imageNamed:@"astronaut-frame7.png"],
                      [UIImage imageNamed:@"astronaut-frame6.png"],
                      [UIImage imageNamed:@"astronaut-frame5.png"],
                      [UIImage imageNamed:@"astronaut-frame4.png"],
                      nil
                      ];
    
    Astronaut.animationImages=astronautWaveArray;
    [Astronaut setAnimationDuration:astronautWaveDuration];
    [Astronaut setAnimationRepeatCount:5];
    [Astronaut startAnimating];
    
}

-(void)swapViews{
   
    self.view.userInteractionEnabled = NO;
    
    for (UIView *subview in [self.view subviews]) {
           [subview removeFromSuperview];
    }
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
   
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Space"];

}

@end
