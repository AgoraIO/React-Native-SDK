//
//  AgoraNotify.h
//  RNapi
//
//  Created by CavanSu on 26/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#ifndef AgoraNotify_h
#define AgoraNotify_h

static NSString *const isCameraZoomSupported = @"isCameraZoomSupported";
static NSString *const isCameraTorchSupported = @"isCameraTorchSupported";
static NSString *const isCameraFocusPositionInPreviewSupported = @"isCameraFocusPositionInPreviewSupported";
static NSString *const isCameraAutoFocusFaceModeSupported = @"isCameraAutoFocusFaceModeSupported";
static NSString *const isSpeakerphoneEnabled = @"isSpeakerphoneEnabled";
static NSString *const getEffectsVolume = @"getEffectsVolume";
static NSString *const getAudioMixingDuration = @"getAudioMixingDuration";
static NSString *const getAudioMixingCurrentPosition = @"getAudioMixingCurrentPosition";
static NSString *const startEchoTest = @"startEchoTest";
static NSString *const getCallId = @"getCallId";
static NSString *const getSdkVersion = @"getSdkVersion";

static NSString *const DidOccurWarning = @"DidOccurWarning";
static NSString *const DidOccurError =  @"DidOccurError";
static NSString *const LocalDidJoinedChannel = @"LocalDidJoinedChannel";
static NSString *const CurrentDidRejoinChannel = @"CurrentDidRejoinChannel";
static NSString *const ReportAudioVolumeIndicationOfSpeakers = @"ReportAudioVolumeIndicationOfSpeakers";
static NSString *const FirstLocalVideoFrame = @"FirstLocalVideoFrame";
static NSString *const FirstRemoteVideoDecoded = @"FirstRemoteVideoDecoded";
static NSString *const FirstRemoteVideoFrame = @"FirstRemoteVideoFrame";
static NSString *const RemoteDidJoinedChannel = @"RemoteDidJoinedChannel";
static NSString *const RemoteDidOfflineOfUid = @"RemoteDidOfflineOfUid";
static NSString *const DidAudioMuted = @"DidAudioMuted";
static NSString *const DidVideoMuted = @"DidVideoMuted";
static NSString *const DidVideoEnabled = @"DidVideoEnabled";
static NSString *const LocalVideoStats = @"LocalVideoStats";
static NSString *const RemoteVideoStats = @"RemoteVideoStats";
static NSString *const CameraDidReady = @"CameraDidReady";
static NSString *const VideoDidStop = @"VideoDidStop";
static NSString *const ConnectionDidLost = @"ConnectionDidLost";
static NSString *const ConnectionDidInterrupted = @"ConnectionDidInterrupted";
static NSString *const ConnectionDidBanned = @"ConnectionDidBanned";
static NSString *const ReportRtcStats = @"ReportRtcStats";
static NSString *const DidLeaveChannelWithStats = @"DidLeaveChannelWithStats";
static NSString *const AudioQuality = @"AudioQuality";
static NSString *const LastmileQuality =  @"LastmileQuality";
static NSString *const NetworkQuality = @"NetworkQuality";
static NSString *const RequestToken = @"RequestToken";
static NSString *const LocalAudioMixingDidFinish = @"LocalAudioMixingDidFinish";
static NSString *const DidAudioEffectFinish = @"DidAudioEffectFinish";
static NSString *const RemoteAudioMixingDidStart = @"RemoteAudioMixingDidStart";
static NSString *const RemoteAudioMixingDidFinish = @"RemoteAudioMixingDidFinish";
static NSString *const ReceiveStreamMessageFromUid = @"ReceiveStreamMessageFromUid";
static NSString *const DidOccurStreamMessageErrorFromUid = @"DidOccurStreamMessageErrorFromUid";
static NSString *const ActiveSpeaker = @"ActiveSpeaker";
static NSString *const CameraFocusDidChangedToRect = @"CameraFocusDidChangedToRect";
static NSString *const DidAudioRouteChanged = @"DidAudioRouteChanged";
static NSString *const VideoSizeChanged = @"VideoSizeChanged";
static NSString *const DidRefreshRecordingServiceStatus = @"DidRefreshRecordingServiceStatus";
static NSString *const FirstLocalAudioFrame = @"FirstLocalAudioFrame";
static NSString *const FirstRemoteAudioFrame = @"FirstRemoteAudioFrame";
static NSString *const DidClientRoleChanged = @"DidClientRoleChanged";

static NSString *const DidMicrophoneEnabled = @"DidMicrophoneEnabled";
static NSString *const DidLocalVideoEnabled = @"DidLocalVideoEnabled";
static NSString *const RemoteVideoStateChanged = @"RemoteVideoStateChanged";
static NSString *const DidLocalPublishFallbackToAudioOnly = @"DidLocalPublishFallbackToAudioOnly";
static NSString *const DidRemoteSubscribeFallbackToAudioOnly = @"DidRemoteSubscribeFallbackToAudioOnly";
static NSString *const AudioTransportStats = @"AudioTransportStats";
static NSString *const VideoTransportStats = @"VideoTransportStats";
static NSString *const StreamPublished = @"StreamPublished";
static NSString *const StreamUnpublished = @"StreamUnpublished";
static NSString *const TranscodingUpdated = @"TranscodingUpdated";
static NSString *const EngineDidLoaded = @"EngineDidLoaded";
static NSString *const EngineDidStartCall = @"EngineDidStartCall";
#endif /* AgoraNotify_h */
