//
//  AgroaEnumConvert.m
//  RNapi
//
//  Created by CavanSu on 26/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "AgroaEnumConvert.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTUIManager.h>
#import <React/RCTUIManagerUtils.h>
#import <AgoraRTCEngineKit/AgoraRtcEngineKit.h>
#import "AgoraEnum.h"

#pragma mark - <ENUM Converter Implementation>
@implementation RCTConvert (AgoraChannelProfile)
RCT_ENUM_CONVERTER(AgoraChannelProfile, AgoraChannelProfileDic,
                   AgoraChannelProfileCommunication, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraChannelProfileDic;
};
@end

@implementation RCTConvert (AgoraVideoRenderMode)
RCT_ENUM_CONVERTER(AgoraVideoRenderMode, AgoraVideoRenderModeDic,
                   AgoraVideoRenderModeHidden, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraVideoRenderModeDic;
};
@end

@implementation RCTConvert (AgoraAudioProfile)
RCT_ENUM_CONVERTER(AgoraAudioProfile, AgoraAudioProfileDic,
                   AgoraAudioProfileDefault, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraAudioProfileDic;
};
@end

@implementation RCTConvert (AgoraAudioScenario)
RCT_ENUM_CONVERTER(AgoraAudioScenario, AgoraAudioScenarioDic,
                   AgoraAudioScenarioDefault, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraAudioScenarioDic;
};
@end

@implementation RCTConvert (AgoraVideoProfile)
RCT_ENUM_CONVERTER(AgoraVideoProfile, AgoraVideoProfileDic,
                   AgoraVideoProfileLandscape360P, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraVideoProfileDic;
};
@end

@implementation RCTConvert (AgoraVideoStreamType)
RCT_ENUM_CONVERTER(AgoraVideoStreamType, AgoraVideoStreamTypeDic,
                   AgoraVideoStreamTypeHigh, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraVideoStreamTypeDic;
};
@end

@implementation RCTConvert (AgoraVideoMirrorMode)
RCT_ENUM_CONVERTER(AgoraVideoMirrorMode, AgoraVideoMirrorModeDic,
                   AgoraVideoMirrorModeAuto, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraVideoMirrorModeDic;
};
@end

@implementation RCTConvert (AgoraAudioEqualizationBandFrequency)
RCT_ENUM_CONVERTER(AgoraAudioEqualizationBandFrequency, AgoraAudioEqualizationBandFrequencyDic,
                   AgoraAudioEqualizationBand31, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraAudioEqualizationBandFrequencyDic;
};
@end

@implementation RCTConvert (AgoraAudioReverbType)
RCT_ENUM_CONVERTER(AgoraAudioReverbType, AgoraAudioReverbTypeDic,
                   AgoraAudioReverbDryLevel, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraAudioReverbTypeDic;
};
@end

@implementation RCTConvert (AgoraAudioRecordingQuality)
RCT_ENUM_CONVERTER(AgoraAudioRecordingQuality, AgoraAudioRecordingQualityDic,
                   AgoraAudioRecordingQualityLow, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraAudioRecordingQualityDic;
};
@end

@implementation RCTConvert (AgoraClientRole)
RCT_ENUM_CONVERTER(AgoraClientRole, AgoraClientRoleDic,
                   AgoraClientRoleAudience, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraClientRoleDic;
};
@end

@implementation RCTConvert (AgoraAudioSessionOperationRestriction)
RCT_ENUM_CONVERTER(AgoraAudioSessionOperationRestriction, AgoraAudioSessionOperationRestrictionDic,
                   AgoraAudioSessionOperationRestrictionNone, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraAudioSessionOperationRestrictionDic;
};
@end

@implementation RCTConvert (AgoraStreamFallbackOptions)
RCT_ENUM_CONVERTER(AgoraStreamFallbackOptions, AgoraStreamFallbackOptionsDic,
                   AgoraStreamFallbackOptionDisabled, integerValue)
- (NSDictionary *)constantsToExport {
  return AgoraStreamFallbackOptionsDic;
};
@end

//AgoraAudioEqualizationBandFrequencyDic
#pragma mark - <LoadDictionary>
@implementation RCTConvert (LoadDictionary)
+ (void)load {
  [AgoraEnum loadEnums];
}
@end

@implementation AgroaEnumConvert
@end
