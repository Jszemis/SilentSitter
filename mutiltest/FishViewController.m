//
//  FishViewController.m
//  mutiltest
//
//  Created by Lizzie Szemis on 2/10/12.
//
//

#import "FishViewController.h"
#import "Rodcast.h"
#import "MultiboxAppDelegate.h"

@interface FishViewController ()

@end

@implementation FishViewController

@synthesize SplashImage;
@synthesize FishermanImage;
@synthesize FishImage;
@synthesize WhaleImage;
@synthesize BirdCollection;


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

    linePathStartX = 155;
    linePathStartY = 427;
    linePathEndX = 0;
    linePathEndY = 0;
    linePathApexX = 0;
    linePathApexY = 0;
    CastFlag = 0;
    fishCount = 0;
    
    CGRect umFrame = CGRectMake(0,0,0,0);
    for (Bird *birdLocal in BirdCollection) {
        [birdLocal drawRect:(umFrame)];
    }
    
    Rodcast *recognizer = [[Rodcast alloc] initWithTarget:self action:@selector(didRecognizeCheckmark:)];
    [self.view addGestureRecognizer:recognizer];

    fishermanWaveTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(FishermanWave)
                                   userInfo:nil
                                    repeats:NO];

    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(FishEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)FishEnable{
    
    self.view.userInteractionEnabled = YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRecognizeCheckmark:(UIGestureRecognizer*)gestureRecognizer
{

    if(CastFlag == 0){
        
        [fishermanWaveTimer invalidate];
        [FishermanImage stopAnimating];
    
        CastFlag = 1;
        fishCount++;
        linePathApexX = [gestureRecognizer locationInView:self.view].x;
        linePathApexY = [gestureRecognizer locationInView:self.view].y;
   
        if(linePathApexX <= 115){
            linePathApexX = 115;
        }
    
        if(linePathApexX >= 290){
            linePathApexX = 290;
        }
    
        if(linePathApexY >= 400){
            linePathApexY = 400;
        }
        
        if(linePathApexX > 170 && linePathApexX <= 290){
        
            linePathEndX = linePathApexX + linePathApexX - linePathStartX;
        
            if(linePathEndX <= 190){
                linePathEndX = 190;
            }
        
            if(linePathEndX >= 290){
                linePathEndX = 290;
            }
            
            linePathEndY = linePathApexY + 50;
            
            if(linePathEndY <= 300){
                linePathEndY = 300;
            }
            
            if(linePathEndY >= 450){
                linePathEndY = 450;
            }

        }
    
        if(linePathApexX <= 170 && linePathApexX >= 115){
 
            linePathEndX = linePathApexX + linePathApexX - linePathStartX;
        
            if(linePathEndX <= 115){
                linePathEndX = 115;
            }

            linePathEndY = linePathApexY + 50;
            
            if(linePathEndY <= 300){
                linePathEndY = 300;
            }
            
            if(linePathEndY >= 400){
                linePathEndY = 400;
            }
        
        }
        
        [FishermanImage setImage:[UIImage imageNamed:@"FishermanCast.png"]];
        
        linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(linePathStartX, linePathStartY)];
        [linePath addCurveToPoint:CGPointMake(linePathEndX, linePathEndY)
				    controlPoint1:CGPointMake(linePathApexX, linePathApexY)
				    controlPoint2:CGPointMake(linePathApexX, linePathApexY)];
    
        lineDraw = [CAShapeLayer layer];
        lineDraw.path = linePath.CGPath;
        lineDraw.strokeColor = [UIColor blackColor].CGColor;
        lineDraw.fillColor = [UIColor clearColor].CGColor;
        lineDraw.lineWidth = 2.0;
        [self.view.layer addSublayer:lineDraw];
        
        float linePathLength = sqrt(pow(linePathStartX - linePathApexX,2) + pow(linePathStartY - linePathApexY,2)) + sqrt(pow(linePathEndX - linePathApexX,2) + pow(linePathEndY - linePathApexY,2));
        //linePathLength = linePathLength - (sqrt(pow(linePathStartY - linePathApexY,2)/2)) - (sqrt(pow(linePathApexY - linePathEndY,2)/2));
        //float lineDuration = linePathLength/90;
 
        float lineDuration = linePathLength/200;
        
        CABasicAnimation *lineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        lineAnimation.duration  = lineDuration;
        lineAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        lineAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
        [lineDraw addAnimation:lineAnimation forKey:@"lineAnimation"];

        hookLayer = [CALayer layer];
        hookLayer.bounds = CGRectMake(-10, -10, 24, 16);
        hookLayer.position = CGPointMake(-10, -10);
        hookLayer.contents = (id)([UIImage imageNamed:@"hook.png"].CGImage);
        [self.view.layer addSublayer:hookLayer];
    
        CAKeyframeAnimation *hookAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        hookAnimation.path = linePath.CGPath;
        hookAnimation.rotationMode = kCAAnimationRotateAuto;
        hookAnimation.duration = lineDuration;
        hookAnimation.calculationMode = kCAAnimationPaced;       
        [hookLayer addAnimation:hookAnimation forKey:@"hookAnimation"];
        
        [NSTimer scheduledTimerWithTimeInterval:lineDuration + 0.1
                                                         target:self
                                                       selector:@selector(LineLands)
                                                       userInfo:nil
                                                        repeats:NO];
    
    }

}

