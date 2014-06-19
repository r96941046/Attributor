//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Hung Yu-Ting on 2014/6/19.
//  Copyright (c) 2014年 Hung Yu-Ting. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

// The following pattern of updating UI is kind of a fixed pattern

- (void)setTextToAnalize:(NSAttributedString *)textToAnalize
{
    _textToAnalize = textToAnalize;
    if (self.view.window) [self updateUI]; // if view is on the screen, update UI here
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self updateUI]; // if view is off screen, update UI here
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalize length]) {
        NSRange range;
        id value = [self.textToAnalize attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalize attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    return characters;
}

- (void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters",[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters",[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
