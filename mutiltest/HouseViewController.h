//
//  HouseViewController.h
//  Silent Sitter
//
//  Created by Lizzie Szemis on 12/04/13.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Petal.h"
#import "FlyingBee.h"
#import "HorizontalBlind.h"

@class Petal;
@class FlyingBee;
@class HorizontalBlind;

@interface HouseViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate>

{
	IBOutlet UIView *previewView;
	IBOutlet UISegmentedControl *camerasControl;
	AVCaptureVideoPreviewLayer *previewLayer;
	AVCaptureVideoDataOutput *videoDataOutput;
	dispatch_queue_t videoDataOutputQueue;
	CGFloat effectiveScale;
    NSMutableArray *viewGesturesArray;
    AVCaptureSession *session;
    NSTimer *OpenCurtainLeftTimer;
    NSTimer *OpenCurtainRightTimer;
    int FinishFlag;

}

@property (weak, nonatomic) IBOutlet UIImageView *LeftShutter;
@property (weak, nonatomic) IBOutlet UIImageView *RightShutter;
@property (weak, nonatomic) IBOutlet UIImageView *Blind;
@property (weak, nonatomic) IBOutlet FlyingBee *FlyingBee;
@property (weak, nonatomic) IBOutlet UIImageView *WindowFrame;
@property (weak, nonatomic) IBOutlet UIImageView *CurtainLeft;
@property (weak, nonatomic) IBOutlet UIImageView *CurtainRight;
@property (nonatomic, strong) IBOutletCollection(HorizontalBlind) NSArray *VerticalCollection;
@property (weak, nonatomic) IBOutlet HorizontalBlind *VerticalChain;
@property (nonatomic, strong) IBOutletCollection(HorizontalBlind) NSArray *HorizontalCollection;
@property (weak, nonatomic) IBOutlet UIImageView *House;
@property (weak, nonatomic) IBOutlet HorizontalBlind *HorizontalCordLeft;
@property (weak, nonatomic) IBOutlet HorizontalBlind *HorizontalCordRight;
@property (weak, nonatomic) IBOutlet HorizontalBlind *HorizontalCordKnob;
@property (weak, nonatomic) IBOutlet HorizontalBlind *HorizontalKnob;
@property (weak, nonatomic) IBOutlet UIImageView *Lace;
@property (weak, nonatomic) IBOutlet UIImageView *MetalDoor;
@property (nonatomic, strong) IBOutletCollection(Petal) NSArray *PetalCollection;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *LeftShutterSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *RightShutterSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpVerticleSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *DownVerticleSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *LeftVerticleSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *RightVerticleSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpBlindSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *DownBlindSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *LeftCurtainSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *RightCurtainSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpWindowSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *DownWindowSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpHorizontalSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *DownHorizontalSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpLaceSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *DownLaceSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *DownMetalSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpMetalSwipe;

- (IBAction)LeftShutterSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)RightShutterSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)UpVerticleSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)DownVerticleSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)LeftVerticleSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)RightVerticleSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)UpBlindSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)DownBlindSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)LeftCurtainSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)RightCurtainSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)UpWindowSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)DownWindowSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)UpHorizontalSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)DownHorizontalSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)UpLaceSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)DownLaceSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)DownMetalSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)UpMetalSwipe:(UISwipeGestureRecognizer *)sender;

@end
