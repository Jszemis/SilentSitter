//
//  SnowViewController.m
//  mutiltest
//
//  Created by Lizzie Szemis on 5/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SnowViewController.h"
#import "MultiboxAppDelegate.h"

@interface SnowViewController ()

@end

@implementation SnowViewController

@synthesize skierX,startSkiing,skijumpStatus,skijumpNumber,disableGesture,skijumpTotalNumber, skierImage,skijumpImage,skislopeImage;

- (void)viewDidLoad
{
    
    self.view.userInteractionEnabled = NO;
    
    [super viewDidLoad];
    
    startSkiing = 0;
    skijumpStatus = 0;
    skijumpNumber = 0;
    disableGesture = 0;
    skijumpTotalNumber = 4;
    
    skierTimer = [NSTimer scheduledTimerWithTimeInterval:0.005
                                                  target:self
                                                selector:@selector(skierMove:)
                                                userInfo:nil
                                                 repeats:YES];
    
    skicollisionTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                         target:self
                                                       selector:@selector(skiCollison:)
                                                       userInfo:nil
                                                        repeats:YES];
    
    skislopeTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                     target:self
                                                   selector:@selector(skiSlopeMove:)
                                                   userInfo:nil
                                                    repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(SnowEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)SnowEnable{
    
    self.view.userInteractionEnabled = YES;
    
}


-(void)skiCollison: (id) sender{
    
    if(CGRectIntersectsRect(skijumpImage.frame, skierImage.frame)){
        
        [skierTimer invalidate];
        [skicollisionTimer invalidate];
        
        int skierjumpRandom = arc4random() % 3;
        UIImage *skierJump;
        
        if(skierjumpRandom == 0){
            
            skierJump  = [UIImage imageNamed:@"skierJump.png"];
            [skierImage setImage:skierJump];
            
        }else if(skierjumpRandom == 1){
            
            skierJump  = [UIImage imageNamed:@"skierJump00.png"];
            [skierImage setImage:skierJump];
            
            NSMutableArray *_skierJump = [[NSMutableArray alloc] initWithObjects:
                                          [UIImage imageNamed:@"skierJump00.png"],
                                          [UIImage imageNamed:@"skierJump01.png"],
                                          [UIImage imageNamed:@"skierJump02.png"],
                                          [UIImage imageNamed:@"skierJump03.png"],
                                          [UIImage imageNamed:@"skierJump04.png"],
                                          [UIImage imageNamed:@"skierJump05.png"],
                                          [UIImage imageNamed:@"skierJump06.png"],
                                          [UIImage imageNamed:@"skierJump07.png"],
                                          nil
                                          ];
            
            
            skierImage.animationImages=_skierJump;
            [skierImage setAnimationDuration:0.6];
            [skierImage setAnimationRepeatCount:1];
            [skierImage startAnimating];
            
        }else {
            
            skierJump  = [UIImage imageNamed:@"skierDown.png"];
            [skierImage setImage:skierJump];
            
            CABasicAnimation *skierRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            skierRotation.fromValue = [NSNumber numberWithFloat:0];
            skierRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
            skierRotation.duration = 0.5;
            [[skierImage layer] addAnimation: skierRotation forKey:@"360"];
            
        }
        
        int skierInitialX = skierImage.center.x;
        int skierInitialY = skierImage.center.y;
        
        float skijumpInitialX = skierImage.frame.origin.x;
        float skijumpInitialY = skierImage.frame.origin.y;
        
        int skijumpImageHieght = skierJump.size.height;
        int skijumpImageWidth = skierJump.size.width;
        
        CGRect skiFrame = CGRectMake(skijumpInitialX, skijumpInitialY, skijumpImageWidth, skijumpImageHieght);
        skierImage.frame = skiFrame;
        
        CGMutablePathRef aPath;
        CGFloat jumpDuration = 0.65;
        
        aPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(aPath, NULL, skierInitialX, skierInitialY);
        CGPathAddLineToPoint(aPath,NULL, skierInitialX, skierInitialY-100);
        CGPathAddLineToPoint(aPath,NULL, skierInitialX, skierInitialY);
        
        CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [arcAnimation setDuration: jumpDuration];
        [arcAnimation setAutoreverses: NO];
        arcAnimation.removedOnCompletion = NO;
        arcAnimation.fillMode = kCAFillModeBoth;
        arcAnimation.delegate = self;
        [arcAnimation setPath: aPath];
        
        
        CFRelease(aPath);
        
        [[skierImage layer] addAnimation: arcAnimation forKey: @"sunAnimation"];
        
        skijumpStatus = 1;
        
        [NSTimer scheduledTimerWithTimeInterval:jumpDuration + 0.1
                                         target:self
                                       selector:@selector(skierLand:)
                                       userInfo:nil
                                        repeats:NO];
        
    }
    
    
}


