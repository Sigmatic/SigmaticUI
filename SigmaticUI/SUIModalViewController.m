//
// Created by Hisham on 29/07/15.
// Copyright (c) 2015 Sigmatic. All rights reserved.
//

#import "SUIModalViewController.h"


@implementation SUIModalViewController

- (void)dealloc {
    NSLog(@"DEALLOC FOR SUIRMODAL");
}


- (IBAction)didTapDismissButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end