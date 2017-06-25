//
//  HorizontalBlind.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 13/05/13.
//
//

#import "HorizontalBlind.h"

@implementation HorizontalBlind

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)HorizontalBlindShorter{
    
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height - 1);
    
    if(self.frame.size.height > 8){
        
        HorizontalBlindShorterTimer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                         target:self
                                       selector:@selector(HorizontalBlindShorter)
                                       userInfo:nil
                                        repeats:NO];
        

    }
    
}


-(void)HorizontalBlindNarrower{

    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width - 1,self.frame.size.height);
    
    if(self.frame.size.width > 0){
        
        HorizontalBlindNarrowerTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                         target:self
                                       selector:@selector(HorizontalBlindNarrower)
                                       userInfo:nil
                                        repeats:NO];
        
        
    }else{
        self.frame = CGRectMake(0,0,0,0);
    }
    
}

-(void)HorizontalMoveUp:(NSTimer*)aTimer{
    
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y - 1,self.frame.size.width,self.frame.size.height);
           
    if(self.frame.origin.y + self.frame.size.height > 30){

        HorizontalMoveUpTimer = [NSTimer scheduledTimerWithTimeInterval:[aTimer.userInfo floatValue]
                                         target:self
                                       selector:@selector(HorizontalMoveUp:)
                                       userInfo:aTimer.userInfo
                                        repeats:NO];

    }
    
}

-(void)HorizontalMoveLeft:(NSTimer*)aTimer{
    
    self.frame = CGRectMake(self.frame.origin.x - 1,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    
    if(self.frame.origin.x > -50){
        
        HorizontalMoveLeftTimer = [NSTimer scheduledTimerWithTimeInterval:[aTimer.userInfo floatValue]
                                         target:self
                                       selector:@selector(HorizontalMoveLeft:)
                                       userInfo:aTimer.userInfo
                                        repeats:NO];
        
    }
    
}

@end
