//
//  Flower.h
//  mutiltest
//
//  Created by Lizzie Szemis on 24/08/12.
//
//

#import <UIKit/UIKit.h>
#import "BeeViewController.h"

@class Flower;

@interface Flower : UIButton{
    int FlowerFade;
    NSTimer *FlowerFadeTimer;
}

-(void)FlowerFadeIn;
-(void)FlowerFadeOut;
-(IBAction)FlowerPress:(id)sender;
-(void)FlowerFinished;

@end




