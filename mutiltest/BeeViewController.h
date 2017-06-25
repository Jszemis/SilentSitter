//
//  BeeViewController.h
//  mutiltest
//
//  Created by Lizzie Szemis on 23/08/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Flower.h"
#import "Bee.h"
#import "Petal.h"

int gBeeFlyFlag;
float gBeeFlyX;
float gBeeFlyY;
float gFlowerCloseX;
float gFlowerCloseY;
int gFlowerCount;
int gFlowerFlag;
int gbeePressFlag;
NSString *gbeeFlap1;
NSString *gbeeFlap2;

@interface BeeViewController : UIViewController <BeeDelegate>

@property (nonatomic, strong) IBOutlet Bee *bee;
@property (nonatomic, strong) IBOutlet UIButton *hive;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *FlowerCollection;
@property (nonatomic, strong) IBOutletCollection(Petal) NSArray *PetalCollection;

- (IBAction) moveBeeHive: (id) sender;

@end