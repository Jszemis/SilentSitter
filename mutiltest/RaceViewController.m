//
//  RaceViewController.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 12/02/13.
//
//

#import "RaceViewController.h"
#import "MultiboxAppDelegate.h"

@interface RaceViewController ()

@end

@implementation RaceViewController

@synthesize RaceClouds,RaceMountains,RaceHills,RaceForest,RaceTrees,RaceGrass;
@synthesize HorseCowboy,HorsePrincess,HorseKnight,HorseJockey;
@synthesize JockeyCup, CowboyHat, ButterflyBlue, ButterflyOrange, ButterflyPink, ButterflyRed, ButterflyYellow, HorseWater;

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
    // Do any additional setup after loading the view from its nib.

    disableGesture = 0;
    backgroundcount = 0;

    HorseCowboy.adjustsImageWhenDisabled = NO;
    HorseCowboy.enabled = NO;
    HorsePrincess.adjustsImageWhenDisabled = NO;
    HorsePrincess.enabled = NO;
    HorseJockey.adjustsImageWhenDisabled = NO;
    HorseJockey.enabled = NO;
    HorseKnight.adjustsImageWhenDisabled = NO;
    HorseKnight.enabled = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(RaceEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)RaceEnable{
    
    self.view.userInteractionEnabled = YES;
    
}



