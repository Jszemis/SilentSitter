//
//  VehicleViewController.m
//  mutiltest
//
//  Created by Lizzie Szemis on 12/09/12.
//
//

#import "VehicleViewController.h"
#import "MultiboxAppDelegate.h"

@interface VehicleViewController  ()

@end

@implementation VehicleViewController

@synthesize ladder;
@synthesize OceanTop;
@synthesize OceanBottom;
@synthesize vehicle;
@synthesize WidgetCollection;
@synthesize Shadow;

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
    
    CGRect umFrame = CGRectMake(0,0,0,0);
    [vehicle drawRect:(umFrame)];
    
    vehicleCollisionFlag = 1;
    vehicleMoveFlag = 0;
    vehicleClickFlag = 0;
    widgetCount = 0;
    linePath = [UIBezierPath bezierPath];
    flyPath = [UIBezierPath bezierPath];
    
    lineLayer = [CAShapeLayer layer];
    lineLayer.name = @"lineLayer";
    lineLayer.strokeColor = [UIColor blackColor].CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 3.0;

    for (Widget *widgetLocal in WidgetCollection) {
        [widgetLocal drawRect:(umFrame)];
    }
 
    float shadowDuration = 0.2;
    NSArray *shadowFlap;

    shadowFlap = [[NSArray alloc] initWithObjects:
                  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Shadow0-frame1" ofType:@"png"]],
                  [UIImage imageNamed:@"Shadow0-frame2.png"],
                  nil
                  ];
    [Shadow stopAnimating];
    [Shadow.layer removeAllAnimations];
    Shadow.animationImages=shadowFlap;
    [Shadow setAnimationDuration:shadowDuration];
    [Shadow setAnimationRepeatCount:HUGE_VALF];
    [Shadow startAnimating];

    OceanMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(OceanMove:)
                                                userInfo:nil
                                                 repeats:YES];
   
    MoveShadowTimer = [NSTimer scheduledTimerWithTimeInterval:0.005
                                     target:self
                                   selector:@selector(MoveShadow)
                                   userInfo:nil
                                    repeats:YES];

    [super viewDidLoad];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(VehicleEnable)
                                   userInfo:nil
                                    repeats:NO];

}


-(void)VehicleEnable{
    
    self.view.userInteractionEnabled = YES;
    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (Widget *widgetLocal in WidgetCollection) {   
    
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        if (widgetLocal.center.x < point.x + 22 && widgetLocal.center.x > point.x - 22 &&
            widgetLocal.center.y < point.y + 22 && widgetLocal.center.y > point.y - 22 && vehicleMoveFlag == 0) {

            flyPathLength = 0;
            linePath = [UIBezierPath bezierPath];
            flyPath = [UIBezierPath bezierPath];
        
            lineLayer = [CAShapeLayer layer];
            lineLayer.name = @"lineLayer";
            lineLayer.strokeColor = [UIColor blackColor].CGColor;
            lineLayer.fillColor = [UIColor clearColor].CGColor;
            lineLayer.lineWidth = 3.0;
        
            [self.view.layer addSublayer:lineLayer];
            [linePath moveToPoint:P(vehicle.center.x, vehicle.center.y)];
            lineLayer.path = linePath.CGPath;
        
            [linePath addLineToPoint:CGPointMake(widgetLocal.center.x, widgetLocal.center.y)];
            lineLayer.path = linePath.CGPath;
        
            [flyPath moveToPoint:P(vehicle.center.x, vehicle.center.y)];
            [flyPath addLineToPoint:CGPointMake(widgetLocal.center.x, widgetLocal.center.y)];

            vehicleMoveFlag = 1;
            flyPathLength = flyPathLength + sqrt(pow(vehicle.center.x - widgetLocal.center.x,2) + pow(vehicle.center.y - widgetLocal.center.y,2));

            CAKeyframeAnimation *flyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            flyAnimation.path = flyPath.CGPath;
            flyAnimation.removedOnCompletion = NO;
            flyAnimation.rotationMode = nil;
            flyAnimation.repeatCount = 0;
            flyAnimation.duration = flyPathLength/250;
            flyAnimation.fillMode = kCAFillModeBoth;
            flyAnimation.delegate = self;
            flyAnimation.calculationMode = kCAAnimationPaced;
            [vehicle.layer addAnimation:flyAnimation forKey:@"flyAnimation"];
        
            [UIView beginAnimations: [NSString stringWithFormat: @"flyAnimation"] context: nil];
            [UIView setAnimationDuration: flyPathLength/250];
            [UIView commitAnimations];
        
            [NSTimer scheduledTimerWithTimeInterval:0.3
                                         target:self
                                       selector:@selector(StraightLineRemove)
                                       userInfo:nil
                                        repeats:NO];
            
            [NSTimer scheduledTimerWithTimeInterval:flyPathLength/250 + 0.1
                                             target:self
                                           selector:@selector(resetvehicleStraightLineFlag)
                                           userInfo:nil
                                            repeats:NO];
            
            [flyPath removeAllPoints];
            flyPathLength = 0;

        }
        
    }
    
}


