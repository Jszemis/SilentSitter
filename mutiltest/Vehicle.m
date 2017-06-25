//
//  Vehicle.m
//  mutiltest
//
//  Created by Lizzie Szemis on 12/09/12.
//
//

#import "Vehicle.h"
#import <QuartzCore/QuartzCore.h>

#define degreesToRadians(x) (M_PI * x / 180.0)

@implementation Vehicle

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

    [self VehicleStopAnim:0];

}

-(void)VehicleStopAnim:(int)localwidget{
    
    NSString *outputLable1 = [NSString stringWithFormat:@"Vehicle%i%@",localwidget,@"-frame1.png"];
    NSString *outputLable2 = [NSString stringWithFormat:@"Vehicle%i%@",localwidget,@"-frame2.png"];
    
    float vehicleFlapDuration = 0.2;
    NSArray *vehicleFlap;
    vehicleFlap = [[NSArray alloc] initWithObjects:
               [UIImage imageNamed:outputLable1],
               [UIImage imageNamed:outputLable2],
               nil
               ];
    
    [self stopAnimating];
    [self.layer removeAllAnimations];
    self.animationImages=vehicleFlap;
    [self setAnimationDuration:vehicleFlapDuration];
    [self setAnimationRepeatCount:HUGE_VALF];
    [self startAnimating];
    
    if(localwidget == 6){
        
        [self stopAnimating];
        
        float vehicleFlapDuration = 0.8;
        NSArray *vehicleFlap;
        vehicleFlap = [[NSArray alloc] initWithObjects:

                   [UIImage imageNamed:@"Vehicle8-frame1.png"],
                   [UIImage imageNamed:@"Vehicle8-frame2.png"],
                   [UIImage imageNamed:@"Vehicle8-frame1.png"],
                   [UIImage imageNamed:@"Vehicle8-frame2.png"],
                   [UIImage imageNamed:@"Vehicle9-frame1.png"],
                   [UIImage imageNamed:@"Vehicle9-frame2.png"],
                   [UIImage imageNamed:@"Vehicle9-frame1.png"],
                   [UIImage imageNamed:@"Vehicle9-frame2.png"],
                   
                   nil
                   ];
        
        [self stopAnimating];
        [self.layer removeAllAnimations];
        self.animationImages=vehicleFlap;
        [self setAnimationDuration:vehicleFlapDuration];
        [self setAnimationRepeatCount:HUGE_VALF];
        [self startAnimating];

    }
    
}

@end
