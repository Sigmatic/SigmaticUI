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

@protocol SUIControllerExtender;


@interface UIViewController (Monitoring)

/**
Updated property to maintain whether view is visible
*/
@property(nonatomic, readonly) BOOL isVisible;

/**
List of extenders
*/
@property(nonatomic, readonly) NSArray *extendersList;

///---------------------
/// @name First Appearance
///---------------------

/**
Callback for only the first view will appear
@param animated Whether the view is presented with animation
*/
- (void)firstViewWillAppear:(BOOL)animated;

/**
Callback for only the first view did appear
@param animated Whether the view is presented with animation
*/
- (void)firstViewDidAppear:(BOOL)animated;

/**
Add a new extender to the view controller
@param extender the extender
*/
- (void)addExtender:(id<SUIControllerExtender>)extender;

@end