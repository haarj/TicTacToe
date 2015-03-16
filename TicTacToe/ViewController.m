//
//  ViewController.m
//  TicTacToe
//
//  Created by Justin Haar on 3/12/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) UILabel *selectedLabel;
@property (nonatomic) NSArray *labelsArray;
- (void)clearBoard;
- (BOOL)isBoardFilled;
- (void)countDown:(NSTimer *)timer;

@end

@implementation ViewController


- (void)clearBoard
{
    self.labelOne.text = @"";
    self.labelTwo.text = @"";
    self.labelThree.text = @"";
    self.labelFour.text = @"";
    self.labelFive.text = @"";
    self.labelSix.text = @"";
    self.labelSeven.text = @"";
    self.labelEight.text = @"";
    self.labelNine.text = @"";

    //nil value puts something in label indefinitely
    //@""empties it

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelsArray = @[self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine];
    self.whichPlayerLabel.text = @"X";
    self.whichPlayerLabel.textColor = [UIColor blueColor];

    self.timerLabel.text = @"10";
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void)countDown:(NSTimer *)timer
{
    self.timerLabel.text = [NSString stringWithFormat:@"%d",[self.timerLabel.text  intValue] - 1];
    if ([self.timerLabel.text isEqualToString:@"0"]) {
        if ([self.whichPlayerLabel.text isEqual:@"X"]) {
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
            self.timerLabel.text = @"10";

            [timer invalidate];

            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tic Tac No..." message:@"You're too slow!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Next Player", nil];
            [alertView show];

        } else if ([self.whichPlayerLabel.text isEqual:@"O"])
        {
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
            self.timerLabel.text = @"10";

            [timer invalidate];

            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tic Tac No..." message:@"You're too slow!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Next Player", nil];
            [alertView show];

        }
        [timer invalidate];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.timerLabel.text = @"10";
    }
}

- (void)xAlertView:(UIAlertView *)xAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.timerLabel.text = @"10";
    }
}

- (void)oAlertView:(UIAlertView *)oAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.timerLabel.text = @"10";
    }
}

#pragma METHODS

- (BOOL)isBoardFilled
{

    for (int i = 0; i < self.labelsArray.count; i++) {

        UILabel *someLabel = self.labelsArray[i];
        if ([someLabel.text isEqual:@""])
        {
            NSLog(@"FALSE");
            return NO;
        }
    }
    return TRUE;
}

- (void)findLabelUsingPoint:(CGPoint)point
{
    self.selectedLabel = nil;
    for (int i = 0; i < self.labelsArray.count; i++) {
        UILabel *someLabel = self.labelsArray[i];
        if (CGRectContainsPoint(someLabel.frame, point))
        {
            self.selectedLabel = someLabel;
            break;
        }
    }
}

- (void)playerXAlert
{
    UIAlertView *xAlertView = [[UIAlertView alloc] initWithTitle:@"Player X Won!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again", nil];
    [xAlertView  show];
}

- (void)playerOAlert
{
    UIAlertView *oAlertView = [[UIAlertView alloc] initWithTitle:@"Player O Won!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again", nil];
    [oAlertView  show];
}

#pragma Gestures

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];

    self.timerLabel.text = @"10";

    [self findLabelUsingPoint:point];
    if (self.selectedLabel)
    {
        self.timerLabel.text = @"10";

        if ([self.whichPlayerLabel.text  isEqual: @"X"]) {
            self.selectedLabel.text = @"X";
            self.selectedLabel.textColor = [UIColor blueColor];
        } else
        {
            self.selectedLabel.textColor = [UIColor redColor];
            self.selectedLabel.text = @"O";
        }
        if ([self.selectedLabel.text isEqual:@"X"]) {
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
        } else
        {
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
        }
    }
    else
    {
        CGPoint point = [sender locationInView:self.view];
        self.whichPlayerLabel.center = point;
    }
    {

        if ([self.labelOne.text isEqual:@"X"] && [self.labelOne.text isEqual:self.labelTwo.text] && [self.labelTwo.text isEqual:self.labelThree.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelFour.text isEqual:@"X"] && [self.labelFour.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSix.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelSeven.text isEqual:@"X"] && [self.labelSeven.text isEqual:self.labelEight.text] && [self.labelEight.text isEqual:self.labelNine.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelOne.text isEqual:@"X"] && [self.labelOne.text isEqual:self.labelFour.text] && [self.labelFour.text isEqual:self.labelSeven.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelTwo.text isEqual:@"X"] && [self.labelTwo.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelEight.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelThree.text isEqual:@"X"] && [self.labelThree.text isEqual:self.labelSix.text] && [self.labelSix.text isEqual:self.labelNine.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelOne.text isEqual:@"X"] && [self.labelOne.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelNine.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelThree.text isEqual:@"X"] && [self.labelThree.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSeven.text]) {

            [self playerXAlert];
            [self clearBoard];


        } else if ([self.labelOne.text isEqual:@"O"] && [self.labelOne.text isEqual:self.labelTwo.text] && [self.labelTwo.text isEqual:self.labelThree.text]) {

            [self playerOAlert];
            [self clearBoard];


        } else if ([self.labelFour.text isEqual:@"O"] && [self.labelFour.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSix.text]) {

            [self playerOAlert];
            [self clearBoard];


        } else if ([self.labelSeven.text isEqual:@"O"] && [self.labelSeven.text isEqual:self.labelEight.text] && [self.labelEight.text isEqual:self.labelNine.text]) {

            [self playerOAlert];
            [self clearBoard];


        } else if ([self.labelOne.text isEqual:@"O"] && [self.labelOne.text isEqual:self.labelFour.text] && [self.labelFour.text isEqual:self.labelSeven.text]) {

            [self playerOAlert];
            [self clearBoard];


        } else if ([self.labelTwo.text isEqual:@"O"] && [self.labelTwo.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelEight.text]) {

            [self playerOAlert];
            [self clearBoard];

        } else if ([self.labelThree.text isEqual:@"O"] && [self.labelThree.text isEqual:self.labelSix.text] && [self.labelSix.text isEqual:self.labelNine.text]) {

            [self playerOAlert];
            [self clearBoard];


        } else if ([self.labelOne.text isEqual:@"O"] && [self.labelOne.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelNine.text]) {

            [self playerOAlert];
            [self clearBoard];
            
            
        } else if ([self.labelThree.text isEqual:@"O"] && [self.labelThree.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSeven.text]) {

            [self playerOAlert];
            [self clearBoard];


        } else if ([self isBoardFilled]) {

            [self playerOAlert];
            [self clearBoard];

        }
    }
}

