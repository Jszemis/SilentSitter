//
//  HouseViewController.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 12/04/13.
//
//

#import "HouseViewController.h"
#import "MultiboxAppDelegate.h"

@interface HouseViewController ()

- (void)setupAVCapture;
- (AVCaptureDevice *)frontCamera;

@end

@implementation HouseViewController

@synthesize PetalCollection,VerticalCollection,HorizontalCollection;
@synthesize LeftShutter,RightShutter,CurtainLeft,CurtainRight,Blind,WindowFrame,House,Lace,VerticalChain;
@synthesize HorizontalCordRight,HorizontalCordLeft,HorizontalCordKnob,HorizontalKnob,MetalDoor;
@synthesize LeftShutterSwipe,RightShutterSwipe,UpVerticleSwipe,DownVerticleSwipe,LeftVerticleSwipe,RightVerticleSwipe,UpBlindSwipe,DownBlindSwipe,LeftCurtainSwipe,RightCurtainSwipe,UpWindowSwipe,DownWindowSwipe,UpHorizontalSwipe,DownHorizontalSwipe,UpLaceSwipe,DownLaceSwipe,DownMetalSwipe,UpMetalSwipe;


- (void)setupAVCapture
{
    
    session = [AVCaptureSession new];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    AVCaptureDevice *device = [self frontCamera];
    
	AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];

	if ( [session canAddInput:deviceInput] )
		[session addInput:deviceInput];
	videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", NULL);
	[videoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];
	
    if ( [session canAddOutput:videoDataOutput] )
		[session addOutput:videoDataOutput];
	[[videoDataOutput connectionWithMediaType:AVMediaTypeVideo] setEnabled:NO];
	
	effectiveScale = 1.0;
	previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
	[previewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
	[previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
	CALayer *rootLayer = [previewView layer];
	[rootLayer setMasksToBounds:YES];
	[previewLayer setFrame:[rootLayer bounds]];
	[rootLayer addSublayer:previewLayer];
	[session startRunning];
    
}


- (AVCaptureDevice *)frontCamera {
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    
    return nil;
}


-(void)OpenRightShutter{
    
    [RightShutter setImage:[UIImage imageNamed:@"Shutter-Frame00.png"]];
    
    float RightShutterVictoryDuration = 2;
    NSArray *RightShutterVictory;
    RightShutterVictory = [[NSArray alloc] initWithObjects:
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame11.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame12.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame13.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame14.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame15.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame16.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame17.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame18.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame09.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame08.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame07.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame06.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame05.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame04.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame03.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame02.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame01.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame00.png"]],
                          nil
                          ];
    
    RightShutter.animationImages=RightShutterVictory;
    [RightShutter setAnimationDuration:RightShutterVictoryDuration];
    [RightShutter setAnimationRepeatCount:1];
    [RightShutter startAnimating];
}


-(void)OpenLeftShutter{
    
    [LeftShutter setImage:[UIImage imageNamed:@"Shutter-Frame11.png"]];
    
    float LeftShutterVictoryDuration = 2;
    NSArray *LeftShutterVictory;
    LeftShutterVictory = [[NSArray alloc] initWithObjects:
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame00.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame01.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame02.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame03.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame04.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame05.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame06.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame07.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame08.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame09.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame18.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame17.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame16.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame15.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame14.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame13.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame12.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"Shutter-Frame11.png"]],
                     nil
                     ];
    
    LeftShutter.animationImages=LeftShutterVictory;
    [LeftShutter setAnimationDuration:LeftShutterVictoryDuration];
    [LeftShutter setAnimationRepeatCount:1];
    [LeftShutter startAnimating];

}


