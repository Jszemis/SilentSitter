//
//  Sheep.m
//  sheep
//
//  Created by Lizzie Szemis on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sheep.h"
#import <QuartzCore/QuartzCore.h>

@implementation Sheep

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
       
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
     int randomStartGraze = arc4random() % 5 + 1;
    sheepTimer = [NSTimer scheduledTimerWithTimeInterval:randomStartGraze
                                     target:self
                                   selector:@selector(sheepHeadDown)
                                   userInfo:nil
                                    repeats:NO];    
     
}


- (IBAction) sheepJump: (id) sender {
    
    [delegate changeSheepJump:self];
    
    [sheepTimer invalidate];
   // sheepTimer = nil;
    
    int InitialX = self.center.x;
    int InitialY = self.center.y; 
    self.adjustsImageWhenDisabled = NO;
    self.enabled = NO;
    
    if(self.imageView.isAnimating){
        [self.imageView stopAnimating];      
    }    
    UIImage * btnImage1 = [UIImage imageNamed:@"sheepjump.png"];
    [self setImage:btnImage1 forState:UIControlStateNormal];
    self.enabled = NO;    
    CGMutablePathRef aPath;
    int arcTop = 50;
    CGFloat duration = 0.9;
    
    aPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, NULL, InitialX, InitialY);
    
    CGPathAddCurveToPoint(aPath, NULL, 180, InitialY-arcTop, 180, InitialY-arcTop, 320-InitialX, InitialY);        
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth; 
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath];
    CFRelease(aPath);
    
    [[self layer] addAnimation: arcAnimation forKey: @"test2222"];
    
    [UIView beginAnimations: [NSString stringWithFormat: @"test2222"] context: nil];
    [UIView setAnimationDuration: duration];
    [UIView commitAnimations];
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    
    [sheepTimer invalidate];
    //sheepTimer = nil;
    
    if(theAnimation == [[self layer] animationForKey:@"test2222"] ){
        UIImage * btnImage1 = [UIImage imageNamed:@"sheep.png"];
        [self setImage:btnImage1 forState:UIControlStateNormal]; 
       
        int randomRepeat = arc4random() % 5 + 1;               
        int SheepCount = [delegate numberOfSheepJump:self];
         
        if(SheepCount == 0){
            sheepTimer = [NSTimer scheduledTimerWithTimeInterval:randomRepeat
                                                          target:self
                                                        selector:@selector(sheepGoToSleep)
                                                        userInfo:nil
                                                         repeats:NO]; 
        }else{
            sheepTimer = [NSTimer scheduledTimerWithTimeInterval:randomRepeat
                                                          target:self
                                                        selector:@selector(sheepHeadDown)
                                                        userInfo:nil
                                                         repeats:NO];         
        }
        
    }

    
}


-(void)sheepHeadDown{
    
    [self setImage:[UIImage imageNamed:@"sheepeat-frame06.png"] forState:UIControlStateNormal];
    
    float sheepHeadDownDuration = 0.6;
    NSArray *sheepHeadDown;
    sheepHeadDown = [[NSArray alloc] initWithObjects:
                     [UIImage imageNamed:@"sheepeat-frame01.png"],
                     [UIImage imageNamed:@"sheepeat-frame02.png"],
                     [UIImage imageNamed:@"sheepeat-frame03.png"],
                     [UIImage imageNamed:@"sheepeat-frame04.png"],
                     [UIImage imageNamed:@"sheepeat-frame05.png"],
                     [UIImage imageNamed:@"sheepeat-frame06.png"],
                     nil
                     ];
    
    self.imageView.animationImages=sheepHeadDown;
    [self.imageView setAnimationDuration:sheepHeadDownDuration];
    [self.imageView setAnimationRepeatCount:1];
    
    [self.imageView startAnimating]; 
    
    NSNumber *startStage = [NSNumber numberWithInt: 1];
    
    sheepTimer = [NSTimer scheduledTimerWithTimeInterval:sheepHeadDownDuration - 0.05
                                                   target:self
                                                 selector:@selector(sheepGraze:)
                                                 userInfo:startStage
                                                  repeats:NO];
    
}


