//
//  AttributorViewController.m
//  Attributor
//
//  Created by Hung Yu-Ting on 2014/6/17.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController

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

@end
