//
//  AgoraEnum.m
//  RNapi
//
//  Created by CavanSu on 29/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "AgoraEnum.h"
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

NSDictionary *AgoraChannelProfileDic = nil;
NSDictionary *AgoraVideoRenderModeDic = nil;
NSDictionary *AgoraAudioProfileDic = nil;
NSDictionary *AgoraAudioScenarioDic = nil;
NSDictionary *AgoraVideoProfileDic = nil;
NSDictionary *AgoraVideoStreamTypeDic = nil;
NSDictionary *AgoraVideoMirrorModeDic = nil;
NSDictionary *AgoraAudioEqualizationBandFrequencyDic = nil;
NSDictionary *AgoraAudioReverbTypeDic = nil;
NSDictionary *AgoraAudioRecordingQualityDic = nil;
NSDictionary *AgoraClientRoleDic = nil;
NSDictionary *AgoraAudioSessionOperationRestrictionDic = nil;
NSDictionary *AgoraStreamFallbackOptionsDic = nil;

@implementation AgoraEnum
+ (void)loadEnums {
  if (AgoraAudioRecordingQualityDic) return;
  
  AgoraChannelProfileDic = @{ @"AgoraChannelProfileCommunication" : @(AgoraChannelProfileCommunication),
                              @"AgoraChannelProfileLiveBroadcasting" : @(AgoraChannelProfileLiveBroadcasting),
                              @"AgoraChannelProfileGame" : @(AgoraChannelProfileGame)};
  
  AgoraVideoRenderModeDic = @{ @"AgoraVideoRenderModeHidden" : @(AgoraVideoRenderModeHidden),
                               @"AgoraVideoRenderModeFit" : @(AgoraVideoRenderModeFit),
                               @"AgoraVideoRenderModeAdaptive" : @(AgoraVideoRenderModeAdaptive)};
  
  AgoraAudioProfileDic = @{ @"AgoraAudioProfileDefault" : @(AgoraAudioProfileDefault),
                            @"AgoraAudioProfileSpeechStandard" : @(AgoraAudioProfileSpeechStandard),
                            @"AgoraAudioProfileMusicStandard" : @(AgoraAudioProfileMusicStandard),
                            @"AgoraAudioProfileMusicStandardStereo" : @(AgoraAudioProfileMusicStandardStereo),
                            @"AgoraAudioProfileMusicHighQuality" : @(AgoraAudioProfileMusicHighQuality),
                            @"AgoraAudioProfileMusicHighQualityStereo" : @(AgoraAudioProfileMusicHighQualityStereo)};
  
  AgoraAudioScenarioDic = @{ @"AgoraAudioScenarioDefault" : @(AgoraAudioScenarioDefault),
                             @"AgoraAudioScenarioChatRoomGaming" : @(AgoraAudioScenarioChatRoomGaming),
                             @"AgoraAudioScenarioChatRoomEntertainment" : @(AgoraAudioScenarioChatRoomEntertainment),
                             @"AgoraAudioScenarioEducation" : @(AgoraAudioScenarioEducation),
                             @"AgoraAudioScenarioGameStreaming" : @(AgoraAudioScenarioGameStreaming),
                             @"AgoraAudioScenarioShowRoom" : @(AgoraAudioScenarioShowRoom)};
  
  AgoraVideoProfileDic = @{ @"AgoraVideoProfileInvalid" : @(AgoraVideoProfileInvalid),
                            @"AgoraVideoProfile120P" : @(AgoraVideoProfileLandscape120P),
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfile120P_3" : @(AgoraVideoProfileLandscape120P_3),
                            @"AgoraVideoProfile180P" : @(AgoraVideoProfileLandscape180P),
                            @"AgoraVideoProfile180P_3" : @(AgoraVideoProfileLandscape180P_3),
                            @"AgoraVideoProfile180P_4" : @(AgoraVideoProfileLandscape180P_4),
#endif
                            
                            @"AgoraVideoProfile240P" : @(AgoraVideoProfileLandscape240P),
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfile240P_3" : @(AgoraVideoProfileLandscape240P_3),
                            @"AgoraVideoProfile240P_4" : @(AgoraVideoProfileLandscape240P_4),
#endif
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfile360P" : @(AgoraVideoProfileLandscape360P),
#endif
                            
                            @"AgoraVideoProfile360P_3" : @(AgoraVideoProfileLandscape360P_3),
                            @"AgoraVideoProfile360P_4" : @(AgoraVideoProfileLandscape360P_4),
                            @"AgoraVideoProfile360P_6" : @(AgoraVideoProfileLandscape360P_6),
                            
                            @"AgoraVideoProfile360P_7" : @(AgoraVideoProfileLandscape360P_7),
                            @"AgoraVideoProfile360P_8" : @(AgoraVideoProfileLandscape360P_8),
                            @"AgoraVideoProfile360P_9" : @(AgoraVideoProfileLandscape360P_9),
                            
                            @"AgoraVideoProfile360P_10" : @(AgoraVideoProfileLandscape360P_10),
                            @"AgoraVideoProfile360P_11" : @(AgoraVideoProfileLandscape360P_11),
                            @"AgoraVideoProfile480P" : @(AgoraVideoProfileLandscape480P),
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfile480P_3" : @(AgoraVideoProfileLandscape480P_3),
#endif
                            
                            @"AgoraVideoProfile480P_4" : @(AgoraVideoProfileLandscape480P_4),
                            @"AgoraVideoProfile480P_6" : @(AgoraVideoProfileLandscape480P_6),
                            @"AgoraVideoProfile480P_8" : @(AgoraVideoProfileLandscape480P_8),
                            @"AgoraVideoProfile480P_9" : @(AgoraVideoProfileLandscape480P_9),
                            @"AgoraVideoProfile480P_10" : @(AgoraVideoProfileLandscape480P_10),
                            
                            @"AgoraVideoProfile720P" : @(AgoraVideoProfileLandscape720P),
                            @"AgoraVideoProfile720P_3" : @(AgoraVideoProfileLandscape720P_3),
                            @"AgoraVideoProfile720P_5" : @(AgoraVideoProfileLandscape720P_5),
                            @"AgoraVideoProfile720P_6" : @(AgoraVideoProfileLandscape720P_6),
                            
                            /*
                            @"AgoraVideoProfile1080P_3" : @(AgoraVideoProfileLandscape1080P_3),
                            @"AgoraVideoProfile1080P_5" : @(AgoraVideoProfileLandscape1080P_5),
                            
                            @"AgoraVideoProfile1440P" : @(AgoraVideoProfileLandscape1440P),
                            @"AgoraVideoProfile1440P_2" : @(AgoraVideoProfileLandscape1440P_2),
                            @"AgoraVideoProfile4K" : @(AgoraVideoProfileLandscape4K),
                            @"AgoraVideoProfile4K_3" : @(AgoraVideoProfileLandscape4K_3),
                            
                            
                            @"AgoraVideoProfilePortrait120P" : @(AgoraVideoProfilePortrait120P),
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfilePortrait120P_3" : @(AgoraVideoProfilePortrait120P_3),
                            @"AgoraVideoProfilePortrait180P" : @(AgoraVideoProfilePortrait180P),
                            @"AgoraVideoProfilePortrait180P_3" : @(AgoraVideoProfilePortrait180P_3),
                            @"AgoraVideoProfilePortrait180P_4" : @(AgoraVideoProfilePortrait180P_4),
#endif
                            
                            @"AgoraVideoProfilePortrait240P" : @(AgoraVideoProfilePortrait240P),
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfilePortrait240P_3" : @(AgoraVideoProfilePortrait240P_3),
                            @"AgoraVideoProfilePortrait240P_4" : @(AgoraVideoProfilePortrait240P_4),
#endif
                            
                            @"AgoraVideoProfilePortrait360P" : @(AgoraVideoProfilePortrait360P),
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfilePortrait360P_3" : @(AgoraVideoProfilePortrait360P_3),
#endif
                            
                            @"AgoraVideoProfilePortrait360P_4" : @(AgoraVideoProfilePortrait360P_4),
                            @"AgoraVideoProfilePortrait360P_6" : @(AgoraVideoProfilePortrait360P_6),
                            @"AgoraVideoProfilePortrait360P_7" : @(AgoraVideoProfilePortrait360P_7),
                            @"AgoraVideoProfilePortrait360P_8" : @(AgoraVideoProfilePortrait360P_8),
                            @"AgoraVideoProfilePortrait360P_9" : @(AgoraVideoProfilePortrait360P_9),
                            
                            @"AgoraVideoProfilePortrait360P_10" : @(AgoraVideoProfilePortrait360P_10),
                            @"AgoraVideoProfilePortrait360P_11" : @(AgoraVideoProfilePortrait360P_11),
                            @"AgoraVideoProfilePortrait480P" : @(AgoraVideoProfilePortrait480P),
                            
#if TARGET_OS_IPHONE
                            @"AgoraVideoProfilePortrait480P_3" : @(AgoraVideoProfilePortrait480P_3),
#endif
                            
                            @"AgoraVideoProfilePortrait480P_4" : @(AgoraVideoProfilePortrait480P_4),
                            @"AgoraVideoProfilePortrait480P_6" : @(AgoraVideoProfilePortrait480P_6),
                            @"AgoraVideoProfilePortrait480P_8" : @(AgoraVideoProfilePortrait480P_8),
                            @"AgoraVideoProfilePortrait480P_9" : @(AgoraVideoProfilePortrait480P_9),
                            @"AgoraVideoProfilePortrait480P_10" : @(AgoraVideoProfilePortrait480P_10),
                            
                            @"AgoraVideoProfilePortrait720P" : @(AgoraVideoProfilePortrait720P),
                            @"AgoraVideoProfilePortrait720P_3" : @(AgoraVideoProfilePortrait720P_3),
                            @"AgoraVideoProfilePortrait720P_5" : @(AgoraVideoProfilePortrait720P_5),
                            @"AgoraVideoProfilePortrait720P_6" : @(AgoraVideoProfilePortrait720P_6),
                            
                            @"AgoraVideoProfilePortrait1080P" : @(AgoraVideoProfilePortrait1080P),
                            @"AgoraVideoProfilePortrait1080P_3" : @(AgoraVideoProfilePortrait1080P_3),
                            @"AgoraVideoProfilePortrait1080P_5" : @(AgoraVideoProfilePortrait1080P_5),
                            @"AgoraVideoProfilePortrait1440P" : @(AgoraVideoProfilePortrait1440P),
                            @"AgoraVideoProfilePortrait1440P_2" : @(AgoraVideoProfilePortrait1440P_2),
                            
                            @"AgoraVideoProfilePortrait4K" : @(AgoraVideoProfilePortrait4K),
                            @"AgoraVideoProfilePortrait4K_3" : @(AgoraVideoProfilePortrait4K_3),
                             */
                            @"AgoraVideoProfileDEFAULT" : @(AgoraVideoProfileLandscape360P)};
  
  
  AgoraVideoStreamTypeDic = @{ @"AgoraVideoStreamTypeHigh" : @(AgoraVideoStreamTypeHigh),
                               @"AgoraVideoStreamTypeLow" : @(AgoraVideoStreamTypeLow)};
  
  AgoraVideoMirrorModeDic = @{ @"AgoraVideoMirrorModeAuto" : @(AgoraVideoMirrorModeAuto),
                               @"AgoraVideoMirrorModeEnabled" : @(AgoraVideoMirrorModeEnabled),
                               @"AgoraVideoMirrorModeDisabled" : @(AgoraVideoMirrorModeDisabled)};
  
  AgoraAudioEqualizationBandFrequencyDic = @{ @"AgoraAudioEqualizationBand31": @(AgoraAudioEqualizationBand31),
                                              @"AgoraAudioEqualizationBand62": @(AgoraAudioEqualizationBand62),
                                              @"AgoraAudioEqualizationBand125": @(AgoraAudioEqualizationBand125),
                                              @"AgoraAudioEqualizationBand250": @(AgoraAudioEqualizationBand250),
                                              @"AgoraAudioEqualizationBand500": @(AgoraAudioEqualizationBand500),
                                              @"AgoraAudioEqualizationBand1K": @(AgoraAudioEqualizationBand1K),
                                              @"AgoraAudioEqualizationBand2K": @(AgoraAudioEqualizationBand2K),
                                              @"AgoraAudioEqualizationBand4K": @(AgoraAudioEqualizationBand4K),
                                              @"AgoraAudioEqualizationBand8K": @(AgoraAudioEqualizationBand8K),
                                              @"AgoraAudioEqualizationBand16K": @(AgoraAudioEqualizationBand16K)};
  
  AgoraAudioReverbTypeDic = @{ @"AgoraAudioReverbDryLevel": @(AgoraAudioReverbDryLevel),
                               @"AgoraAudioReverbWetLevel": @(AgoraAudioReverbWetLevel),
                               @"AgoraAudioReverbRoomSize": @(AgoraAudioReverbRoomSize),
                               @"AgoraAudioReverbWetDelay": @(AgoraAudioReverbWetDelay),
                               @"AgoraAudioReverbStrength": @(AgoraAudioReverbStrength)};
  
  AgoraAudioRecordingQualityDic = @{ @"AgoraAudioRecordingQualityLow": @(AgoraAudioRecordingQualityLow),
                                     @"AgoraAudioRecordingQualityMedium": @(AgoraAudioRecordingQualityMedium),
                                     @"AgoraAudioRecordingQualityHigh": @(AgoraAudioRecordingQualityHigh),};
  
  AgoraClientRoleDic = @{ @"AgoraClientRoleBroadcaster": @(AgoraClientRoleBroadcaster),
                          @"AgoraClientRoleAudience": @(AgoraClientRoleAudience),
                          };
  
  AgoraAudioSessionOperationRestrictionDic =
  @{@"AgoraAudioSessionOperationRestrictionNone": @(AgoraAudioSessionOperationRestrictionNone),
    @"AgoraAudioSessionOperationRestrictionAll": @(AgoraAudioSessionOperationRestrictionAll),
    @"AgoraAudioSessionOperationRestrictionSetCategory": @(AgoraAudioSessionOperationRestrictionSetCategory),
    @"AgoraAudioSessionOperationRestrictionConfigureSession": @(AgoraAudioSessionOperationRestrictionConfigureSession),
    @"AgoraAudioSessionOperationRestrictionDeactivateSession": @(AgoraAudioSessionOperationRestrictionDeactivateSession),
                          };
  
  AgoraStreamFallbackOptionsDic =
  @{@"AgoraStreamFallbackOptionDisabled": @(AgoraStreamFallbackOptionDisabled),
    @"AgoraStreamFallbackOptionVideoStreamLow": @(AgoraStreamFallbackOptionVideoStreamLow),
    @"AgoraStreamFallbackOptionAudioOnly": @(AgoraStreamFallbackOptionAudioOnly),
    };
}
@end
