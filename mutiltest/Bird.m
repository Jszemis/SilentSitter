//
//  Bird.m
//  mutiltest
//
//  Created by Lizzie Szemis on 5/10/12.
//
//

#import "Bird.h"

@implementation Bird

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

    birdInitialX = self.center.x;
    birdInitialY = self.center.y;
    
    int FlapDurations = arc4random() % 5 + 2;
    
    birdFlapTimer = [NSTimer scheduledTimerWithTimeInterval:FlapDurations
                                     target:self
                                   selector:@selector(BirdFlap)
                                   userInfo:nil
                                    repeats:NO];
    
    birdMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.15
                                     target:self
                                   selector:@selector(BirdMove)
                                   userInfo:nil
                                    repeats:YES];
    
    
}

-(void)BirdFlap{
    
    [self stopAnimating];
    
    float beeFlapDuration = 0.8;
    NSArray *beeFlap;
    beeFlap = [[NSArray alloc] initWithObjects:
                   
               [UIImage imageNamed:@"Bird-frame01.png"],
               [UIImage imageNamed:@"Bird-frame02.png"],
               [UIImage imageNamed:@"Bird-frame03.png"],
               [UIImage imageNamed:@"Bird-frame04.png"],
               [UIImage imageNamed:@"Bird-frame05.png"],
               [UIImage imageNamed:@"Bird-frame04.png"],
               [UIImage imageNamed:@"Bird-frame03.png"],
               [UIImage imageNamed:@"Bird-frame02.png"],
               [UIImage imageNamed:@"Bird-frame01.png"],
               nil
               ];
    
    self.animationImages=beeFlap;
    [self setAnimationDuration:beeFlapDuration];
    [self setAnimationRepeatCount:1];
    [self startAnimating];
    
    int FlapDurations = arc4random() % 8 + 2;
    
    birdFlapTimer = [NSTimer scheduledTimerWithTimeInterval:FlapDurations
                                     target:self
                                   selector:@selector(BirdFlap)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)BirdMove{
    
    int randomX = (arc4random() % 3) - 1;
    int randomY = (arc4random() % 3) - 1;
    
    if(self.center.x < birdInitialX - 3){
        randomX = 1;
    }
    
    if(self.center.x > birdInitialX + 3){
        randomX = -1;
    }
    
    if(self.center.y < birdInitialY - 3){
        randomY = 1;
    }
    
    if(self.center.y > birdInitialY + 3){
        randomY = -1;
    }
    
    CGPoint widgetLocation = CGPointMake(self.center.x + randomX,self.center.y + randomY);
    self.center = widgetLocation;
    
}

@end