-(void)OpenBlind{
    
    int presentBlindInitialX = Blind.center.x;
    int presentBlindInitialY = Blind.center.y;
    
    CGMutablePathRef BlindPath;
    BlindPath = CGPathCreateMutable();
    CGFloat BlindDuration = 4;
    
    CGPathMoveToPoint(BlindPath, NULL, presentBlindInitialX, presentBlindInitialY);
    CGPathAddLineToPoint(BlindPath,NULL, presentBlindInitialX, presentBlindInitialY-500);
    
    CAKeyframeAnimation* BlindAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [BlindAnimation setDuration: BlindDuration];
    [BlindAnimation setAutoreverses: NO];
    BlindAnimation.removedOnCompletion = NO;
    BlindAnimation.fillMode = kCAFillModeBoth;
    BlindAnimation.delegate = self;
    [BlindAnimation setPath: BlindPath];
    CFRelease(BlindPath);
    
    [[Blind layer] addAnimation: BlindAnimation forKey: @"BlindAnimation"];
    
}


-(void)OpenCurtainLeft{
    
    CurtainLeft.frame = CGRectMake(CurtainLeft.frame.origin.x,CurtainLeft.frame.origin.y,CurtainLeft.frame.size.width - 1,CurtainLeft.frame.size.height);
    
    if(CurtainLeft.frame.size.width > 300){
        
        OpenCurtainLeftTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(OpenCurtainLeft)
                                       userInfo:nil
                                        repeats:NO];
    }

}


-(void)OpenCurtainRight{
    
    CurtainRight.frame = CGRectMake(CurtainRight.frame.origin.x + 1,CurtainRight.frame.origin.y,CurtainRight.frame.size.width - 1,CurtainRight.frame.size.height);
    
    if(CurtainRight.frame.size.width > 300){
        
        OpenCurtainRightTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(OpenCurtainRight)
                                       userInfo:nil
                                        repeats:NO];
    }
    
}


-(void)OpenWindowFrame{
    
    int presentFrameInitialX = WindowFrame.center.x;
    int presentFrameInitialY = WindowFrame.center.y;
    
    CGMutablePathRef FramePath;
    FramePath = CGPathCreateMutable();
    CGFloat FrameDuration = 4;
    
    CGPathMoveToPoint(FramePath, NULL, presentFrameInitialX, presentFrameInitialY);
    CGPathAddLineToPoint(FramePath,NULL, presentFrameInitialX, presentFrameInitialY-500);
    
    CAKeyframeAnimation* FrameAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [FrameAnimation setDuration: FrameDuration];
    [FrameAnimation setAutoreverses: NO];
    FrameAnimation.removedOnCompletion = NO;
    FrameAnimation.fillMode = kCAFillModeBoth;
    FrameAnimation.delegate = self;
    [FrameAnimation setPath: FramePath];
    CFRelease(FramePath);
    
    [[WindowFrame layer] addAnimation: FrameAnimation forKey: @"FrameAnimation"];
    
}


-(void)OpenVertical{
    
    for (HorizontalBlind *verticleLocal in VerticalCollection) {
    
           [verticleLocal HorizontalBlindNarrower];
    }
    
    VerticalChain->HorizontalMoveLeftTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:VerticalChain
                                   selector:@selector(HorizontalMoveLeft:)
                                   userInfo:[NSNumber numberWithDouble:0.05]
                                    repeats:NO];
  
    float VerticalChainDuration = 0.5;
    NSArray *VerticalChainArray;
    VerticalChainArray = [[NSArray alloc] initWithObjects:
                          [UIImage imageNamed:[NSString stringWithFormat:@"VerticleChain-Frame1.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"VerticleChain-Frame2.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"VerticleChain-Frame3.png"]],
                          nil
                          ];
    
    VerticalChain.animationImages=VerticalChainArray;
    [VerticalChain setAnimationDuration:VerticalChainDuration];
    [VerticalChain setAnimationRepeatCount:10];
    [VerticalChain startAnimating];

}


