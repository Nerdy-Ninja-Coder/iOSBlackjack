//
//  Hand.m
//  Blackjack
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import "Hand.h"
#import "Card.h"

@implementation Hand

@synthesize handClosed = _handClosed;

- (id)init {
    self = [super init];
    if (self) {
        self.cardsInHand = [[NSMutableArray alloc] initWithCapacity:2];
        _handClosed = NO;
    }
    return self;
}

-(NSInteger) countCards {
    return ([self.cardsInHand count]);
}

-(void) addCard:(Card *)card {
    if ((_handClosed == NO) |([self countCards] == 0))
    {
    [self.cardsInHand addObject:card];
    }
    else
    {
        card.cardClosed = YES;
        [self.cardsInHand addObject:card];
    }
}

//  This fixes the aces, now either 1 or 11
-(NSInteger) getPipValue {
    NSInteger aValue = 0;
    NSInteger numberOfAces = 0;
    for (Card *tCard in self.cardsInHand) {
        if (tCard.pipValue == 11)
            numberOfAces = numberOfAces +1;
        
        aValue = aValue + [tCard pipValue];
    }
    while ((numberOfAces > 0) && (aValue > 21))
    {
        aValue = aValue - 10;
        numberOfAces = numberOfAces - 1;
    }
    return aValue;
}

-(Card *) getCardAtIndex:(NSInteger) index
{
    return ([self.cardsInHand objectAtIndex:index]);
}

-(NSString *)description{
    return [NSString stringWithFormat:@"cards in hand : %@", self.cardsInHand];
}

-(BOOL) handClosed
{
    return _handClosed;
}

-(void) setHandClosed:(BOOL)aHandClosed
{
    
    if (aHandClosed == NO) {
        for( Card *c in self.cardsInHand)
            c.cardClosed=NO;
    }
    _handClosed = aHandClosed;
}


@end
