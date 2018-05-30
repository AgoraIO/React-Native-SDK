# Agora RTC SDK for React Native (Beta)


This tutorial shows you how to quickly start developing requests with the Agora RTC SDK for [React Native](https://facebook.github.io/react-native/) wrapper for [Android](https://docs.agora.io/en/2.2/product/Voice/API%20Reference/communication_android_audio?platform=Android)/[iOS](https://docs.agora.io/en/2.2/product/Voice/API%20Reference/communication_ios_audio?platform=iOS).

This tutorial demonstrates these basic Agora SDK features:

- [Render the View](#render-the-view)
- [Join a Channel](#join-a-channel)
- [Leave a Channel](#leave-a-channel)
- [Switch Camera](#switch-camera)
- [Switch Audio Route](#switch-audio-route)
- [Add Event Listener](#add-event-listener)

## Prerequisites
- Agora.io Developer Account
- Node.js 6.9.1+
- For Android development:
  - Android Studio 2.0+
  - A code editor such as Visual Studio Code or Sublime Text
  - Physical Android device (Android Simulator is not supported)

- For iOS development:
  - Xcode 8.0+
  - A physical iPhone or iPad device (iOS Simulator is not supported)

## Quick Start
This section shows you how to prepare and build the Agora React Native wrapper for the sample app.

### Create an Account and Obtain an App ID

1. Create a developer account at [agora.io](https://dashboard.agora.io/signin/).
2. In the Agora.io Dashboard that appears, click **Projects** > **Project List** in the left navigation.
3. Copy the **App ID** from the Dashboard to a text file. You will use this ID later when you launch the app.

### Update and Run the Sample Application

1. Open the `App.js` file. In the `render()` method, update `YOUR APP ID` with your App ID.

    ``` JavaScript
    render() {

        AgoraRtcEngine.createEngine('YOUR APP ID');

        ...
    }
    ```

1. Using Terminal or Command Prompt, `cd` to your project directory and enter ` npm install`. This command generates the project files for the Android or iOS sample apps.

2. Add the appropriate SDK, connect the device, and run the project as described here:

    **Android**

    Download the [Agora Video SDK](https://www.agora.io/en/download/).

    Un-compress the downloaded SDK package and copy the `libs/agora-rtc-sdk.jar` file into the `android/app/libs` folder.

    Then copy the `libs/arm64-v8a/x86/armeabi-v7a` folder into the `android/app/src/main/jniLibs` folder.

    In Android Studio, open the `android` project folder and connect the Android device.

    Sync and run the project.

    **iOS**

    Download the [Agora Video SDK](https://www.agora.io/en/download/).

    Un-compress the downloaded SDK package and copy the `libs/AograRtcEngineKit.framework` file into the `ios/RNapi` folder.

    Open `RNapi.xcodeproj` and connect your iPhone/iPad device.

    Apply a valid provisioning profile and run the project.


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

## Resources
* [Agora React Native API Reference](apis.md).
* Complete API documentation is available at the [Document Center](https://docs.agora.io/en/).
* You can file bugs about this sample [here](https://github.com/AgoraIO/Agora-RTC-SDK-for-React-Native/issues).
* Learn how to [contribute code](contributions.md) to the sample project.

## License
This software is under the MIT License (MIT). [View the license](LICENSE.md).
