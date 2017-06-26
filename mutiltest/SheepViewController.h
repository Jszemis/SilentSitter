//
//  SheepViewController.h
//  mutiltest
//
//  Created by Lizzie Szemis on 4/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Sheep.h"

@interface SheepViewController : UIViewController <SheepDelegate, CAAnimationDelegate>

@property (nonatomic,strong) IBOutlet UIImageView *backgroundImage;
@property (nonatomic,strong) IBOutlet UIImageView *foregroundImage;
@property (nonatomic,strong) IBOutlet UIImageView *sun;
@property (nonatomic,strong) IBOutlet UIImageView *moon;
@property (nonatomic, strong) IBOutletCollection(Sheep) NSArray *SheepCollection;

@end