-(void)sheepGraze:(NSTimer*)aTimer{
    
    NSNumber *aStage = aTimer.userInfo;
    int x;
    float sheepGrazeDuration = 0;
    NSString *sheepEatFrame1;
    NSString *sheepEatFrame2;

    NSMutableArray *sheepGraze = [[NSMutableArray alloc] initWithCapacity:1];
    int randomGraze = arc4random() % 5 + 2;
    
    if ([aStage integerValue] == 1) {
        sheepEatFrame1 = @"sheepeat-frame07.png";
        sheepEatFrame2 = @"sheepeat-frame08.png";
        aStage = [NSNumber numberWithInt: 2];
    }else if([aStage integerValue] == 2){
        sheepEatFrame1 = @"sheepeat-frame09.png";
        sheepEatFrame2 = @"sheepeat-frame10.png";
        aStage = [NSNumber numberWithInt: 3];        
    }else if([aStage integerValue] == 3){
        sheepEatFrame1 = @"sheepeat-frame07.png";
        sheepEatFrame2 = @"sheepeat-frame08.png";
        aStage = [NSNumber numberWithInt: 4];
    }else{
        sheepEatFrame1 = @"sheepeat-frame11.png";
        sheepEatFrame2 = @"sheepeat-frame12.png";
        aStage = [NSNumber numberWithInt: 5];        
    }
    
    for(x=1; x<=randomGraze;x++){
        [sheepGraze addObject:[UIImage imageNamed:sheepEatFrame1]];
        [sheepGraze addObject:[UIImage imageNamed:sheepEatFrame2]];    
        sheepGrazeDuration = sheepGrazeDuration + 0.2; 
    }
    [sheepGraze addObject:[UIImage imageNamed:sheepEatFrame1]];
    [sheepGraze addObject:[UIImage imageNamed:sheepEatFrame2]];
    sheepGrazeDuration = sheepGrazeDuration + 0.2;   
    
    self.imageView.animationImages=sheepGraze;
    [self.imageView setAnimationDuration:sheepGrazeDuration];
    [self.imageView setAnimationRepeatCount:1];
    
    [self.imageView startAnimating];   
    
    if([aStage integerValue] == 4) {
        sheepTimer = [NSTimer scheduledTimerWithTimeInterval:sheepGrazeDuration - 0.05
                                                       target:self
                                                     selector:@selector(sheepHeadUp)
                                                     userInfo:nil
                                                      repeats:NO];   
    }else if([aStage integerValue] == 5) {
        
        
        int SheepCount = [delegate numberOfSheepJump:self];

        if(SheepCount == 0){
            sheepTimer = [NSTimer scheduledTimerWithTimeInterval:sheepGrazeDuration -00.5
                                                          target:self
                                                        selector:@selector(sheepGoToSleep)
                                                        userInfo:nil
                                                         repeats:NO];  
        }else{
            sheepTimer = [NSTimer scheduledTimerWithTimeInterval:sheepGrazeDuration + randomGraze
                                                          target:self
                                                        selector:@selector(sheepHeadDown)
                                                        userInfo:nil
                                                         repeats:NO];          
        }
       
        
        
    }else{
        sheepTimer = [NSTimer scheduledTimerWithTimeInterval:sheepGrazeDuration - 0.05
                                                       target:self
                                                     selector:@selector(sheepGraze:)
                                                     userInfo:aStage
                                                      repeats:NO];   
    }
    
}


-(void)sheepHeadUp{
    
    [self setImage:[UIImage imageNamed:@"sheepeat-frame12.png"] forState:UIControlStateNormal];
    
    float sheepHeadUpDuration = 0.6;
    NSArray *sheepHeadUp;
    sheepHeadUp = [[NSArray alloc] initWithObjects:        
                   [UIImage imageNamed:@"sheepeat-frame06.png"],
                   [UIImage imageNamed:@"sheepeat-frame05.png"],
                   [UIImage imageNamed:@"sheepeat-frame04.png"],
                   [UIImage imageNamed:@"sheepeat-frame03.png"],
                   [UIImage imageNamed:@"sheepeat-frame02.png"],
                   [UIImage imageNamed:@"sheepeat-frame01.png"],
                   [UIImage imageNamed:@"sheepeat-frame12.png"], 
                   nil
                   ];  
    
    self.imageView.animationImages=sheepHeadUp;
    [self.imageView setAnimationDuration:sheepHeadUpDuration];
    [self.imageView setAnimationRepeatCount:1];
    [self.imageView startAnimating];
    
    NSNumber *startStage = [NSNumber numberWithInt: 5];
    
    sheepTimer = [NSTimer scheduledTimerWithTimeInterval:sheepHeadUpDuration - 0.05
                                                   target:self
                                                 selector:@selector(sheepGraze:)
                                                 userInfo:startStage
                                                  repeats:NO];  
    
}
    
    
-(void)sheepGoToSleep{
    
    
    [self setImage:[UIImage imageNamed:@"sheepsleep-frame09.png"] forState:UIControlStateNormal];
    
    float sheepGoToSleepDuration = 0.6;
    NSArray *sheepGoToSleep;
    sheepGoToSleep = [[NSArray alloc] initWithObjects:        
                   [UIImage imageNamed:@"sheepsleep-frame02.png"],
                   [UIImage imageNamed:@"sheepsleep-frame03.png"],
                   [UIImage imageNamed:@"sheepsleep-frame04.png"],
                   [UIImage imageNamed:@"sheepsleep-frame05.png"],
                   [UIImage imageNamed:@"sheepsleep-frame06.png"],
                   [UIImage imageNamed:@"sheepsleep-frame07.png"],
                   [UIImage imageNamed:@"sheepsleep-frame08.png"],
                   [UIImage imageNamed:@"sheepsleep-frame09.png"],
                   nil
                   ];  
    
    self.imageView.animationImages=sheepGoToSleep;
    [self.imageView setAnimationDuration:sheepGoToSleepDuration];
    [self.imageView setAnimationRepeatCount:1];
    [self.imageView startAnimating];
        
    sheepTimer = [NSTimer scheduledTimerWithTimeInterval:sheepGoToSleepDuration - 0.05
                                                  target:self
                                                selector:@selector(sheepSleep)
                                                userInfo:nil
                                                 repeats:NO];  
    
}

-(void)sheepSleep{
    
    
    
    float sheepSleepDuration = 4;
    NSArray *sheepSleep;
    sheepSleep = [[NSArray alloc] initWithObjects:        
                      [UIImage imageNamed:@"sheepsleep-frame10.png"],
                      [UIImage imageNamed:@"sheepsleep-frame11.png"],
                      [UIImage imageNamed:@"sheepsleep-frame12.png"],
                      [UIImage imageNamed:@"sheepsleep-frame13.png"],
                    nil
                      ];  
    
    self.imageView.animationImages=sheepSleep;
    [self.imageView setAnimationDuration:sheepSleepDuration];
    [self.imageView setAnimationRepeatCount:1000];
    [self.imageView startAnimating];
    
}

@end
