//
//  AgoraEnum.h
//  RNapi
//
//  Created by CavanSu on 29/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSDictionary *AgoraChannelProfileDic;
extern NSDictionary *AgoraVideoRenderModeDic;
extern NSDictionary *AgoraAudioProfileDic;
extern NSDictionary *AgoraAudioScenarioDic;
extern NSDictionary *AgoraVideoProfileDic;
extern NSDictionary *AgoraVideoStreamTypeDic;
extern NSDictionary *AgoraVideoMirrorModeDic;
extern NSDictionary *AgoraAudioEqualizationBandFrequencyDic;
extern NSDictionary *AgoraAudioReverbTypeDic;
extern NSDictionary *AgoraAudioRecordingQualityDic;
extern NSDictionary *AgoraClientRoleDic;
extern NSDictionary *AgoraAudioSessionOperationRestrictionDic;
extern NSDictionary *AgoraStreamFallbackOptionsDic;

@interface AgoraEnum : NSObject
+ (void)loadEnums;
@end
