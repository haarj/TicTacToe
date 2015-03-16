//
//  helpViewController.m
//  TicTacToe
//
//  Created by Justin Haar on 3/13/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "helpViewController.h"

@interface helpViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *helpView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation helpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.activityIndicator.hidesWhenStopped = YES;
    [self performLoadRequestWithString:@"http://en.wikipedia.org/wiki/Tic-tac-toe"];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (void)performLoadRequestWithString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.helpView loadRequest:urlRequest];
}

@end
