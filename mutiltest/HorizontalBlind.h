//
//  HorizontalBlind.h
//  Silent Sitter
//
//  Created by Lizzie Szemis on 13/05/13.
//
//

#import <UIKit/UIKit.h>

@interface HorizontalBlind : UIImageView{

@public
     NSTimer *HorizontalBlindShorterTimer;
     NSTimer *HorizontalBlindNarrowerTimer;
     NSTimer *HorizontalMoveUpTimer;
     NSTimer *HorizontalMoveLeftTimer;
    
}

-(void)HorizontalBlindShorter;
-(void)HorizontalBlindNarrower;
-(void)HorizontalMoveUp:(NSTimer*)aTimer;
-(void)HorizontalMoveLeft:(NSTimer*)aTimer;

@end