-(void)skierMove: (id) sender{
    
    if(startSkiing == 1){
        
        if(skierImage.center.x > skierX + 20 && skierImage.center.x > 100) {
            
            CGPoint skierLocation = CGPointMake(skierImage.center.x - 1,150);
            skierImage.center = skierLocation;
            [skierImage setImage:[UIImage imageNamed:@"skierLeft.png"]];
            
        }else if (skierImage.center.x < skierX - 20 && skierImage.center.x < 220) {
            
            CGPoint skierLocation = CGPointMake(skierImage.center.x + 1,150);
            skierImage.center = skierLocation;
            [skierImage setImage:[UIImage imageNamed:@"skierRight.png"]];
            
        }else{
            
            [skierImage setImage: [UIImage imageNamed:@"skierDown.png"]];
            
        }
        
    }
    
}

-(void)skierLand: (id) sender{
    
    if(skijumpStatus == 1){
        
        [skierImage.layer removeAllAnimations];
        
        UIImage *skierDown = [UIImage imageNamed:@"skierDown.png"];
        [skierImage setImage:skierDown];
        skierImage.frame = CGRectMake(skierImage.frame.origin.x, skierImage.frame.origin.y, skierDown.size.width, skierDown.size.height);
        
        skierTimer = [NSTimer scheduledTimerWithTimeInterval:0.005
                                                      target:self
                                                    selector:@selector(skierMove:)
                                                    userInfo:nil
                                                     repeats:YES];
        
        skicollisionTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                             target:self
                                                           selector:@selector(skiCollison:)
                                                           userInfo:nil
                                                            repeats:YES];
        
        skijumpStatus = 0;
        
    }
    
}


- (IBAction)testHoldPress:(UILongPressGestureRecognizer *)sender {
    
    if(disableGesture == 1){
        sender.enabled = NO;
    }
    
    if([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged){
        
        if(startSkiing == 0){
            
            skijumpTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                            target:self
                                                          selector:@selector(skijumpMove:)
                                                          userInfo:nil
                                                           repeats:YES];
            
            startSkiing = 1;
        }
        
        skierX = [sender locationInView:self.view].x;
        
    }
    
    if([sender state] == UIGestureRecognizerStateEnded){
        skierX = skierImage.center.x;
    }
    
    
}

-(void)skijumpMove: (id) sender{
    
    skijumpImage.center = CGPointMake(skijumpImage.center.x, skijumpImage.center.y - 2);
    
    if(skijumpImage.center.y < -200){
         
        if(skijumpNumber > skijumpTotalNumber){
            
            UIImage *skierStop = [UIImage imageNamed:@"skierStop02.png"];
            [skierImage setImage:skierStop];
            skierImage.frame = CGRectMake(skierImage.frame.origin.x, skierImage.frame.origin.y, skierStop.size.width, skierStop.size.height);
            
            NSMutableArray *_skierStop = [[NSMutableArray alloc] initWithObjects:
                                          [UIImage imageNamed:@"skierStop00.png"],
                                          [UIImage imageNamed:@"skierStop01.png"],
                                          [UIImage imageNamed:@"skierStop02.png"],
                                          nil
                                          ];
            
            
            skierImage.animationImages=_skierStop;
            [skierImage setAnimationDuration:0.5];
            [skierImage setAnimationRepeatCount:1];
            [skierImage startAnimating];
            
            int InitialX = skierImage.center.x;
            int InitialY = skierImage.center.y;
            
            CGMutablePathRef aPath;
            CGFloat jumpDuration = 0.65;
            int arcTop = 40;
            int arcY = 20;
            
            aPath = CGPathCreateMutable();
            
            CGPathMoveToPoint(aPath, NULL, InitialX, InitialY);
            
            CGPathAddCurveToPoint(aPath, NULL, InitialX+10, InitialY+arcTop, InitialX+10, InitialY+arcTop, InitialX+arcY, InitialY+arcTop);
            
            CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
            
            [arcAnimation setDuration: jumpDuration];
            [arcAnimation setAutoreverses: NO];
            arcAnimation.removedOnCompletion = NO;
            arcAnimation.fillMode = kCAFillModeBoth;
            arcAnimation.delegate = self;
            [arcAnimation setPath: aPath];
            
            CFRelease(aPath);
            
            [[skierImage layer] addAnimation: arcAnimation forKey: @"sunAnimation"];
            
            [skierTimer invalidate];
            [skijumpTimer invalidate];
            [skicollisionTimer invalidate];
            [skislopeTimer invalidate];
            
            [NSTimer scheduledTimerWithTimeInterval:2
                                             target:self
                                           selector:@selector(swapViews)
                                           userInfo:nil
                                            repeats:NO];
            
            [NSTimer scheduledTimerWithTimeInterval:0.52
                                             target:self
                                           selector:@selector(skierSkid:)
                                           userInfo:nil
                                            repeats:NO];
            
            
        }else{
            
            skijumpImage.center = CGPointMake(arc4random() % 108 + 106, 700);
            
            int skijumpRandom = arc4random() % 3;
            
            if(skijumpRandom == 0){
                
                //Snowman
                NSMutableArray *_skijumpArray = [[NSMutableArray alloc] initWithObjects:
                                                 [UIImage imageNamed:@"skijump00.png"],
                                                 [UIImage imageNamed:@"skijump00.png"],
                                                 [UIImage imageNamed:@"skijump00.png"],
                                                 [UIImage imageNamed:@"skijump00.png"],
                                                 [UIImage imageNamed:@"skijump07.png"],
                                                 nil
                                                 ];
                skijumpImage.animationImages=_skijumpArray;
                [skijumpImage setAnimationDuration:2];
                [skijumpImage setAnimationRepeatCount:2];
                [skijumpImage startAnimating];
                
                
            } else if(skijumpRandom == 1){
                
                //Penguin
                NSMutableArray *_skijumpArray = [[NSMutableArray alloc] initWithObjects:
                                                 [UIImage imageNamed:@"skijump01.png"],
                                                 [UIImage imageNamed:@"skijump03.png"],
                                                 [UIImage imageNamed:@"skijump01.png"],
                                                 [UIImage imageNamed:@"skijump03.png"],
                                                 [UIImage imageNamed:@"skijump01.png"],
                                                 [UIImage imageNamed:@"skijump02.png"],
                                                 nil
                                                 ];
                
                skijumpImage.animationImages=_skijumpArray;
                [skijumpImage setAnimationDuration:2];
                [skijumpImage setAnimationRepeatCount:2];
                [skijumpImage startAnimating];
                
            } else {
                
                //Rabbit
                NSMutableArray *_skijumpArray = [[NSMutableArray alloc] initWithObjects:
                                                 [UIImage imageNamed:@"skijump04.png"],
                                                 [UIImage imageNamed:@"skijump04.png"],
                                                 [UIImage imageNamed:@"skijump04.png"],
                                                 [UIImage imageNamed:@"skijump05.png"],
                                                 [UIImage imageNamed:@"skijump06.png"],
                                                 [UIImage imageNamed:@"skijump05.png"],
                                                 [UIImage imageNamed:@"skijump06.png"],
                                                 [UIImage imageNamed:@"skijump05.png"],
                                                 [UIImage imageNamed:@"skijump06.png"],
                                                 [UIImage imageNamed:@"skijump05.png"],
                                                 nil
                                                 ];
                
                skijumpImage.animationImages=_skijumpArray;
                [skijumpImage setAnimationDuration:2];
                [skijumpImage setAnimationRepeatCount:2];
                [skijumpImage startAnimating];
                
            }
            
            skijumpNumber++;
            
        }
        
    }
    
}

