// Copyright (c) 2015 Sigmatic
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SUIControllerExtender <NSObject>

/**
The host ViewController
*/
@property(nonatomic, weak) UIViewController *hostViewController;

@optional
/**
The required host ViewController type
*/

- (Class)requiredHostClassType;

/**
Handle the event of first being added as an extender
*/
- (void)handleAddedToViewController;

/**
Handle the event of the view controller being de-allocated from memory
*/
- (void)handleViewControllerWillDealloc;

/**
Handle the event of viewDidLoad
*/
- (void)viewDidLoad;

/**
Handle the event of viewWillAppear:
@param animated whether the view was animated
*/
- (void)viewWillAppear:(BOOL)animated;

/**
Handle the event of firstViewWillAppear:
@param animated whether the view was animated
*/
- (void)firstViewWillAppear:(BOOL)animated;

/**
Handle the event of viewDidAppear:
@param animated whether the view was animated
*/
- (void)viewDidAppear:(BOOL)animated;

/**
Handle the event of firstViewDidAppear:
@param animated whether the view was animated
*/
- (void)firstViewDidAppear:(BOOL)animated;

/**
Handle the event of viewWillDisappear:
@param animated whether the view was animated
*/
- (void)viewWillDisappear:(BOOL)animated;

/**
Handle the event of viewDidDisappear:
@param animated whether the view was animated
*/
- (void)viewDidDisappear:(BOOL)animated;

@end