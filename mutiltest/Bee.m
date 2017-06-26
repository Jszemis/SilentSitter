//
//  Bee.m
//  mutiltest
//
//  Created by Lizzie Szemis on 23/08/12.
//
//

#import "Bee.h"
#import <QuartzCore/QuartzCore.h>
#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)


@implementation Bee

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(IBAction)BeePress:(id)sender{
    
    extern int gbeePressFlag;
    
    if(gbeePressFlag == 1){
        
        [delegate beePress:self];
    }
    gbeePressFlag = 0;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{


    extern int gBeeFlyFlag;
    gBeeFlyFlag = 0;
    extern float gBeeFlyX;
    gBeeFlyX = self.center.x;
    extern float gBeeFlyY;
    gBeeFlyY = self.center.y;
    extern int gFlowerCount;
    gFlowerCount = 0;
    extern int gFlowerFlag;
    gFlowerFlag = 0;   
    extern float gFlowerCloseX;
    gFlowerCloseX = 0;
    extern float gFlowerCloseY;
    gFlowerCloseY = 0;
    extern int gbeePressFlag;
    gbeePressFlag = 0;
  
    extern NSString *gbeeFlap1;
    gbeeFlap1 = @"BeeFlap15-Frame1.png";
    extern NSString *gbeeFlap2;
    gbeeFlap2 = @"BeeFlap15-Frame2.png";

    self.imageView.image = [UIImage imageNamed:gbeeFlap1];
    
    beeCentreX = self.center.x;
    beeCentreY = self.center.y;

    beeFlySize = 3;
    beeFlyTimer = 0.5;
     
    beeHoverTimer = [NSTimer scheduledTimerWithTimeInterval:beeFlyTimer
                                                  target:self
                                                selector:@selector(beeHover)
                                                userInfo:nil
                                                 repeats:YES];
    
    beeFlapWingsTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                    target:self
                                                  selector:@selector(beeFlap)
                                                  userInfo:nil
                                                   repeats:YES];
    
    
}

-(void)beeFlap{
    
    extern NSString *gbeeFlap1;
    extern NSString *gbeeFlap2;
    
    self.imageView.image = [UIImage imageNamed:gbeeFlap1];
    
    float beeFlapDuration = 0.2;
    NSArray *beeFlap;
    beeFlap = [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:gbeeFlap1],
                      [UIImage imageNamed:gbeeFlap2],
                      nil
                      ];
    
    self.imageView.animationImages=beeFlap;
    [self.imageView setAnimationDuration:beeFlapDuration];
    [self.imageView setAnimationRepeatCount:1];
    [self.imageView startAnimating];
    
}

-(void)beeHover{
    
    extern int gFlowerCount;
    extern int gBeeFlyFlag;
    extern float gBeeFlyX;    
    extern float gBeeFlyY;
    extern int gbeePressFlag;
    
    if(gBeeFlyFlag == 0){

    gbeePressFlag = 1;
        
    CGMutablePathRef aPath;
    CGFloat duration = beeFlyTimer;
    
    aPath = CGPathCreateMutable();
 
    int randomHoverDegree = arc4random() % 2;
    beeFlySize = (arc4random() % 2) +2;

    if(randomHoverDegree == 1){
        CGPathAddArc(aPath,NULL,beeCentreX+beeFlySize,beeCentreY,beeFlySize,DEGREES_TO_RADIANS(180),DEGREES_TO_RADIANS(179),NO);
    }else{
        CGPathAddArc(aPath,NULL,beeCentreX-beeFlySize,beeCentreY,beeFlySize,DEGREES_TO_RADIANS(359),DEGREES_TO_RADIANS(0),YES);
    }
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
    
    [[self layer] addAnimation: arcAnimation forKey: @"sunAnimation"];
    
    [UIView beginAnimations: [NSString stringWithFormat: @"sunAnimation"] context: nil];
    [UIView setAnimationDuration: duration];
    [UIView commitAnimations];

    }else{
   
        [beeHoverTimer invalidate];
        
        gbeePressFlag = 0;
        
        CGMutablePathRef aPath;
        CGFloat duration = 1;//1.5
        
        aPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(aPath, NULL, beeCentreX, beeCentreY);

        CGPathAddCurveToPoint(aPath, NULL, gBeeFlyX, gBeeFlyY - beeCentreY, beeCentreX - gBeeFlyX, beeCentreY, gBeeFlyX, gBeeFlyY);

        CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [arcAnimation setDuration: duration];
        [arcAnimation setAutoreverses: NO];
        arcAnimation.removedOnCompletion = NO;
        arcAnimation.fillMode = kCAFillModeBoth;
        arcAnimation.delegate = self;
        [arcAnimation setPath: aPath];
        
        CFRelease(aPath);
        
        [[self layer] addAnimation: arcAnimation forKey: @"sunAnimation"];
        
        [UIView beginAnimations: [NSString stringWithFormat: @"sunAnimation"] context: nil];
        [UIView setAnimationDuration: duration];
        [UIView commitAnimations];
        
        beeCentreX = gBeeFlyX;
        beeCentreY = gBeeFlyY;
        
        [NSTimer scheduledTimerWithTimeInterval:(duration - beeFlyTimer)
                                                         target:self
                                                       selector:@selector(beeMove)
                                                       userInfo:nil
                                                        repeats:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:duration
                                         target:self
                                       selector:@selector(beeResetValues)
                                       userInfo:nil
                                        repeats:NO];
        
    }
    
}

