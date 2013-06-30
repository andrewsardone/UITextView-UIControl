#import "ExampleViewController.h"
#import <UITextView+UIControl/UITextView+APSUIControlTargetAction.h>

@interface ExampleViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ExampleViewController

- (NSString *)title { return NSLocalizedString(@"UITextView + target-action", nil); }

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.textView addTarget:self
                      action:@selector(textViewDidChange:)
            forControlEvents:UIControlEventEditingChanged];
}

- (void)textViewDidChange:(UITextView *)sender
{
    NSLog(@"%s, text view text: %@", __PRETTY_FUNCTION__, sender.text);
}

- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        _textView.font = [UIFont systemFontOfSize:18.0];
        [self.view addSubview:_textView];
    }
    return _textView;
}

@end
