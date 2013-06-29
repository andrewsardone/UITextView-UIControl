#import <Kiwi/Kiwi.h>
#import <UITextView+UIControl/UITextView+APSUIControlTargetAction.h>

SPEC_BEGIN(UITextViewTargetActionSpec)

describe(@"UITextView+APSUIControlTargetAction", ^{

    __block UITextView *textView;

    beforeEach(^{
        textView = [[UITextView alloc] initWithFrame:CGRectZero];
        [UIApplication.sharedApplication.delegate.window addSubview:textView];
    });

    it(@"responds to adding a target-action pair", ^{
        [[textView should] respondToSelector:@selector(addTarget:action:forControlEvents:)];
    });

    it(@"responds to removing a target-action pair", ^{
        [[textView should] respondToSelector:@selector(removeTarget:action:forControlEvents:)];
    });

    it(@"starts with zero targets", ^{
        [[textView.allTargets shouldNot] beNil];
        [[textView.allTargets should] beEmpty];
    });

    it(@"tracks the targets", ^{
        id target = [NSObject new];
        [textView addTarget:target action:@selector(doesNotMatter:) forControlEvents:UIControlEventEditingDidEnd];
        [[textView.allTargets should] contain:target];
    });

});

SPEC_END
