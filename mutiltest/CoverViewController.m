//
//  CoverViewController.m
//  mutiltest
//
//  Created by Lizzie Szemis on 7/11/12.
//
//

#import "CoverViewController.h"
#import "MultiboxAppDelegate.h"



@interface CoverViewController ()

@end

@implementation CoverViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(swapViews)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)swapViews{

    for (UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
    
    for (CALayer *layer in [self.view.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    
    MultiboxAppDelegate *delegateMulti = (MultiboxAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegateMulti switchRandom:@"Cover"];
      
}

@end