-(void)FishermanWave{
    
    float waveDuration = 0.3;
    NSArray *waveArray;
    waveArray = [[NSArray alloc] initWithObjects:
                 [UIImage imageNamed:@"Fisherman-frame1.png"],
                 [UIImage imageNamed:@"Fisherman-frame2.png"],
                 [UIImage imageNamed:@"Fisherman-frame3.png"],
                 [UIImage imageNamed:@"Fisherman-frame4.png"],
                 [UIImage imageNamed:@"Fisherman-frame5.png"],
                 [UIImage imageNamed:@"Fisherman-frame4.png"],
                 [UIImage imageNamed:@"Fisherman-frame3.png"],
                 [UIImage imageNamed:@"Fisherman-frame2.png"],
                 [UIImage imageNamed:@"Fisherman-frame1.png"],
                 nil
                 ];
    
    FishermanImage.animationImages=waveArray;
    [FishermanImage setAnimationDuration:waveDuration];
    [FishermanImage setAnimationRepeatCount:3];
    [FishermanImage startAnimating];
    
    double randomWave = (double)((arc4random() % 30) + 10)/10;
    fishermanWaveTimer = [NSTimer scheduledTimerWithTimeInterval:randomWave
                                                          target:self
                                                        selector:@selector(FishermanWave)
                                                        userInfo:nil
                                                         repeats:NO];
}