-(void)StraightLineRemove{
    
    [linePath removeAllPoints];
    lineLayer.path = linePath.CGPath;
    
}


-(void)resetvehicleStraightLineFlag{
    
    vehicleCollisionFlag = 1;
    vehicleMoveFlag = 0;
    vehicleClickFlag = 0;
    vehicleChangeFlag = 0;
    
    [self widgetCollision];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)MoveShadow{
    
    vehicle.frame = [[vehicle.layer presentationLayer] frame];
    CGPoint shadowLocation = CGPointMake(vehicle.frame.origin.x+80,vehicle.frame.origin.y+100);
    Shadow.center = shadowLocation;
    
}


-(void)widgetCollision{

    vehicle.frame = [[vehicle.layer presentationLayer] frame];
    CGRect vehicleLocalFrame = vehicle.frame;
    
    for (Widget *widgetLocal in WidgetCollection) {
        
        CGRect WidgetLocalFrame = [widgetLocal widgetReturnRectange];
        
        if(CGRectIntersectsRect(vehicleLocalFrame, WidgetLocalFrame) && vehicleCollisionFlag == 1){
        
            vehicleCollisionFlag = 0;
            
            vehicleMoveFlag = 1;
            vehicleClickFlag = 1;
            vehicleChangeFlag = 1;
            
            [widgetLocal WidgetRemove];

            [vehicle.layer removeAnimationForKey:@"flyAnimation"];
         
            int VehicleX = vehicle.layer.frame.origin.x + (vehicle.layer.frame.size.width/2);
            int VehicleY = vehicle.layer.frame.origin.y + (vehicle.layer.frame.size.height/2);

            int WidgetX = WidgetLocalFrame.origin.x;
            int WidgetY = WidgetLocalFrame.origin.y;
            
            NSTimeInterval moveduration = 0.3;

            CGMutablePathRef aPath;
            aPath = CGPathCreateMutable();
            
            CGPathMoveToPoint(aPath,NULL,VehicleX,VehicleY);
            CGPathAddLineToPoint(aPath,NULL,WidgetX,WidgetY-60);
            
            CAKeyframeAnimation* flyAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
            
            [flyAnimation setDuration: moveduration];
            [flyAnimation setAutoreverses: NO];
            flyAnimation.removedOnCompletion = NO;
            flyAnimation.fillMode = kCAFillModeBoth;
            flyAnimation.delegate = self;
            flyAnimation.calculationMode = kCAAnimationPaced;
            [flyAnimation setPath: aPath];
            CFRelease(aPath);

            [vehicle.layer addAnimation:flyAnimation forKey:@"flyAnimation"];
            
            [UIView beginAnimations: [NSString stringWithFormat: @"flyAnimation"] context: nil];
            [UIView setAnimationDuration: moveduration];
            [UIView commitAnimations];
            
            [NSTimer scheduledTimerWithTimeInterval:moveduration
                                             target:self
                                           selector:@selector(DownLadder)
                                           userInfo:nil
                                            repeats:NO];
            
   

        }
        
    }
    
}


