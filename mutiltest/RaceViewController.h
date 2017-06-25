//
//  RaceViewController.h
//  Silent Sitter
//
//  Created by Lizzie Szemis on 12/02/13.
//
//

#import <UIKit/UIKit.h>
#import "Horse.h"

@interface RaceViewController : UIViewController{
        CADisplayLink *racegameloop;
        CADisplayLink *horsegameloop;
        int disableGesture;
        int backgroundcount;
    
        float HorseCowboyStartX;
        float HorsePrincessStartX;
        float HorseJockeyStartX;
        float HorseKnightStartX;
    
        NSString *HorseWinner;
    
}

@property (nonatomic,strong) IBOutlet UIImageView *RaceClouds;
@property (nonatomic,strong) IBOutlet UIImageView *RaceMountains;
@property (nonatomic,strong) IBOutlet UIImageView *RaceHills;
@property (nonatomic,strong) IBOutlet UIImageView *RaceForest;
@property (nonatomic,strong) IBOutlet UIImageView *RaceTrees;
@property (nonatomic,strong) IBOutlet UIImageView *RaceGrass;

@property (nonatomic,strong) IBOutlet UIImageView *JockeyCup;
@property (nonatomic,strong) IBOutlet UIImageView *CowboyHat;
@property (nonatomic,strong) IBOutlet UIImageView *ButterflyBlue;
@property (nonatomic,strong) IBOutlet UIImageView *ButterflyOrange;
@property (nonatomic,strong) IBOutlet UIImageView *ButterflyPink;
@property (nonatomic,strong) IBOutlet UIImageView *ButterflyRed;
@property (nonatomic,strong) IBOutlet UIImageView *ButterflyYellow;
@property (nonatomic,strong) IBOutlet UIImageView *HorseWater;

@property (nonatomic,strong) IBOutlet Horse *HorseCowboy;
@property (nonatomic,strong) IBOutlet Horse *HorsePrincess;
@property (nonatomic,strong) IBOutlet Horse *HorseKnight;
@property (nonatomic,strong) IBOutlet Horse *HorseJockey;

-(void)BackgroundMoving;
-(void)HorseMoving;
-(void)FinishingRace;
-(int)HorseFinish: (Horse *) pHorse withFinish:(float)pFinish withStartX:(float)pStartX;
-(void)HorseMove: (Horse *) pHorse;
-(void)HorseVictory;
-(void)CowboyHatThrow;
-(void)CowboyHatShoot;
-(void)ButterFlyAnimation:(UIImageView *) pButterFly withColour:(NSString *) pColour withTime:(float) pTime withCenterX:(int) pCenterX withCenterY:(int) pCenterY withHieght:(int) pHieght withWidth:(int) pWidth withSpeed:(float) pSpeed;
-(void)ButterFlyPath:(UIImageView *) pButterFly withCenterX:(int) pCenterX withCenterY:(int) pCenterY withHieght:(int) pHieght withWidth:(int) pWidth withSpeed:(float) pSpeed;
-(void)swapViews;

@end
