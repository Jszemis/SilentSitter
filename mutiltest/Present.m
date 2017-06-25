//
//  Present.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 14/12/12.
//
//

#import "Present.h"
#import <QuartzCore/QuartzCore.h>

@implementation Present

@synthesize delegate;

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
    // Drawing code
    shakeCount = 0;
    
}

-(IBAction)PresentPress:(id)sender{

    shakeCount++;
    
    int presentInitialX = self.center.x;
    int presentInitialY = self.center.y;
    
    CGMutablePathRef shakePath;
    shakePath = CGPathCreateMutable();
    CGFloat shakeDuration = 0.5;
    
    CGPathMoveToPoint(shakePath, NULL, presentInitialX, presentInitialY);
    CGPathAddLineToPoint(shakePath,NULL, presentInitialX, presentInitialY-3);
    CGPathAddLineToPoint(shakePath,NULL, presentInitialX, presentInitialY);
    CGPathAddLineToPoint(shakePath,NULL, presentInitialX, presentInitialY-3);
    CGPathAddLineToPoint(shakePath,NULL, presentInitialX, presentInitialY);
    CGPathAddLineToPoint(shakePath,NULL, presentInitialX, presentInitialY-3);
    CGPathAddLineToPoint(shakePath,NULL, presentInitialX, presentInitialY);
    
    CAKeyframeAnimation* shakeAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [shakeAnimation setDuration: shakeDuration];
    [shakeAnimation setAutoreverses: NO];
    shakeAnimation.removedOnCompletion = NO;
    shakeAnimation.fillMode = kCAFillModeBoth;
    shakeAnimation.delegate = self;
    [shakeAnimation setPath: shakePath];
    CFRelease(shakePath);
    
    [[self layer] addAnimation: shakeAnimation forKey: @"shakeAnimation"];
    
    if(shakeCount > 3){
        
        self.enabled = NO;
        self.adjustsImageWhenDisabled = NO;
        
        [NSTimer scheduledTimerWithTimeInterval:shakeDuration
                                         target:self
                                       selector:@selector(PresentOpen)
                                       userInfo:nil
                                        repeats:NO];
        
    }
    
}

