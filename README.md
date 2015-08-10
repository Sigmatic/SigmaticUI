
<h1 align="center">Sigmatic UI</h1>

<p align="center">
<a href="https://travis-ci.org/Sigmatic/SigmaticUI"><img src="https://travis-ci.org/Sigmatic/SigmaticUI.svg?style=flat" alt="CI Status" /></a>
<a href="https://github.com/Sigmatic/SigmaticUI/issues"><img src="https://img.shields.io/github/issues/Sigmatic/SigmaticUI.svg?style=flat" alt="Issues" /></a>
<a href="https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html"><img src="https://img.shields.io/badge/language-Objective--C-blue.svg" alt="Objective-C" /></a>
<a href="https://www.apple.com/ios/"><img src="https://img.shields.io/badge/Platform-iOS-blue.svg" alt="iOS" /></a>
<a href="https://github.com/Sigmatic/SigmaticUI/blobs/master/LICENSE.md"><img src="https://img.shields.io/badge/license-MIT-lightgrey.svg" alt="MIT License" /></a>
</p>

## Overview

Take back control of your views and controllers.
<br />
Sigmatic UI allows you to easily manage your views and view controllers from anywhere in your application.

## Installation

SigmaticUI is available through [CocoaPods](http://cocoapods.org). To install the library, simply add the following line to your Podfile:
```ruby
pod "SigmaticUI"
```
<br />
Or if you are only interested in a subspec, use 
<br />
```ruby
pod "SigmaticUI/<Subspec>"
#example
pod "SigmaticUI/ControllerExpansion"
```

### Available Subspecs

#### UIView
Easily change view dimensions and location. Move and align with respect to the superview or a sibling view.
```objective-c
[submitButton setWidth:cancelButton.width];
[submitButton alignRightOfView:cancelButton margin:7.f];
```

<br />
Find all input text fields for any view and easily implement a 'Next' 'Previous' buttons on your keyboard. Already sorted based on their location on screen.
```objective-c
[formView textInputSubviews];
```

<br />
And many many more features

#### UIViewController
Receive callbacks for when the view has first appeared
```objective-c
- (void)firstViewWillAppear:(BOOL)animated {
}

- (void)firstViewDidAppear:(BOOL)animated {
}
```
<br />
<br />
Check whether the view is visible
```objective-c
if (myViewController.isVisible) {
}
```
<br />

## Documentation

<a href="http://cocoadocs.org/docsets/SigmaticUI">CocoaDocs</a>

## Contribution
Can't say no to that!

## License

SigmaticUI is released under the MIT license. See LICENSE for details.