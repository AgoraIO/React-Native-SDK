# Agora RTC SDK for React Native (Beta)

## Steps to Create the Sample

- [Render the View](#render-the-view)
- [Join a Channel](#join-a-channel)
- [Leave a Channel](#leave-a-channel)
- [Switch Camera](#switch-camera)
- [Switch Audio Route](#switch-audio-route)
- [Add Event Listener](#add-event-listener)

The `App` class extension in the `App.js` file, contains the relevant Agora SDK code for the React Native Android/iOS sample app.

``` JavaScript
export default class App extends Component {
    ...
}
```

### Render the View

- [Create the RTC Engine](#create-the-rtc-engine)
- [Enable Audio and Video](#enable-audio-and-video)
- [Set Video and Channel Profiles](#set-video-and-channel-profiles)
- [Create the View](#create-the-view)

The `render()` method generates the UI elements within its `return` statement. Define any required Agora engine settings in the code that precedes `return`.

``` JavaScript  
  render() {
    ...
    return (
        ...
    );
  }
```    

#### Create the RTC Engine

Before rendering the view, create the Agora RTC engine, as shown here.

``` JavaScript  
    AgoraRtcEngine.createEngine('YOUR APP ID');
```

The `YOUR APP ID` is the same app ID used in the [Quick Start](#quick-start).

#### Enable Audio and Video

After creating the RTC Engine, enable the video and audio, as shown here.

``` JavaScript  
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.enableAudio();
```

#### Set Video and Channel Profiles

Set the video and channel profile, as shown here.

``` JavaScript  
    AgoraRtcEngine.setVideoProfileDetail(360, 640, 15, 300);
    AgoraRtcEngine.setChannelProfile(AgoraRtcEngine.AgoraChannelProfileCommunication);

```

The sample app sets the following values for the video profile:
- Width: `360`
- Height: `640`
- Frame rate: `15`
- Bitrate: `300`

To learn more, see the [React Native API doc](apis.md).

#### Create the View

The `return()` method displays the view for the sample app. The `AgoraRendererView` elements are the UI elements Agora uses to display the audio/video. The sample app creates two `AgoraRendererView ` elements, the `_localView` and `_remoteView`.

``` JavaScript  
    return (
    <View style = {styles.container} >

      <AgoraRendererView
        ref={component => this._localView = component}
        style = {{width: 360, height: 240}}
      />

      <AgoraRendererView
        ref={component => this._remoteView = component}
        style = {{width: 360, height: 240}}
      />

      ...

    </View>
    );
```

The remaining portion of `return()` adds UI button elements, which enable the user to [join the channel](#join-a-channel), [leave the channel](#leave-a-channel), [switch their camera](#switch-camera), and [switch the audio route](#switch-audio-route).

``` JavaScript  
    return (
    <View style = {styles.container} >

      ...

      <View style={{flexDirection: 'row'}}>
          <Button style = {{flex: 1}}
            onPress={this._joinChannel.bind(this)}
            title="Join Channel"
            style={{width:180, float:"left", backgroundColor:"rgb(0,0,0)"}}
            color="#841584"
          />
          <Button style = {{flex: 1}}
            onPress={this._leaveChannel.bind(this)}
            title="Leave Channel"
            color="#841584"
            style={{width:180, float:"left"}}
          />
      </View>

      <View style={{flexDirection: 'row'}}>
          <Button
            onPress={this._switchCamera.bind(this)}
            title="Switch Camera"
            color="#841584"
          />
          <Button
            onPress={this._switchAudio.bind(this)}
            title="Switch Audio Route"
            color="#841584"
          />
      </View>

    </View>
    );
```

### Join a Channel

The sample app uses the `_joinChannel()` method to join the user to a specific channel.

``` JavaScript  
  _joinChannel() {
      ...
  }
```

Within the `_joinChannel()` method, the following methods perform additional tasks:

`AgoraRtcEngine.setLocalVideoView()` sets the local video view.

The sample app applies the local video view to the `_localView` UI element created in the [`render()`](#render-the-view) method, and requests that the video mode fit within the `_localView`.

``` JavaScript  
    AgoraRtcEngine.setLocalVideoView(this._localView, AgoraRtcEngine.AgoraVideoRenderModeFit);    
```

`AgoraRtcEngine.setVideoProfile()` sets the video profile to the default Agora profile without changing its orientation. To learn more about `setVideoProfile()`, see the [React Native API doc](apis.md) .

``` JavaScript
AgoraRtcEngine.setVideoProfile(AgoraRtcEngine.AgoraVideoProfileDEFAULT, false);
```

`AgoraRtcEngine.startPreview()` starts the Agora SDK preview and `AgoraRtcEngine.joinChannel()` joins the channel.

``` JavaScript
    AgoraRtcEngine.startPreview();
    AgoraRtcEngine.joinChannel(null, "rnchannel01", "React Native for Agora RTC SDK", 0);  
```

The `joinChannel` parameters set:
- `token` to `null`. After the channel has been joined, the Agora Engine sets `token` to a new value.
- `channel` name to `rnchannel01 `.
- `info` about the channel to `React Native for Agora RTC SDK`.
- `uid` to `0`, a generic user ID value.

### Leave a Channel

The sample app applies the `_leaveChannel()` method, which invokes `AgoraRtcEngine.stopPreview()` method and `AgoraRtcEngine.leaveChannel()` method.

**Note:** `_leaveChannel()` does not automatically stop the preview. Therefore, `stopPreview()` must be called first.

``` JavaScript  
  _leaveChannel() {
    AgoraRtcEngine.stopPreview();
    AgoraRtcEngine.leaveChannel();
  }
```

### Switch the Camera

The sample app applies the `_switchCamera()` method, which invokes `AgoraRtcEngine.switchCamera()` to switch the camera.

``` JavaScript  
  _switchCamera() {
    AgoraRtcEngine.switchCamera();
  }
```

### Switch Audio Route

The sample app uses the `_switchAudio()` method, which invokes `AgoraRtcEngine.setEnableSpeakerphone()` to turn the speakerphone on or off.

**Note:** `isSpeakerPhone` must be changed after calling `setEnableSpeakerphone`, since it is used globally to detect if the user is in speakerphone mode.

``` JavaScript  
  _switchAudio() {
    AgoraRtcEngine.setEnableSpeakerphone(isSpeakerPhone);
    isSpeakerPhone = !isSpeakerPhone;
  }

```

### Add Event Listener

The sample app uses `agoraKitEmitter.addListener()` to add a `remoteDidJoineChannelNoti` event listener to detect when a remote user joins the channel.

The name of the event listener is `RemoteDidJoinedChannel`. When this listener is triggered, it does the following:
- Adds the remote video view to the `_remoteView` UI element created by the [`render()`](#render-the-view) method.
- Applies the remote video view for the user, `notify.uid`.
- Requests that the video mode fit within the `_remoteView`.


``` JavaScript  
  remoteDidJoineChannelNoti = agoraKitEmitter.addListener(
    'RemoteDidJoinedChannel',
    (notify) => {
      AgoraRtcEngine.setRemoteVideoView(this._remoteView, notify.uid, AgoraRtcEngine.AgoraVideoRenderModeFit);
    }
  );

```

After the React Native view is destroyed, remove the `remoteDidJoineChannelNoti` event listener by calling `remoteDidJoineChannelNoti.remove()`.

``` JavaScript  
  componentWillUnmount() {
    remoteDidJoineChannelNoti.remove()
  }
```

To learn more about Agora event listeners for React Native, see the [React Native API doc](apis.md).