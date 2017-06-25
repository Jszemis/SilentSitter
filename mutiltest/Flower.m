//
//  Flower.m
//  mutiltest
//
//  Created by Lizzie Szemis on 24/08/12.
//
//

#import "Flower.h"
#import <QuartzCore/QuartzCore.h>

@implementation Flower

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

 - (void)drawRect:(CGRect)rect
{
    // Drawing code
    if(FlowerFade == 0){
        FlowerFade = 1;        
        FlowerFadeTimer = [NSTimer scheduledTimerWithTimeInterval:2.5
                                                                           target:self
                                                                         selector:@selector(FlowerFadeIn)
                                                                         userInfo:nil
                                                                          repeats:NO];
        
    }
    
}

-(void)FlowerFadeIn{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    [self.imageView setAlpha:0];
    [UIView commitAnimations];
    
    FlowerFadeTimer = [NSTimer scheduledTimerWithTimeInterval:1.2
                                                       target:self
                                                     selector:@selector(FlowerFadeOut)
                                                     userInfo:nil
                                                      repeats:NO];
    
}

-(void)FlowerFadeOut{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [self.imageView setAlpha:1];
    [UIView commitAnimations];
    
    FlowerFadeTimer = [NSTimer scheduledTimerWithTimeInterval:8
                                                       target:self
                                                     selector:@selector(FlowerFadeIn)
                                                     userInfo:nil
                                                      repeats:NO];
    
}

- (IBAction) FlowerPress: (id) sender {
    
    extern int gBeeFlyFlag;
    extern float gBeeFlyX;
    extern float gBeeFlyY;
    extern int gFlowerCount;
    extern int gFlowerFlag;
    
    if(gFlowerFlag == 0){
        gFlowerFlag = 1;
        gBeeFlyFlag = 1;
        gFlowerCount++;
        gBeeFlyY = self.center.y;
        gBeeFlyX = self.center.x;
        
        [NSTimer scheduledTimerWithTimeInterval:1.5 //2
                                         target:self
                                       selector:@selector(FlowerFinished)
                                       userInfo:nil
                                        repeats:NO];
         
    }
    
}

-(void)FlowerFinished{
    
    [FlowerFadeTimer invalidate];
    extern int gFlowerFlag;
    self.enabled = NO;
    self.hidden = YES;
    gFlowerFlag = 0;
    
}


@end