-(void)OpenHorizontal{
   
    //double horizontalLocalTemp;
    
    for (HorizontalBlind *horizontalLocal in HorizontalCollection) {
        //horizontalLocalTemp = horizontalLocal.frame.size.height;
        [horizontalLocal HorizontalBlindShorter];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1.5
                                     target:self
                                   selector:@selector(UpHorizontal)
                                   userInfo:nil
                                    repeats:NO];
    
    float HorizontalKnobDuration = 0.5;
    NSArray *HorizontalKnobArray;
    HorizontalKnobArray = [[NSArray alloc] initWithObjects:
                          [UIImage imageNamed:[NSString stringWithFormat:@"HorizontalKnob.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"HorizontalKnob2.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"HorizontalKnob.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"HorizontalKnob2.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"HorizontalKnob.png"]],
                          [UIImage imageNamed:[NSString stringWithFormat:@"HorizontalKnob2.png"]],
                          nil
                          ];
    
    HorizontalKnob.animationImages=HorizontalKnobArray;
    [HorizontalKnob setAnimationDuration:HorizontalKnobDuration];
    [HorizontalKnob setAnimationRepeatCount:1];
    [HorizontalKnob startAnimating];
    
}


-(void)UpHorizontal{

    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:HorizontalCordLeft
                                   selector:@selector(HorizontalMoveUp:)
                                   userInfo:[NSNumber numberWithDouble:0.01]
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:HorizontalCordRight
                                   selector:@selector(HorizontalMoveUp:)
                                   userInfo:[NSNumber numberWithDouble:0.01]
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:HorizontalCordKnob
                                   selector:@selector(HorizontalMoveUp:)
                                   userInfo:[NSNumber numberWithDouble:0.02]
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:HorizontalKnob
                                   selector:@selector(HorizontalMoveUp:)
                                   userInfo:[NSNumber numberWithDouble:0.02]
                                    repeats:NO];
    
    double horizontalTimer = 0.01;
    
    for (int x=1; x<14; x++) {
    
        for (HorizontalBlind *horizontalLocal in HorizontalCollection) {
      
            if((int)horizontalLocal.tag == x){
                
                horizontalLocal->HorizontalMoveUpTimer = [NSTimer scheduledTimerWithTimeInterval:horizontalTimer
                                                 target:horizontalLocal
                                               selector:@selector(HorizontalMoveUp:)
                                               userInfo:[NSNumber numberWithDouble:0.01]
                                                repeats:NO];
                
                horizontalTimer = horizontalTimer + 0.15;
                
                
            }
             
         }
         
     }

}


-(void)OpenLace{

    [Lace setImage:[UIImage imageNamed:@"Lace-Frame0.png"]];
    
    float LaceDuration = 1.5;
    NSArray *LaceArray;
    LaceArray = [[NSArray alloc] initWithObjects:
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame1.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame9.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame8.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame7.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame6.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame5.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame4.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame3.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame2.png"]],
                            [UIImage imageNamed:[NSString stringWithFormat:@"Lace-Frame0.png"]],
                            nil
                           ];
    
    Lace.animationImages=LaceArray;
    [Lace setAnimationDuration:LaceDuration];
    [Lace setAnimationRepeatCount:1];
    [Lace startAnimating];
    
}


