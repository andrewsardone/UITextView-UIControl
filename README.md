# UITextView+UIControl

A `UIControl`-like API addition to `UITextView`.

## Target-Action

`UITextField` is a `UIControl`, so it exposes a target-action interface for various events. `UITextView+APSUIControlTargetAction.h` adds the same interface, allowing arbitrary target-actions to subscribe to the following events:

- `UIControlEventEditingDidBegin`
- `UIControlEventEditingChanged`
- `UIControlEventEditingDidEnd`

For example:

```objc
#import "ExampleViewController.h"
#import <UITextView+UIControl/UITextView+APSUIControlTargetAction.h>

@interface ExampleViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.textView addTarget:self action:@selector(textViewDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textViewDidChange:(UITextView *)sender
{
    NSLog(@"%s, text view text: %@", __PRETTY_FUNCTION__, sender.text);
}

@end
```

<img src="https://s3.amazonaws.com/f.cl.ly/items/2n383X1y1l3S0v1l1J3J/uitextview%2Btarget-action@2x.gif" alt="UITextView target-action screencast" width="618" height="434" />

## TODO

Once this hits a version 0.1, I'll submit it as a CocoaPod.

## Attribution

A big chunk of the work was done during the [*Back on the Map' Objective-c Hackathon](https://objectivechackathon.appspot.com/).
