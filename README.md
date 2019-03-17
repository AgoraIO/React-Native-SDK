# Agora RTC SDK for React Native (Deprecated)
**Please refer to [here](https://github.com/AgoraIO-Community/Agora-RN-Quickstart) for a new QuickStart. This repo is about to be deprecated. The new one has NPM support and is more suited to latest React Native development.**

*Read this in other languages: [中文](README.zh.md)*

**There's another React Native Repo for Agora SDK maintained by community developers which you can find [here](https://github.com/syanbo/react-native-agora)**


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
  - A code editor such as Sublime Text
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

## Resources
- A detailed code walkthrough for this sample is available in [Steps to Create this Sample](./guide.md).
* [Agora React Native API Reference](apis.md).
* Complete API documentation is available at the [Document Center](https://docs.agora.io/en/).
* You can file bugs about this sample [here](https://github.com/AgoraIO/Agora-RTC-SDK-for-React-Native/issues).
* Learn how to [contribute code](contributions.md) to the sample project.

## License
This software is under the MIT License (MIT). [View the license](LICENSE.md).