-(void)LineLands{

    [hookLayer removeFromSuperlayer];

    [linePath removeAllPoints];
    linePath = [UIBezierPath bezierPath];
	[linePath moveToPoint:CGPointMake(linePathStartX, linePathStartY)];
    [linePath addLineToPoint:CGPointMake(linePathEndX-1, linePathEndY+5)];
    lineDraw.path = linePath.CGPath;
 
    [SplashImage setImage:[UIImage imageNamed:@"Splash-frame12.png"]];
    SplashImage.center = CGPointMake(linePathEndX,linePathEndY-1);
    float splashDuration = 2.5;
    NSArray *splashArray;
    splashArray = [[NSArray alloc] initWithObjects:
                  [UIImage imageNamed:@"Splash-frame01.png"],
                  [UIImage imageNamed:@"Splash-frame02.png"],
                  [UIImage imageNamed:@"Splash-frame03.png"],
                  [UIImage imageNamed:@"Splash-frame04.png"],
                  [UIImage imageNamed:@"Splash-frame05.png"],
                  [UIImage imageNamed:@"Splash-frame06.png"],
                  [UIImage imageNamed:@"Splash-frame07.png"],
                  [UIImage imageNamed:@"Splash-frame08.png"],
                  [UIImage imageNamed:@"Splash-frame09.png"],
                  [UIImage imageNamed:@"Splash-frame10.png"],
                  [UIImage imageNamed:@"Splash-frame11.png"],
                  [UIImage imageNamed:@"Splash-frame12.png"],
                                 
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  
                  [UIImage imageNamed:@"Splash-frame12.png"],
                  [UIImage imageNamed:@"Splash-frame12.png"],
                  [UIImage imageNamed:@"Splash-frame12.png"],
                  [UIImage imageNamed:@"Splash-frame12.png"],
                  
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  [UIImage imageNamed:@"Splash-frame13.png"],
                  
                  [UIImage imageNamed:@"Splash-frame12.png"],
                  [UIImage imageNamed:@"Splash-frame12.png"],
                  [UIImage imageNamed:@"Splash-frame12.png"],
                  [UIImage imageNamed:@"Splash-frame12.png"],                  
                  
                  nil
                  ];
    
    SplashImage.animationImages=splashArray;
    [SplashImage setAnimationDuration:splashDuration];
    [SplashImage setAnimationRepeatCount:1];
    [SplashImage startAnimating];
    
  //  int randomWait = arc4random() % 2;
    int randomWait = 0.5;
    
    [NSTimer scheduledTimerWithTimeInterval:splashDuration + randomWait
                                     target:self
                                   selector:@selector(LineBack)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)LineBack{    
    
    UIImage *FishermanPull  = [UIImage imageNamed:@"FishermanPull.png"];
    [FishermanImage setImage:FishermanPull];
      
    [linePath removeAllPoints];
    linePath = [UIBezierPath bezierPath];
	[linePath moveToPoint:CGPointMake(102, 404)];
    [linePath addLineToPoint:CGPointMake(linePathEndX-1, linePathEndY+5)];
    lineDraw.path = linePath.CGPath;
    
    [SplashImage setImage:[UIImage imageNamed:@"Splash-frame22.png"]];
    SplashImage.center = CGPointMake(linePathEndX,linePathEndY-1);
    float splashDuration = 0.5;
    NSArray *splashArray;
    splashArray = [[NSArray alloc] initWithObjects:
                   [UIImage imageNamed:@"Splash-frame13.png"],
                   [UIImage imageNamed:@"Splash-frame14.png"],
                   [UIImage imageNamed:@"Splash-frame15.png"],
                   [UIImage imageNamed:@"Splash-frame16.png"],
                   [UIImage imageNamed:@"Splash-frame17.png"],
                   [UIImage imageNamed:@"Splash-frame18.png"],
                   [UIImage imageNamed:@"Splash-frame19.png"],
                   [UIImage imageNamed:@"Splash-frame20.png"],
                   [UIImage imageNamed:@"Splash-frame21.png"],
                   [UIImage imageNamed:@"Splash-frame22.png"],
                   nil
                   ];
    
    SplashImage.animationImages=splashArray;
    [SplashImage setAnimationDuration:splashDuration];
    [SplashImage setAnimationRepeatCount:1];
    [SplashImage startAnimating];

    if(fishCount >= 4){
        [NSTimer scheduledTimerWithTimeInterval:2
                                         target:self
                                       selector:@selector(WhaleJump)
                                       userInfo:nil
                                        repeats:NO];
    }else{
        [NSTimer scheduledTimerWithTimeInterval:2
                                         target:self
                                       selector:@selector(FishJump)
                                       userInfo:nil
                                        repeats:NO];
    }

}

-(void)FishJump{

    [FishermanImage setImage:[UIImage imageNamed:@"FishermanStart.png"]];
 
    int RandomFish = arc4random() % 11 + 1;
    NSString *RandomFishLabel = [NSString stringWithFormat:@"Fish%i%@",RandomFish,@".png"];
    [FishImage setImage:[UIImage imageNamed:RandomFishLabel]];
    
    [linePath removeAllPoints];
  	lineDraw.path = linePath.CGPath;
    linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(linePathEndX-1, linePathEndY+5)];
    
    int fishPathApexX = sqrt(pow(linePathEndX - 71,2));
    
    [linePath addCurveToPoint:CGPointMake(71, 445)
				 controlPoint1:CGPointMake(fishPathApexX, linePathEndY-150)
				 controlPoint2:CGPointMake(71, 400)];

    
    CAKeyframeAnimation *fishAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	fishAnimation.path = linePath.CGPath;
	fishAnimation.rotationMode = kCAAnimationRotateAuto;
	fishAnimation.repeatCount = 0;
	fishAnimation.duration = 1.3;
    [FishImage.layer addAnimation:fishAnimation forKey:@"fishAnimation"];
    
    [SplashImage setImage:[UIImage imageNamed:@"Splash-frame23.png"]];
    float splashDuration = 0.7;
    NSArray *splashArray;
    splashArray = [[NSArray alloc] initWithObjects:
                   [UIImage imageNamed:@"Splash-frame15.png"],
                   [UIImage imageNamed:@"Splash-frame16.png"],
                   [UIImage imageNamed:@"Splash-frame17.png"],
                   [UIImage imageNamed:@"Splash-frame18.png"],
                   [UIImage imageNamed:@"Splash-frame19.png"],
                   [UIImage imageNamed:@"Splash-frame20.png"],
                   [UIImage imageNamed:@"Splash-frame21.png"],
                   [UIImage imageNamed:@"Splash-frame22.png"],
                   [UIImage imageNamed:@"Splash-frame23.png"],
                   nil
                   ];
    
    SplashImage.animationImages=splashArray;
    [SplashImage setAnimationDuration:splashDuration];
    [SplashImage setAnimationRepeatCount:1];
    [SplashImage startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:1.6
                                     target:self
                                   selector:@selector(ResetLines)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)WhaleJump{
    
    [linePath removeAllPoints];
  	lineDraw.path = linePath.CGPath;
    
    [FishermanImage setImage:[UIImage imageNamed:@"FishermanScared.png"]];
    SplashImage.center = CGPointMake(-50,-50);
    
    int WhaleX = linePathEndX;
    int WhaleY = linePathEndY - 28;
    
    if(WhaleX >= 275){
        WhaleX = 275;
    }
    
    if(WhaleX <= 140){
        WhaleX = 140;
    }
    
    WhaleImage.center = CGPointMake(WhaleX,WhaleY);
    
    [WhaleImage setImage:[UIImage imageNamed:@"Whale16.png"]];
    float whaleDuration = 0.8;
    NSArray *whaleArray;
    whaleArray = [[NSArray alloc] initWithObjects:
                   [UIImage imageNamed:@"Whale01.png"],
                   [UIImage imageNamed:@"Whale02.png"],
                   [UIImage imageNamed:@"Whale03.png"],
                   [UIImage imageNamed:@"Whale04.png"],
                   [UIImage imageNamed:@"Whale05.png"],
                   [UIImage imageNamed:@"Whale06.png"],
                   [UIImage imageNamed:@"Whale07.png"],
                   [UIImage imageNamed:@"Whale08.png"],
                   [UIImage imageNamed:@"Whale09.png"],
                   [UIImage imageNamed:@"Whale10.png"],
                   [UIImage imageNamed:@"Whale11.png"],
                   [UIImage imageNamed:@"Whale12.png"],
                   [UIImage imageNamed:@"Whale13.png"],
                   [UIImage imageNamed:@"Whale14.png"],
                   [UIImage imageNamed:@"Whale15.png"],
                   [UIImage imageNamed:@"Whale16.png"],
                   nil
                   ];
    
    WhaleImage.animationImages=whaleArray;
    [WhaleImage setAnimationDuration:whaleDuration];
    [WhaleImage setAnimationRepeatCount:1];
    [WhaleImage startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:whaleDuration + 0.1
                                     target:self
                                   selector:@selector(WhaleWater)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)WhaleWater{
    
    [FishermanImage setImage:[UIImage imageNamed:@"FishermanFinish.png"]];
    
    float whaleDuration = 1;
    float WhaleMultiplier = 5;
    NSArray *whaleArray;
    whaleArray = [[NSArray alloc] initWithObjects:
                  [UIImage imageNamed:@"Whale17.png"],
                  [UIImage imageNamed:@"Whale18.png"],
                  [UIImage imageNamed:@"Whale19.png"],
                  [UIImage imageNamed:@"Whale20.png"],
                  nil
                  ];
    
    WhaleImage.animationImages=whaleArray;
    [WhaleImage setAnimationDuration:whaleDuration];
    [WhaleImage setAnimationRepeatCount:WhaleMultiplier];
    [WhaleImage startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:whaleDuration * WhaleMultiplier + 0.1
                                     target:self
                                   selector:@selector(swapViews)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)ResetLines{
   
    [linePath removeAllPoints];
  	lineDraw.path = linePath.CGPath;
    CastFlag = 0;
    
    double randomWave = (double)((arc4random() % 30) + 10)/10;
    fishermanWaveTimer = [NSTimer scheduledTimerWithTimeInterval:randomWave
                                                          target:self
                                                        selector:@selector(FishermanWave)
                                                        userInfo:nil
                                                         repeats:NO];

}

-(void)swapViews{
    
    self.view.userInteractionEnabled = NO;
    
    for (Bird *birdLocal in BirdCollection) {
        [birdLocal->birdFlapTimer invalidate];
        [birdLocal->birdMoveTimer invalidate];

    }

    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Fish"];
    
}

@end
