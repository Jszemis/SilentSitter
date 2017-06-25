//
//  Bird.h
//  mutiltest
//
//  Created by Lizzie Szemis on 5/10/12.
//
//

#import <UIKit/UIKit.h>

@interface Bird : UIImageView{
    float birdInitialX;
    float birdInitialY;
    @public
    NSTimer *birdFlapTimer;
    NSTimer *birdMoveTimer;
}

@end
