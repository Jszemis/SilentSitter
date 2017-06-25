//
//  Sheep.h
//  sheep
//
//  Created by Lizzie Szemis on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class Sheep;

@protocol SheepDelegate <NSObject>

-(int)numberOfSheepJump:(Sheep *)sheepView;
-(void)changeSheepJump:(Sheep *)sheepView;

@end

@interface Sheep : UIButton{
    NSTimer *sheepTimer;
}

@property (strong, nonatomic) id<SheepDelegate> delegate;

- (IBAction)sheepJump:(id)sender;
- (void)sheepHeadDown;
- (void)sheepHeadUp;
- (void)sheepGraze:(NSTimer*)aTimer;
- (void)sheepGoToSleep;
- (void)sheepSleep;

@end
