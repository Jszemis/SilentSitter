//
//  Present.h
//  Silent Sitter
//
//  Created by Lizzie Szemis on 14/12/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Present;

@protocol PresentDelegate <NSObject>

-(void)changePresentCount:(Present *)presentView;
-(int)getPresent:(Present *)presentView;

@end

@interface Present : UIButton{
    int shakeCount;
}

@property (strong, nonatomic) id<PresentDelegate> delegate;

-(IBAction)PresentPress:(id)sender;

@end

