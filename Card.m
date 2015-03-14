//
//  Card.m
//  Blackjack
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize suit = _suit, cardNumber = _cardNumber, cardClosed = _cardClosed;

-(id) initWithCardNumber:(NSInteger) aCardNumber suit:(Suit) aSuit{
    if ((self = [super init]))
    {
        _suit = aSuit;
        _cardNumber = aCardNumber;
        _cardClosed = NO;
        
    }
    return self;
}

-(NSString *) suitAsString{
    switch (_suit) {
        case Hearts:
            return @"Hearts";
            break;
        case Diamonds:
            return @"Diamonds";
            break;
        case Spades:
            return @"Spades";
            break;
        case Clubs:
            return @"Clubs";
            break;
        default:
            return nil;
            break;
    }
}


//TODO: Ace can be 1 or 11. At the moment it is just always 1.
-(NSInteger) pipValue {
    if (_cardClosed == YES)
    {
        return (0);
    }
    else if (_cardNumber >= 10)
        return (10);
    else if (_cardNumber == 1)
        return (11);
    else
        return (_cardNumber);
}


-(NSString *) cardNumberAsString{
    switch (_cardNumber) {
        case 1:
            return @"Ace";
            break;
        case 11:
            return @"Jack";
            break;
        case 12:
            return @"Queen";
            break;
        case 13:
            return @"King";
            break;
        default:
            return [NSString stringWithFormat:@"%li", (long)_cardNumber];
            break;
    }
}

-(NSString *)filename {
    if (_cardClosed == YES) {
        return @"closedcard.png";
    }
    else {
        return [NSString stringWithFormat:@"%d-%ld.png",self.suit, (long)self.cardNumber];
    }
}


-(NSString *) description{
    return [NSString stringWithFormat:@"%@ %@ (pipValue = %li)", [self suitAsString], [self cardNumberAsString], (long)[self pipValue]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