-(void)OpenMetal{
    
    int presentMetalInitialX = MetalDoor.center.x;
    int presentMetalInitialY = MetalDoor.center.y;
    
    CGMutablePathRef MetalPath;
    MetalPath = CGPathCreateMutable();
    CGFloat MetalDuration = 4;
    
    CGPathMoveToPoint(MetalPath, NULL, presentMetalInitialX, presentMetalInitialY);
    CGPathAddLineToPoint(MetalPath,NULL, presentMetalInitialX, presentMetalInitialY+400);
    
    CAKeyframeAnimation* MetalAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [MetalAnimation setDuration: MetalDuration];
    [MetalAnimation setAutoreverses: NO];
    MetalAnimation.removedOnCompletion = NO;
    MetalAnimation.fillMode = kCAFillModeBoth;
    MetalAnimation.delegate = self;
    [MetalAnimation setPath: MetalPath];
    CFRelease(MetalPath);
    
    [[MetalDoor layer] addAnimation: MetalAnimation forKey: @"MetalAnimation"];
    
}


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
    [self setupAVCapture];
    [_FlyingBee startFlying];
    NSMutableArray *viewWindowsArray = [[NSMutableArray alloc] init];
    self->viewGesturesArray = [[NSMutableArray alloc] init];
    FinishFlag = 1;
    
    [viewWindowsArray addObject:@"Blind"];
    [viewWindowsArray addObject:@"Horizontal"];
    [viewWindowsArray addObject:@"Verticle"];
    [viewWindowsArray addObject:@"Window"];
    [viewWindowsArray addObject:@"Lace"];
    [viewWindowsArray addObject:@"Metal"];
    [viewWindowsArray addObject:@"Curtain"];

    [self->viewGesturesArray addObject:@"Start"];
    int x;
    for(x=[viewWindowsArray count]; x>0; x--){
    
    int randomIndex = (arc4random() % [viewWindowsArray count]);
        
        NSString *outputLable = [viewWindowsArray objectAtIndex:randomIndex];
        [viewWindowsArray removeObjectAtIndex:randomIndex];

        if([outputLable isEqual: @"Curtain"]){
            [self->viewGesturesArray addObject:@"Curtain"];
            [self->viewGesturesArray addObject:@"Curtain"];
            [self.view bringSubviewToFront:CurtainLeft];
            [self.view bringSubviewToFront:CurtainRight];
        } else if([outputLable isEqual: @"Blind"]){
            [self->viewGesturesArray addObject:@"Blind"];
            [self.view bringSubviewToFront:Blind];
        } else if([outputLable isEqual: @"Verticle"]){
            [self->viewGesturesArray addObject:@"Verticle"];
            for (UIImageView *verticleLocal in VerticalCollection) {
                [self.view bringSubviewToFront:verticleLocal];
            }
            [self.view bringSubviewToFront:VerticalChain];
        } else if([outputLable isEqual: @"Window"]){
            [self->viewGesturesArray addObject:@"Window"];            
            [self.view bringSubviewToFront:WindowFrame];
        } else if([outputLable isEqual: @"Horizontal"]){
            [self->viewGesturesArray addObject:@"Horizontal"];             
            for (UIImageView *horizontalLocal in HorizontalCollection) {
                [self.view bringSubviewToFront:horizontalLocal];
            }
            [self.view bringSubviewToFront:HorizontalCordLeft];
            [self.view bringSubviewToFront:HorizontalCordRight];
            [self.view bringSubviewToFront:HorizontalKnob];
            [self.view bringSubviewToFront:HorizontalCordKnob];
        } else if([outputLable isEqual: @"Lace"]){
            [self->viewGesturesArray addObject:@"Lace"];  
            [self.view bringSubviewToFront:Lace];
        } else if([outputLable isEqual: @"Metal"]){
            [self->viewGesturesArray addObject:@"Metal"];             
            [self.view bringSubviewToFront:MetalDoor];
        }
    }

    [self->viewGesturesArray addObject:@"Shutter"];
    [self->viewGesturesArray addObject:@"Shutter"];
    
    [self.view bringSubviewToFront:House];
    for (Petal *daisyLocal in PetalCollection) {
        [self.view bringSubviewToFront:daisyLocal];
        [daisyLocal FlowerRotate];
    }
    [self.view bringSubviewToFront:LeftShutter];
    [self.view bringSubviewToFront:RightShutter];
    [self.view bringSubviewToFront:_FlyingBee];
    /*
    UpVerticleSwipe.enabled = NO;
    DownVerticleSwipe.enabled = NO;
    LeftVerticleSwipe.enabled = NO;
    RightVerticleSwipe.enabled = NO;
    UpBlindSwipe.enabled = NO;
    DownBlindSwipe.enabled = NO;
    LeftCurtainSwipe.enabled = NO;
    RightCurtainSwipe.enabled = NO;
    UpWindowSwipe.enabled = NO;
    DownWindowSwipe.enabled = NO;
    UpHorizontalSwipe.enabled = NO;
    DownHorizontalSwipe.enabled = NO;
    UpLaceSwipe.enabled = NO;
    DownLaceSwipe.enabled = NO;
    DownMetalSwipe.enabled = NO;
    UpMetalSwipe.enabled = NO;
    
    LeftShutterSwipe.enabled = NO;
    RightShutterSwipe.enabled = NO;
    */
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(ShutterEnable)
                                   userInfo:nil
                                    repeats:NO];
    
    
    
}


