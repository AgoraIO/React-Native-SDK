/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  Button,
  StyleSheet,
  Text,
  View,
  Image,
  findNodeHandle,
  NativeEventEmitter,
  NativeModules,
  UIManager,
  DeviceEventEmitter
} from 'react-native';
import AgoraRtcEngine from './components/AgoraRtcEngineModule'
import AgoraRendererView from './components/AgoraRendererView'

const agoraKitEmitter = new NativeEventEmitter(AgoraRtcEngine);
var isSpeakerPhone = false;

export default class App extends Component {
  
// Agora Action 
  _joinChannel() {
    AgoraRtcEngine.setLocalVideoView(this._localView, AgoraRtcEngine.AgoraVideoRenderModeFit);
    AgoraRtcEngine.setVideoProfile(AgoraRtcEngine.AgoraVideoProfile120P_3, false);
    AgoraRtcEngine.startPreview();
    AgoraRtcEngine.joinChannel(null, "1224", "ARCore with RtcEngine", 0);
  }
  
  _leaveChannel() {
    AgoraRtcEngine.stopPreview();
    AgoraRtcEngine.leaveChannel();
  }

  _switchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  _switchAudio() {
    AgoraRtcEngine.setEnableSpeakerphone(isSpeakerPhone);
    isSpeakerPhone = !isSpeakerPhone;
  }
  
  render() {
    
    AgoraRtcEngine.createEngine('0c0b4b61adf94de1befd7cdd78a50444');

    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.enableAudio();
    AgoraRtcEngine.setVideoProfileDetail(360, 640, 15, 300);
    AgoraRtcEngine.setChannelProfile(AgoraRtcEngine.AgoraChannelProfileCommunication);
    
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
            title="AudioRoute Changed"
            color="#841584"
          />
      </View>

    </View>
    );
  }

  // Aogra CallBack
  remoteDidJoineChannelNoti = agoraKitEmitter.addListener(
    'RemoteDidJoinedChannel',
    (notify) => {
      AgoraRtcEngine.setRemoteVideoView(this._remoteView, notify.uid, AgoraRtcEngine.AgoraVideoRenderModeFit);
    }
  );

  componentWillUnmount() {
    remoteDidJoineChannelNoti.remove()
  }
  
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  thumbnail: {
    width: 53,
    height: 81,
  },
});