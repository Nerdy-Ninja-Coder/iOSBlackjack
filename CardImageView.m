//
//  CardImageView.m
//  Blackjack
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import "CardImageView.h"
#import "Card.h"
#import "Deck.h"
#import "Hand.h"

@interface CardImageView () {
    UIImage *image;
    BOOL open;
}

@end

@implementation CardImageView

@synthesize suit, cardId, open, image;

-(UIImageView *)image {
    NSString *fileName;
    switch (self.isOpen) {
        case YES:
            fileName = [NSString stringWithFormat:@"%d-%d.png", self.suit, self.cardId];
            break;
            
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
