#import <React/RCTViewManager.h>

// NativeCustomViewManager maps to NativeCustomView in react native requireNativeComponent('NativeCustomView');
// message maps to the message prop on react native's view property
// bgColor maps to the bgColor prop on react native's view property
// onClick maps to the onClick prop on react native's view property
@interface RCT_EXTERN_MODULE(NativeCustomViewManager, RCTViewManager)
//RCT_EXPORT_VIEW_PROPERTY(message, NSString)
//RCT_EXPORT_VIEW_PROPERTY(bgColor, NSString)
//RCT_EXPORT_VIEW_PROPERTY(onClick, RCTBubblingEventBlock)
@end
