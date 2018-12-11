//
//  AgoraRtcEngineModule.m
//  RNapi
//
//  Created by CavanSu on 21/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "AgoraRtcEngineModule.h"
#import <AgoraRTCEngineKit/AgoraRtcEngineKit.h>
#import <React/RCTUIManager.h>
#import <React/RCTUIManagerUtils.h>
#import "AgoraViewManager.h"
#import "AgoraNotify.h"
#import "AgoraRtcEngineModule+EnumConvert.h"

/*
 Info.plist: Set Privacy - Camera Usage Description, Privacy - Microphone Usage Description
 */

@interface AgoraRtcEngineModule () <AgoraRtcEngineDelegate>
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
@property (nonatomic) BOOL hasListeners;
@end

@implementation AgoraRtcEngineModule{
  RCTResponseSenderBlock _block;
}
RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[
           isCameraZoomSupported,
           isCameraTorchSupported,
           isCameraFocusPositionInPreviewSupported,
           isCameraAutoFocusFaceModeSupported,
           isSpeakerphoneEnabled,
           getEffectsVolume,
           getAudioMixingDuration,
           getAudioMixingCurrentPosition,
           startEchoTest,
           getCallId,
           getSdkVersion,
           
           DidOccurWarning,
           DidOccurError,
           LocalDidJoinedChannel,
           CurrentDidRejoinChannel,
           ReportAudioVolumeIndicationOfSpeakers,
           FirstLocalVideoFrame,
           FirstRemoteVideoDecoded,
           FirstRemoteVideoFrame,
           RemoteDidJoinedChannel,
           RemoteDidOfflineOfUid,
           DidAudioMuted,
           DidVideoMuted,
           DidVideoEnabled,
           LocalVideoStats,
           RemoteVideoStats,
           CameraDidReady,
           VideoDidStop,
           ConnectionDidLost,
           ConnectionDidInterrupted,
           ConnectionDidBanned,
           ReportRtcStats,
           DidLeaveChannelWithStats,
           AudioQuality,
           LastmileQuality,
           NetworkQuality,
           RequestToken,
           LocalAudioMixingDidFinish,
           DidAudioEffectFinish,
           RemoteAudioMixingDidStart,
           RemoteAudioMixingDidFinish,
           ReceiveStreamMessageFromUid,
           DidOccurStreamMessageErrorFromUid,
           ActiveSpeaker,
           CameraFocusDidChangedToRect,
           DidAudioRouteChanged,
           VideoSizeChanged,
           DidRefreshRecordingServiceStatus,
           FirstLocalAudioFrame,
           FirstRemoteAudioFrame,
           DidClientRoleChanged,
           
           DidMicrophoneEnabled,
           DidLocalVideoEnabled,
           RemoteVideoStateChanged,
           DidLocalPublishFallbackToAudioOnly,
           DidRemoteSubscribeFallbackToAudioOnly,
           AudioTransportStats,
           VideoTransportStats,
           StreamPublished,
           StreamUnpublished,
           TranscodingUpdated,
           EngineDidLoaded,
           EngineDidStartCall,
  ];
}

RCT_EXPORT_METHOD(createEngine:(NSString *)appId) {
  self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:appId delegate:self];
}

RCT_EXPORT_METHOD(enableWebSdkInteroperability:(BOOL)enabled) {
  [self.agoraKit enableWebSdkInteroperability:enabled];
}

RCT_EXPORT_METHOD(setChannelProfile:(AgoraChannelProfile)profile) {
  [self.agoraKit setChannelProfile:profile];
}

RCT_EXPORT_METHOD(setClientRole:(AgoraClientRole)role) {
  [self.agoraKit setClientRole:role];
}

RCT_EXPORT_METHOD(enableAudio) {
  [self.agoraKit enableAudio];
}

RCT_EXPORT_METHOD(enableLocalAudio:(BOOL)enabled) {
  [self.agoraKit enableLocalAudio:enabled];
}

RCT_EXPORT_METHOD(disableAudio) {
  [self.agoraKit disableAudio];
}

RCT_EXPORT_METHOD(joinChannel:(NSString *)token channel:(NSString *)channel info:(NSString *)info uid:(NSInteger)uid) {
  [self.agoraKit joinChannelByToken:nil channelId:channel info:info uid:uid joinSuccess:nil];
}

RCT_EXPORT_METHOD(leaveChannel) {
  [self.agoraKit leaveChannel:nil];
}

RCT_EXPORT_METHOD(enableInEarMonitoring:(BOOL)enabled) {
  [self.agoraKit enableInEarMonitoring:enabled];
}

RCT_EXPORT_METHOD(setInEarMonitoringVolume:(NSInteger)volume) {
  [self.agoraKit setInEarMonitoringVolume:volume];
}

RCT_EXPORT_METHOD(setAudioProfile:(AgoraAudioProfile)profile scenario:(AgoraAudioScenario)scenario) {
  [self.agoraKit setAudioProfile:profile scenario:scenario];
}

