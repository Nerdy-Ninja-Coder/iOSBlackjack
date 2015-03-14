//
//  Deck.h
//  Blackjack
//
//  Created by Amy Wold on 12/27/14.
//  Copyright (c) 2014 Amy Wold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)shuffle;
-(Card *)drawCard;


@end
