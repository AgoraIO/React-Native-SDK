//
//  AgoraRtcEngineModule+EnumConvert.m
//  RNapi
//
//  Created by CavanSu on 28/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "AgoraRtcEngineModule+EnumConvert.h"
#import <AgoraRTCEngineKit/AgoraRtcEngineKit.h>
#import "AgoraEnum.h"

#pragma mark - <LoadDictionary>

@implementation AgoraRtcEngineModule (EnumConvert)
static NSMutableDictionary *AgoraTotalDic = nil;

+ (void)load {
  [AgoraEnum loadEnums];
  
  AgoraTotalDic = [NSMutableDictionary dictionaryWithDictionary:AgoraChannelProfileDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraVideoRenderModeDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraAudioProfileDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraAudioScenarioDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraVideoProfileDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraVideoStreamTypeDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraVideoMirrorModeDic];
  
  [AgoraTotalDic addEntriesFromDictionary:AgoraAudioEqualizationBandFrequencyDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraAudioReverbTypeDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraAudioRecordingQualityDic];
  
  [AgoraTotalDic addEntriesFromDictionary:AgoraClientRoleDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraAudioSessionOperationRestrictionDic];
  [AgoraTotalDic addEntriesFromDictionary:AgoraStreamFallbackOptionsDic];
}

- (NSDictionary *)constantsToExport {
  return AgoraTotalDic;
};

@end
