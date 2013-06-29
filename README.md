# UITextView+UIControl

An add on to `UITextView` that adds a `UIControl`-like API.

## Target-Action

`UITextField` is a `UIControl`, and it exposes a target-action interface for the
following control events:

```objc
// UIControl.h
typedef NS_OPTIONS(NSUInteger, UIControlEvents) {
    // …
    UIControlEventEditingDidBegin     = 1 << 16,     // UITextField
    UIControlEventEditingChanged      = 1 << 17,
    UIControlEventEditingDidEnd       = 1 << 18,
    UIControlEventEditingDidEndOnExit = 1 << 19,     // 'return key' ending editing
    // …
};
```

Would'nt it be nice to have the same target-action API for the same set (or
subset) of control events on `UITextView`?

## TODO

Lots. Mostly forwarding NSNotifications events to the stored target-actions. I'll get to that once my MacBook finishes charging and I'm back to where I can code.

Once this hits a version 0.1, I'll submit it as a CocoaPod.
