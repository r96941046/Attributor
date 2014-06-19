//
//  AttributorViewController.m
//  Attributor
//
//  Created by Hung Yu-Ting on 2014/6/17.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AttributorViewController.h"
#import "TextStatsViewController.h" // in fact is part of the view, ok to import here

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Analyze Text"]) {
        if ([segue.destinationViewController isKindOfClass:[TextStatsViewController class]]) {
            TextStatsViewController *tsvc = (TextStatsViewController *)segue.destinationViewController;
            tsvc.textToAnalize = self.body.textStorage;
        }
    }
}

- (IBAction)changeBodySelectionColor:(UIButton *)sender {
    
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection:(UIButton *)sender {
    
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3, NSStrokeColorAttributeName : [UIColor blackColor]} range:self.body.selectedRange];
}

- (IBAction)unOutlineBodySelection:(UIButton *)sender {
    
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    
    [title setAttributes:@{ NSStrokeWidthAttributeName : @3, NSStrokeColorAttributeName : self.outlineButton.tintColor} range:NSMakeRange(0, [title length])];

    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];

}

- (void)preferredFontsChanged:(NSNotification *)notification {

    [self usePreferredFonts];
}

- (void)usePreferredFonts {

    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

@end