RCT_EXPORT_METHOD(enableVideo) {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.agoraKit enableVideo];
  });
}

RCT_EXPORT_METHOD(enableLocalVideo:(BOOL)enabled) {
  [self.agoraKit enableLocalVideo:enabled];
}

RCT_EXPORT_METHOD(disableVideo) {
  [self.agoraKit disableVideo];
}

RCT_EXPORT_METHOD(setVideoProfile:(AgoraVideoProfile)profile swapWidthAndHeight:(BOOL)swapWidthAndHeight) {
  [self.agoraKit setVideoProfile:profile swapWidthAndHeight:swapWidthAndHeight];
}

RCT_EXPORT_METHOD(setVideoProfileDetail:(NSInteger)width height:(NSInteger)height frameRate:(NSInteger)frameRate bitrate:(NSInteger)bitrate) {
  [self.agoraKit setVideoResolution:CGSizeMake(width, height) andFrameRate:frameRate bitrate:bitrate];
}

RCT_EXPORT_METHOD(setLocalView:(nonnull NSNumber *)reactTag renderMode:(AgoraVideoRenderMode)renderMode) {
  AgoraRendererViewManager *manager = [AgoraRendererViewManager currentManager];
  dispatch_async(RCTGetUIManagerQueue(), ^{
    [manager.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
      UIView *view = viewRegistry[reactTag];
      AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
      canvas.uid = 0;
      canvas.view = view;
      canvas.renderMode = renderMode;
      [self.agoraKit setupLocalVideo:canvas];
    }];
  });
}

RCT_EXPORT_METHOD(setRemoteView:(nonnull NSNumber *)reactTag remoteId:(nonnull NSNumber *)remoteId renderMode:(AgoraVideoRenderMode)renderMode) {
  AgoraRendererViewManager *manager = [AgoraRendererViewManager currentManager];
  dispatch_async(RCTGetUIManagerQueue(), ^{
    [manager.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
      UIView *view = viewRegistry[reactTag];
      AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
      canvas.uid = remoteId.unsignedIntegerValue;
      canvas.view = view;
      canvas.renderMode = renderMode;
      [self.agoraKit setupRemoteVideo:canvas];
    }];
  });
}

RCT_EXPORT_METHOD(enableDualStreamMode:(BOOL)enabled) {
  [self.agoraKit enableDualStreamMode:enabled];
}

RCT_EXPORT_METHOD(setRemoteVideoStream:(NSUInteger)uid type:(AgoraVideoStreamType)streamType) {
  [self.agoraKit setRemoteVideoStream:uid type:streamType];
}

RCT_EXPORT_METHOD(setRemoteDefaultVideoStreamType:(AgoraVideoStreamType)streamType) {
  [self.agoraKit setRemoteDefaultVideoStreamType:streamType];
}

RCT_EXPORT_METHOD(setVideoQualityParameters:(BOOL)enabled) {
  [self.agoraKit setVideoQualityParameters:enabled];
}

RCT_EXPORT_METHOD(startPreview) {
  [self.agoraKit startPreview];
}

RCT_EXPORT_METHOD(stopPreview) {
  [self.agoraKit stopPreview];
}

RCT_EXPORT_METHOD(setLocalRenderMode:(AgoraVideoRenderMode)mode) {
  [self.agoraKit setLocalRenderMode:mode];
}

RCT_EXPORT_METHOD(setRemoteRenderMode:(NSUInteger)uid mode:(AgoraVideoRenderMode)mode) {
  [self.agoraKit setRemoteRenderMode:uid mode:mode];
}

RCT_EXPORT_METHOD(setLocalVideoMirrorMode:(AgoraVideoMirrorMode)mode) {
  [self.agoraKit setLocalVideoMirrorMode:mode];
}

RCT_EXPORT_METHOD(switchCamera) {
  [self.agoraKit switchCamera];
}

RCT_EXPORT_METHOD(isCameraZoomSupported:(RCTResponseSenderBlock)block) {
  BOOL isSupported = [self.agoraKit isCameraZoomSupported];
  block(@[@(isSupported)]);
}

RCT_EXPORT_METHOD(isCameraTorchSupported:(RCTResponseSenderBlock)block) {
  BOOL isSupported = [self.agoraKit isCameraTorchSupported];
  block(@[@(isSupported)]);
}

RCT_EXPORT_METHOD(isCameraFocusPositionInPreviewSupported:(RCTResponseSenderBlock)block) {
  BOOL isSupported = [self.agoraKit isCameraFocusPositionInPreviewSupported];
  block(@[@(isSupported)]);
}

RCT_EXPORT_METHOD(isCameraAutoFocusFaceModeSupported:(RCTResponseSenderBlock)block) {
  BOOL isSupported = [self.agoraKit isCameraAutoFocusFaceModeSupported];
  block(@[@(isSupported)]);
}

