//
//  FishViewController.h
//  mutiltest
//
//  Created by Lizzie Szemis on 2/10/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Bird.h"

UIBezierPath *linePath;
CAShapeLayer *lineDraw;
int linePathStartX;
int linePathStartY;
int linePathEndX;
int linePathEndY;
int linePathApexX;
int linePathApexY;
CAShapeLayer *hookLayer;
int CastFlag;
NSTimer *fishermanWaveTimer;
int fishCount;

@interface FishViewController : UIViewController 

@property (nonatomic,strong) IBOutlet UIImageView *SplashImage;
@property (nonatomic,strong) IBOutlet UIImageView *FishermanImage;
@property (nonatomic,strong) IBOutlet UIImageView *FishImage;
@property (nonatomic,strong) IBOutlet UIImageView *WhaleImage;
@property (nonatomic, strong) IBOutletCollection(Bird) NSArray *BirdCollection;

-(void)didRecognizeCheckmark:(UIGestureRecognizer*)gestureRecognizer;
-(void)FishermanWave;
-(void)LineLands;
-(void)LineBack;
-(void)FishJump;
-(void)WhaleJump;
-(void)WhaleWater;
-(void)ResetLines;
-(void)swapViews;

@end











