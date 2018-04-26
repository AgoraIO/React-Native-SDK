# Agora React Native API
AgoraRtcEngineModule.js provides RN SDK API and AgoraRendererView.js provides a view to render video stream. So the two JS files must be included your project. 

Class AgoraRtcEngine can provide SDK functionalities, and also it's one event emitter, client could listen on interested event.

To create AgoraRtcEngine instance :

```
AgoraRtcEngine.createEngine('YOUR APP ID');
``` 

## APIs:

```
createEngine(appId)
	
setChannelProfile(profile)
	
enableAudio()
	
disableAudio()
 	
joinChannel(token, channel, info, uid)
	
leaveChannel()
	
setInEarMonitoringVolume(volume)
	
setAudioProfile(profile, scenario)

enableVideo()

disableVideo()

setVideoProfile(profile, swapWidthAndHeight)

setVideoProfileDetail(width, height, frameRate, bitrate)

setLocalView(reactTag, renderMode)

setRemoteView(reactTag, remoteId, renderMode)

enableDualStreamMode(enabled)

setRemoteVideoStream(uid, streamType)

setVideoQualityParameters(enabled)

startPreview()
	
stopPreview()
		
setLocalRenderMode(mode)
	
setRemoteRenderMode(uid, mode)
	
setLocalVideoMirrorMode(mode)

switchCamera()

setCameraZoomFactor(zoomFactor)

setCameraFocusPositionInPreview(position)

setCameraTorchOn(isOn)

setCameraAutoFocusFaceModeEnabled(enable)

setDefaultAudioRouteToSpeakerphone(defaultToSpeaker)
	
setEnableSpeakerphone(isSpeaker)

enableAudioVolumeIndication(interval, smooth)

setEffectsVolume(volume)

setVolumeOfEffect(soundId, volume)

setLocalVoicePitch(pitch)

setLocalVoiceEqualizationOfBandFrequency(bandFrequency, gain)

setLocalVoiceReverbOfType(reverbType, value)
	
playEffect(soundId, filePath, loop, pitch, pan, gain)
                  
stopEffect(soundId)
                  
stopAllEffects()

preloadEffect(soundId, filePath)

unloadEffect(soundId)

pauseEffect(soundId)

pauseAllEffect()

resumeEffect(soundId)

resumeAllEffects()

muteLocalAudioStream(muted)

muteAllRemoteAudioStreams(muted)

muteRemoteAudioStream(uid, muted)

muteLocalVideoStream(muted)

muteAllRemoteVideoStreams(mute)

muteRemoteVideoStream(uid, mute)

startAudioMixing(filePath, loopback, replace, cycle)

stopAudioMixing()

pauseAudioMixing()

resumeAudioMixing()

adjustAudioMixingVolume(volume)

setAudioMixingPosition(pos)

startAudioRecording(filePath, quality)

stopAudioRecording()

adjustRecordingSignalVolume(volume)

adjustPlaybackSignalVolume(volume)

setEncryptionSecret(secret)
	
setEncryptionMode(mode)

createDataStream(streamId, reliable, ordered)

sendStreamMessage(streamId, data)

startEchoTest()

stopEchoTest()

enableLastmileTest()

disableLastmileTest()

rate(callId, rating, description)

complain(callId description:(NSString*) description

renewToken(token)

setLogFile(filePath)

destroy()



RCTBlcok: get a value

isCameraZoomSupported(isSupported)

isCameraTorchSupported(isSupported)

isCameraFocusPositionInPreviewSupported(isSupported)

isCameraAutoFocusFaceModeSupported(isSupported)

isSpeakerphoneEnabled(isSupported)

getEffectsVolume(volume)

getAudioMixingDuration(duration)

getAudioMixingCurrentPosition(currentPosition)

getCallId(callID)

getSdkVersion(sdkVersion)

```


## Events

```
DidOccurWarning: message, code

DidOccurError: message, code

LocalDidJoinedChannel: uid, elapsed

CurrentDidRejoinChannel: channel, uid, elapsed

ReportAudioVolumeIndicationOfSpeakers: speakers

FirstLocalVideoFrame: width, height, elapsed

FirstRemoteVideoDecoded: width, height, elapsed

FirstRemoteVideoFrame: width, height, elapsed

RemoteDidJoinedChannel: uid, elapsed

RemoteDidOfflineOfUid: uid, reasonCode

DidAudioMuted: uid, isMuted

DidVideoMuted: uid, isMuted

DidVideoEnabled: uid, isMuted

LocalVideoStats: sentBitrate, sentFrameRate
 
RemoteVideoStats: uid, width, height, receivedBitrate, receivedFrameRate, rxStreamType 

CameraDidReady: nil

VideoDidStop: nil

ConnectionDidInterrupted: nil

ConnectionDidLost: nil

ConnectionDidBanned: nil

ReportRtcStats: duration, txBytes, rxBytes, txAudioKBitrate, rxAudioKBitrate, txVideoKBitrate, rxAudioKBitrate, userCount, rxAudioKBitrate, userCount, cpuAppUsage, cpuTotalUsage

DidLeaveChannelWithStats: duration, txBytes, rxBytes, txAudioKBitrate, rxAudioKBitrate, txVideoKBitrate, rxAudioKBitrate, userCount, rxAudioKBitrate, userCount, cpuAppUsage, cpuTotalUsage
 
AudioQuality: uid, quality, delay, lost

NetworkQuality: uid, txQuality, rxQuality

RequestToken: nil

LocalAudioMixingDidFinish: nil

DidAudioEffectFinish: soundId

RemoteAudioMixingDidStart: nil

RemoteAudioMixingDidFinish: nil

ReceiveStreamMessageFromUid: uid, streamId, message

DidOccurStreamMessageErrorFromUid: uid, streamId, error, missed, cached

ActiveSpeaker: speakerUid

CameraFocusDidChangedToRect: left, right, top, bottom

DidAudioRouteChanged: AgoraAudioOutputRouting

VideoSizeChanged: uid, width, height, rotation

DidRefreshRecordingServiceStatus: status

FirstLocalAudioFrame: elapsed

FirstRemoteAudioFrame: uid, elapsed

DidClientRoleChanged: oldRole, newRole
 
```