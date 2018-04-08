# Agora-RTC-SDK-for-React-Native

*其他语言：[English](README.md)*

这个开源示例项目是 Agora 视频通话 SDK 对于 **[React Native](https://facebook.github.io/react-native/)** 的封装实现。

在这个开源项目包含了封装代码以及一个简单的示例程序，示例程序包含了以下功能：

- 加入通话和离开通话；
- 切换摄像头；
- 外放和听筒切换；

## 运行示例程序
首先在 [Agora.io 注册](https://dashboard.agora.io/cn/signup/) 注册账号，并创建自己的测试项目，获取到 AppID。将 AppID 填写进 App.js

```
AgoraRtcEngine.createEngine('YOUR APP ID');
```

假设你的机器上已经安装了 [Node](https://nodejs.org/en/download/) 并且可以使用 `npm` 这样的命令行工具。

安装项目所需的依赖模块：
```
npm install
```

### Android
然后在 [Agora.io SDK](https://www.agora.io/cn/download/) 下载 **视频通话 + 直播 SDK**，解压后将其中的 **libs** 文件夹下的 ***.jar** 复制到本项目的 **android\app\libs** 下，其中的 **libs** 文件夹下的 **arm64-v8a**/**x86**/**armeabi-v7a** 复制到本项目的 **android/app/src/main/jniLibs** 下。

最后打开该项目，连接 Android 测试设备，即可运行项目。

运行之前需要启动开发服务环境：
```
npm start
```

### iOS
然后在 [Agora.io SDK](https://www.agora.io/cn/download/) 下载 **视频通话 + 直播 SDK**，解压后将其中的 **libs** 文件夹下的 **AgoraRtcEngineKit.framework** 复制到本项目的 **ios/RNapi** 文件夹下。

最后使用 XCode 打开 RNapi.xcodeproj，连接 iPhone／iPad 测试设备，设置有效的开发者签名后即可运行。

运行之前需要启动开发服务环境：
```
npm start
```

## 运行环境

### Android
* Visual Studio Code/Sublime Text
* Android 真机设备
* 不支持模拟器

### iOS
* XCode 8.0 +
* iOS 真机设备
* 不支持模拟器

## 联系我们

- 完整的 API 文档见 [文档中心](https://docs.agora.io/cn/)
- 如果在集成中遇到问题，你可以到 [开发者社区](https://dev.agora.io/cn/) 提问
- 如果有售前咨询问题，可以拨打 400 632 6626，或加入官方Q群 12742516 提问
- 如果需要售后技术支持，你可以在 [Agora Dashboard](https://dashboard.agora.io) 提交工单
- 如果发现了示例代码的bug，欢迎提交 [issue](https://github.com/AgoraIO/Agora-RTC-SDK-for-React-Native/issues)

## 代码许可

The MIT License (MIT).
