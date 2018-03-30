package com.rnapi;

import android.util.Log;
import android.view.SurfaceView;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;

import java.lang.ref.WeakReference;
import java.util.Map;

import javax.annotation.Nullable;

import io.agora.rtc.RtcEngine;

public class SurfaceViewManager extends SimpleViewManager<SurfaceView> {
    public static final String REACT_CLASS = "AgoraRendererView";

    public static final int COMMAND_SET_LOCAL_VIDEO = 1;
    public static final int COMMAND_SET_REMOTE_VIDEO = 2;

    private WeakReference<AgoraModule> mAgoraModule;

    public SurfaceViewManager(AgoraModule agoraModule) {
        mAgoraModule = new WeakReference<>(agoraModule);
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    protected SurfaceView createViewInstance(ThemedReactContext reactContext) {
        SurfaceView surfaceView = RtcEngine.CreateRendererView(reactContext);
        surfaceView.setZOrderOnTop(true);
        surfaceView.setZOrderMediaOverlay(true);
        return surfaceView;
    }

    @Nullable
    @Override
    public Map<String, Integer> getCommandsMap() {
        Log.d("React", " View manager getCommandsMap:");
        return MapBuilder.of(
                "localVideo",
                COMMAND_SET_LOCAL_VIDEO,
                "remoteVideo",
                COMMAND_SET_REMOTE_VIDEO);
    }

    @Override
    public void receiveCommand(SurfaceView root, int commandId, @Nullable ReadableArray args) {
        switch (commandId) {
            case COMMAND_SET_LOCAL_VIDEO: {
                mAgoraModule.get().setupLocalVideo(root, args.getInt(0), args.getInt(1));
                return;
            }
            case COMMAND_SET_REMOTE_VIDEO: {
                mAgoraModule.get().setupRemoteVideo(root, args.getInt(0), args.getInt(1));
                return;
            }

            default:
                throw new IllegalArgumentException(String.format(
                        "Unsupported command %d received by %s.",
                        commandId,
                        getClass().getSimpleName()));
        }
    }
}
