//
//  Card.h
//  Blackjack
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Hearts,
    Spades,
    Diamonds,
    Clubs
} Suit;

@interface Card : NSObject {
}

@property NSInteger cardNumber;
@property Suit suit;
@property BOOL cardClosed; //open;


-(id) initWithCardNumber:(NSInteger) aCardNumber suit:(Suit) aSuit;
-(NSString *) filename;
-(NSInteger) pipValue;

@end
