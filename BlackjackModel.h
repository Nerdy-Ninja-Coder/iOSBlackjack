//
//  BlackjackModel.h
//  Blackjack
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Hand.h"

typedef enum {
    Player,
    Dealer,
    Draw
} Winner;

@interface BlackjackModel : NSObject <UIAlertViewDelegate>
{
    Hand *dealerHand;
    Hand *playerHand;
    Deck *deck;
}

@property Hand *dealerHand;
@property Hand *playerHand;
@property Deck *deck;
@property  int totalPlays;
@property int wins;
@property int loses;
@property int draws;


-(void) setup;
-(void) resetGame;
-(void) playerHandDraws;
-(void) playerStands;
-(NSInteger) totalGames;
-(NSInteger) totalWins;
-(NSInteger) totalLoses;
-(NSInteger) totalDraws;

+(BlackjackModel *)getBlackjackModel;




@end