-(void)skiSlopeMove: (id) sender{
    
    if(startSkiing == 1){
        
        if( skislopeImage.center.y < 130 && skijumpNumber <= skijumpTotalNumber){
            
            CGPoint skislopeLocation = CGPointMake( skislopeImage.center.x, 608);
            skislopeImage.center = skislopeLocation;
            
        }else{
            
            CGPoint skislopeLocation = CGPointMake( skislopeImage.center.x,skislopeImage.center.y - 2);
            skislopeImage.center = skislopeLocation;
            
        }
    }
}

-(void)skierSkid: (id) sender{
    
    disableGesture = 1;
    
    UIImage *skierJump  = [UIImage imageNamed:@"skierStop17.png"];
    [skierImage setImage:skierJump];
    
    NSMutableArray *_skierSkid = [[NSMutableArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"skierStop03.png"],
                                  [UIImage imageNamed:@"skierStop04.png"],
                                  [UIImage imageNamed:@"skierStop05.png"],
                                  [UIImage imageNamed:@"skierStop06.png"],
                                  [UIImage imageNamed:@"skierStop07.png"],
                                  [UIImage imageNamed:@"skierStop08.png"],
                                  [UIImage imageNamed:@"skierStop09.png"],
                                  [UIImage imageNamed:@"skierStop10.png"],
                                  [UIImage imageNamed:@"skierStop11.png"],
                                  [UIImage imageNamed:@"skierStop12.png"],
                                  [UIImage imageNamed:@"skierStop13.png"],
                                  [UIImage imageNamed:@"skierStop14.png"],
                                  [UIImage imageNamed:@"skierStop15.png"],
                                  [UIImage imageNamed:@"skierStop16.png"],
                                  [UIImage imageNamed:@"skierStop02.png"],
                                  [UIImage imageNamed:@"skierStop02.png"],
                                  [UIImage imageNamed:@"skierStop02.png"],
                                  [UIImage imageNamed:@"skierStop02.png"],
                                  [UIImage imageNamed:@"skierStop02.png"],
                                  nil
                                  ];
    
    skierImage.animationImages=_skierSkid;
    [skierImage setAnimationDuration:0.4];
    [skierImage setAnimationRepeatCount:1];
    [skierImage startAnimating];
    
}

-(void)swapViews{
    
    self.view.userInteractionEnabled = NO;
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Snow"];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
