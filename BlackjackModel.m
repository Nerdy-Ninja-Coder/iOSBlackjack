//
//  BlackjackModel.m
//  Blackjack
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import "BlackjackModel.h"
#import "Deck.h"
#import "Hand.h"
#import "BlackJackViewController.h"

@implementation BlackjackModel

@synthesize deck = _deck, dealerHand=_dealerHand, playerHand=_playerHand, totalPlays = _totalPlays, wins = _wins, loses = _loses, draws = _draws;

static BlackjackModel* blackjackModel = nil;

-(id) init {
    if ((self = [super init])){
        _deck = [[Deck alloc] init];
        _playerHand = [[Hand alloc] init];
        _dealerHand = [[Hand alloc] init];
        _dealerHand.handClosed = YES;

    }
    return (self);
}

-(void)setup
{
    //deal cards
    [self playerHandDraws];
    [self dealerHandDraws];
    
    [self playerHandDraws];
    [self dealerHandDraws];
    
}

-(void)dealerHandDraws
{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"dealerHand"];
}

-(void)playerHandDraws
{
    [self willChangeValueForKey:@"playerHand"];
    [_playerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"playerHand"];
    [self EndGameIfPlayerIsBust];
}

-(void)dealerStartsTurn{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand setHandClosed:NO];
    [self didChangeValueForKey:@"dealerHand"];
}

-(void)playerStands
{
    [self dealerStartsTurn];
    [self dealerPlays];
}

-(void) EndGameIfPlayerIsBust
{
    if (_playerHand.getPipValue > 21) {
        [self gameEnds:Dealer];
    }
}

-(void) gameEnds:(Winner) winner;
{
    self.totalPlays = self.totalPlays+1;
    NSString *msg;
    switch (winner) {
        case Player: {
            if (_dealerHand.getPipValue > 21) {
                msg = @"Dealer Busted, You Win!";
            } else {
            msg = @"You Win!";
            }
            self.wins = self.wins +1;
            break;
        }
        case Dealer: {
            if (_playerHand.getPipValue > 21) {
                msg = @"Dealer Wins, You Busted!";
            } else {
            msg = @"Dealer wins!";
            }
            self.loses = self.loses +1;
            break;
        }
        case Draw:
            msg = @"Draw game!";
            self.draws = self.draws +1;
            break;
        
        default:
            break;
    }

    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    [self init];
}

-(void) resetGame;
{
    _deck = nil;
    _playerHand = nil;
    _dealerHand = nil;
    _deck = [[Deck alloc] init];
    _playerHand = [[Hand alloc] init];
    _dealerHand = [[Hand alloc] init];
    _dealerHand.handClosed = YES;
    [self setup];
}

-(void)dealerPlays
{
    while (_dealerHand.getPipValue < 17)
    {
        [self dealerHandDraws];
        
    }
    
    if (_dealerHand.getPipValue > 21){
        [self gameEnds:Player];
    }
    else if (_dealerHand.getPipValue > _playerHand.getPipValue) {
        [self gameEnds:Dealer];
    }
    else if (_dealerHand.getPipValue < _playerHand.getPipValue) {
        [self gameEnds:Player];
    }
    else {
        [self gameEnds:Draw ];
    }
}

+(BlackjackModel *) getBlackjackModel{
    if (blackjackModel == nil){
        blackjackModel = [[BlackjackModel alloc] init];
    }
    return blackjackModel;
}

// Score
-(NSInteger)totalGames {

    return  self.totalPlays;
}
-(NSInteger)totalWins {
    
    return self.wins;
}
-(NSInteger)totalLoses {
    
    return self.loses;
}
-(NSInteger)totalDraws {
    
    return self.draws;
}

@end

