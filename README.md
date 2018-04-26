# Agora-RTC-SDK-for-React-Native

*Other languages: [简体中文](README.cn.md)*

The Agora-RTC-SDK-for-React-Native is an open-source wrapper for **[React Native](https://facebook.github.io/react-native/)** developers

This repository contains wrapper SDK and sample app, with this sample app, you can:

- Join / leave channel
- Switch camera
- Switch audio route

## Running the App
First, create a developer account at [Agora.io](https://dashboard.agora.io/signin/), and obtain an App ID. Update "App.js" with your App ID.

```
AgoraRtcEngine.createEngine('YOUR APP ID');
```

Assuming that you have [Node](https://nodejs.org/en/download/) installed, you can use `npm` in command line.

Install modules related to project:
```
npm install
```

### Android

Next, download the **Agora Video SDK** from [Agora.io SDK](https://www.agora.io/en/download/). Unzip the downloaded SDK package and copy ***.jar** under **libs** to **android\app\libs** , **arm64-v8a**/**x86**/**armeabi-v7a** under **libs** to **android\app\src\main\jniLibs**.

Finally, Open the Android project, connect to your Android device, and run the project.

Start a development server before you run this project

```
npm start
```

### iOS

Next, download the **Agora Video SDK** from [Agora.io SDK](https://www.agora.io/en/download/). Unzip the downloaded SDK package and copy the **AograRtcEngineKit.framework** under **libs** to **ios/RNapi** folder in project.

Finally, Open RNapi.xcodeproj, connect your iPhone／iPad device, setup your development signing and run.

Start a development server before you run this project

```
npm start
```

## Developer Environment Requirements

### Android
* Android Studio 2.0 or above/Visual Studio Code/Sublime Text
* Real devices (Nexus 5X or other devices)
* Android simulator is NOT supported

### iOS
* XCode 8.0 +
* Real devices (iPhone or iPad)
* iOS simulator is NOT supported

## Connect Us

- You can find full API document at [Document Center](https://docs.agora.io/en/)

## Contributions Welcome
- [React Native APIs](apis.md)
- [File an issue](https://github.com/AgoraIO/Agora-RTC-SDK-for-React-Native/issues)
- [Contribute code](contribuitions.md)

## License

The MIT License (MIT).