RCT_EXPORT_METHOD(setCameraZoomFactor:(float)zoomFactor) {
  [self.agoraKit setCameraZoomFactor:zoomFactor];
}

RCT_EXPORT_METHOD(setCameraFocusPositionInPreview:(CGPoint)position) {
  [self.agoraKit setCameraFocusPositionInPreview:position];
}

RCT_EXPORT_METHOD(setCameraTorchOn:(BOOL)isOn) {
  [self.agoraKit setCameraTorchOn:isOn];
}

RCT_EXPORT_METHOD(setCameraAutoFocusFaceModeEnabled:(BOOL)enable) {
  [self.agoraKit setCameraAutoFocusFaceModeEnabled:enable];
}

RCT_EXPORT_METHOD(setDefaultAudioRouteToSpeakerphone:(BOOL)defaultToSpeaker) {
  [self.agoraKit setDefaultAudioRouteToSpeakerphone:defaultToSpeaker];
}

RCT_EXPORT_METHOD(setEnableSpeakerphone:(BOOL)isSpeaker) {
  [self.agoraKit setEnableSpeakerphone:isSpeaker];
}

RCT_EXPORT_METHOD(isSpeakerphoneEnabled:(RCTResponseSenderBlock)block) {
  BOOL isSupported = [self.agoraKit isSpeakerphoneEnabled];
  block(@[@(isSupported)]);
}

RCT_EXPORT_METHOD(enableAudioVolumeIndication:(NSInteger)interval smooth:(NSInteger)smooth) {
  [self.agoraKit enableAudioVolumeIndication:interval smooth:smooth];
}

RCT_EXPORT_METHOD(getEffectsVolume:(RCTResponseSenderBlock)block) {
  double volume = [self.agoraKit getEffectsVolume];
  block(@[@(volume)]);
}

RCT_EXPORT_METHOD(setEffectsVolume:(double)volume) {
  [self.agoraKit setEffectsVolume:volume];
}

RCT_EXPORT_METHOD(setVolumeOfEffect:(int)soundId withVolume:(double) volume) {
  [self.agoraKit setVolumeOfEffect:soundId withVolume:volume];
}

RCT_EXPORT_METHOD(setLocalVoicePitch:(double)pitch) {
  [self.agoraKit setLocalVoicePitch:pitch];
}

RCT_EXPORT_METHOD(setLocalVoiceEqualizationOfBandFrequency:(AgoraAudioEqualizationBandFrequency)bandFrequency withGain:(int)gain
                  ) {
  [self.agoraKit setLocalVoiceEqualizationOfBandFrequency:bandFrequency withGain:gain];
}

RCT_EXPORT_METHOD(setLocalVoiceReverbOfType:(AgoraAudioReverbType)reverbType withValue:(int)value) {
  [self.agoraKit setLocalVoiceReverbOfType:reverbType withValue:value];
}

RCT_EXPORT_METHOD(playEffect: (int) soundId
                  filePath: (NSString*) filePath
                  loop: (BOOL) loop
                  pitch: (double) pitch
                  pan: (double) pan
                  gain: (double) gain
                  publish: (BOOL)publish) {
  [self.agoraKit playEffect:soundId filePath:filePath loopCount:loop pitch:pitch pan:pan gain:gain publish:publish];
}

RCT_EXPORT_METHOD(stopEffect:(int) soundId) {
  [self.agoraKit stopEffect:soundId];
}

RCT_EXPORT_METHOD(stopAllEffects) {
  [self.agoraKit stopAllEffects];
}

RCT_EXPORT_METHOD(preloadEffect:(int)soundId filePath:(NSString*)filePath) {
  [self.agoraKit preloadEffect:soundId filePath:filePath];
}

RCT_EXPORT_METHOD(unloadEffect:(int) soundId) {
  [self.agoraKit unloadEffect:soundId];
}

RCT_EXPORT_METHOD(pauseEffect:(int) soundId) {
  [self.agoraKit pauseEffect:soundId];
}

RCT_EXPORT_METHOD(pauseAllEffect) {
  [self.agoraKit pauseAllEffects];
}

RCT_EXPORT_METHOD(resumeEffect:(int) soundId) {
  [self.agoraKit resumeEffect:soundId];
}

RCT_EXPORT_METHOD(resumeAllEffects) {
  [self.agoraKit resumeAllEffects];
}

RCT_EXPORT_METHOD(muteLocalAudioStream:(BOOL)muted) {
  [self.agoraKit muteLocalAudioStream:muted];
}

RCT_EXPORT_METHOD(muteAllRemoteAudioStreams:(BOOL)muted) {
  [self.agoraKit muteAllRemoteAudioStreams:muted];
}

RCT_EXPORT_METHOD(setDefaultMuteAllRemoteAudioStreams:(BOOL)mute) {
  [self.agoraKit setDefaultMuteAllRemoteAudioStreams:mute];
}