-(void)DownLadder{
    
    int VehicleX = vehicle.layer.frame.origin.x + (vehicle.layer.frame.size.width/2) + 10;
    int VehicleY = vehicle.layer.frame.origin.y + (vehicle.layer.frame.size.height/2) - 4;
    
    UIImage *DownLadderImage = [UIImage imageNamed:@"Ladder.png"];
    ladder = [[UIImageView alloc] initWithImage:DownLadderImage];
    ladder.frame = CGRectMake(VehicleX, VehicleY, 12, 64);
    [self.view addSubview:ladder];
    
    float LadderDownDuration = 0.5;
    NSArray *ladderDown;
    ladderDown = [[NSArray alloc] initWithObjects:
               [UIImage imageNamed:@"LadderDown-frame4.png"],
               [UIImage imageNamed:@"LadderDown-frame3.png"],
               [UIImage imageNamed:@"LadderDown-frame2.png"],
               [UIImage imageNamed:@"LadderDown-frame1.png"],
               nil
               ];
    [ladder stopAnimating];
    [ladder.layer removeAllAnimations];
    ladder.animationImages=ladderDown;
    [ladder setAnimationDuration:LadderDownDuration];
    [ladder setAnimationRepeatCount:1];
    [ladder startAnimating];
       
    float ShadowDownDuration = 0.5;
    NSArray *shadowDown;
    shadowDown = [[NSArray alloc] initWithObjects:
               [UIImage imageNamed:@"Shadow1-frame1.png"],
               [UIImage imageNamed:@"Shadow1-frame2.png"],
               [UIImage imageNamed:@"Shadow2-frame1.png"],
               [UIImage imageNamed:@"Shadow2-frame2.png"],
               [UIImage imageNamed:@"Shadow3-frame1.png"],
               [UIImage imageNamed:@"Shadow3-frame2.png"],
               [UIImage imageNamed:@"Shadow4-frame1.png"],
               [UIImage imageNamed:@"Shadow4-frame2.png"],
               nil
               ];
    [Shadow stopAnimating];
    [Shadow.layer removeAllAnimations];
    Shadow.animationImages=shadowDown;
    [Shadow setAnimationDuration:ShadowDownDuration];
    [Shadow setAnimationRepeatCount:1];
    [Shadow startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(UpLadder)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)UpLadder{
    
    [ladder removeFromSuperview];
    int VehicleX = vehicle.layer.frame.origin.x + (vehicle.layer.frame.size.width/2) + 10;
    int VehicleY = vehicle.layer.frame.origin.y + (vehicle.layer.frame.size.height/2) - 4;
    
    UIImage *UpLadderImage = [UIImage imageNamed:@"Ladder.png"];
    ladder = [[UIImageView alloc] initWithImage:UpLadderImage];
    ladder.frame = CGRectMake(VehicleX, VehicleY, 12, 64);
    [self.view addSubview:ladder];
    
    float LadderUpDuration = 0.5;
    NSArray *ladderUp;
    ladderUp = [[NSArray alloc] initWithObjects:
               [UIImage imageNamed:@"LadderUp-frame1.png"],
               [UIImage imageNamed:@"LadderUp-frame2.png"],
               [UIImage imageNamed:@"LadderUp-frame3.png"],
               [UIImage imageNamed:@"LadderUp-frame4.png"],
               nil
               ];
    
    [ladder stopAnimating];
    [ladder.layer removeAllAnimations];
    ladder.animationImages=ladderUp;
    [ladder setAnimationDuration:LadderUpDuration];
    [ladder setAnimationRepeatCount:1];
    [ladder startAnimating];
    
 
    
    float ShadowUpDuration = 0.5;
    NSArray *shadowUp;
    shadowUp = [[NSArray alloc] initWithObjects:
                  [UIImage imageNamed:@"Shadow4-frame1.png"],
                  [UIImage imageNamed:@"Shadow4-frame2.png"],
                  [UIImage imageNamed:@"Shadow3-frame1.png"],
                  [UIImage imageNamed:@"Shadow3-frame2.png"],
                  [UIImage imageNamed:@"Shadow2-frame1.png"],
                  [UIImage imageNamed:@"Shadow2-frame2.png"],
                  [UIImage imageNamed:@"Shadow1-frame1.png"],
                  [UIImage imageNamed:@"Shadow1-frame2.png"],
                  nil
                  ];
    
    [Shadow stopAnimating];
    [Shadow.layer removeAllAnimations];
    Shadow.animationImages=shadowUp;
    [Shadow setAnimationDuration:ShadowUpDuration];
    [Shadow setAnimationRepeatCount:1];
    [Shadow startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(resetvehicleCollisionFlag)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)resetvehicleCollisionFlag{
    
    widgetCount++;
    [vehicle VehicleStopAnim:widgetCount];
    [ladder removeFromSuperview];
    vehicleCollisionFlag = 1;
    
    float shadowDuration = 0.2;
    NSArray *shadowFlap;
    shadowFlap = [[NSArray alloc] initWithObjects:
                  [UIImage imageNamed:@"Shadow0-frame1.png"],
                  [UIImage imageNamed:@"Shadow0-frame2.png"],
                  nil
                  ];
    
    [Shadow stopAnimating];
    [Shadow.layer removeAllAnimations];
    
    Shadow.animationImages=shadowFlap;
    [Shadow setAnimationDuration:shadowDuration];
    [Shadow setAnimationRepeatCount:HUGE_VALF];
    [Shadow startAnimating];
    
    if(widgetCount == 6){
    
      //
        self.view.userInteractionEnabled = NO;
        
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(swapViews)
                                       userInfo:nil
                                        repeats:NO];
    }else{
        
        [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(resetvehicleMoveFlag)
                                       userInfo:nil
                                        repeats:NO];
    }

}


-(void)swapViews{
   
    self.view.userInteractionEnabled = NO;
    
    [OceanMoveTimer invalidate];
    [MoveShadowTimer invalidate];
    [vehicleResetTimer invalidate];
    
    [Shadow stopAnimating];
    [vehicle stopAnimating];
    
    [Shadow.layer removeAllAnimations];
    [vehicle.layer removeAllAnimations];
    
    for (UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Vehicle"];
    
}


- (IBAction)vehicleCreatePath:(UILongPressGestureRecognizer *)sender {
    
    if(vehicleMoveFlag == 0){
    
        CGPoint touchPoint = [sender locationInView:[self view]];
        if ([vehicle.layer.presentationLayer hitTest:touchPoint]) {
            vehicleClickFlag = 1;
        }
    
        if(vehicleClickFlag == 1){
            
            if([sender state] == UIGestureRecognizerStateBegan){
        
                    linePathLength = 0;
                    linePathLengthX = [sender locationInView:self.view].x;
                    linePathLengthY = [sender locationInView:self.view].y;

                    flyPathLength = 0; 
                    flyPathLengthX = vehicle.layer.frame.origin.x + (vehicle.layer.frame.size.width/2);
                    flyPathLengthY = vehicle.layer.frame.origin.y + (vehicle.layer.frame.size.height/2);
                
                    int lineX = [sender locationInView:self.view].x;
                    int lineY = [sender locationInView:self.view].y;
        
                    int flyX = vehicle.layer.frame.origin.x + (vehicle.layer.frame.size.width/2);
                    int flyY = vehicle.layer.frame.origin.y + (vehicle.layer.frame.size.height/2);
                
                    [self.view.layer addSublayer:lineLayer];
                    [linePath moveToPoint:P(lineX, lineY)];
                    lineLayer.path = linePath.CGPath;

                    [flyPath moveToPoint:P(flyX, flyY)];
                    [flyPath addLineToPoint:CGPointMake(flyX, flyY)];
                    flyLayer.path = flyPath.CGPath;
                
                    vehicleChangeFlag = 1;
      
            }
        
            if([sender state] == UIGestureRecognizerStateChanged && vehicleChangeFlag == 1 && linePathLength < 1000){
              
                float lineX = [sender locationInView:self.view].x;
                float lineY = [sender locationInView:self.view].y;
                
                float flyX = [sender locationInView:self.view].x;
                float flyY = [sender locationInView:self.view].y;
                
                if(flyX < 85){
                    flyX = 85;
                }
                
                if(flyX > 235){
                    flyX = 235;
                }
                
                if(flyY < 65){
                    flyY = 65;
                }

                CGRect screenBounds = [[UIScreen mainScreen] bounds];
                if (screenBounds.size.height == 568) {
                    if(flyY > 508){
                        flyY = 508;
                    }
                } else {
                    if(flyY > 420){
                        flyY = 420;
                    }
                }
          
                linePathLength = linePathLength + sqrt(pow(linePathLengthX - lineX,2) + pow(linePathLengthY - lineY,2));
                linePathLengthX = lineX;
                linePathLengthY = lineY;
                
                [linePath addLineToPoint:CGPointMake(lineX, lineY)];
                lineLayer.path = linePath.CGPath;

                flyPathLength = flyPathLength + sqrt(pow(flyPathLengthX - flyX,2) + pow(flyPathLengthY - flyY,2));
                flyPathLengthX = flyX;
                flyPathLengthY = flyY;
                
                [flyPath addLineToPoint:CGPointMake(flyX, flyY)];
                flyLayer.path = flyPath.CGPath;

            }
    
            if([sender state] == UIGestureRecognizerStateEnded && linePathLength > 0 && vehicleChangeFlag == 1){

                 if(flyPathLength/90 > 0.1){

                    CAKeyframeAnimation *flyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                    flyAnimation.path = flyPath.CGPath;
                    flyAnimation.removedOnCompletion = NO;
                    flyAnimation.rotationMode = nil;
                    flyAnimation.repeatCount = 0;
                    flyAnimation.duration = flyPathLength/180;
                    flyAnimation.fillMode = kCAFillModeBoth;
                    flyAnimation.delegate = self;
                    flyAnimation.calculationMode = kCAAnimationPaced;
                    [vehicle.layer addAnimation:flyAnimation forKey:@"flyAnimation"];
                
                    [UIView beginAnimations: [NSString stringWithFormat: @"flyAnimation"] context: nil];
                    [UIView setAnimationDuration: flyPathLength/90];
                    [UIView commitAnimations];
                }                
                vehicleMoveFlag = 1;
                [linePath removeAllPoints];
                [flyPath removeAllPoints];
                
                lineLayer.path = linePath.CGPath;

                [NSTimer scheduledTimerWithTimeInterval:flyPathLength/180 + 0.1
                                                 target:self
                                            selector:@selector(resetvehicleMoveFlag)
                                                userInfo:nil
                                                    repeats:NO];
                            
            
            }
          
        }
    }

}


-(void)resetvehicleMoveFlag{
    
    vehicleMoveFlag = 0;
    vehicleClickFlag = 0;
    vehicleChangeFlag = 0;
    
    [self widgetCollision];

}


-(void)OceanMove: (id) sender{
    
    if(OceanTop.center.x > 193){
            
        CGPoint oceanTopLocation = CGPointMake(69,OceanTop.center.y);
        OceanTop.center = oceanTopLocation;
            
    }else{
            
        CGPoint oceanTopLocation = CGPointMake(OceanTop.center.x + 1,OceanTop.center.y);
        OceanTop.center = oceanTopLocation;

    }

    if(OceanBottom.center.x > 193){
        
        CGPoint oceanBottomLocation = CGPointMake(69,OceanBottom.center.y);
        OceanBottom.center = oceanBottomLocation;
        
    }else{
        
        CGPoint oceanBottomLocation = CGPointMake(OceanBottom.center.x + 2,OceanBottom.center.y);
        OceanBottom.center = oceanBottomLocation;
        
    }
    
}


@end
