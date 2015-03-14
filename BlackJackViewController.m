//
//  BlackJackViewController.m
//  Blackjack
//
//  Could use some double down and split
//  Maybe add betting
//
//  Created by Amy Wold on 1/8/15.
//  Copyright (c) 2015 Amy Wold. All rights reserved.
//

#import "BlackJackViewController.h"
#import "BlackjackModel.h"
#import "Hand.h"
#import "Card.h"

@interface BlackJackViewController ()
{
    NSMutableArray *allImageViews;
}

@property NSMutableArray *allImageViews;

@property (weak, nonatomic) IBOutlet UILabel *dealerLabel;
@property (weak, nonatomic) IBOutlet UILabel
*playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPlaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsLabel;
@property (weak, nonatomic) IBOutlet UILabel *losesLabel;
@property (weak, nonatomic) IBOutlet UILabel *drawsLabel;

@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;


@end

@implementation BlackJackViewController

@synthesize dealerLabel=_dealerLabel, playerLabel=_playerLabel, totalPlaysLabel = _totalPlaysLabel, winsLabel = _winsLabel, losesLabel = _losesLabel, drawsLabel = _drawsLabel, allImageViews =_allImageViews;

- (IBAction)hitButton:(id)sender {
    // draw another card for player
    [[BlackjackModel getBlackjackModel] playerHandDraws];
}

- (IBAction)standButton:(id)sender {
    // disable all buttons on stand so dealer can take turn
    [_hitButton setEnabled:NO];
    [_standButton setEnabled:NO];
    [_restartButton setEnabled:NO];
    
    [[BlackjackModel getBlackjackModel] playerStands];
}

- (IBAction)restartButton:(id)sender {
    
    // Hide start button enable and show hit and stand
    [_hitButton setEnabled:YES];
    [_standButton setEnabled:YES];
    [_hitButton setHidden:NO];
    [_standButton setHidden:NO];
    [_restartButton setHidden:YES];
    
    // reset the model
    for (UIView *view in _allImageViews)
    {
        [view removeFromSuperview];
    }
    [_allImageViews removeAllObjects];
    [_dealerLabel setText:@"Dealer"];
    [_playerLabel setText:@"Player"];
    
    // update scores
    [_totalPlaysLabel setText:[NSString stringWithFormat:@"Games: %ld", (long)[[BlackjackModel getBlackjackModel]totalGames]]];
    [_winsLabel setText:[NSString stringWithFormat:@"Won: %ld", (long)[[BlackjackModel getBlackjackModel]totalWins]]];
    [_losesLabel setText:[NSString stringWithFormat:@"Lost: %ld", (long)[[BlackjackModel getBlackjackModel]totalLoses]]];
    [_drawsLabel setText:[NSString stringWithFormat:@"Draws: %ld", (long)[[BlackjackModel getBlackjackModel]totalDraws]]];


    [_restartButton setEnabled:NO];
    [self startGame];
    
    [[BlackjackModel getBlackjackModel] resetGame];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Welcome to" message: @"BlackJack By Amy" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Let's play!", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self restartButton:self];
    
}

-(void) startGame {
    _allImageViews = [[NSMutableArray alloc] initWithCapacity:5];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"dealerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"playerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    //
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"totalPlays"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"wins"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"loses"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"draws"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    
    [[BlackjackModel getBlackjackModel] setup];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showHand:(Hand *)hand atYPos:(NSInteger) yPos atXPos:(NSInteger) xPos;
{
    for (int i=0; i< [hand countCards] ; i++) {
        Card *card = [hand getCardAtIndex:i];
        
        UIImage  *cardImage = [ UIImage imageNamed:[card filename]];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:cardImage];
        CGRect arect = CGRectMake( (i*40)+xPos, yPos, 71, 96); 
        imageView.frame = arect;
        
        [_allImageViews addObject:imageView];
        
        [self.view addSubview:imageView];
    }
    
}

-(void) showDealerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:80 atXPos:100];
    _dealerLabel.text = [NSString stringWithFormat:@"Dealer (%ld)",(long)[hand getPipValue]];
}

-(void) showPlayerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:400 atXPos:100];
    _playerLabel.text = [NSString stringWithFormat:@"Player (%ld)",(long)[hand getPipValue]];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"dealerHand"])
    {
        [self showDealerHand: (Hand *)[object dealerHand]];
    } else
        if ([keyPath isEqualToString:@"playerHand"])
        {
            [self showPlayerHand: (Hand *)[object playerHand]];
        }
        else if ([keyPath isEqualToString:@"totalPlays"])
        {
            [self endGame];
        }
        else if ([keyPath isEqualToString:@"wins"])
        {
            [self endGame];
        }
        else if ([keyPath isEqualToString:@"loses"])
        {
            [self endGame];
        }
        else if ([keyPath isEqualToString:@"draws"])
        {
            [self endGame];
        }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) endGame{
    [_hitButton setEnabled:NO];
    [_standButton setEnabled:NO];
    [_restartButton setEnabled:YES];
    [_hitButton setHidden:YES];
    [_standButton setHidden:YES];
    [_restartButton setHidden:NO];
    
    [_totalPlaysLabel setText:[NSString stringWithFormat:@"Games: %ld", (long)[[BlackjackModel getBlackjackModel]totalGames]]];
    [_winsLabel setText:[NSString stringWithFormat:@"Won: %ld", (long)[[BlackjackModel getBlackjackModel]totalWins]]];
    [_losesLabel setText:[NSString stringWithFormat:@"Lost: %ld", (long)[[BlackjackModel getBlackjackModel]totalLoses]]];
    [_drawsLabel setText:[NSString stringWithFormat:@"Draws: %ld", (long)[[BlackjackModel getBlackjackModel]totalDraws]]];

}

@end
