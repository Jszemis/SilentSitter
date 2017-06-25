//
//  Rodcast.m
//  mutiltest
//
//  Created by Lizzie Szemis on 2/10/12.
//
//

#import "Rodcast.h"

@implementation Rodcast

- (void)resetCheckmark
{
    _checkmarkState = CheckmarkFirstStrokeDown;
    _turnPoint = CGPointZero;
    _startPoint = CGPointZero;
}

// Override the reset method. This methods gets
// called whenever the state changes to
// UIGestureRecognizerStateFailed.
- (void)reset
{
    [super reset];
    [self resetCheckmark];
}

// Touch began on view so save the start point
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint startPoint = [[touches anyObject] locationInView:self.view];
    
    if ([touches count] != 1 || startPoint.x <= 50 || startPoint.x >= 140 || startPoint.y <= 410 || startPoint.y >= 480) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }else{
        _startPoint = [[touches anyObject] locationInView:self.view];
    }
}

// Track the move of the current gesture
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed)
        return;
    
    CGPoint newPoint = [[touches anyObject] locationInView:self.view];
   // CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
    
   // if (newPoint.y <= prevPoint.y){
        _turnPoint = newPoint;
  //  }else{
   //     self.state = UIGestureRecognizerStateFailed;
   // }
}

// Track the end of the gesture
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];

    if (self.state == UIGestureRecognizerStatePossible)  {
        self.state = UIGestureRecognizerStateRecognized;
    }else{
        self.state = UIGestureRecognizerStateFailed;
    }
}

// The gesture will fail if touche was cancelled
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateFailed;
}


@end