- (IBAction)onLabelDragged:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.view];

        self.timerLabel.text = @"10";

        [self findLabelUsingPoint:point];
        if (self.selectedLabel)
        {
            self.timerLabel.text = @"10";

            if ([self.whichPlayerLabel.text  isEqual: @"X"])
            {
                self.selectedLabel.text = @"X";
                self.selectedLabel.textColor = [UIColor blueColor];
            } else {
                self.selectedLabel.textColor = [UIColor redColor];
                self.selectedLabel.text = @"O";
            }
            if ([self.selectedLabel.text isEqual:@"X"])
            {
                self.whichPlayerLabel.text = @"O";
                self.whichPlayerLabel.textColor = [UIColor redColor];
            } else
            {
                self.whichPlayerLabel.text = @"X";
                self.whichPlayerLabel.textColor = [UIColor blueColor];
            }
        } else
        {
            CGPoint point = [sender locationInView:self.view];
            self.whichPlayerLabel.center = point;
        }
        {

            if ([self.labelOne.text isEqual:@"X"] && [self.labelOne.text isEqual:self.labelTwo.text] && [self.labelTwo.text isEqual:self.labelThree.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelFour.text isEqual:@"X"] && [self.labelFour.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSix.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelSeven.text isEqual:@"X"] && [self.labelSeven.text isEqual:self.labelEight.text] && [self.labelEight.text isEqual:self.labelNine.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelOne.text isEqual:@"X"] && [self.labelOne.text isEqual:self.labelFour.text] && [self.labelFour.text isEqual:self.labelSeven.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelTwo.text isEqual:@"X"] && [self.labelTwo.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelEight.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelThree.text isEqual:@"X"] && [self.labelThree.text isEqual:self.labelSix.text] && [self.labelSix.text isEqual:self.labelNine.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelOne.text isEqual:@"X"] && [self.labelOne.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelNine.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelThree.text isEqual:@"X"] && [self.labelThree.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSeven.text]) {

                [self playerXAlert];
                [self clearBoard];


            } else if ([self.labelOne.text isEqual:@"O"] && [self.labelOne.text isEqual:self.labelTwo.text] && [self.labelTwo.text isEqual:self.labelThree.text]) {

                [self playerOAlert];
                [self clearBoard];


            } else if ([self.labelFour.text isEqual:@"O"] && [self.labelFour.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSix.text]) {

                [self playerOAlert];
                [self clearBoard];


            } else if ([self.labelSeven.text isEqual:@"O"] && [self.labelSeven.text isEqual:self.labelEight.text] && [self.labelEight.text isEqual:self.labelNine.text]) {

                [self playerOAlert];
                [self clearBoard];


            } else if ([self.labelOne.text isEqual:@"O"] && [self.labelOne.text isEqual:self.labelFour.text] && [self.labelFour.text isEqual:self.labelSeven.text]) {

                [self playerOAlert];
                [self clearBoard];


            } else if ([self.labelTwo.text isEqual:@"O"] && [self.labelTwo.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelEight.text]) {

                [self playerOAlert];
                [self clearBoard];

            } else if ([self.labelThree.text isEqual:@"O"] && [self.labelThree.text isEqual:self.labelSix.text] && [self.labelSix.text isEqual:self.labelNine.text]) {
                
                [self playerOAlert];
                [self clearBoard];
                
                
            } else if ([self.labelOne.text isEqual:@"O"] && [self.labelOne.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelNine.text]) {
                
                [self playerOAlert];
                [self clearBoard];
                
                
            } else if ([self.labelThree.text isEqual:@"O"] && [self.labelThree.text isEqual:self.labelFive.text] && [self.labelFive.text isEqual:self.labelSeven.text]) {
                
                [self playerOAlert];
                [self clearBoard];
                
                
            } else if ([self isBoardFilled]) {
                
                [self playerOAlert];
                [self clearBoard];
                
            }
        }
    }
}

@end
