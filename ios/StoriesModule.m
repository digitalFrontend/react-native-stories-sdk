//
//  StoriesModule.m
//  react-native-stories-sdk
//
//  Created by Admin on 20.10.2022.
//

#import <React/RCTBridgeModule.h>


@interface RCT_EXTERN_MODULE(StoriesModule, NSObject)

RCT_EXTERN_METHOD(onCreate: (NSString *) apiKey
                  withUserId:(NSString *) userId)
RCT_EXTERN_METHOD(showSingle: (NSString *) stotyId)

@end
