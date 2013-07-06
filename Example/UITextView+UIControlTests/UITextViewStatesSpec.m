#import <Kiwi/Kiwi.h>
#import <UITextView+UIControl/UITextView+APSUIControlStates.h>

SPEC_BEGIN(UITextViewStatesSpec)

describe(@"UITextView with UIControl-like states", ^{

    __block UITextView *textView;

    beforeEach(^{
        textView = [[UITextView alloc] initWithFrame:CGRectZero];
        [UIApplication.sharedApplication.delegate.window addSubview:textView];
    });

    it(@"defaults to being enabled", ^{
        [[theValue(textView.isEnabled) should] beYes];
    });

    it(@"binds its editable state to its enabled state", ^{
        textView.editable = NO;
        [[theValue(textView.isEnabled) should] beNo];

        textView.enabled = YES;
        [[theValue(textView.isEditable) should] beYes];
    });

});

SPEC_END