-(void)beeMove{
    
    [self flowerClose];
        
    beeHoverTimer = [NSTimer scheduledTimerWithTimeInterval:beeFlyTimer
                                                     target:self
                                                   selector:@selector(beeHover)
                                                   userInfo:nil
                                                    repeats:YES];
     
}

-(void)flowerClose{

    [delegate beeCloseFlower:self];

    extern float gBeeFlyX;
    extern float gBeeFlyY;
    extern float gFlowerCloseX;
    extern float gFlowerCloseY;
    
    gFlowerCloseX = gBeeFlyX;
    gFlowerCloseY = gBeeFlyY;
    
}


-(void)beeResetValues{
            
    extern int gBeeFlyFlag;
    extern int gFlowerCount;

    extern NSString *gbeeFlap1;
    extern NSString *gbeeFlap2;
    
    int beeNextSize = 5 + [[gbeeFlap1 substringWithRange:NSMakeRange(7, 2)] intValue];
    
    gbeeFlap1 = [NSString stringWithFormat:@"BeeFlap%i%@",beeNextSize,@"-Frame1.png"];
    gbeeFlap2 = [NSString stringWithFormat:@"BeeFlap%i%@",beeNextSize,@"-Frame2.png"];

    self.frame = CGRectMake(beeCentreX-25, beeCentreY-25, 50, 50);
    
    gBeeFlyFlag = 0;
    
    if(gFlowerCount == 7){
        
        gFlowerCount = 8;
        [NSTimer scheduledTimerWithTimeInterval:1.5
                                         target:self
                                       selector:@selector(beeFlyAway)
                                       userInfo:nil
                                        repeats:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:2
                                         target:self
                                       selector:@selector(flowerClose)
                                       userInfo:nil
                                        repeats:NO];

    }
 
}

-(void)beeFlyAway{
    
    [beeHoverTimer invalidate];
    
    extern float gBeeFlyX;
    extern float gBeeFlyY;
    
    gBeeFlyX = 360;
    gBeeFlyY = 50;
    
    CGMutablePathRef aPath;
    CGFloat duration = 1.5;//2
    
    aPath = CGPathCreateMutable();
    
    
    CGPathMoveToPoint(aPath, NULL, beeCentreX, beeCentreY);
    
    CGPathAddCurveToPoint(aPath, NULL, gBeeFlyX, gBeeFlyY - beeCentreY, beeCentreX - gBeeFlyX, beeCentreY, gBeeFlyX, gBeeFlyY);
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
    
    [[self layer] addAnimation: arcAnimation forKey: @"sunAnimation"];
    
    [UIView beginAnimations: [NSString stringWithFormat: @"sunAnimation"] context: nil];
    [UIView setAnimationDuration: duration];
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:3//3.5
                                     target:self
                                   selector:@selector(beeGoHome)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5//2
                                     target:self
                                   selector:@selector(beeFlapReset)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)beeFlapReset{
    
    [beeFlapWingsTimer invalidate];
}


-(void)beeGoHome{
    
    [delegate disableHive:self];
    
    extern int gBeeFlyFlag;
    extern int gFlowerCount;
    gBeeFlyFlag = 0;

    UIImage *beeImage = [UIImage imageNamed:@"LittleBee.png"];
    self.frame = CGRectMake(50, 10, beeImage.size.width, beeImage.size.height);

    float beeFlapDuration = 4;
    NSArray *beeFlap;
    beeFlap = [[NSArray alloc] initWithObjects:
               [UIImage imageNamed:@"LittleBee.png"],
               nil
               ];
    
    self.imageView.animationImages=beeFlap;
    [self.imageView setAnimationDuration:beeFlapDuration];
    [self.imageView setAnimationRepeatCount:1];
    [self.imageView startAnimating];
 
    CGMutablePathRef aPath;
    CGFloat duration = 2;
    
    aPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, NULL, 110, -10);    
    CGPathAddCurveToPoint(aPath, NULL, 120, 10, 80, 57, 40, 56);
      
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth;
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    
    CFRelease(aPath);
    
    [[self layer] addAnimation: arcAnimation forKey: @"sunAnimation"];
    
    [UIView beginAnimations: [NSString stringWithFormat: @"sunAnimation"] context: nil];
    [UIView setAnimationDuration: duration];
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:3
                                     target:self
                                   selector:@selector(beeSwapViews)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)beeSwapViews{

        [delegate beeSwapView:self];
}

@end
