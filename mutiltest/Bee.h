//
//  Bee.h
//  mutiltest
//
//  Created by Lizzie Szemis on 23/08/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Bee;

@protocol BeeDelegate <NSObject>

-(void)beeSwapView:(Bee *)beeParameter;
-(void)disableHive:(Bee *)beeParameter;
-(void)beeCloseFlower:(Bee *)beeParameter;
-(void)beePress:(Bee *)beeParameter;
    
@end

@interface Bee : UIButton <CAAnimationDelegate>
{
    NSTimer *beeHoverTimer;
    NSTimer *beeFlapWingsTimer;
    float beeX1,beeX2,beeX3;
    float beeY1,beeY2,beeY3;
    float beeCentreX;
    float beeCentreY;
    float beeFlySize;
    float beeFlyTimer;
}

@property (strong, nonatomic) id<BeeDelegate> delegate;

-(void)beeFlap;
-(void)beeHover;
-(void)beeMove;
-(void)beeResetValues;
-(void)beeFlyAway;
-(void)beeGoHome;
-(void)beeFlapReset;
-(void)flowerClose;
-(IBAction)BeePress:(id)sender;
 
@end