-(void)ShutterEnable{
    
    self.view.userInteractionEnabled = YES;
    LeftShutterSwipe.enabled = YES;
    RightShutterSwipe.enabled = YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    
    [self setRightShutter:nil];
    [self setBlind:nil];
    [self setFlyingBee:nil];
    [self setWindowFrame:nil];
    [self setCurtainLeft:nil];
    [self setCurtainRight:nil];
    [self setHouse:nil];
    [self setHorizontalCordLeft:nil];
    [self setHorizontalCordRight:nil];
    [self setHorizontalCordKnob:nil];
    [self setHorizontalKnob:nil];
    [self setLace:nil];
    [self setVerticalChain:nil];
    [self setMetalDoor:nil];
    [self setLeftShutterSwipe:nil];
    [self setRightShutterSwipe:nil];
    [self setLeftVerticleSwipe:nil];
    [self setRightVerticleSwipe:nil];
    [self setUpBlindSwipe:nil];
    [self setLeftCurtainSwipe:nil];
    [self setRightCurtainSwipe:nil];
    [self setUpWindowSwipe:nil];
    [self setUpHorizontalSwipe:nil];
    [self setUpLaceSwipe:nil];
    [self setDownLaceSwipe:nil];
    [self setDownMetalSwipe:nil];
    [self setDownBlindSwipe:nil];
    [self setDownHorizontalSwipe:nil];
    [self setUpMetalSwipe:nil];
    [self setDownWindowSwipe:nil];
    [self setUpVerticleSwipe:nil];
    [self setDownVerticleSwipe:nil];
    [super viewDidUnload];
    
}


-(void)CycleGestrues:(NSString *)pNextGesture {
    
    if([pNextGesture isEqual:@"Curtain"]){
        LeftCurtainSwipe.enabled = YES;
        RightCurtainSwipe.enabled = YES;
    }
    
    if([pNextGesture isEqual:@"Blind"]){
        UpBlindSwipe.enabled = YES;
        DownBlindSwipe.enabled = YES;
    }
    
    if([pNextGesture isEqual:@"Verticle"]){
        UpVerticleSwipe.enabled = YES;
        DownVerticleSwipe.enabled = YES;
        LeftVerticleSwipe.enabled = YES;
        RightVerticleSwipe.enabled = YES;
    }
    
    if([pNextGesture isEqual:@"Window"]){
        UpWindowSwipe.enabled = YES;
        DownWindowSwipe.enabled = YES;
    }
    
    if([pNextGesture isEqual:@"Horizontal"]){
        UpHorizontalSwipe.enabled = YES;
        DownHorizontalSwipe.enabled = YES;
    }
    
    if([pNextGesture isEqual:@"Lace"]){
        UpLaceSwipe.enabled = YES;
        DownLaceSwipe.enabled = YES;
    }
    
    if([pNextGesture isEqual:@"Metal"]){
        DownMetalSwipe.enabled = YES;
        UpMetalSwipe.enabled = YES;
    }
    
    if(1 == [self->viewGesturesArray count] && FinishFlag == 1){
        
        FinishFlag = 0;
        self.view.userInteractionEnabled = NO;
        
        [NSTimer scheduledTimerWithTimeInterval:5
                                         target:self
                                       selector:@selector(swapViews)
                                       userInfo:nil
                                        repeats:NO];
    }
    
}


- (IBAction)LeftShutterSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenLeftShutter];
    [self->viewGesturesArray removeLastObject];
    LeftShutterSwipe.enabled = NO;
    if(![[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1] isEqual:@"Shutter"]){
        [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    }
 
}


- (IBAction)RightShutterSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenRightShutter];
    [self->viewGesturesArray removeLastObject];
    RightShutterSwipe.enabled = NO;
    if(![[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1] isEqual:@"Shutter"]){
        [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    }
}