RCT_EXPORT_METHOD(muteRemoteAudioStream:(NSUInteger)uid muted:(BOOL)muted) {
  [self.agoraKit muteRemoteAudioStream:uid mute:muted];
}

RCT_EXPORT_METHOD(muteLocalVideoStream:(BOOL)muted) {
  [self.agoraKit muteLocalVideoStream:muted];
}

RCT_EXPORT_METHOD(muteAllRemoteVideoStreams:(BOOL)mute) {
  [self.agoraKit muteAllRemoteVideoStreams:mute];
}

RCT_EXPORT_METHOD(setDefaultMuteAllRemoteVideoStreams:(BOOL)mute) {
  [self.agoraKit setDefaultMuteAllRemoteVideoStreams:mute];
}

RCT_EXPORT_METHOD(muteRemoteVideoStream:(NSUInteger)uid mute:(BOOL)mute) {
  [self.agoraKit muteRemoteVideoStream:uid mute:mute];
}

RCT_EXPORT_METHOD(setAudioSessionOperationRestriction:(AgoraAudioSessionOperationRestriction)restriction) {
  [self.agoraKit setAudioSessionOperationRestriction:restriction];
}

RCT_EXPORT_METHOD(startAudioMixing: (NSString*) filePath
                  loopback: (BOOL) loopback
                  replace: (BOOL) replace
                  cycle: (NSInteger) cycle) {
  [self.agoraKit startAudioMixing:filePath loopback:loopback replace:replace cycle:cycle];
}

RCT_EXPORT_METHOD(stopAudioMixing) {
  [self.agoraKit stopAudioMixing];
}

RCT_EXPORT_METHOD(pauseAudioMixing) {
  [self.agoraKit pauseAudioMixing];
}

RCT_EXPORT_METHOD(resumeAudioMixing) {
  [self.agoraKit resumeAudioMixing];
}

RCT_EXPORT_METHOD(adjustAudioMixingVolume:(NSInteger) volume) {
  [self.agoraKit adjustAudioMixingVolume:volume];
}

RCT_EXPORT_METHOD(getAudioMixingDuration:(RCTResponseSenderBlock)block) {
  int duration = [self.agoraKit getAudioMixingDuration];
  block(@[@(duration)]);
}

RCT_EXPORT_METHOD(getAudioMixingCurrentPosition:(RCTResponseSenderBlock)block) {
  int currentPosition = [self.agoraKit getAudioMixingCurrentPosition];
  block(@[@(currentPosition)]);
}

RCT_EXPORT_METHOD(setAudioMixingPosition:(NSInteger) pos) {
  [self.agoraKit setAudioMixingPosition:pos];
}

RCT_EXPORT_METHOD(startAudioRecording:(NSString*)filePath quality:(AgoraAudioRecordingQuality)quality) {
  [self.agoraKit startAudioRecording:filePath quality:quality];
}

RCT_EXPORT_METHOD(stopAudioRecording) {
  [self.agoraKit stopAudioRecording];
}

RCT_EXPORT_METHOD(adjustRecordingSignalVolume:(NSInteger)volume) {
  [self.agoraKit adjustRecordingSignalVolume:volume];
}

RCT_EXPORT_METHOD(adjustPlaybackSignalVolume:(NSInteger)volume) {
  [self.agoraKit adjustPlaybackSignalVolume:volume];
}

RCT_EXPORT_METHOD(setEncryptionSecret:(NSString*)secret) {
  [self.agoraKit setEncryptionSecret:secret];
}

RCT_EXPORT_METHOD(setEncryptionMode:(NSString*)encryptionMode) {
  [self.agoraKit setEncryptionMode:encryptionMode];
}

RCT_EXPORT_METHOD(createDataStream:(NSInteger*)streamId reliable:(BOOL)reliable ordered:(BOOL)ordered) {
  [self.agoraKit createDataStream:streamId reliable:reliable ordered:ordered];
}

RCT_EXPORT_METHOD(sendStreamMessage:(NSInteger)streamId data:(NSData*)data) {
  [self.agoraKit sendStreamMessage:streamId data:data];
}

RCT_EXPORT_METHOD(startEchoTest) {
  __weak AgoraRtcEngineModule *weakself = self;
  [self.agoraKit startEchoTest:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
    [weakself sendEventWithName:startEchoTest body:@{@"channel": channel, @"uid": @(uid), @"elapsed": @(elapsed)}];
  }];
}

RCT_EXPORT_METHOD(stopEchoTest) {
  [self.agoraKit stopEchoTest];
}

RCT_EXPORT_METHOD(enableLastmileTest) {
  [self.agoraKit enableLastmileTest];
}

RCT_EXPORT_METHOD(disableLastmileTest) {
  [self.agoraKit disableLastmileTest];
}

