//
//  Horse.m
//  Silent Sitter
//
//  Created by Lizzie Szemis on 13/02/13.
//
//

#import "Horse.h"

@implementation Horse

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
    HorseStartHeight = self.center.y;
    HorseJumpHeight = self.center.y;
    
}

-(void)HorseGallop{
     
    float HorseGallopDuration = 0.7;
    NSArray *HorseGallop;
    HorseGallop = [[NSArray alloc] initWithObjects:
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame08.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame07.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame06.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame05.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame04.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame03.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame02.png"]],
                     [UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Frame01.png"]],
                     nil
                     ];
    
    self.imageView.animationImages=HorseGallop;
    [self.imageView setAnimationDuration:HorseGallopDuration];
    [self.imageView setAnimationRepeatCount:100];
    
    [self.imageView startAnimating];

}

- (IBAction) clickHorse: (id) sender {
    
    if(HorseJumpHeight >60){
        HorseJumpHeight = HorseJumpHeight - 30;
    }
    [self.imageView stopAnimating];
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Jump.png"]] forState:UIControlStateNormal];

}

-(void)HorseStop{
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Horse%@%@",self.titleLabel.text,@"-Stop.png"]] forState:UIControlStateNormal];
}


-(float)HorseJumpHeight{
    return HorseJumpHeight;
}


-(float)HorseStartHeight{
    return HorseStartHeight;
}

-(void)HorseJumpHeightReset{
   HorseJumpHeight = HorseJumpHeight + 1;
}


@end
