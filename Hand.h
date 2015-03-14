//
//  Hand.h
//  Blackjack
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Card;

@interface Hand : NSObject {

}

@property NSMutableArray *cardsInHand;
@property BOOL handClosed;

-(void) addCard:(Card *)Card;
-(NSInteger) getPipValue;
-(NSInteger) countCards;
-(Card *) getCardAtIndex:(NSInteger) index;


@end