RCT_EXPORT_METHOD(setLocalPublishFallbackOption:(AgoraStreamFallbackOptions)option) {
  [self.agoraKit setLocalPublishFallbackOption:option];
}

RCT_EXPORT_METHOD(setRemoteSubscribeFallbackOption:(AgoraStreamFallbackOptions)option) {
  [self.agoraKit setRemoteSubscribeFallbackOption:option];
}

RCT_EXPORT_METHOD(getCallId:(RCTResponseSenderBlock)block) {
  NSString *callID = [self.agoraKit getCallId];
  block(@[callID]);
}

RCT_EXPORT_METHOD(rate:(NSString*)callId rating:(NSInteger)rating description:(NSString*) description) {
  [self.agoraKit rate:callId rating:rating description:description];
}

RCT_EXPORT_METHOD(complain:(NSString*)callId description:(NSString*) description) {
  [self.agoraKit complain:callId description:description];
}

RCT_EXPORT_METHOD(renewToken:(NSString*) token) {
  [self.agoraKit renewToken:token];
}

RCT_EXPORT_METHOD(setLogFile:(NSString*)filePath) {
  [self.agoraKit setLogFile:filePath];
}

RCT_EXPORT_METHOD(setLogFilter:(NSUInteger)filter) {
  [self.agoraKit setLogFilter:filter];
}

RCT_EXPORT_METHOD(destroy) {
  [AgoraRtcEngineKit destroy];
}

RCT_EXPORT_METHOD(getSdkVersion:(RCTResponseSenderBlock)block) {
  NSString *sdkVersion = [AgoraRtcEngineKit getSdkVersion];
  block(@[sdkVersion]);
}

RCT_EXPORT_METHOD(addPublishStreamUrl:(NSString *)url transcodingEnabled:(BOOL)transcodingEnabled) {
  [self.agoraKit addPublishStreamUrl:url transcodingEnabled:transcodingEnabled];
}

RCT_EXPORT_METHOD(removePublishStreamUrl:(NSString *)url) {
  [self.agoraKit removePublishStreamUrl:url];
}

RCT_EXPORT_METHOD(setLiveTranscoding:(NSDictionary *)transcoding) {
  CGSize size = [RCTConvert CGSize:transcoding[@"size"]];
  NSInteger videoBitrate = [RCTConvert NSInteger:transcoding[@"videoBitrate"]];
  NSInteger videoFramerate = [RCTConvert NSInteger:transcoding[@"videoFramerate"]];
  NSInteger lowLatency = [RCTConvert BOOL:transcoding[@"lowLatency"]];
  NSInteger videoGop = [RCTConvert NSInteger:transcoding[@"videoGop"]];
  AgoraVideoCodecProfileType videoCodecProfile = [RCTConvert NSUInteger:transcoding[@"videoCodecProfile"]];
  
  NSString *transcodingExtraInfo = [RCTConvert NSString:transcoding[@"transcodingExtraInfo"]];
  UIColor *backgroundColor = [RCTConvert UIColor:transcoding[@"backgroundColor"]];
  AgoraAudioSampleRateType audioSampleRate = [RCTConvert NSUInteger:transcoding[@"audioSampleRate"]];
  NSInteger audioBitrate = [RCTConvert NSInteger:transcoding[@"audioBitrate"]];
  NSInteger audioChannels = [RCTConvert NSInteger:transcoding[@"audioChannels"]];
  
  AgoraLiveTranscoding *liveTranscoding = [[AgoraLiveTranscoding alloc] init];
  liveTranscoding.size = size;
  liveTranscoding.videoBitrate = videoBitrate;
  liveTranscoding.videoFramerate = videoFramerate;
  liveTranscoding.lowLatency = lowLatency;
  liveTranscoding.videoGop = videoGop;
  liveTranscoding.videoCodecProfile = videoCodecProfile;
  liveTranscoding.transcodingExtraInfo = transcodingExtraInfo;
  liveTranscoding.backgroundColor = backgroundColor;
  liveTranscoding.audioSampleRate = audioSampleRate;
  liveTranscoding.audioBitrate = audioBitrate;
  liveTranscoding.audioChannels = audioChannels;
  
  NSDictionary *watermarkDic = [RCTConvert NSDictionary:transcoding[@"watermark"]];
  if (watermarkDic) {
    NSURL *url = [RCTConvert NSURL:watermarkDic[@"url"]];
    CGRect rect = [RCTConvert CGRect:watermarkDic[@"rect"]];
    AgoraImage *watermark = [[AgoraImage alloc] init];
    watermark.url = url;
    watermark.rect = rect;
    liveTranscoding.watermark = watermark;
  }
  
  NSDictionary *backgroundImageDic = [RCTConvert NSDictionary:transcoding[@"backgroundImage"]];
  if (backgroundImageDic) {
    NSURL *url = [RCTConvert NSURL:backgroundImageDic[@"url"]];
    CGRect rect = [RCTConvert CGRect:backgroundImageDic[@"rect"]];
    AgoraImage *backgroundImage = [[AgoraImage alloc] init];
    backgroundImage.url = url;
    backgroundImage.rect = rect;
    liveTranscoding.backgroundImage = backgroundImage;
  }
  
  NSArray<NSDictionary *> *transcodingUsersArray = [RCTConvert NSDictionaryArray:transcoding[@"transcodingUsers"]];
  if (transcodingUsersArray.count) {
    NSMutableArray<AgoraLiveTranscodingUser *> *usersArray = [[NSMutableArray alloc] init];
    for (NSDictionary *transcodingUserDic in transcodingUsersArray) {
      NSUInteger uid = [RCTConvert NSUInteger:transcodingUserDic[@"uid"]];
      CGRect rect = [RCTConvert CGRect:transcodingUserDic[@"rect"]];
      NSUInteger zOrder = [RCTConvert NSInteger:transcodingUserDic[@"zOrder"]];
      NSUInteger alpha = [RCTConvert double:transcodingUserDic[@"alpha"]];
      NSUInteger audioChannel = [RCTConvert NSInteger:transcodingUserDic[@"audioChannel"]];
      AgoraLiveTranscodingUser *user = [[AgoraLiveTranscodingUser alloc] init];
      user.uid = uid;
      user.rect = rect;
      user.zOrder = zOrder;
      user.alpha = alpha;
      user.audioChannel = audioChannel;
      [usersArray addObject:user];
    }
    liveTranscoding.transcodingUsers = usersArray;
  }
  
  [self.agoraKit setLiveTranscoding:liveTranscoding];
}

