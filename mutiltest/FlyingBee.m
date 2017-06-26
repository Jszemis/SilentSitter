//
//  FlyingBee.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 9/05/13.
//
//

#import "FlyingBee.h"
#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)

@implementation FlyingBee

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}
*/

- (void)startFlying{

    
   FlyingBeeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(FlyingBeeHover)
                                                userInfo:nil
                                                    repeats:NO];
    
    FlyingBeeAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                               target:self
                                                             selector:@selector(beeFlyingFlap)
                                                             userInfo:nil
                                                              repeats:YES];
}

-(void)StopFlying{
    
    [FlyingBeeTimer invalidate];
    [FlyingBeeAnimationTimer invalidate];    
    
}

-(void)beeFlyingFlap{
    
    float beeFlapDuration = 0.2;
    NSArray *beeFlap;
    beeFlap = [[NSArray alloc] initWithObjects:
               [UIImage imageNamed:@"BeeHouse-Frame1.png"],
               [UIImage imageNamed:@"BeeHouse-Frame2.png"],
               nil
               ];
    
    self.animationImages=beeFlap;
    [self setAnimationDuration:beeFlapDuration];
    [self setAnimationRepeatCount:1];
    [self startAnimating];
    
}


-(void)FlyingBeeHover{
    
    int beeCentreX = self.center.x;
    int beeCentreY = self.center.y;
    int beeFinalX = self.center.x; 
    int beeFinalY = self.center.y; 
    
    CGMutablePathRef aPath;
    CGFloat duration;
    aPath = CGPathCreateMutable();
    int beeFlyDestination = arc4random() % 11;
    
    
    if (beeFlyDestination == 1) {
    
        int randomFlower = arc4random() % 7;
        switch(randomFlower)
        {
            case 0:
                beeFinalX = 34;
                beeFinalY = 377;
                break;
            case 1:
                beeFinalX = 70;
                beeFinalY = 361;
                break;
            case 2:
                beeFinalX = 106;
                beeFinalY = 383;
                break;
            case 3:
                beeFinalX = 146;
                beeFinalY = 367;
                break;
            case 4:
                beeFinalX = 190;
                beeFinalY = 370;
                break;
            case 5:
                beeFinalX = 234;
                beeFinalY = 381;
                break;
            case 6:
                beeFinalX = 275;
                beeFinalY = 362;
                break;
        }
        
         double beeFlyDistance = sqrt(pow(fabs((float)beeCentreX - (float)beeFinalX),2) + pow(fabs((float)beeCentreY - (float)beeFinalY),2));
         if(beeFlyDistance < 0.1) beeFlyDistance = 0.1;
         duration = beeFlyDistance/60;
        
         CGPathMoveToPoint(aPath, NULL, beeCentreX, beeCentreY);
         CGPathAddLineToPoint(aPath,NULL, beeFinalX, beeFinalY);

    } else {
         
        int randomHoverDegree = arc4random() % 2;
        int beeFlySize = (arc4random() % 2) +2;
        duration = 0.5;
        
        if(randomHoverDegree == 1){
            CGPathAddArc(aPath,NULL,beeCentreX+beeFlySize,beeCentreY,beeFlySize,DEGREES_TO_RADIANS(180),DEGREES_TO_RADIANS(179),NO);
        }else{
            CGPathAddArc(aPath,NULL,beeCentreX-beeFlySize,beeCentreY,beeFlySize,DEGREES_TO_RADIANS(359),DEGREES_TO_RADIANS(0),YES);
        }
 
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
    
    self.frame = CGRectMake(beeFinalX -5, beeFinalY-5, 10, 10);
    
    FlyingBeeTimer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                      target:self
                                                    selector:@selector(FlyingBeeHover)
                                                    userInfo:nil
                                                     repeats:NO];
    
  
}

@end
