//
//  ChristmasViewController.h
//  Silent Sitter
//
//  Created by Lizzie Szemis on 13/12/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Light.h"
#import "Present.h"

@interface ChristmasViewController : UIViewController <PresentDelegate>{
        int bulbCounter;
}

@property (nonatomic,strong) IBOutletCollection(Light) NSArray *LightCollection;
@property (nonatomic,strong) IBOutletCollection(Present) NSArray *PresentCollection;
@property (nonatomic,strong) IBOutlet UIImageView *Fire;
@property (nonatomic,strong) IBOutlet UIButton *Tree;
@property (strong, nonatomic) NSMutableArray *presentArray;

-(void)swapViews;
-(void)DisableTree;
-(IBAction)ClearTest:(id)sender forEvent:(UIEvent *)event;
-(void)changePresentCount:(Present *)presentView;
-(int)getPresent:(Present *)presentView;

@end

