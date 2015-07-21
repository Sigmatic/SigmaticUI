//
// Created by Hisham on 22/07/15.
// Copyright (c) 2015 Sigmatic. All rights reserved.
//

#import "SUISubviewAdderExtender.h"
#import "SUIViewFrame.h"
#import "ViewController.h"

@interface SUISubviewAdderExtender ()

@property(nonatomic, weak) UIView *subview;

@end

@implementation SUISubviewAdderExtender

- (Class)requiredHostClassType {
    return ViewController.class;
}

- (void)firstViewWillAppear:(BOOL)animated {
    [super firstViewWillAppear:animated];
    UIView *aSubview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [aSubview setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:aSubview];
    self.subview = aSubview;
}

- (void)firstViewDidAppear:(BOOL)animated {
    [super firstViewDidAppear:animated];
    [UIView animateWithDuration:5.0 delay:2.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.subview setY:self.subview.y + 50];
    } completion:nil];
}


@end