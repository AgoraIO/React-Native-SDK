import {NativeModules, findNodeHandle, Platform, UIManager} from 'react-native';
import AgoraRendererView from './AgoraRendererView'
let AgoraRtcEngine = Object.create(NativeModules.AgoraRtcEngineModule);

AgoraRtcEngine.setLocalVideoView = (rendererView, renderMode) => {
    if (Platform.OS === 'ios') {
        AgoraRtcEngine.setLocalView(findNodeHandle(rendererView), renderMode);
    }
    else {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(rendererView),
            UIManager.AgoraRendererView.Commands.localVideo,
            [0, renderMode]
        );
    }
}

AgoraRtcEngine.setRemoteVideoView = (rendererView, uid, renderMode) => {
    if (Platform.OS === 'ios') {
        AgoraRtcEngine.setRemoteView(findNodeHandle(rendererView), uid, renderMode);
    }
    else {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(rendererView),
            UIManager.AgoraRendererView.Commands.remoteVideo,
            [uid, renderMode]
        );
    }
}

module.exports = AgoraRtcEngine;
