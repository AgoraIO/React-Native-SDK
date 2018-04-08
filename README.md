# Agora-RTC-SDK-for-React-Native

*其他语言版本： [简体中文](README.cn.md)*

The Agora-RTC-SDK-for-React-Native Sample App is an open-source demo that will help you get 1 to 1 video chat integrated directly into your iOS/Android applications using **the React Native Api Of Agora Video SDK**.

With this sample app, you can:

- Join / leave channel
- Switch Camera
- Switch speaker

## Running the App
First, create a developer account at [Agora.io](https://dashboard.agora.io/signin/), and obtain an App ID. Update "App.js" with your App ID.

```
AgoraRtcEngine.createEngine('YOUR APPID');
```

And Install Node in Terminal

```
brew install node
```

Install node_modules

```
npm install
```

### Android

Start modules to configurate and lanuch a local server 

```
npm start
```

Next, download the **Agora Video SDK** from [Agora.io SDK](https://www.agora.io/en/blog/download/). Unzip the downloaded SDK package and copy the **libs/agora-rtc-sdk.jar** to the "android\app\libs" folder in project, then copy the corresponding platform's so file to the project's "android\app\src\main\jniLibs" folder。

Finally, Open the android project, connect to your Android device, and run the project.

### iOS

Start modules to configurate and lanuch a local server 

```
npm start
```

Next, download the **Agora Video SDK** from [Agora.io SDK](https://www.agora.io/en/blog/download/). Unzip the downloaded SDK package and copy the **libs/AograRtcEngineKit.framework** to the "ios/RNapi/" folder in project.

Finally, Open RNapi.xcodeproj, connect your iPhone／iPad device, setup your development signing and run.

## Developer Environment Requirements

### Android
* Android Studio
* Real devices (Android)
* Android simulator is NOT supported

### iOS
* XCode 8.0 +
* Real devices (iPhone or iPad)
* iOS simulator is NOT supported

## Connect Us

- You can find full API document at [Document Center](https://docs.agora.io/en/)
- You can file bugs about this demo at [issue](https://github.com/AgoraIO/OpenLive-Voice-Only-iOS/issues)

## License

The MIT License (MIT).
