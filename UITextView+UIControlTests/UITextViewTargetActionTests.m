#import <SenTestingKit/SenTestingKit.h>
#import "UITextView+APSUIControlTargetAction.h"

@interface UITextViewTargetActionTests : SenTestCase
@end
@implementation UITextViewTargetActionTests
{
    UITextView *textView;
}

- (void)setUp
{
    [super setUp];

    textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [UIApplication.sharedApplication.delegate.window addSubview:textView];
}

- (void)testRespondToAddTargetAction
{
    STAssertNoThrow([textView addTarget:self action:@selector(someAction:) forControlEvents:UIControlEventEditingDidBegin], nil);
}

@end
