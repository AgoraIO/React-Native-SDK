//
//  AgoraViewManager.h
//  RNapi
//
//  Created by CavanSu on 23/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTUIManager.h>

@interface AgoraRendererViewManager : RCTViewManager
+ (AgoraRendererViewManager *)currentManager;
@end
