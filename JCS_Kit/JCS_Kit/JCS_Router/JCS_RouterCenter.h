//
//  JCS_RouterCenter.h
//  AFNetworking
//
//  Created by 永平 on 2020/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCS_RouterCenter : NSObject

+ (id)router2Url:(NSString * _Nonnull )url
            args:(NSDictionary * _Nullable)args
      completion:(void(^ _Nullable)(NSError * _Nullable error, id  _Nullable response))completion;

+ (id)router2ClassName:(NSString * _Nonnull)className
               selName:(NSString * _Nonnull)selName
                  args:(NSDictionary* _Nullable)args
            completion:( void(^ _Nullable )(NSError * _Nullable error, id _Nullable response))completion;

@end

NS_ASSUME_NONNULL_END