- (IBAction)UpVerticleSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenVertical];
    [self->viewGesturesArray removeLastObject];
    UpVerticleSwipe.enabled = NO;
    DownVerticleSwipe.enabled = NO;
    LeftVerticleSwipe.enabled = NO;
    RightVerticleSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)DownVerticleSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenVertical];
    [self->viewGesturesArray removeLastObject];
    UpVerticleSwipe.enabled = NO;
    DownVerticleSwipe.enabled = NO;
    LeftVerticleSwipe.enabled = NO;
    RightVerticleSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)LeftVerticleSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenVertical];
    [self->viewGesturesArray removeLastObject];
    UpVerticleSwipe.enabled = NO;
    DownVerticleSwipe.enabled = NO;
    LeftVerticleSwipe.enabled = NO;
    RightVerticleSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)RightVerticleSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenVertical];
    [self->viewGesturesArray removeLastObject];
    UpVerticleSwipe.enabled = NO;
    DownVerticleSwipe.enabled = NO;
    LeftVerticleSwipe.enabled = NO;
    RightVerticleSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)UpBlindSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenBlind];
    [self->viewGesturesArray removeLastObject];
    UpBlindSwipe.enabled = NO;
    DownBlindSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)DownBlindSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenBlind];
    [self->viewGesturesArray removeLastObject];
    UpBlindSwipe.enabled = NO;
    DownBlindSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)LeftCurtainSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenCurtainLeft];
    [self->viewGesturesArray removeLastObject];
    LeftCurtainSwipe.enabled = NO;
    if(![[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1] isEqual:@"Curtain"]){
        [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    }
    
}


- (IBAction)RightCurtainSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenCurtainRight];
    [self->viewGesturesArray removeLastObject];
    RightCurtainSwipe.enabled = NO;
    if(![[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1] isEqual:@"Curtain"]){
        [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    }
    
}


- (IBAction)UpWindowSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenWindowFrame];
    [self->viewGesturesArray removeLastObject];
    UpWindowSwipe.enabled = NO;
    DownWindowSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)DownWindowSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenWindowFrame];
    [self->viewGesturesArray removeLastObject];
    UpWindowSwipe.enabled = NO;
    DownWindowSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)UpHorizontalSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenHorizontal];
    [self->viewGesturesArray removeLastObject];
    UpHorizontalSwipe.enabled = NO;
    DownHorizontalSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)DownHorizontalSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenHorizontal];
    [self->viewGesturesArray removeLastObject];
    UpHorizontalSwipe.enabled = NO;
    DownHorizontalSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)UpLaceSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenLace];
    [self->viewGesturesArray removeLastObject];
    UpLaceSwipe.enabled = NO;
    DownLaceSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)DownLaceSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenLace];
    [self->viewGesturesArray removeLastObject];
    UpLaceSwipe.enabled = NO;
    DownLaceSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)DownMetalSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenMetal];
    [self->viewGesturesArray removeLastObject];
    DownMetalSwipe.enabled = NO;
    UpMetalSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


- (IBAction)UpMetalSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self OpenMetal];
    [self->viewGesturesArray removeLastObject];
    DownMetalSwipe.enabled = NO;
    UpMetalSwipe.enabled = NO;
    [self CycleGestrues:[self->viewGesturesArray objectAtIndex:[self->viewGesturesArray count] - 1]];
    
}


-(void)swapViews{
    
    self.view.userInteractionEnabled = NO;
    
    [session stopRunning];
    dispatch_release(videoDataOutputQueue);
    
    [_FlyingBee StopFlying];
    
    [HorizontalCordLeft->HorizontalMoveUpTimer invalidate];
    [HorizontalCordRight->HorizontalMoveUpTimer invalidate];
    [HorizontalCordKnob->HorizontalMoveUpTimer invalidate];
    [HorizontalKnob->HorizontalMoveUpTimer invalidate];
    
    for (HorizontalBlind *horizontalLocal in HorizontalCollection) {
        [horizontalLocal->HorizontalMoveUpTimer invalidate];
    }
    
    [VerticalChain->HorizontalMoveLeftTimer invalidate];
    
    for (HorizontalBlind *verticleLocal in VerticalCollection) {
        [verticleLocal->HorizontalBlindNarrowerTimer invalidate];
    }
    
    [OpenCurtainLeftTimer invalidate];
    [OpenCurtainRightTimer invalidate];
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        layer.contents=nil;
        layer.delegate=nil;
        [layer removeFromSuperlayer];
    }
    
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"House"];
    
}


@end