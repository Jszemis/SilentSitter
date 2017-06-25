//
//  VehicleViewController.h
//  mutiltest
//
//  Created by Lizzie Szemis on 12/09/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Vehicle.h"
#import "Widget.h"

#define degreesToRadians(x) (M_PI * x / 180.0)
#define P(x,y) CGPointMake(x, y)

@interface VehicleViewController : UIViewController <UIGestureRecognizerDelegate> {
    int widgetCount;
    int vehicleCollisionFlag;
    int vehicleMoveFlag;
    int vehicleClickFlag;
    int vehicleChangeFlag;

    UIBezierPath *linePath;
    CAShapeLayer *lineLayer;
    float linePathLength;
    float linePathLengthX;
    float linePathLengthY;
    
    UIBezierPath *flyPath;
    CAShapeLayer *flyLayer;
    float flyPathLength;
    float flyPathLengthX;
    float flyPathLengthY;
    
    NSTimer *vehicleResetTimer;
    NSTimer *OceanMoveTimer;
    NSTimer *MoveShadowTimer;
    
}

@property (nonatomic,strong) IBOutlet UIImageView *ladder;
@property (nonatomic,strong) IBOutlet UIImageView *OceanTop;
@property (nonatomic,strong) IBOutlet UIImageView *OceanBottom;
@property (nonatomic,strong) IBOutlet UIImageView *Shadow;
@property (nonatomic,strong) IBOutlet Vehicle *vehicle;
@property (nonatomic, strong) IBOutletCollection(Widget) NSArray *WidgetCollection;

-(void)DownLadder;
-(void)UpLadder;
-(void)OceanMove:(id)sender;
-(void)swapViews;
-(void)MoveShadow;

@end
