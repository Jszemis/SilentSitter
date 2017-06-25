//
//  Petal.m
//  mutiltest
//
//  Created by Lizzie Szemis on 17/09/12.
//
//

#import "Petal.h"

@implementation Petal

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)FlowerRotate{
    {
        // Drawing code
        CABasicAnimation *daisyRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        daisyRotation.fromValue = [NSNumber numberWithFloat:0];
        daisyRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        daisyRotation.duration = 60;
        daisyRotation.repeatCount = 1000;
        [[self layer] addAnimation: daisyRotation forKey:@"Daisy360"];
        
    }
}



@end
