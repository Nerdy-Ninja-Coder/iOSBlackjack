//
//  Deck.m
//  Blackjack
//
//  Created by Amy Wold on 12/27/14.
//  Copyright (c) 2014 Amy Wold. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()
{

    NSMutableArray *cards;
}



@end

@implementation Deck


#pragma mark - Initialization
-(id)init
{
    if (self = [super init]) {
        cards = [[NSMutableArray alloc] init];
    
        for (int suit = 0; suit <= 3; suit++) {
            for (int cardNumber = 1; cardNumber <= 13; cardNumber++) {
                [cards addObject:[[Card alloc]initWithCardNumber:cardNumber suit:suit]];
            }
        }
        [self shuffle];
    }
    return self;
}

#pragma mark - Deck Functionality



-(void)shuffle
{
    NSUInteger count = [cards count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

-(Card *)drawCard
{
    if ([cards count] > 0) {
        Card *tCard = [cards lastObject];
        [cards removeLastObject];
        return tCard;
    }
    return nil;
}

//-(NSInteger) cardsRemaining
//{
//    return [cards count];
//}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Deck : %@", cards];
}

@end
