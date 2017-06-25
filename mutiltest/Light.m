//
//  Light.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 13/12/12.
//
//

#import "Light.h"

@implementation Light

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
    
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(LightTwinkle)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)LightTwinkle{
    
    [self stopAnimating];
    
    float TwinkleDurations = (float)(arc4random() % 10)/10 + 1;
    
    NSArray *twinkleArray;
    twinkleArray = [[NSArray alloc] initWithObjects:     
               [UIImage imageNamed:@"christmaslightclear.png"],
               [UIImage imageNamed:@"christmaslight.png"],
               nil
               ];
    
    self.animationImages=twinkleArray;
    [self setAnimationDuration:TwinkleDurations];
    [self setAnimationRepeatCount:HUGE_VALF];
    [self startAnimating];
  
}

@end


