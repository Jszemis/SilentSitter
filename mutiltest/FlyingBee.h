//
//  FlyingBee.h
//  Silent Sitter
//
//  Created by Lizzie Szemis on 9/05/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FlyingBee : UIImageView{

    NSTimer *FlyingBeeTimer;
    NSTimer *FlyingBeeAnimationTimer;
    
}

- (void)startFlying;
- (void)beeFlyingFlap;
- (void)StopFlying;

@end
