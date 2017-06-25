//
//  BeeViewController.m
//  mutiltest
//
//  Created by Lizzie Szemis on 23/08/12.
//
//

#import "BeeViewController.h"
#import "MultiboxAppDelegate.h"

@interface BeeViewController ()

@end

@implementation BeeViewController{

}

@synthesize bee;
@synthesize hive;
@synthesize FlowerCollection;
@synthesize PetalCollection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.view.userInteractionEnabled = NO;
    
    [super viewDidLoad];
  //  CGRect umFrame = CGRectMake(0,0,0,0);
  //  [bee drawRect:(umFrame)];
    [bee setDelegate:self];

    for (Petal *daisyLocal in PetalCollection) {

        [daisyLocal FlowerRotate];

    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(BeeEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)BeeEnable{
    
    self.view.userInteractionEnabled = YES;
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil; 
}


-(void)beeCloseFlower:(Bee *)beeParameter{
    
    for (Petal *daisyLocal in PetalCollection) {
        
        if(daisyLocal.center.x == gFlowerCloseX && daisyLocal.center.y == gFlowerCloseY){
            
            NSString *FlowerColour;
                        
            if(daisyLocal.center.x == 154 && daisyLocal.center.y == 280){
                FlowerColour = @"White";
            }
            if(daisyLocal.center.x == 77 && daisyLocal.center.y == 172){
                FlowerColour = @"Blue";
            }
            if(daisyLocal.center.x == 209 && daisyLocal.center.y == 424){
                FlowerColour = @"Red";
            }
            if(daisyLocal.center.x == 270 && daisyLocal.center.y == 316){
                FlowerColour = @"Purple";
            }
            if(daisyLocal.center.x == 50 && daisyLocal.center.y == 297){
                FlowerColour = @"Pink";
            }
            if(daisyLocal.center.x == 236 && daisyLocal.center.y == 193){
                FlowerColour = @"Orange";
            }
            if(daisyLocal.center.x == 71 && daisyLocal.center.y == 410){
                FlowerColour = @"Yellow";
            }
  
            [daisyLocal.layer removeAnimationForKey:@"Daisy360"];
            
            UIImage *closeImage  = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame8.png"]];
            [daisyLocal setImage:closeImage];
            
            float beeFlapDuration = 0.7;
            NSArray *beeFlap;
            beeFlap = [[NSArray alloc] initWithObjects:
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame1.png"]],
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame2.png"]],
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame3.png"]],
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame4.png"]],
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame5.png"]],
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame6.png"]],
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame7.png"]],
                       [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",FlowerColour,@"Flower-Frame8.png"]],
                       nil
                       ];
            
            daisyLocal.animationImages=beeFlap;
            [daisyLocal setAnimationDuration:beeFlapDuration];
            [daisyLocal setAnimationRepeatCount:1];
            [daisyLocal startAnimating];
    
        }

    }

}

-(void)beeSwapView:(Bee *)beeParameter{

    self.view.userInteractionEnabled = NO;
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Bee"];
    
}


-(void)beePress:(Bee *)beeParameter{

    if(gFlowerCount <= 6 && gbeePressFlag == 1){
        
        NSMutableArray *beeArray = [[NSMutableArray alloc] init];
    
        for (Flower *flowerLocal in FlowerCollection) {
            if(flowerLocal.hidden == 0){
                [beeArray addObject:flowerLocal];
            }
        }
    
        NSInteger countbeeArray = ([beeArray count]);
        int finalScreen = arc4random() % countbeeArray;
    
        [[beeArray objectAtIndex:finalScreen] sendActionsForControlEvents:UIControlEventTouchDown];
        
    }
    
}

-(void)disableHive:(Bee *)beeParameter{
    
    hive.adjustsImageWhenDisabled = NO;
    hive.enabled = NO;
    
}

- (IBAction) moveBeeHive: (id) sender{
    
    CAKeyframeAnimation *wiggleHiveAnimation;
    wiggleHiveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    wiggleHiveAnimation.duration = 0.5;
    wiggleHiveAnimation.repeatCount = 2;
    wiggleHiveAnimation.values = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0],
                                [NSNumber numberWithFloat:0.25*M_PI],
                                [NSNumber numberWithFloat:-0.25*M_PI],
                                [NSNumber numberWithFloat:0],nil];
    
    wiggleHiveAnimation.keyTimes = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0],
                                  [NSNumber numberWithFloat:0.25],
                                  [NSNumber numberWithFloat:0.75],
                                  [NSNumber numberWithFloat:1.0],nil];

    wiggleHiveAnimation.removedOnCompletion = NO;
    wiggleHiveAnimation.fillMode = kCAFillModeForwards;

    [[sender layer] addAnimation: wiggleHiveAnimation forKey:@"HIVE"];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end