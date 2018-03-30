//
//  AgoraViewManager.m
//  RNapi
//
//  Created by CavanSu on 23/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "AgoraViewManager.h"

@implementation AgoraRendererViewManager
RCT_EXPORT_MODULE();

static AgoraRendererViewManager *manager;

+ (AgoraRendererViewManager *)currentManager {  
  return manager;
}

- (UIView *)view {
  manager = self;
  return [[UIView alloc] init];
}

@end