- (IBAction)StartRace:(UITapGestureRecognizer *)sender {

    HorseCowboy.enabled = YES;
    HorsePrincess.enabled = YES;
    HorseJockey.enabled = YES;
    HorseKnight.enabled = YES;
    
    HorseCowboyStartX = [HorseCowboy HorseStartHeight];
    HorsePrincessStartX = [HorsePrincess HorseStartHeight];
    HorseJockeyStartX = [HorseJockey HorseStartHeight];
    HorseKnightStartX = [HorseKnight HorseStartHeight];
    
    if(disableGesture == 1){
        sender.enabled = NO;
    }else{
        racegameloop =[CADisplayLink displayLinkWithTarget:self selector:@selector(BackgroundMoving)];
        [racegameloop addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        horsegameloop =[CADisplayLink displayLinkWithTarget:self selector:@selector(HorseMoving)];
        [horsegameloop addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        [HorseCowboy HorseGallop];
        [HorsePrincess HorseGallop];
        [HorseJockey HorseGallop];
        [HorseKnight HorseGallop];
        
        [HorseCowboy performSelector:@selector( HorseGallop) withObject:nil afterDelay:0.1];
        [HorsePrincess performSelector:@selector( HorseGallop) withObject:nil afterDelay:0.3];
        [HorseJockey performSelector:@selector( HorseGallop) withObject:nil afterDelay:0.2];
        [HorseKnight performSelector:@selector( HorseGallop) withObject:nil afterDelay:0.4];
                
    }
    
    disableGesture = 1;
}

-(void)HorseMove: (Horse *) pHorse{

    
    float pHorseX = pHorse.center.x;
    float pHorseY = pHorse.center.y;
    
    if([pHorse HorseJumpHeight] == [pHorse HorseStartHeight]){
        
        int randomX = (arc4random() % 3) - 1;
        
        if (CGRectIntersectsRect(HorseWater.frame, pHorse.frame)){
            pHorseX = pHorseX - 1;
        }else{
            pHorseX = pHorseX + randomX;   
        }
         
    }else{
        
        if([pHorse HorseJumpHeight] < pHorse.center.y){

            pHorseX = pHorseX + 0.2;
            pHorseY = pHorseY - 1;
            
        }else{
            
            pHorseX = pHorseX + 0.2;
            pHorseY = pHorseY + 1;
            
            [pHorse HorseJumpHeightReset];
            
            if([pHorse HorseJumpHeight] == [pHorse HorseStartHeight]){
                
                [pHorse HorseGallop];
            }
            
        }
        
    }
    
    if(pHorseX < 37.5){
        pHorseX = 37.5;
    }
    if(pHorseX > 242.5){
        pHorseX = 242.5;
    }
    
    pHorse.center = CGPointMake(pHorseX,pHorseY);
    
}

-(void)HorseMoving{
    
    [self HorseMove:HorseCowboy];
    [self HorseMove:HorsePrincess];
    [self HorseMove:HorseJockey];
    [self HorseMove:HorseKnight];
    
    HorseWater.center = CGPointMake(HorseWater.center.x - 2,HorseWater.center.y);
    if (HorseWater.center.x < -550) {
        HorseWater.center = CGPointMake(540,HorseWater.center.y);
    }

}

-(void)BackgroundMoving{
 
    RaceClouds.center = CGPointMake(RaceClouds.center.x - 0.25,RaceClouds.center.y);
    if(RaceClouds.center.x < -4) RaceClouds.center = CGPointMake(400,RaceClouds.center.y);
    
    RaceMountains.center = CGPointMake(RaceMountains.center.x - 0.5,RaceMountains.center.y);
    if(RaceMountains.center.x < 36) RaceMountains.center = CGPointMake(415,RaceMountains.center.y);
    
    RaceHills.center = CGPointMake(RaceHills.center.x - 1,RaceHills.center.y);
    if(RaceHills.center.x < 0) RaceHills.center = CGPointMake(1363,RaceHills.center.y);
    
    RaceForest.center = CGPointMake(RaceForest.center.x - 1.5,RaceForest.center.y);
    if(RaceForest.center.x < 10) RaceForest.center = CGPointMake(875,RaceForest.center.y);
    
    RaceTrees.center = CGPointMake(RaceTrees.center.x - 1.75,RaceTrees.center.y);
    if(RaceTrees.center.x < 34) RaceTrees.center = CGPointMake(1032,RaceTrees.center.y);

    RaceGrass.center = CGPointMake(RaceGrass.center.x - 2,RaceGrass.center.y);
        
    if(RaceGrass.center.x < -1255){
        
        RaceGrass.center = CGPointMake(-1255,RaceGrass.center.y);
        
        [racegameloop invalidate];
        [horsegameloop invalidate];
        
        HorseCowboy.adjustsImageWhenDisabled = NO;
        HorseCowboy.enabled = NO;
        HorsePrincess.adjustsImageWhenDisabled = NO;
        HorsePrincess.enabled = NO;
        HorseJockey.adjustsImageWhenDisabled = NO;
        HorseJockey.enabled = NO;
        HorseKnight.adjustsImageWhenDisabled = NO;
        HorseKnight.enabled = NO;
        
        NSMutableArray *HorseWinnerArray = [[NSMutableArray alloc] init];;
        
        [HorseWinnerArray addObject:[NSNumber numberWithFloat:HorseCowboy.center.x]];
        [HorseWinnerArray addObject:[NSNumber numberWithFloat:HorsePrincess.center.x]];
        [HorseWinnerArray addObject:[NSNumber numberWithFloat:HorseJockey.center.x]];
        [HorseWinnerArray addObject:[NSNumber numberWithFloat:HorseKnight.center.x]];

        int HorseWinnerArraySizeI = 0;
        int  HorseWinnerNumber = 0;
        
        for (NSNumber *ArrayI in HorseWinnerArray ){
            
            HorseWinnerArraySizeI++;
            int HorseWinnerArraySizeJ = 0;
            
            for (NSNumber *ArrayJ in HorseWinnerArray ){
 
                if([ArrayI floatValue] >= [ArrayJ floatValue]){
                    HorseWinnerArraySizeJ++;
                }
                if(HorseWinnerArraySizeJ == 4){
                    HorseWinnerNumber = HorseWinnerArraySizeI;
                }
            }
                  
        }
        
        if(HorseWinnerNumber == 2){
            HorseWinner = @"Princess";
        }else if(HorseWinnerNumber == 3){
            HorseWinner = @"Jockey";            
        }else if(HorseWinnerNumber == 4){
            HorseWinner = @"Knight";            
        }else{
            HorseWinner = @"Cowboy";            
        }
        
        horsegameloop =[CADisplayLink displayLinkWithTarget:self selector:@selector(FinishingRace)];
        [horsegameloop addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    
}

-(int)HorseFinish: (Horse *) pHorse withFinish:(float)pFinish withStartX:(float)pStartX{
    
    float FinalHorseX = pHorse.center.x;
    float FinalHorseY = pHorse.center.y;
    
    if(pHorse.center.x < pFinish){
        pHorse.center = CGPointMake(pHorse.center.x + 2,pHorse.center.y);
    }
    
    if(pHorse.center.y < pStartX){
        pHorse.center = CGPointMake(pHorse.center.x,pHorse.center.y + 1);
        if(pHorse.center.y == pStartX){
            [pHorse HorseGallop];
        }
    }
    
    
    
    if(FinalHorseX >= pHorse.center.x && FinalHorseY >= pHorse.center.y){
        
        [pHorse.imageView stopAnimating];
        [pHorse HorseStop];
        
        return 1;
    }
    
    return 0;
}

-(void)FinishingRace{
    
    float HorseWinnerCowboy = 242.5;
    float HorseWinnerPrincess = 242.5;
    float HorseWinnerJockey = 242.5;
    float HorseWinnerKnight = 242.5;
    
    if([HorseWinner isEqual: @"Cowboy"]){
        HorseWinnerCowboy = 282.5;
    }else if([HorseWinner isEqual: @"Princess"]){
        HorseWinnerPrincess = 282.5;
    }else if([HorseWinner isEqual: @"Jockey"]){
        HorseWinnerJockey = 282.5;
    }else if([HorseWinner isEqual: @"Knight"]){
        HorseWinnerKnight = 282.5;
    }
    
    int HorseCowboyDone = [self HorseFinish:HorseCowboy withFinish:HorseWinnerCowboy withStartX:HorseCowboyStartX];
    int HorsePrincessDone = [self HorseFinish:HorsePrincess withFinish:HorseWinnerPrincess withStartX:HorsePrincessStartX];
    int HorseJockeyDone = [self HorseFinish:HorseJockey withFinish:HorseWinnerJockey withStartX:HorseJockeyStartX];
    int HorseKnightDone = [self HorseFinish:HorseKnight withFinish:HorseWinnerKnight withStartX:HorseKnightStartX];;

    if(HorseCowboyDone == 1 && HorsePrincessDone == 1 && HorseJockeyDone == 1 && HorseKnightDone == 1){
        [horsegameloop invalidate];

        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(HorseVictory)
                                       userInfo:nil
                                        repeats:NO];
        
        
    }
    
    
}


-(void)HorseVictory{
    
    
    ///////////// HORSE JOCKEY WINNING ANIMATION /////////////
    
    if([HorseWinner isEqual: @"Jockey"]){
    
        [HorseJockey setImage:[UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop06.png"]] forState:UIControlStateNormal];

        float JockeyVictoryDuration = 5;
        NSArray *JockeyVictory;
        JockeyVictory = [[NSArray alloc] initWithObjects:
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop01.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop02.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop03.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop04.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop05.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop05.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop05.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop06.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop07.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop08.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop09.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop10.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop11.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop12.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop13.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop14.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop13.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop12.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop11.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop10.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop11.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop12.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop13.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop14.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop13.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop12.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop11.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop10.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop11.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop12.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop13.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop14.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop13.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop12.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop11.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop10.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop09.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop08.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop07.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop06.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop15.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop16.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop17.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop16.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop17.png"]],
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseJockey-Stop06.png"]],
                        nil
                        ];
    
        HorseJockey.imageView.animationImages=JockeyVictory;
        [HorseJockey.imageView setAnimationDuration:JockeyVictoryDuration];
        [HorseJockey.imageView setAnimationRepeatCount:1];
        [HorseJockey.imageView startAnimating];
        
        CGFloat HorseJockeyCupDuration = 1.5;
        
        CABasicAnimation *HorseJockeyCupRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        HorseJockeyCupRotation.fromValue = [NSNumber numberWithFloat:0];
        HorseJockeyCupRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        HorseJockeyCupRotation.duration = HorseJockeyCupDuration/2;
        HorseJockeyCupRotation.repeatCount = 2;
        
        CGMutablePathRef HorseJockeyCupPath;
        HorseJockeyCupPath = CGPathCreateMutable();
        CGPathMoveToPoint(HorseJockeyCupPath, NULL, 350, 400);
        CGPathAddCurveToPoint(HorseJockeyCupPath, NULL, 320, 300, 320, 300, 292, 408);
        
        CAKeyframeAnimation *HorseJockeyCupAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        
        [HorseJockeyCupAnimation setDuration: HorseJockeyCupDuration];
        [HorseJockeyCupAnimation setAutoreverses: NO];
        HorseJockeyCupAnimation.removedOnCompletion = NO;
        HorseJockeyCupAnimation.fillMode = kCAFillModeBoth;
        HorseJockeyCupAnimation.delegate = self;
        [HorseJockeyCupAnimation setPath: HorseJockeyCupPath];
        CFRelease(HorseJockeyCupPath);
        
        [[JockeyCup layer] addAnimation: HorseJockeyCupAnimation forKey: @"HorseJockeyCupAnimation"];
        [[JockeyCup layer] addAnimation: HorseJockeyCupRotation forKey:@"HorseJockeyCupRotation"];

        [NSTimer scheduledTimerWithTimeInterval:5
                                         target:self
                                       selector:@selector(swapViews)
                                       userInfo:nil
                                        repeats:NO];
        
    }
    
    
    ///////////// HORSE KNIGHT WINNING ANIMATION /////////////
    
    if([HorseWinner isEqual: @"Knight"]){
        
        [HorseKnight setImage:[UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop18.png"]] forState:UIControlStateNormal];
        HorseKnight.center = CGPointMake(HorseKnight.center.x,HorseKnight.center.y-9);

        float KnightVictoryDuration = 4;
        NSArray *KnightVictory;
        KnightVictory = [[NSArray alloc] initWithObjects:
                        [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop01.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop01.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop02.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop03.png"]],
                         
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop04.png"]],
                         
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop05.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop06.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop07.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop08.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop09.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop10.png"]],
                         
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop12.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop13.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop14.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop15.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop16.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop17.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop18.png"]],
                         
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop19.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop20.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop21.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop20.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop19.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop20.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop21.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop20.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop19.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseKnight-Stop18.png"]],                         
                         
                        nil
                        ];
        
        HorseKnight.imageView.animationImages=KnightVictory;
        [HorseKnight.imageView setAnimationDuration:KnightVictoryDuration];
        [HorseKnight.imageView setAnimationRepeatCount:1];
        [HorseKnight.imageView startAnimating];
        
        [NSTimer scheduledTimerWithTimeInterval:4
                                         target:self
                                       selector:@selector(swapViews)
                                       userInfo:nil
                                        repeats:NO];
         
    }
        
    ///////////// HORSE COWBOY WINNING ANIMATION /////////////
    
    if([HorseWinner isEqual: @"Cowboy"]){
        
        [HorseCowboy setImage:[UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop17.png"]] forState:UIControlStateNormal];
        
        float CowboyVictoryDuration = 4;
        NSArray *CowboyVictory;
        CowboyVictory = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop01.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop02.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop03.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop05.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop06.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop07.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop08.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop09.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop10.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop12.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop13.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop14.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop15.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop16.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop17.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop18.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop19.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop20.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop20.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop21.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop22.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop23.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorseCowboy-Stop24.png"]],
                         nil
                         ];
        
        HorseCowboy.imageView.animationImages=CowboyVictory;
        [HorseCowboy.imageView setAnimationDuration:CowboyVictoryDuration];
        [HorseCowboy.imageView setAnimationRepeatCount:1];
        [HorseCowboy.imageView startAnimating];
        
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(CowboyHatThrow)
                                       userInfo:nil
                                        repeats:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:4.5
                                         target:self
                                       selector:@selector(swapViews)
                                       userInfo:nil
                                        repeats:NO];
        
        
    }
    
    ///////////// HORSE PRINCESS WINNING ANIMATION /////////////
    
    if([HorseWinner isEqual: @"Princess"]){
        
        [HorsePrincess setImage:[UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop16.png"]] forState:UIControlStateNormal];
        
        float PrincessVictoryDuration = 4;
        NSArray *PrincessVictory;
        PrincessVictory = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop.png"]],                         
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop01.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop02.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop03.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop04.png"]],
                          
                         //Orange Spark
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop05.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop06.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop07.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop06.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop05.png"]],
                          
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop04.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop08.png"]],
                          
                         //Blue Spark
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop09.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop10.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop11.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop10.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop09.png"]],
                          
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop08.png"]],                         
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop04.png"]],

                         //Green Spark
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop12.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop13.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop14.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop13.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop12.png"]],
                          
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop04.png"]],                          
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop08.png"]],                            
                          
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop15.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop16.png"]],
                          
                         //Yellow Spark
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop17.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop18.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop19.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop18.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop17.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop17.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop18.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop19.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop18.png"]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop17.png"]],
                          
                         [UIImage imageNamed:[NSString stringWithFormat:@"HorsePrincess-Stop16.png"]],                          

                         nil
                         ];
        
        HorsePrincess.imageView.animationImages=PrincessVictory;
        [HorsePrincess.imageView setAnimationDuration:PrincessVictoryDuration];
        [HorsePrincess.imageView setAnimationRepeatCount:1];
        [HorsePrincess.imageView startAnimating];
        
        [NSTimer scheduledTimerWithTimeInterval:PrincessVictoryDuration
                                         target:self
                                       selector:@selector(ButterFlies)
                                       userInfo:nil
                                        repeats:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:7.5
                                         target:self
                                       selector:@selector(swapViews)
                                       userInfo:nil
                                        repeats:NO];
        
    }

}

-(void)CowboyHatThrow{
    
    CGFloat HorseCowboyCupDuration = 1.7;
    
    CABasicAnimation *HorseCowboyCupRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    HorseCowboyCupRotation.fromValue = [NSNumber numberWithFloat:0];
    HorseCowboyCupRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    HorseCowboyCupRotation.duration = HorseCowboyCupDuration/2;
    HorseCowboyCupRotation.repeatCount = 2;
    
    CGMutablePathRef HorseCowboyCupPath;
    HorseCowboyCupPath = CGPathCreateMutable();
    CGPathMoveToPoint(HorseCowboyCupPath, NULL, 287, 350);
    CGPathAddCurveToPoint(HorseCowboyCupPath, NULL, 270, 240, 270, 240, 300, 250);
    CAKeyframeAnimation *HorseCowboyCupAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [HorseCowboyCupAnimation setDuration: HorseCowboyCupDuration];
    [HorseCowboyCupAnimation setAutoreverses: NO];
    HorseCowboyCupAnimation.removedOnCompletion = NO;
    HorseCowboyCupAnimation.fillMode = kCAFillModeBoth;
    HorseCowboyCupAnimation.delegate = self;
    [HorseCowboyCupAnimation setPath: HorseCowboyCupPath];
    CFRelease(HorseCowboyCupPath);
    
    [[CowboyHat layer] addAnimation: HorseCowboyCupAnimation forKey: @"HorseCowboyCupAnimation"];
    [[CowboyHat layer] addAnimation: HorseCowboyCupRotation forKey:@"HorseCowboyCupRotation"];
    
    [NSTimer scheduledTimerWithTimeInterval:HorseCowboyCupDuration
                                     target:self
                                   selector:@selector(CowboyHatShoot)
                                   userInfo:nil
                                    repeats:NO];

}

-(void)CowboyHatShoot{
    
    CGFloat HorseCowboyCupDuration = 0.3;
    
    CABasicAnimation *HorseCowboyCupRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    HorseCowboyCupRotation.fromValue = [NSNumber numberWithFloat:0];
    HorseCowboyCupRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    HorseCowboyCupRotation.duration = HorseCowboyCupDuration/2;
    HorseCowboyCupRotation.repeatCount = 2;
    
    CGMutablePathRef HorseCowboyCupPath;
    HorseCowboyCupPath = CGPathCreateMutable();
    CGPathMoveToPoint(HorseCowboyCupPath, NULL, 300, 250);
    CGPathAddLineToPoint(HorseCowboyCupPath,NULL, 350, 200);
    CAKeyframeAnimation *HorseCowboyCupAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [HorseCowboyCupAnimation setDuration: HorseCowboyCupDuration];
    [HorseCowboyCupAnimation setAutoreverses: NO];
    HorseCowboyCupAnimation.removedOnCompletion = NO;
    HorseCowboyCupAnimation.fillMode = kCAFillModeBoth;
    HorseCowboyCupAnimation.delegate = self;
    [HorseCowboyCupAnimation setPath: HorseCowboyCupPath];
    CFRelease(HorseCowboyCupPath);
    
    [[CowboyHat layer] addAnimation: HorseCowboyCupAnimation forKey: @"HorseCowboyCupAnimation"];
    [[CowboyHat layer] addAnimation: HorseCowboyCupRotation forKey:@"HorseCowboyCupRotation"];
    
}

-(void)ButterFlies{
    
    [self ButterFlyAnimation:ButterflyBlue withColour:@"Blue" withTime:0.25 withCenterX:285  withCenterY:350 withHieght:25 withWidth:15 withSpeed:10];
    [self ButterFlyAnimation:ButterflyOrange withColour:@"Orange" withTime:0.275 withCenterX:280  withCenterY:335 withHieght:30 withWidth:15 withSpeed:13];
    [self ButterFlyAnimation:ButterflyPink withColour:@"Pink" withTime:0.3 withCenterX:270  withCenterY:340 withHieght:20 withWidth:20 withSpeed:11.5];
    [self ButterFlyAnimation:ButterflyRed withColour:@"Red" withTime:0.325 withCenterX:275  withCenterY:330 withHieght:20 withWidth:25 withSpeed:11];
    [self ButterFlyAnimation:ButterflyYellow withColour:@"Yellow" withTime:0.35 withCenterX:275  withCenterY:350 withHieght:25 withWidth:25 withSpeed:12];
    
}

-(void)ButterFlyAnimation:(UIImageView *) pButterFly withColour:(NSString *) pColour withTime:(float) pTime withCenterX:(int) pCenterX withCenterY:(int) pCenterY withHieght:(int) pHieght withWidth:(int) pWidth withSpeed:(float) pSpeed {
    
    NSArray *CowboyVictory;
    CowboyVictory = [[NSArray alloc] initWithObjects:
                     [UIImage imageNamed:[NSString stringWithFormat:@"ButterFly%@%@",pColour,@"-Frame01.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"ButterFly%@%@",pColour,@"-Frame02.png"]],
                     nil
                     ];
    
    pButterFly.animationImages=CowboyVictory;
    [pButterFly setAnimationDuration:pTime];
    [pButterFly setAnimationRepeatCount:200];
    [pButterFly startAnimating];
    
    [self ButterFlyPath:pButterFly withCenterX:pCenterX  withCenterY:pCenterY withHieght:pHieght withWidth:pWidth withSpeed:pSpeed];
    
}

-(void)ButterFlyPath:(UIImageView *) pButterFly withCenterX:(int) pCenterX withCenterY:(int) pCenterY withHieght:(int) pHieght withWidth:(int) pWidth withSpeed:(float) pSpeed{
    
    int ButterFlyStartPointX = pCenterX + pWidth + pWidth;
    int ButterFlyStartPointY = pCenterY - pHieght - pHieght;

    int ButterFlyEndPointX = pCenterX + pWidth;
    int ButterFlyEndPointY = pCenterY;
    
    int ButterFlyCirclePointX = pCenterX - pWidth;
    int ButterFlyCirclePointY = pCenterY - pHieght;
    
    int ButterFlyCircleHieght = pHieght + pHieght;
    int ButterFlyCircleWidth = pWidth + pWidth;
    
    CGMutablePathRef ButterFlyPath;
    ButterFlyPath = CGPathCreateMutable();

    CGPathMoveToPoint(ButterFlyPath, NULL, ButterFlyStartPointX, ButterFlyStartPointY);
    CGPathAddLineToPoint(ButterFlyPath,NULL, ButterFlyEndPointX, ButterFlyEndPointY);
    for(int i = 1; i <= 5; i++){
        CGPathAddEllipseInRect(ButterFlyPath, NULL,CGRectMake(ButterFlyCirclePointX, ButterFlyCirclePointY, ButterFlyCircleWidth, ButterFlyCircleHieght));
    }
    
    CAKeyframeAnimation *ButterFlyCupAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [ButterFlyCupAnimation setDuration: pSpeed];
    [ButterFlyCupAnimation setAutoreverses: NO];
    ButterFlyCupAnimation.removedOnCompletion = NO;
    ButterFlyCupAnimation.fillMode = kCAFillModeBoth;
    ButterFlyCupAnimation.delegate = self;
    ButterFlyCupAnimation.calculationMode = kCAAnimationPaced;
    [ButterFlyCupAnimation setPath: ButterFlyPath];
    CFRelease(ButterFlyPath);
    [[pButterFly layer] addAnimation: ButterFlyCupAnimation forKey: @"ButterFlyCupAnimation"];
    
}

-(void)swapViews{
    
    self.view.userInteractionEnabled = NO;

    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }

    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Horse"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
