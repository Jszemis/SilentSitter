//
//  Widget.m
//  mutiltest
//
//  Created by Lizzie Szemis on 12/09/12.
//
//

#import "Widget.h"

@implementation Widget

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    widgetInitialX = self.center.x;
    widgetInitialY = self.center.y;
    
    widgetCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                             target:self
                                                           selector:@selector(widgetMove)
                                                           userInfo:nil
                                                            repeats:YES];
    
}


-(CGRect)widgetReturnRectange{
    
    return widgetFrame;
    
}

-(void)widgetMove{
    
    int randomX = (arc4random() % 3) - 1;
    int randomY = (arc4random() % 3) - 1;
    
    if(self.center.x < widgetInitialX - 5){
        randomX = 1;
    }
    
    if(self.center.x > widgetInitialX + 5){
        randomX = -1;
    }
    
    if(self.center.y < widgetInitialY - 5){
        randomY = 1;
    }
    
    if(self.center.y > widgetInitialY + 5){
        randomY = -1;
    }
        
    CGPoint widgetLocation = CGPointMake(self.center.x + randomX,self.center.y + randomY);
    self.center = widgetLocation;

    widgetFrame = self.layer.frame;
    
}

-(void)WidgetRemove{
    
    [NSTimer scheduledTimerWithTimeInterval:0.8
                                        target:self
                                        selector:@selector(WidgetRemoveDelay)
                                        userInfo:nil
                                        repeats:NO];
    
}

-(void)WidgetRemoveDelay{
    
    [widgetCollisionTimer invalidate];
    widgetFrame =  CGRectMake(-100,-100,0,0);
    self.frame = CGRectMake(-100,-100,0,0);
    [self removeFromSuperview];
    
}

@end