#pragma mark - <AgoraRtcEngineDelegate>
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraWarningCode)warningCode {
  [self sendEventWithName:DidOccurWarning body:@{@"message": @"Agora Warning", @"code": @(warningCode)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraErrorCode)errorCode {
  [self sendEventWithName:DidOccurError body:@{@"message": @"Agora Error", @"code": @(errorCode)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self sendEventWithName:LocalDidJoinedChannel body:@{@"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didRejoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self sendEventWithName:CurrentDidRejoinChannel body:@{@"channel": channel, @"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportAudioVolumeIndicationOfSpeakers:(NSArray*)speakers totalVolume:(NSInteger)totalVolume {
  NSMutableDictionary *dic = [NSMutableDictionary dictionary];
  NSString *userName = nil;
  NSString *volumeStr = nil;
  AgoraRtcAudioVolumeInfo *item = nil;
  
  int uid = 0;
  int volume = 0;
  
  for (int i = 0; i < speakers.count; i ++) {
    item = speakers[i];
    
    userName = [NSString stringWithFormat:@"uid%d", i];
    volumeStr = [NSString stringWithFormat:@"volume%d", i];
    uid = (int)item.uid;
    volume = (int)item.volume;
    
    dic[userName] = @(uid);
    dic[volumeStr] = @(volume);
  }
  dic[@"count"] = @(speakers.count);
  dic[@"totalVolume"] = @(totalVolume);
  
  [self sendEventWithName:ReportAudioVolumeIndicationOfSpeakers body:dic];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed {
  [self sendEventWithName:FirstLocalVideoFrame body:@{@"width": @(size.width), @"height": @(size.height), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed {
  [self sendEventWithName:FirstRemoteVideoDecoded body:@{@"width": @(size.width), @"height": @(size.height), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoFrameOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed {
  [self sendEventWithName:FirstRemoteVideoFrame body:@{@"width": @(size.width), @"height": @(size.height), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self sendEventWithName:RemoteDidJoinedChannel body:@{@"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
  [self sendEventWithName:RemoteDidOfflineOfUid body:@{@"uid": @(uid), @"reasonCode": @(reason)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didAudioMuted:(BOOL)muted byUid:(NSUInteger)uid {
   [self sendEventWithName:DidAudioMuted body:@{@"uid": @(uid), @"isMuted": @(muted)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didVideoMuted:(BOOL)muted byUid:(NSUInteger)uid {
  [self sendEventWithName:DidVideoMuted body:@{@"uid": @(uid), @"isMuted": @(muted)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didVideoEnabled:(BOOL)enabled byUid:(NSUInteger)uid {
  [self sendEventWithName:DidVideoEnabled body:@{@"uid": @(uid), @"isEnabled": @(enabled)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didLocalVideoEnabled:(BOOL)enabled byUid:(NSUInteger)uid {
  [self sendEventWithName:DidLocalVideoEnabled body:@{@"enabled": @(enabled), @"uid": @(uid)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine localVideoStats:(AgoraRtcLocalVideoStats *)stats {
  [self sendEventWithName:LocalVideoStats body:@{@"sentBitrate": @(stats.sentBitrate), @"sentFrameRate": @(stats.sentFrameRate)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine remoteVideoStats:(AgoraRtcRemoteVideoStats*)stats {
  [self sendEventWithName:RemoteVideoStats body:@{@"uid": @(stats.uid), @"width": @(stats.width), @"height": @(stats.height), @"receivedBitrate": @(stats.receivedBitrate), @"receivedFrameRate": @(stats.receivedFrameRate), @"rxStreamType": @(stats.rxStreamType)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine audioTransportStatsOfUid:(NSUInteger)uid delay:(NSUInteger)delay lost:(NSUInteger)lost rxKBitRate:(NSUInteger)rxKBitRate {
  [self sendEventWithName:AudioTransportStats body:@{@"uid":@(uid),
                                                          @"delay":@(delay),
                                                          @"lost":@(lost),
                                                          @"rxKBitRate":@(rxKBitRate),
                                                          }];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine videoTransportStatsOfUid:(NSUInteger)uid delay:(NSUInteger)delay lost:(NSUInteger)lost rxKBitRate:(NSUInteger)rxKBitRate {
  [self sendEventWithName:VideoTransportStats body:@{@"uid":@(uid),
                                                     @"delay":@(delay),
                                                     @"lost":@(lost),
                                                     @"rxKBitRate":@(rxKBitRate),
                                                     }];
}

- (void)rtcEngineCameraDidReady:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:CameraDidReady body:nil];
}

- (void)rtcEngineVideoDidStop:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:VideoDidStop body:nil];
}

- (void)rtcEngineConnectionDidInterrupted:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:ConnectionDidInterrupted body:nil];
}

- (void)rtcEngineConnectionDidLost:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:ConnectionDidLost body:nil];
}

- (void)rtcEngineConnectionDidBanned:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEventWithName:ConnectionDidBanned body:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportRtcStats:(AgoraChannelStats *)stats {
  [self sendEventWithName:ReportRtcStats body:@{@"duration": @(stats.duration),
                                                @"txBytes": @(stats.txBytes),
                                                @"rxBytes": @(stats.rxBytes),
                                                @"txAudioKBitrate": @(stats.txAudioKBitrate),
                                                @"rxAudioKBitrate": @(stats.rxAudioKBitrate),
                                                @"txVideoKBitrate": @(stats.txVideoKBitrate),
                                                @"rxAudioKBitrate": @(stats.rxAudioKBitrate),
                                                @"userCount": @(stats.userCount),
                                                @"rxAudioKBitrate": @(stats.rxAudioKBitrate),
                                                @"userCount": @(stats.userCount),
                                                @"cpuAppUsage": @(stats.cpuAppUsage),
                                                @"cpuTotalUsage": @(stats.cpuTotalUsage)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didLeaveChannelWithStats:(AgoraChannelStats *)stats {
  [self sendEventWithName:DidLeaveChannelWithStats body:@{@"duration": @(stats.duration),
                                                @"txBytes": @(stats.txBytes),
                                                @"rxBytes": @(stats.rxBytes),
                                                @"txAudioKBitrate": @(stats.txAudioKBitrate),
                                                @"rxAudioKBitrate": @(stats.rxAudioKBitrate),
                                                @"txVideoKBitrate": @(stats.txVideoKBitrate),
                                                @"rxAudioKBitrate": @(stats.rxAudioKBitrate),
                                                @"userCount": @(stats.userCount),
                                                @"rxAudioKBitrate": @(stats.rxAudioKBitrate),
                                                @"userCount": @(stats.userCount),
                                                @"cpuAppUsage": @(stats.cpuAppUsage),
                                                @"cpuTotalUsage": @(stats.cpuTotalUsage)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine audioQualityOfUid:(NSUInteger)uid quality:(AgoraNetworkQuality)quality delay:(NSUInteger)delay lost:(NSUInteger)lost {
  [self sendEventWithName:AudioQuality body:@{@"uid": @(uid),
                                              @"quality": @(quality),
                                              @"delay": @(delay),
                                              @"lost": @(lost)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine lastmileQuality:(AgoraNetworkQuality)quality {
  [self sendEventWithName:LastmileQuality body:@{@"quality": @(quality)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine networkQuality:(NSUInteger)uid txQuality:(AgoraNetworkQuality)txQuality rxQuality:(AgoraNetworkQuality)rxQuality {
  [self sendEventWithName:NetworkQuality body:@{@"uid": @(uid),
                                                 @"txQuality": @(txQuality),
                                                 @"rxQuality": @(rxQuality)}];
}

- (void)rtcEngineRequestToken:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:RequestToken body:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didMicrophoneEnabled:(BOOL)enabled {
  [self sendEventWithName:DidMicrophoneEnabled body:@{@"enabled": @(enabled)}];
}

- (void)rtcEngineLocalAudioMixingDidFinish:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:LocalAudioMixingDidFinish body:nil];
}

- (void)rtcEngineDidAudioEffectFinish:(AgoraRtcEngineKit *)engine soundId:(NSInteger)soundId {
  [self sendEventWithName:DidAudioEffectFinish body:@{@"soundId": @(soundId)}];
}

- (void)rtcEngineRemoteAudioMixingDidStart:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:RemoteAudioMixingDidStart body:nil];
}

- (void)rtcEngineRemoteAudioMixingDidFinish:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:RemoteAudioMixingDidFinish body:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine receiveStreamMessageFromUid:(NSUInteger)uid streamId:(NSInteger)streamId data:(NSData *)data {
  NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  [self sendEventWithName:ReceiveStreamMessageFromUid body:@{@"uid": @(uid), @"streamId": @(streamId), @"message": message}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurStreamMessageErrorFromUid:(NSUInteger)uid streamId:(NSInteger)streamId error:(NSInteger)error missed:(NSInteger)missed cached:(NSInteger)cached {
  [self sendEventWithName:DidOccurStreamMessageErrorFromUid body:@{@"uid": @(uid), @"streamId": @(streamId), @"error": @(error), @"missed": @(missed), @"cached": @(cached)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine activeSpeaker:(NSUInteger)speakerUid {
  [self sendEventWithName:ActiveSpeaker body:@{@"speakerUid": @(speakerUid)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine cameraFocusDidChangedToRect:(CGRect)rect {
  int left = rect.origin.x;
  int right = left + rect.size.width;
  int top = rect.origin.y;
  int bottom = top + rect.size.height;
  [self sendEventWithName:CameraFocusDidChangedToRect body:@{@"left": @(left), @"right": @(right), @"top": @(top), @"bottom": @(bottom)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didAudioRouteChanged:(AgoraAudioOutputRouting)routing {
  [self sendEventWithName:DidAudioRouteChanged body:@{@"AgoraAudioOutputRouting": @(routing)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine videoSizeChangedOfUid:(NSUInteger)uid size:(CGSize)size rotation:(NSInteger)rotation {
  [self sendEventWithName:VideoSizeChanged body:@{@"uid": @(uid), @"width": @(size.width), @"height": @(size.height), @"rotation": @(rotation)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine remoteVideoStateChangedOfUid:(NSUInteger)uid state:(AgoraVideoRemoteState)state {
  [self sendEventWithName:RemoteVideoStateChanged body:@{@"uid": @(uid), @"state": @(state)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didRefreshRecordingServiceStatus:(NSInteger)status {
  [self sendEventWithName:DidRefreshRecordingServiceStatus body:@{@"status": @(status)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstLocalAudioFrame:(NSInteger)elapsed {
  [self sendEventWithName:FirstLocalAudioFrame body:@{@"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteAudioFrameOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self sendEventWithName:FirstRemoteAudioFrame body:@{@"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole {
  [self sendEventWithName:DidClientRoleChanged body:@{@"oldRole": @(oldRole), @"newRole": @(newRole)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didLocalPublishFallbackToAudioOnly:(BOOL)isFallbackOrRecover {
  [self sendEventWithName:DidLocalPublishFallbackToAudioOnly body:@{@"isFallbackOrRecover": @(isFallbackOrRecover)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didRemoteSubscribeFallbackToAudioOnly:(BOOL)isFallbackOrRecover byUid:(NSUInteger)uid {
  [self sendEventWithName:DidRemoteSubscribeFallbackToAudioOnly body:@{@"isFallbackOrRecover": @(isFallbackOrRecover), @"uid": @(uid)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine streamPublishedWithUrl:(NSString *)url errorCode:(AgoraErrorCode)errorCode {
  [self sendEventWithName:StreamPublished body:@{@"url": url, @"errorCode": @(errorCode)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine streamUnpublishedWithUrl:(NSString *)url {
  [self sendEventWithName:StreamUnpublished body:@{@"url":url}];
}

- (void)rtcEngineTranscodingUpdated:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:TranscodingUpdated body:nil];
}

- (void)rtcEngineMediaEngineDidLoaded:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:EngineDidLoaded body:nil];
}

- (void)rtcEngineMediaEngineDidStartCall:(AgoraRtcEngineKit *)engine {
  [self sendEventWithName:EngineDidStartCall body:nil];
}

#pragma mark - RCTEventEmitter Overrides

- (void)startObserving
{
  [super startObserving];
  self.hasListeners = YES;
}

- (void)stopObserving
{
  [super stopObserving];
  self.hasListeners = NO;
}

- (void)sendEventWithName:(NSString *)eventName body:(id)body
{
  // Only send events when there are listeners to avoid spammy YellowBox warnings.
  // See explanation at https://facebook.github.io/react-native/docs/native-modules-ios#optimizing-for-zero-listeners
  if (self.hasListeners) {
    [super sendEventWithName:eventName body:body];
  }
}

@end
