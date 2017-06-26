#import "SheepViewController.h"
#import "MultiboxAppDelegate.h"

@interface SheepViewController ()

@end

@implementation SheepViewController{
    int _sheepJumpCount;
}

@synthesize backgroundImage;
@synthesize foregroundImage;
@synthesize SheepCollection;
@synthesize sun;
@synthesize moon;

-(void)changeSheepJump:(Sheep *)sheepView{
    _sheepJumpCount--;
    if(_sheepJumpCount == 0){
        [self Sunset];
    }
}

-(int)numberOfSheepJump:(Sheep *)sheepView{    
    return _sheepJumpCount;
}

-(void)Sunset{
    
    UIImage *image1 = [UIImage imageNamed:@"sky01.png"];
    UIImage *image2 = [UIImage imageNamed:@"sky02.png"];
    
    CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
    crossFade.duration = 5.0;
    crossFade.fromValue = image1;
    crossFade.toValue = image2;
    [backgroundImage.layer addAnimation:crossFade forKey:@"animateContents"];
    
    backgroundImage.image = image2;
    
    UIImage *foreImage1 = [UIImage imageNamed:@"landscapeforegroundpng.png"];
    UIImage *foreImage2 = [UIImage imageNamed:@"landscapeforeground2png.png"];
    
    CABasicAnimation *crossForeFade = [CABasicAnimation animationWithKeyPath:@"contents"];
    crossForeFade.duration = 10.0;
    crossForeFade.fromValue = foreImage1;
    crossForeFade.toValue = foreImage2;
    [foregroundImage.layer addAnimation:crossForeFade forKey:@"animateContents"];
    
    foregroundImage.image = foreImage2;
    
    int sunInitialX = sun.center.x;
    int sunInitialY = sun.center.y; 
    
    CGMutablePathRef aPath;
    CGFloat duration = 5;
    
    aPath = CGPathCreateMutable();  
    
    CGPathMoveToPoint(aPath, NULL, sunInitialX, sunInitialY);   
    CGPathAddLineToPoint(aPath,NULL, sunInitialX, sunInitialY+100); 
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth; 
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath]; 
    
    CFRelease(aPath);
    
    [[sun layer] addAnimation: arcAnimation forKey: @"sunAnimation"];
    
    [UIView beginAnimations: [NSString stringWithFormat: @"sunAnimation"] context: nil];
    [UIView setAnimationDuration: duration];
    [UIView commitAnimations];    
    
    [NSTimer scheduledTimerWithTimeInterval:duration
                                     target:self
                                   selector:@selector(Moonrise)
                                   userInfo:nil
                                    repeats:NO];   
 
}

-(void)Moonrise{
    
    UIImage *image1 = [UIImage imageNamed:@"sky02.png"];
    UIImage *image2 = [UIImage imageNamed:@"sky03.png"];
    
    CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
    crossFade.duration = 5.0;
    crossFade.fromValue = image1;
    crossFade.toValue = image2;
    [backgroundImage.layer addAnimation:crossFade forKey:@"animateContents"];
    
    backgroundImage.image = image2;
    
    int moonInitialX = moon.center.x;
    int moonInitialY = moon.center.y; 
    
    CGMutablePathRef aPath;
    CGFloat duration = 5;
    
    aPath = CGPathCreateMutable();  
    
    CGPathMoveToPoint(aPath, NULL, moonInitialX, moonInitialY);   
    CGPathAddLineToPoint(aPath,NULL, moonInitialX, moonInitialY-100); 
    
    CAKeyframeAnimation* arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [arcAnimation setDuration: duration];
    [arcAnimation setAutoreverses: NO];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeBoth; 
    arcAnimation.delegate = self;
    [arcAnimation setPath: aPath]; 
    
    CFRelease(aPath);
    
    [[moon layer] addAnimation: arcAnimation forKey: @"moonAnimation"];
    
    [UIView beginAnimations: [NSString stringWithFormat: @"moonAnimation"] context: nil];
    [UIView setAnimationDuration: duration];
    [UIView commitAnimations];   
    
    [NSTimer scheduledTimerWithTimeInterval:(duration + 2)
                                     target:self
                                   selector:@selector(swapViews)
                                   userInfo:nil
                                    repeats:NO];       
    
}

-(void)swapViews{
    
    self.view.userInteractionEnabled = NO;
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Sheep"];
    
}


- (void)viewDidLoad
{
    
    self.view.userInteractionEnabled = NO;
    
    [super viewDidLoad];
    
    for (Sheep *sheepLocal in SheepCollection) {
        [sheepLocal setDelegate:self];
    }
    
    _sheepJumpCount = (int)[SheepCollection count];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(SheepEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)SheepEnable{
    
    self.view.userInteractionEnabled = YES;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
