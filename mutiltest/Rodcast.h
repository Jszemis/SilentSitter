//
//  Rodcast.h
//  mutiltest
//
//  Created by Lizzie Szemis on 2/10/12.
//
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

typedef enum {
    CheckmarkFirstStrokeDown,
    CheckmarkSecondStrokeUp
} CheckmarkGestureState;


@interface Rodcast : UIGestureRecognizer {
    
    CheckmarkGestureState _checkmarkState;
    CGPoint _turnPoint;
    CGPoint _startPoint;
    
}

- (void)resetCheckmark;

- (void)reset;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


@end