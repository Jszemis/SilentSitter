//
//  SpaceViewController.m
//  mutiltest
//
//  Created by Lizzie Szemis on 15/10/12.
//
//

#import "SpaceViewController.h"
#import "MultiboxAppDelegate.h"

@interface SpaceViewController ()

@end

@implementation SpaceViewController

@synthesize RedPlanet,BluePlanet,PurplePlanet,GreyPlanet,GreenPlanet,EarthPlanet,YellowPlanet;
@synthesize Solar,Space;

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
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    gameloop =[CADisplayLink displayLinkWithTarget:self selector:@selector(UpdatePlanetVisibility)];
    [gameloop addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    [RedPlanet DrawEllipse:160:140:30:110:30:10];
    [PurplePlanet DrawEllipse:160:140:20:140:0:12];
    [GreenPlanet DrawEllipse:160:140:40:100:90:9];
    [GreyPlanet DrawEllipse:160:140:20:170:-40:20];
    [BluePlanet DrawEllipse:160:140:25:100:-20:6];
    [YellowPlanet DrawEllipse:160:140:30:130:60:8];
    
    float solarDuration = 2.4;
    NSArray *solarArray;
    solarArray = [[NSArray alloc] initWithObjects:
                   [UIImage imageNamed:@"solar-frame1.png"],
                   [UIImage imageNamed:@"solar-frame2.png"],
                   [UIImage imageNamed:@"solar-frame3.png"],
                   [UIImage imageNamed:@"solar-frame4.png"],
                   [UIImage imageNamed:@"solar-frame5.png"],
                   [UIImage imageNamed:@"solar-frame6.png"],
                   [UIImage imageNamed:@"solar-frame5.png"],
                   [UIImage imageNamed:@"solar-frame4.png"],
                   [UIImage imageNamed:@"solar-frame3.png"],
                   [UIImage imageNamed:@"solar-frame2.png"],
                  nil
                   ];
    
    [Solar.imageView stopAnimating];
    [Solar.imageView.layer removeAllAnimations];
    
    Solar.imageView.animationImages=solarArray;
    [Solar.imageView setAnimationDuration:solarDuration];
    [Solar.imageView setAnimationRepeatCount:HUGE_VALF];
    [Solar.imageView startAnimating];
    [self.view bringSubviewToFront:Solar];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(SpaceEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)SpaceEnable{
    
    self.view.userInteractionEnabled = YES;
    
}

    
-(void)PlanetVisibility:(float) parMinX :(float) parMaxX :(float) parMinY :(float) parMaxY :(float) parMinX2 :(float) parMaxX2 :(float) parMinY2 :(float) parMaxY2 :(Planet*) parPlanet{
    
        CGRect planetFrame = [[parPlanet.layer presentationLayer] frame];
            parPlanet.center = CGPointMake(planetFrame.origin.x + (planetFrame.size.width/2),planetFrame.origin.y + (planetFrame.size.height/2));     
        if(parPlanet.center.x > parMinX && parPlanet.center.x < parMaxX && parPlanet.center.y > parMinY && parPlanet.center.y < parMaxY){
            [self.view sendSubviewToBack:parPlanet];
            [self.view sendSubviewToBack:Space];
 
            if(parPlanet.center.x > parMinX2 && parPlanet.center.x < parMaxX2 && parPlanet.center.y > parMinY2 && parPlanet.center.y < parMaxY2){
                [self.view bringSubviewToFront:parPlanet]; 
            }
    
        }else{
            [self.view bringSubviewToFront:parPlanet];
        }
        
}

-(void)UpdatePlanetVisibility{

    [self PlanetVisibility:100:240:80:160:0:150:120:300:RedPlanet];
    [self PlanetVisibility:80:240:0:135:0:0:0:0:PurplePlanet];
    [self PlanetVisibility:0:150:0:360:0:0:0:0:GreenPlanet];
    [self PlanetVisibility:90:200:80:180:142:300:132:300:GreyPlanet];
    [self PlanetVisibility:60:220:80:160:145:300:135:300:BluePlanet];
    [self PlanetVisibility:130:225:60:215:0:195:145:300:YellowPlanet];
    
}

- (IBAction)clickHomePlanet:(id)sender{
    
    [gameloop removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    RedPlanet.adjustsImageWhenDisabled = NO;
    RedPlanet.enabled = NO;
    BluePlanet.adjustsImageWhenDisabled = NO;
    BluePlanet.enabled = NO;
    GreenPlanet.adjustsImageWhenDisabled = NO;
    GreenPlanet.enabled = NO;
    PurplePlanet.adjustsImageWhenDisabled = NO;
    PurplePlanet.enabled = NO;
    GreyPlanet.adjustsImageWhenDisabled = NO;
    GreyPlanet.enabled = NO;
    YellowPlanet.adjustsImageWhenDisabled = NO;
    YellowPlanet.enabled = NO;
    
    Solar.enabled = NO;

    zoomPlanetTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(zoomPlanet)
                                   userInfo:nil
                                    repeats:YES];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.21
                                     target:self
                                   selector:@selector(removePlanetLayers)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)zoomPlanet{

    [self.view bringSubviewToFront:EarthPlanet];
    
    float skijumpInitialX = EarthPlanet.frame.origin.x;
    float skijumpInitialY = EarthPlanet.frame.origin.y;
    
    int skijumpImageHieght = EarthPlanet.frame.size.height+5;
    int skijumpImageWidth = EarthPlanet.frame.size.width+5;
    
    CGRect skiFrame = CGRectMake(skijumpInitialX, skijumpInitialY-5, skijumpImageWidth, skijumpImageHieght);
    EarthPlanet.frame = skiFrame;
    
}

-(void)removePlanetLayers{
    
    self.view.userInteractionEnabled = NO;
    
    [zoomPlanetTimer invalidate];
    
    [Solar.imageView stopAnimating];
    [Solar.imageView.layer removeAllAnimations];
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        if(![layer.name isEqual:  @"rocketship"]){
                 [layer removeAllAnimations];
                 [layer removeFromSuperlayer];
        }

    }
    
}


@end
