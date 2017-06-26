//
//  ChristmasViewController.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 13/12/12.
//
//

#import "ChristmasViewController.h"
#import "MultiboxAppDelegate.h"
#import "OBShapedButton.h"

@interface ChristmasViewController ()

@end

@implementation ChristmasViewController{
    int _PresentCount;
}

@synthesize LightCollection;
@synthesize PresentCollection;
@synthesize Fire;
@synthesize Tree;
@synthesize presentArray = _presentArray;

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
    
    bulbCounter = 0;
    _PresentCount = 4;
    
    CGRect umFrame = CGRectMake(0,0,0,0);
    for (Light *lightLocal in LightCollection) {
        [lightLocal drawRect:(umFrame)];
    }
    
    for (Present *presentLocal in PresentCollection) {
        [presentLocal setDelegate:self];
    }

    NSArray *fireArray;
    fireArray = [[NSArray alloc] initWithObjects:
                    [UIImage imageNamed:@"fire0.png"],
                    [UIImage imageNamed:@"fire1.png"],
                    [UIImage imageNamed:@"fire2.png"],
                    [UIImage imageNamed:@"fire4.png"],
                    [UIImage imageNamed:@"fire5.png"],
                    [UIImage imageNamed:@"fire6.png"],
                    nil
                    ];
    
    Fire.animationImages=fireArray;
    [Fire setAnimationDuration:1.5];
    [Fire setAnimationRepeatCount:HUGE_VALF];
    [Fire startAnimating];
    
    _presentArray = [[NSMutableArray alloc] init];

    for(int i = 10; i <= 32; i++){
    
        [_presentArray addObject:[NSNumber numberWithInteger:i]];
        
    }
        
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(ChristmasEnable)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)ChristmasEnable{
    
    self.view.userInteractionEnabled = YES;
    
}


-(void)swapViews{

    self.view.userInteractionEnabled = NO;
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Cover"];
    
}

-(IBAction)ClearTest:(id)sender forEvent:(UIEvent *)event {
    
    if(bulbCounter < 150){
        
        NSSet *touches = [event touchesForView:sender];
        UITouch *tap = [touches anyObject];
        CGPoint touchPoint = [tap locationInView:self.view];
        CGFloat bulbpointX = touchPoint.x;
        CGFloat bulbpointY = touchPoint.y;
        int starCounter = arc4random() % 10;
    
        CAShapeLayer *bulbLayer;
        bulbLayer = [CAShapeLayer layer];
        bulbLayer.bounds = CGRectMake(bulbpointX, bulbpointY, 14,14);
        bulbLayer.position = CGPointMake(bulbpointX, bulbpointY);
        bulbLayer.contents = (id)([UIImage imageNamed:[NSString stringWithFormat:@"christmasbulb%i%@",starCounter,@".png"]].CGImage);

        [self.view.layer addSublayer:bulbLayer];
        bulbCounter++;
        
    }
}


-(void)changePresentCount:(Present *)presentView{

    _PresentCount--;

    if(_PresentCount == 0){
        
        [NSTimer scheduledTimerWithTimeInterval:3
                                         target:self
                                       selector:@selector(swapViews)
                                       userInfo:nil
                                        repeats:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:2.5
                                         target:self
                                       selector:@selector(DisableTree)
                                       userInfo:nil
                                        repeats:NO];
    }
 
}


-(int)getPresent:(Present *)presentView{
    
    int totalPresentNumber = ([_presentArray count]);
    int RandomPresent = arc4random() % totalPresentNumber;

    int returnPresent = [[_presentArray objectAtIndex:RandomPresent] intValue];
    [_presentArray removeObjectAtIndex:RandomPresent];
    
    return returnPresent;

}

-(void)DisableTree{
    
    Tree.adjustsImageWhenDisabled = NO;
    Tree.enabled = NO;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