-(void)PresentOpen{

    [self.superview bringSubviewToFront:self];
    
    int presentInitialX = 40;
    int presentInitialY = 40;
    
    for(int i = 2; i <= 11; i++){
        
        int pieceCount = i/2;
    
        CAShapeLayer *pieceLayer;
        pieceLayer = [CALayer layer];
        pieceLayer.bounds = CGRectMake(presentInitialX, presentInitialY, 40,40);
        pieceLayer.position = CGPointMake(presentInitialX, presentInitialY);
        pieceLayer.contents = (id)([UIImage imageNamed:[NSString stringWithFormat:@"%@%@%i%@",self.titleLabel.text,@"piece",pieceCount,@".png"]].CGImage);
        [self.layer addSublayer:pieceLayer];
    
        CGMutablePathRef piecePath;
        piecePath = CGPathCreateMutable();
        CGFloat pieceDuration = 1;
        
        CGPathMoveToPoint(piecePath, NULL, presentInitialX, presentInitialY);
        
        int presentApexX = presentInitialX;
        int presentFinalX = presentInitialX;
        int presentApexY = presentInitialY;
        int presentFinalY = presentInitialY;
    
        if(i == 2){
            presentApexX = presentInitialX + 100;
            presentFinalX = presentInitialX + 300;
            presentApexY = presentInitialY - 150;
            presentFinalY = presentInitialY - 100;
        }
        
        if(i == 8){
            presentApexX = presentInitialX + 130;
            presentFinalX = presentInitialX + 300;
            presentApexY = presentInitialY - 100;
            presentFinalY = presentInitialY - 50;
        }
        
        if(i == 4){
            presentApexX = presentInitialX + 150;
            presentFinalX = presentInitialX + 300;
            presentApexY = presentInitialY - 50;
            presentFinalY = presentInitialY;
        }
        
        if(i == 10){
            presentApexX = presentInitialX + 150;
            presentFinalX = presentInitialX + 300;
            presentApexY = presentInitialY - 25;
            presentFinalY = presentInitialY + 50;
        }
        
        if(i == 6){
            presentApexX = presentInitialX + 150;
            presentFinalX = presentInitialX + 300;
            presentApexY = presentInitialY;
            presentFinalY = presentInitialY + 100;
        }
        
        if(i == 7){
            presentApexX = presentInitialX - 75;
            presentFinalX = presentInitialX - 300;
            presentApexY = presentInitialY - 200;
            presentFinalY = presentInitialY - 100;
        }
        
        if(i == 3){
            presentApexX = presentInitialX - 200;
            presentFinalX = presentInitialX - 350;
            presentApexY = presentInitialY - 100;
            presentFinalY = presentInitialY - 50;
        }
        
        if(i == 9){
            presentApexX = presentInitialX - 150;
            presentFinalX = presentInitialX - 350;
            presentApexY = presentInitialY - 50;
            presentFinalY = presentInitialY;
        }
        
        if(i == 5){
            presentApexX = presentInitialX - 150;
            presentFinalX = presentInitialX - 300;
            presentApexY = presentInitialY - 25;
            presentFinalY = presentInitialY + 50;
        }
        
        if(i == 11){
            presentApexX = presentInitialX - 100;
            presentFinalX = presentInitialX - 300;
            presentApexY = presentInitialY - 50;
            presentFinalY = presentInitialY + 150;
        }
        
        CGPathAddCurveToPoint(piecePath, NULL, presentApexX, presentApexY, presentApexX, presentApexY, presentFinalX, presentFinalY);
    
        CAKeyframeAnimation* pieceAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
        [pieceAnimation setDuration: pieceDuration];
        [pieceAnimation setAutoreverses: NO];
        pieceAnimation.removedOnCompletion = NO;
        pieceAnimation.fillMode = kCAFillModeBoth;
        pieceAnimation.delegate = self;
        pieceAnimation.calculationMode = kCAAnimationPaced;
        [pieceAnimation setPath: piecePath];
        CFRelease(piecePath);
    
        [pieceLayer addAnimation: pieceAnimation forKey: @"pieceAnimation"];
 
    }
    
    int randomPresent = [delegate getPresent:self];
    
    CAShapeLayer *presentLayer;
    presentLayer = [CALayer layer];
    presentLayer.bounds = CGRectMake(presentInitialX, presentInitialY, 80,80);
//presentLayer.bounds = CGRectMake(presentInitialX, presentInitialY, 40,40);
    presentLayer.position = CGPointMake(presentInitialX, presentInitialY);
    presentLayer.contents = (id)([UIImage imageNamed:[NSString stringWithFormat:@"present%i%@",randomPresent,@".png"]].CGImage);
    [self.layer addSublayer:presentLayer];
    
    CGMutablePathRef presentPath;
    presentPath = CGPathCreateMutable();
    CGFloat presentDuration = 0.8;
    
    CGPathMoveToPoint(presentPath, NULL, presentInitialX, presentInitialY);
    CGPathAddCurveToPoint(presentPath, NULL, presentInitialX, presentInitialX, presentInitialX, 100 - self.center.y, presentInitialX, 470 - self.center.y);
    
    CAKeyframeAnimation* presentAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    
    [presentAnimation setDuration: presentDuration];
    [presentAnimation setAutoreverses: NO];
    presentAnimation.removedOnCompletion = NO;
    presentAnimation.fillMode = kCAFillModeBoth;
    presentAnimation.delegate = self;
   // presentAnimation.calculationMode = kCAAnimationPaced;
    [presentAnimation setPath: presentPath];
    CFRelease(presentPath);
    
    [presentLayer addAnimation: presentAnimation forKey: @"presentAnimation"];
    UIImage *clearpresent  = [UIImage imageNamed:@"christmaslightclear.png"];
    [self.imageView setImage:clearpresent];
    
    [delegate changePresentCount:self];
    
}

@end
