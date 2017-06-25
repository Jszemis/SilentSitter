//
//  Horse.h
//  Silent Sitter
//
//  Created by Lizzie Szemis on 13/02/13.
//
//

#import <UIKit/UIKit.h>
#import "OBShapedButton.h"
//OBShapedButton

@interface Horse : UIButton{
    
//@interface Horse : OBShapedButton{

    float HorseStartHeight;
    float HorseJumpHeight;
    
}

- (IBAction)clickHorse:(id)sender;
-(void)HorseGallop;
-(float)HorseJumpHeight;
-(float)HorseStartHeight;
-(void)HorseJumpHeightReset;
-(void)HorseStop;
    
@end

