# Agora React Native API Reference

The [`AgoraRtcEngineModule.js `](components/AgoraRtcEngineModule.js) file enables use of the JavaScript Agora SDK API through the `AgoraRtcEngine` class. `AgoraRtcEngine` contains the event emitter, which allows the `client` to listen for events.

The [`AgoraRendererView.js`](components/AgoraRendererView.js) file renders the video stream. 

You must include **both** JavaScript files in your project. 


## Quick Start

### Create the `AgoraRtcEngine`

In the `render()` method in your React Native `App.js` file, add `AgoraRtcEngine.createEngine()` to create the Agora engine. Ensure `YOUR APP ID` is replaced with your Agora App ID. After your Agora engine is created, you may begin applying [Agora API methods](#api-methods) and [event listeners](#event-listeners).

``` JavaScript
render() {
		
	AgoraRtcEngine.createEngine('YOUR APP ID');
		
	...
}
```

## API Methods

- [General Methods](#general-methods)
- [Logging and Testing Methods](#logging-and-testing-methods)
- [Device Control Methods](#device-control-methods)
- [View, Preview, and Render Methods](#view-preview-and-render-methods)
- [Client, Channel, and Stream Methods](#client,-channel,-and-stream-methods)
- [Audio Control Methods](#audio-control-methods)
- [Audio Mixing Methods](#audio-mixing-methods)
- [Audio Recording and Playback Methods](#audio-recording-and-playback-methods)
- [Video Control Methods](#video-control-methods)
- [Video Device Methods](#video-device-methods)

### General Methods

These methods handle general API communication with the Agora SDK.

Method|Description
----- | -----
`createEngine(appId)`|Creates an Agora Engine instance.
`rate(callId, rating, description)`|Rates the call.
`complain(callId description:(NSString*) description`|Submits a complaint about a call.
`renewToken(token)`|Renews a token.
`destroy()`|Destroys the call.
`setEncryptionSecret(secret)`|Sets the encryption to secret / not secret. 
`setEncryptionMode(mode)`|Sets the encryption mode.
`getCallId(callID)`|Retrieves the call ID.
`getSdkVersion(sdkVersion)`|Retrieves the Agora SDK version.
`RCTBlcok`|Retrieves a RTC block value.
	
### Logging and Testing Methods

These methods are used to set logging preferences and to test call connectivity.

Method|Description
----- | -----
`setLogFile(filePath)`|Sets the file path for the logs.
`startEchoTest()`|Starts the echo test.
`stopEchoTest()`|Stops the echo test.
`enableLastmileTest()`|Enables the last mile test.
`disableLastmileTest()`|Disables the last mile test.

### Device Control Methods

These methods are used to manage device capabilities.

Method|Description
----- | -----
`switchCamera()`|Switches the camera.
`isCameraZoomSupported(isSupported)`|Checks if camera zoom is supported.
`setCameraZoomFactor(zoomFactor)`|Sets the camera zoom.
`isCameraFocusPositionInPreviewSupported(isSupported)`|Checks if the camera focus position within the Preview is supported.
`setCameraFocusPositionInPreview(position)`|Sets the camera focus position within the Preview.
`isCameraTorchSupported(isSupported)`|Checks if camera torch (lighting) is supported.
`setCameraTorchOn(isOn)`|Turns on/off the camera torch (lighting).
`isCameraAutoFocusFaceModeSupported(isSupported)`|Checks if the facing camera's auto-focus is supported.
`setCameraAutoFocusFaceModeEnabled(enable)`|Enables / disables the facing camera's auto-focus.
`isSpeakerphoneEnabled(isSupported)`|Checks if the speakerphone is enabled.
`setEnableSpeakerphone(isSpeaker)`|Enables / disables the speakerphone.
`setDefaultAudioRouteToSpeakerphone(defaultToSpeaker)`|Sets the speakerphone as the default audio device.

### View, Preview, and Render Methods

These methods are used to manage views, previews, and rendering.

Method|Description
----- | -----
`setLocalView(reactTag, renderMode)`|Sets the local view.
`setRemoteView(reactTag, remoteId, renderMode)`|Sets the remote view.
`startPreview()`|Starts the preview.
`stopPreview()`|Stops the preview.
`setLocalRenderMode(mode)`|Sets the local render mode.
`setRemoteRenderMode(uid, mode)`|Sets the local render mode for a user.

### Client, Channel, and Stream Methods

These methods manage the client, channel. and streams.

Method|Description
----- | -----
`setChannelProfile(profile)`|Sets the channel profile.
`joinChannel(token, channel, info, uid)`|Joins the user to the channel.
`leaveChannel()`|Leaves the channel.
`enableDualStreamMode(enabled)`|Enables dual stream mode.
`setRemoteVideoStream(uid, streamType)`|Sets the remote video stream for the user.
`createDataStream(streamId, reliable, ordered)`|Creates the data stream.
`sendStreamMessage(streamId, data)`|Sends a stream message.

### Audio Control Methods

These methods manage audio settings and controls.

Method|Description
----- | -----
`enableAudio()`|Enables audio.
`disableAudio()`|Disables audio.
`setAudioProfile(profile, scenario)`| Sets the audio profile.
`muteLocalAudioStream(muted)`|Mutes / unmutes the local audio stream.
`muteAllRemoteAudioStreams(muted)`|Mutes / unmutes all the remote audio streams.
`muteRemoteAudioStream(uid, muted)`|Mutes / unmutes the audio stream for a user.

### Audio Effect Methods

These methods manage audio effects.

Method|Description
----- | -----
`getEffectsVolume(volume)`|Retrieves the volume of sound effects.
`setEffectsVolume(volume)`|Sets the volume of sound effects.
`setVolumeOfEffect(soundId, volume)`|Sets the effect volume of a sound object.
`setLocalVoicePitch(pitch)`|Sets the local voice pitch.
`setLocalVoiceEqualizationOfBandFrequency(bandFrequency, gain)`|Sets the local voice equalization of a band frequency.
`setLocalVoiceReverbOfType(reverbType, value)`|Sets the local voice reverb type.
`playEffect(soundId, filePath, loop, pitch, pan, gain)`|Plays an effect from a file path for a sound object with loop, pitch, pan and/or gain.
`stopEffect(soundId)`|Stops the effect of a sound object.
`stopAllEffects()`|Stops all sounds effects.
`preloadEffect(soundId, filePath)`|Preload an effect from a file path, for the sound object.
`unloadEffect(soundId)`|Unload the effect from a sound object.
`pauseEffect(soundId)`|Pause the effect from a sound object.
`pauseAllEffect()`|Pause all sound effects.
`resumeEffect(soundId)`|Resume the effect from a sound object.
`resumeAllEffects()`|Resume all sound effects.

### Audio Mixing Methods

These methods manage audio mixing capabilities.

Method|Description
----- | -----
`startAudioMixing(filePath, loopback, replace, cycle)`|Starts the audio mix saving to a file path applying loopback, replace, and/or cycle.
`stopAudioMixing()`|Stop the audio mix.
`pauseAudioMixing()`|Pause the audio mix.
`resumeAudioMixing()`|Resume the audio mix.
`adjustAudioMixingVolume(volume)`|Adjust the volume of the audio mix.
`setAudioMixingPosition(pos)`|Set the position of the audio mix.
`getAudioMixingDuration(duration)`|Retrieves the audio mix duration.
`getAudioMixingCurrentPosition(currentPosition)`|Retrieves the current position of the audio mix.
`setInEarMonitoringVolume(volume)`|Sets the volume of the in ear audio.

### Audio Recording and Playback Methods

Method|Description
----- | -----
`startAudioRecording(filePath, quality)`|Starts recording audio of a specified quality, to a file path.
`stopAudioRecording()`|Stops the audio recording.
`adjustRecordingSignalVolume(volume)`|Adjusts the recording signal volume.
`adjustPlaybackSignalVolume(volume)`|Adjusts the playback signal volume.
`enableAudioVolumeIndication(interval, smooth)`|Enables the audio volume indicator based on a smooth/unsmoothed specified interval.

### Video Control Methods

These methods manage the video source and video previews.

Method|Description
----- | -----
`enableVideo()`|Enables video.
`disableVideo()`|Disables video.
`setVideoProfile(profile, swapWidthAndHeight)`|Sets the video profile based on a specified orientation.
`setVideoProfileDetail(width, height, frameRate, bitrate)`|Sets the video profile's width, height, frame rate, and bit rate.
`muteLocalVideoStream(muted)`|Mutes the local video stream.
`muteAllRemoteVideoStreams(mute)`|Mutes all remote video streams.
`muteRemoteVideoStream(uid, mute)`|Mutes the remote video stream for a user.
`setVideoQualityParameters(enabled)`|Enables ability to set video quality parameters. 
`setLocalVideoMirrorMode(mode)`|Sets the mirror mode of the local video.

## Event Listeners

- [General Event Listeners](#general-event-listeners)
- [Channel and connection Event Listeners](#channel-and-connection-event-listeners)
- [Audio Event Listeners](#audio-event-listeners)
- [Video Event Listeners](#video-event-listeners)
- [User Event Listeners](#user-event-listeners)
- [Statistic Event Listeners](#statistic-event-listeners)

### General Event Listeners

These are general listeners to check for errors, call quality, and client changes.

Listener Name|Callback Parameters|Description
----- | ----- | -----
`DidOccurWarning`|`message`, `code`|Triggers when a warning occurs.
`DidOccurError`|`message`, `code`|Triggers when an error occurs.
`RequestToken`|`nil`|Triggers when a token is requested.
`CameraFocusDidChangedToRect`|`left`, `right`, `top`, `bottom`|Triggers when the camera focus rectangle changes.
`DidRefreshRecordingServiceStatus`|`status`|Triggers when the recording service status refreshes.
`DidClientRoleChanged`|`oldRole`, `newRole`|Triggers when the client role changes.
`CameraDidReady`|`nil`|Triggers when the camera becomes ready.

### Channel and Connection Event Listeners

These event listeners detect changes to the channel or connection.

Listener Name|Callback Parameters|Description
----- | ----- | -----
`LocalDidJoinedChannel `|`uid `, `elapsed`|Triggers when a user joins the local channel.
`CurrentDidRejoinChannel`|`channel`, `uid`, `elapsed`|Triggers when a user rejoins the channel. 
`RemoteDidJoinedChannel`|`uid`, `elapsed`|Triggers when a remote user joins the channel.
`RemoteDidOfflineOfUid`|`uid`, `reasonCode`|Triggers when the remote user goes offline.
`ConnectionDidInterrupted`|`nil`|Triggers when a connection is interrupted.
`ConnectionDidLost`|`nil`|Triggers when a connection is lost.
`ConnectionDidBanned`|`nil`|Triggers when a connection is banned.

### Audio Event Listeners

These listeners detect audio event changes.

Listener Name|Callback Parameters|Description
----- | ----- | -----
`ReportAudioVolumeIndicationOfSpeakers`|`speakers`|Triggers when a speaker's audio volume indicator changes.
`DidAudioEffectFinish`|`soundId`|Triggers the audio effect of a sound finishes
`LocalAudioMixingDidFinish`|`nil`|Triggers when the local audio mix finishes.
`RemoteAudioMixingDidStart`|`nil`|Triggers when the remote audio mix starts.
`RemoteAudioMixingDidFinish`|`nil`|Triggers when the remote audio mix finishes.
`DidAudioRouteChanged`|`AgoraAudioOutputRouting`|Triggers when the audio route changes.
`FirstLocalAudioFrame`|`elapsed`|Triggers when the first local audio frame elapses.

### Video Event Listeners

These listeners detect changes to the video.

Listener Name|Callback Parameters|Description
----- | ----- | -----
`FirstLocalVideoFrame`|`width`, `height`, `elapsed`|Triggers when the first local video frame elapses.
`FirstRemoteVideoDecoded`|`width`, `height`, `elapsed`|Triggers when the first remote video is decoded.
`FirstRemoteVideoFrame`|`width`, `height`, `elapsed`|Triggers when the first remote video frame elapses.
`VideoDidStop`|`nil`|Triggers when the video stops.
`VideoSizeChanged`|`uid`, `width`, `height`, `rotation`|Triggers when a user's video size changes.

### User Event Listeners

These event listeners detect changes to user information.

Listener Name|Callback Parameters|Description
----- | ----- | -----
`DidAudioMuted`|`uid`, `isMuted`|Triggers when the user mutes/unmutes audio.
`DidVideoMuted`|`uid`, `isMuted`|Triggers when the user mutes/unmutes video. 
`DidVideoEnabled`|`uid`, `isMuted`|Triggers when the user enables/disables video.
`AudioQuality`|`uid`, `quality`, `delay`, `lost`| Triggers when the user's audio quality changes, is delayed, or is lost.
`NetworkQuality`|`uid`, `txQuality`, `rxQuality`| Triggers when the user's network quality changes.
`ReceiveStreamMessageFromUid`|`uid`, `streamId`, `message`| Triggers when receiving a stream message from a user.
`DidOccurStreamMessageErrorFromUid`|`uid`, `streamId`, `error`, `missed`, `cached`| Triggers when a stream message error from a user occurs.
`ActiveSpeaker`|`speakerUid`|Triggers when the active speaker changes.
`FirstRemoteAudioFrame`|`uid`, `elapsed`|Triggers when the first remote audio from for the user elapses. 

### Statistic Event Listeners

These event listeners detect statistical changes.

Listener Name|Callback Parameters|Description
----- | ----- | -----
`LocalVideoStats`|`sentBitrate`, `sentFrameRate`|Triggers when the local video stats change.
`RemoteVideoStats`|`uid`, `width`, `height`, `receivedBitrate`, `receivedFrameRate`, `rxStreamType`|Triggers when the user's video stats change.
`ReportRtcStats`|`duration`, `txBytes`, `rxBytes`, `txAudioKBitrate`, `rxAudioKBitrate`, `txVideoKBitrate`, `rxAudioKBitrate`, `userCount`, `rxAudioKBitrate`, `userCount`, `cpuAppUsage`, `cpuTotalUsage`|Triggers when the RTC stats report changes.
`DidLeaveChannelWithStats`|`duration`, `txBytes`, `rxBytes`, `txAudioKBitrate`, `rxAudioKBitrate`, `txVideoKBitrate`, `rxAudioKBitrate`, `userCount`, `rxAudioKBitrate`, `userCount`, `cpuAppUsage`, `cpuTotalUsage`|Triggers statistics information, when users leave the channel.