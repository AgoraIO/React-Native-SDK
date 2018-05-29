# Agora RTC SDK for React Native (Beta)


This tutorial enables you to quickly get started with using a sample app to develop requests to the Agora RTC SDK through the [React Native](https://facebook.github.io/react-native/) wrapper for [Android](https://docs.agora.io/en/2.2/product/Voice/API%20Reference/communication_android_audio?platform=Android) / [iOS](https://docs.agora.io/en/2.2/product/Voice/API%20Reference/communication_ios_audio?platform=iOS).

This sample app demonstrates how to:

- [Render the View](#render-the-view)
- [Join a Channel](#join-a-channel)
- [Leave a Channel](#leave-a-channel)
- [Switch Camera](#switch-camera)
- [Switch Audio Route](#switch-audio-route)
- [Add Event Listener](#add-event-listener)

## Prerequisites
- Agora.io Developer Account
- Node.js 6.9.1+
- Android development
	- Code Editor such as Android Studio 2.0+, Visual Studio Code, Sublime Text
	- Physical Android device (Android Simulator is not supported)

- iOS development
	- Xcode 8.0+
	- Physical iPhone or iPad device (iOS Simulator is not supported)

## Quick Start
This section shows you how to prepare and build the Agora React Native wrapper for the sample app.

### Create an Account and Obtain an App ID
In order to build and run the sample application you must obtain an App ID: 

1. Create a developer account at [agora.io](https://dashboard.agora.io/signin/). Once you finish the signup process, you will be redirected to the Dashboard.
2. Navigate in the Dashboard tree on the left to **Projects** > **Project List**.
3. Copy the App ID that you obtained from the Dashboard into a text file. You will use this when you launch the app.

### Update and Run the Sample Application 

1. Open the `App.js` file. In the `render()` method, update `YOUR APP ID` with your App ID.

	``` JavaScript
	render() {
		
		AgoraRtcEngine.createEngine('YOUR APP ID');
		
		...
	}
	```

1. In the Terminal app, run the `install` command in your project directory. This command generates the project files for the Android and iOS sample apps.

	```
	npm install
	```

2. Add the appropriate SDK, connect the device, and run the project.

	**Android**

	1. Download the [Agora Video SDK](https://www.agora.io/en/download/). Unzip the downloaded SDK package and copy:

		- The `libs/agora-rtc-sdk.jar` file into the `android/app/libs` folder.
		- The `libs/arm64-v8a/x86/armeabi-v7a` folder into the `android/app/src/main/jniLibs` folder.

	2. Open the the project folder `android` in Android Studio and connect the Android device.
	
	3. Sync and run the project.

	**iOS**

	1. Download the [Agora Video SDK](https://www.agora.io/en/download/). Unzip the downloaded SDK package and copy the `libs/AograRtcEngineKit.framework` file into the `ios/RNapi` folder.

	2. Open `RNapi.xcodeproj` and connect your iPhone／iPad device.
	3. Apply a valid provisioning profile and run the project.


## Steps to Create the Sample

- [Render the View](#render-the-view)
- [Join a Channel](#join-a-channel)
- [Leave a Channel](#leave-a-channel)
- [Switch Camera](#switch-camera)
- [Switch Audio Route](#switch-audio-route)
- [Add Event Listener](#add-event-listener)

The `App` class extension in the `App.js` file, contains the relevant Agora SDK code for the React Native Android / iOS sample app.

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

The `render()` method generates the UI elements within its `return` statement. Ensure that any Agora engine settings needed prior to creating the view are set before the `return`.

``` JavaScript  
  render() {
    ...
    return (
    	...
    );
  }
```    

#### Create the RTC Engine

Before generating the view, create the Agora RTC engine using `AgoraRtcEngine.createEngine()`. The `YOUR APP ID` is the app ID used in the [Quick Start](#quick-start).

``` JavaScript  
	AgoraRtcEngine.createEngine('YOUR APP ID');
```

#### Enable Audio and Video

Once the Agora engine is created, enable the video `AgoraRtcEngine.enableVideo()` and enable the audio `AgoraRtcEngine.enableAudio()`.

``` JavaScript  
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.enableAudio();
```

#### Set Video and Channel Profiles

Set the video profile `AgoraRtcEngine.setVideoProfileDetail()` and channel profile `AgoraRtcEngine.setChannelProfile()`. The sample app sets the video profile to:

- width: 360
- height: 640
- frame rate: 15
- bit rate: 300

You can refer to the [React Native API doc](apis.md) to learn more.


``` JavaScript  
    AgoraRtcEngine.setVideoProfileDetail(360, 640, 15, 300);
    AgoraRtcEngine.setChannelProfile(AgoraRtcEngine.AgoraChannelProfileCommunication);

```
#### Create the View

The `return` is used to display the view for the sample app. The `AgoraRendererView` elements are the UI elements used to by Agora to display the audio / video. The sample app creates two `AgoraRendererView ` elements, the `_localView` and `_remoteView`.
    
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

The remaining portion of the `return` adds UI button elements, which allow the user to [join the channel](#join-a-channel), [leave the channel](#leave-a-channel), [switch their camera](#switch-camera), and [switch the audio route](#switch-audio-route).

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

The `join()` method begins with setting the local video view `AgoraRtcEngine.setLocalVideoView()`. 

The sample app applies the local video view to the `_localView` UI element created in the [`render()`](#render-the-view) method and requests that the video mode fit within the `_localView`.

``` JavaScript  
    AgoraRtcEngine.setLocalVideoView(this._localView, AgoraRtcEngine.AgoraVideoRenderModeFit);    
```

The video profile `AgoraRtcEngine.setVideoProfile()` is set to the default Agora profile, without changing its orientation.

You can refer to the [React Native API doc](apis.md) to learn more about `setVideoProfile()`.

``` JavaScript
AgoraRtcEngine.setVideoProfile(AgoraRtcEngine.AgoraVideoProfileDEFAULT, false);

```

The `join()` method completes with starting the Agora SDK preview `AgoraRtcEngine.startPreview()` and joining the channel `AgoraRtcEngine.joinChannel()`.
      
``` JavaScript
    AgoraRtcEngine.startPreview();
    AgoraRtcEngine.joinChannel(null, "rnchannel01", "React Native for Agora RTC SDK", 0);  
```

The `joinChannel` parameters set:

- `token` to `null`. The `token` will be set by the Agora Engine once the channel is joined.
- `channel` name to `rnchannel01 `.
- `info` about the channel to `React Native for Agora RTC SDK`.
- `uid` to `0`, which a generic value for a user. 

### Leave a Channel

The sample app applies the `_leaveChannel()` method which invokes Agora's stop preview `AgoraRtcEngine.stopPreview()` method and leave channel `AgoraRtcEngine.leaveChannel()` method.

**Note:** `leaveChannel()` does not automatically stop the preview, so `stopPreview()` must be called first.

``` JavaScript  
  _leaveChannel() {
    AgoraRtcEngine.stopPreview();
    AgoraRtcEngine.leaveChannel();
  }

```

### Switch Camera

The sample app applies the `_switchCamera()` method to invoke the Agora SDK engine to switch the camera using `AgoraRtcEngine.switchCamera()`.

``` JavaScript  
  _switchCamera() {
    AgoraRtcEngine.switchCamera();
  }

```

### Switch Audio Route

The sample app uses the `_switchAudio()` method to invoke the Agora SDK engine to turn on / off the speakerphone using`AgoraRtcEngine.setEnableSpeakerphone()`.

**Note:** `isSpeakerPhone` must be changed after calling `setEnableSpeakerphone` since it is used globally to detect if the user is in speakerphone mode.

``` JavaScript  
  _switchAudio() {
    AgoraRtcEngine.setEnableSpeakerphone(isSpeakerPhone);
    isSpeakerPhone = !isSpeakerPhone;
  }
  
```

### Add Event Listener

The sample app adds an event listener `remoteDidJoineChannelNoti` to detect when a remote user joins the channel using `agoraKitEmitter.addListener()`.

The event listener name is `RemoteDidJoinedChannel`. When the `RemoteDidJoinedChannel` listener is triggered, it:

- Adds the remote video view to the `_remoteView` UI element created in the [`render()`](#render-the-view) method.
- Applies the remote video view for the user `notify.uid`.
- Requests that the video mode to fit within the `_remoteView`.


``` JavaScript  
  remoteDidJoineChannelNoti = agoraKitEmitter.addListener(
    'RemoteDidJoinedChannel',
    (notify) => {
      AgoraRtcEngine.setRemoteVideoView(this._remoteView, notify.uid, AgoraRtcEngine.AgoraVideoRenderModeFit);
    }
  );

```

Remove the `remoteDidJoineChannelNoti` event listener is once the React Native view is destroyed by calling the `remoteDidJoineChannelNoti.remove()` method.

``` JavaScript  
  componentWillUnmount() {
    remoteDidJoineChannelNoti.remove()
  }
```

You can refer to the [React Native API doc](apis.md) to learn more about Agora event listeners for React Native.

## Resources
* [Agora React Native API Reference](apis.md).
* Complete API documentation is available at the [Document Center](https://docs.agora.io/en/).
* You can file bugs about this sample [here](https://github.com/AgoraIO/Agora-RTC-SDK-for-React-Native/issues).
* Learn how to [contribute code](contribuitions.md) to the sample project.

## License
This software is under the MIT License (MIT). [View the license](LICENSE.md).