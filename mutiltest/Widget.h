//
//  Widget.h
//  mutiltest
//
//  Created by Lizzie Szemis on 12/09/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class Widget;

@interface Widget : UIImageView{
    NSTimer *widgetCollisionTimer;
    CGRect widgetFrame;
    float widgetInitialX;
    float widgetInitialY;
}

-(CGRect)widgetReturnRectange;
-(void)widgetMove;
-(void)WidgetRemove;

@end
