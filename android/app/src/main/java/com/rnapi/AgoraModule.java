package com.rnapi;

import android.graphics.Rect;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.SurfaceView;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.google.gson.Gson;

import org.json.JSONException;

import java.lang.ref.WeakReference;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;
import io.agora.rtc.live.LiveTranscoding;
import io.agora.rtc.video.VideoCanvas;

import static com.rnapi.ConvertUtils.convertMapToJson;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_125;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_16K;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_1K;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_250;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_2K;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_31;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_4K;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_500;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_62;
import static io.agora.rtc.Constants.AUDIO_EQUALIZATION_BAND_8K;
import static io.agora.rtc.Constants.AUDIO_PROFILE_DEFAULT;
import static io.agora.rtc.Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY;
import static io.agora.rtc.Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO;
import static io.agora.rtc.Constants.AUDIO_PROFILE_MUSIC_STANDARD;
import static io.agora.rtc.Constants.AUDIO_PROFILE_MUSIC_STANDARD_STEREO;
import static io.agora.rtc.Constants.AUDIO_PROFILE_SPEECH_STANDARD;
import static io.agora.rtc.Constants.AUDIO_RECORDING_QUALITY_HIGH;
import static io.agora.rtc.Constants.AUDIO_RECORDING_QUALITY_LOW;
import static io.agora.rtc.Constants.AUDIO_RECORDING_QUALITY_MEDIUM;
import static io.agora.rtc.Constants.AUDIO_REVERB_DRY_LEVEL;
import static io.agora.rtc.Constants.AUDIO_REVERB_ROOM_SIZE;
import static io.agora.rtc.Constants.AUDIO_REVERB_STRENGTH;
import static io.agora.rtc.Constants.AUDIO_REVERB_WET_DELAY;
import static io.agora.rtc.Constants.AUDIO_REVERB_WET_LEVEL;
import static io.agora.rtc.Constants.AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT;
import static io.agora.rtc.Constants.AUDIO_SCENARIO_CHATROOM_GAMING;
import static io.agora.rtc.Constants.AUDIO_SCENARIO_DEFAULT;
import static io.agora.rtc.Constants.AUDIO_SCENARIO_EDUCATION;
import static io.agora.rtc.Constants.AUDIO_SCENARIO_GAME_STREAMING;
import static io.agora.rtc.Constants.AUDIO_SCENARIO_SHOWROOM;
import static io.agora.rtc.Constants.CHANNEL_PROFILE_COMMUNICATION;
import static io.agora.rtc.Constants.CHANNEL_PROFILE_GAME;
import static io.agora.rtc.Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
import static io.agora.rtc.Constants.RENDER_MODE_ADAPTIVE;
import static io.agora.rtc.Constants.RENDER_MODE_FIT;
import static io.agora.rtc.Constants.RENDER_MODE_HIDDEN;
import static io.agora.rtc.Constants.VIDEO_MIRROR_MODE_AUTO;
import static io.agora.rtc.Constants.VIDEO_MIRROR_MODE_DISABLED;
import static io.agora.rtc.Constants.VIDEO_MIRROR_MODE_ENABLED;
import static io.agora.rtc.Constants.VIDEO_PROFILE_120P;
import static io.agora.rtc.Constants.VIDEO_PROFILE_120P_3;
import static io.agora.rtc.Constants.VIDEO_PROFILE_180P;
import static io.agora.rtc.Constants.VIDEO_PROFILE_180P_3;
import static io.agora.rtc.Constants.VIDEO_PROFILE_180P_4;
import static io.agora.rtc.Constants.VIDEO_PROFILE_240P;
import static io.agora.rtc.Constants.VIDEO_PROFILE_240P_3;
import static io.agora.rtc.Constants.VIDEO_PROFILE_240P_4;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_10;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_11;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_3;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_4;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_6;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_7;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_8;
import static io.agora.rtc.Constants.VIDEO_PROFILE_360P_9;
import static io.agora.rtc.Constants.VIDEO_PROFILE_480P;
import static io.agora.rtc.Constants.VIDEO_PROFILE_480P_10;
import static io.agora.rtc.Constants.VIDEO_PROFILE_480P_3;
import static io.agora.rtc.Constants.VIDEO_PROFILE_480P_4;
import static io.agora.rtc.Constants.VIDEO_PROFILE_480P_6;
import static io.agora.rtc.Constants.VIDEO_PROFILE_480P_8;
import static io.agora.rtc.Constants.VIDEO_PROFILE_480P_9;
import static io.agora.rtc.Constants.VIDEO_PROFILE_720P;
import static io.agora.rtc.Constants.VIDEO_PROFILE_720P_3;
import static io.agora.rtc.Constants.VIDEO_PROFILE_720P_5;
import static io.agora.rtc.Constants.VIDEO_PROFILE_720P_6;
import static io.agora.rtc.Constants.VIDEO_PROFILE_DEFAULT;
import static io.agora.rtc.Constants.VIDEO_STREAM_HIGH;
import static io.agora.rtc.Constants.VIDEO_STREAM_LOW;

public class AgoraModule extends ReactContextBaseJavaModule {
    private final static String TAG = AgoraModule.class.getSimpleName();

    private static final String AGORA_CHANNEL_PROFILE_COMMUNICATION = "AgoraChannelProfileCommunication";
    private static final String AGORA_CHANNEL_PROFILE_LIVEBROADCASTING = "AgoraChannelProfileLiveBroadcasting";
    private static final String AGORA_CHANNEL_PROFILE_GAME = "AgoraChannelProfileGame";

    private static final String AGORA_VIDEO_RENDER_MODE_HIDDEN = "AgoraVideoRenderModeHidden";
    private static final String AGORA_VIDEO_RENDER_MODE_FIT = "AgoraVideoRenderModeFit";
    private static final String AGORA_VIDEO_RENDER_MODE_ADAPTIVE = "AgoraVideoRenderModeAdaptive";

    private static final String AGORA_AUDIO_PROFILE_DEFAULT = "AgoraAudioProfileDefault";
    private static final String AGORA_AUDIO_PROFILE_SPEECH_STANDARD = "AgoraAudioProfileSpeechStandard";
    private static final String AGORA_AUDIO_PROFILE_MUSIC_STANDARD = "AgoraAudioProfileMusicStandard";
    private static final String AGORA_AUDIO_PROFILE_MUSIC_STANDARD_STEREO = "AgoraAudioProfileMusicStandardStereo";
    private static final String AGORA_AUDIO_PROFILE_MUSIC_HIGH_QUALITY = "AgoraAudioProfileMusicHighQuality";
    private static final String AGORA_AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO = "AgoraAudioProfileMusicHighQualityStereo";

    private static final String AGORA_AUDIO_SCENARIO_DEFAULT = "AgoraAudioScenarioDefault";
    private static final String AGORA_AUDIO_SCENARIO_CHAT_ROOM_GAMING = "AgoraAudioScenarioChatRoomGaming";
    private static final String AGORA_AUDIO_SCENARIO_CHAT_ROOM_ENTERTAINMENT = "AgoraAudioScenarioChatRoomEntertainment";
    private static final String AGORA_AUDIO_SCENARIO_EDUCATION = "AgoraAudioScenarioEducation";
    private static final String AGORA_AUDIO_SCENARIO_GAME_STREAMING = "AgoraAudioScenarioGameStreaming";
    private static final String AGORA_AUDIO_SCENARIO_SHOW_ROOM = "AgoraAudioScenarioShowRoom";

    private static final String AGORA_VIDEO_PROFILE_120P = "AgoraVideoProfile120P";
    private static final String AGORA_VIDEO_PROFILE_120P_3 = "AgoraVideoProfile120P_3";
    private static final String AGORA_VIDEO_PROFILE_180P = "AgoraVideoProfile180P";
    private static final String AGORA_VIDEO_PROFILE_180P_3 = "AgoraVideoProfile180P_3";
    private static final String AGORA_VIDEO_PROFILE_180P_4 = "AgoraVideoProfile180P_4";
    private static final String AGORA_VIDEO_PROFILE_240P = "AgoraVideoProfile240P";
    private static final String AGORA_VIDEO_PROFILE_240P_3 = "AgoraVideoProfile240P_3";
    private static final String AGORA_VIDEO_PROFILE_240P_4 = "AgoraVideoProfile240P_4";
    private static final String AGORA_VIDEO_PROFILE_360P = "AgoraVideoProfile360P";
    private static final String AGORA_VIDEO_PROFILE_360P_3 = "AgoraVideoProfile360P_3";
    private static final String AGORA_VIDEO_PROFILE_360P_4 = "AgoraVideoProfile360P_4";
    private static final String AGORA_VIDEO_PROFILE_360P_6 = "AgoraVideoProfile360P_6";
    private static final String AGORA_VIDEO_PROFILE_360P_7 = "AgoraVideoProfile360P_7";
    private static final String AGORA_VIDEO_PROFILE_360P_8 = "AgoraVideoProfile360P_8";
    private static final String AGORA_VIDEO_PROFILE_360P_9 = "AgoraVideoProfile360P_9";
    private static final String AGORA_VIDEO_PROFILE_360P_10 = "AgoraVideoProfile360P_10";
    private static final String AGORA_VIDEO_PROFILE_360P_11 = "AgoraVideoProfile360P_11";
    private static final String AGORA_VIDEO_PROFILE_480P = "AgoraVideoProfile480P";
    private static final String AGORA_VIDEO_PROFILE_480P_3 = "AgoraVideoProfile480P_3";
    private static final String AGORA_VIDEO_PROFILE_480P_4 = "AgoraVideoProfile480P_4";
    private static final String AGORA_VIDEO_PROFILE_480P_6 = "AgoraVideoProfile480P_6";
    private static final String AGORA_VIDEO_PROFILE_480P_8 = "AgoraVideoProfile480P_8";
    private static final String AGORA_VIDEO_PROFILE_480P_9 = "AgoraVideoProfile480P_9";
    private static final String AGORA_VIDEO_PROFILE_480P_10 = "AgoraVideoProfile480P_10";
    private static final String AGORA_VIDEO_PROFILE_720P = "AgoraVideoProfile720P";
    private static final String AGORA_VIDEO_PROFILE_720P_3 = "AgoraVideoProfile720P_3";
    private static final String AGORA_VIDEO_PROFILE_720P_5 = "AgoraVideoProfile720P_5";
    private static final String AGORA_VIDEO_PROFILE_720P_6 = "AgoraVideoProfile720P_6";
    private static final String AGORA_VIDEO_PROFILE_1080P = "AgoraVideoProfile1080P";
    private static final String AGORA_VIDEO_PROFILE_1080P_3 = "AgoraVideoProfile1080P_3";
    private static final String AGORA_VIDEO_PROFILE_1080P_5 = "AgoraVideoProfile1080P_5";
    private static final String AGORA_VIDEO_PROFILE_1440P = "AgoraVideoProfile1440P";
    private static final String AGORA_VIDEO_PROFILE_1440P_2 = "AgoraVideoProfile1440P_2";
    private static final String AGORA_VIDEO_PROFILE_4K = "AgoraVideoProfile4K";
    private static final String AGORA_VIDEO_PROFILE_4K_3 = "AgoraVideoProfile4K_3";
    private static final String AGORA_VIDEO_PROFILE_DEFAULT = "AgoraVideoProfileDEFAULT";

    private static final String AGORA_VIDEO_STREAM_TYPE_HIGH = "AgoraVideoStreamTypeHigh";
    private static final String AGORA_VIDEO_STREAM_TYPE_LOW = "AgoraVideoStreamTypeLow";

    private static final String AGORA_VIDEO_MIRROR_MODE_AUTO = "AgoraVideoMirrorModeAuto";
    private static final String AGORA_VIDEO_MIRROR_MODE_ENABLED = "AgoraVideoMirrorModeEnabled";
    private static final String AGORA_VIDEO_MIRROR_MODE_DISABLED = "AgoraVideoMirrorModeDisabled";

    private static final String AGORA_AUDIO_EQUALIZATION_BAND31 = "AgoraAudioEqualizationBand31";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND62 = "AgoraAudioEqualizationBand62";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND125 = "AgoraAudioEqualizationBand125";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND250 = "AgoraAudioEqualizationBand250";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND500 = "AgoraAudioEqualizationBand500";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND1K = "AgoraAudioEqualizationBand1K";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND2K = "AgoraAudioEqualizationBand2K";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND4K = "AgoraAudioEqualizationBand4K";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND8K = "AgoraAudioEqualizationBand8K";
    private static final String AGORA_AUDIO_EQUALIZATION_BAND16K = "AgoraAudioEqualizationBand16K";

    private static final String AGORA_AUDIO_REVERB_DRY_LEVEL = "AgoraAudioReverbDryLevel";
    private static final String AGORA_AUDIO_REVERB_WET_LEVEL = "AgoraAudioReverbWetLevel";
    private static final String AGORA_AUDIO_REVERB_ROOM_SIZE = "AgoraAudioReverbRoomSize";
    private static final String AGORA_AUDIO_REVERB_WET_DELAY = "AgoraAudioReverbWetDelay";
    private static final String AGORA_AUDIO_REVERB_STRENGTH = "AgoraAudioReverbStrength";

    private static final String AGORA_AUDIO_RECORDING_QUALITY_LOW = "AgoraAudioRecordingQualityLow";
    private static final String AGORA_AUDIO_RECORDING_QUALITY_MEDIUM = "AgoraAudioRecordingQualityMedium";
    private static final String AGORA_AUDIO_RECORDING_QUALITY_HIGH = "AgoraAudioRecordingQualityHigh";

    private ReactApplicationContext mReactContext;
    private RtcEngine mRtcEngine;
    private IRtcEngineEventHandler mHandler;

    private ConcurrentHashMap<String, Method> mMethods = new ConcurrentHashMap<>();
    private Map<String, Boolean> mInternalMethods = new HashMap<>();

    private WeakReference<AgoraPackage> mAgoraPackage;

    private JavaScriptModule mJSModule;

    public AgoraModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mReactContext = reactContext;
    }

    public void setAgoraPackage(AgoraPackage agoraPackage) {
        mAgoraPackage = new WeakReference<>(agoraPackage);
    }

    @Override
    public String getName() {
        return "AgoraRtcEngineModule";
    }

    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();

        constants.put(AGORA_CHANNEL_PROFILE_COMMUNICATION, CHANNEL_PROFILE_COMMUNICATION);
        constants.put(AGORA_CHANNEL_PROFILE_LIVEBROADCASTING, CHANNEL_PROFILE_LIVE_BROADCASTING);
        constants.put(AGORA_CHANNEL_PROFILE_GAME, CHANNEL_PROFILE_GAME);

        constants.put(AGORA_VIDEO_RENDER_MODE_HIDDEN, RENDER_MODE_HIDDEN);
        constants.put(AGORA_VIDEO_RENDER_MODE_FIT, RENDER_MODE_FIT);
        constants.put(AGORA_VIDEO_RENDER_MODE_ADAPTIVE, RENDER_MODE_ADAPTIVE);

        constants.put(AGORA_AUDIO_PROFILE_DEFAULT, AUDIO_PROFILE_DEFAULT);
        constants.put(AGORA_AUDIO_PROFILE_SPEECH_STANDARD, AUDIO_PROFILE_SPEECH_STANDARD);
        constants.put(AGORA_AUDIO_PROFILE_MUSIC_STANDARD, AUDIO_PROFILE_MUSIC_STANDARD);
        constants.put(AGORA_AUDIO_PROFILE_MUSIC_STANDARD_STEREO, AUDIO_PROFILE_MUSIC_STANDARD_STEREO);
        constants.put(AGORA_AUDIO_PROFILE_MUSIC_HIGH_QUALITY, AUDIO_PROFILE_MUSIC_HIGH_QUALITY);
        constants.put(AGORA_AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO, AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO);

        constants.put(AGORA_AUDIO_SCENARIO_DEFAULT, AUDIO_SCENARIO_DEFAULT);
        constants.put(AGORA_AUDIO_SCENARIO_CHAT_ROOM_GAMING, AUDIO_SCENARIO_CHATROOM_GAMING);
        constants.put(AGORA_AUDIO_SCENARIO_CHAT_ROOM_ENTERTAINMENT, AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT);
        constants.put(AGORA_AUDIO_SCENARIO_EDUCATION, AUDIO_SCENARIO_EDUCATION);
        constants.put(AGORA_AUDIO_SCENARIO_GAME_STREAMING, AUDIO_SCENARIO_GAME_STREAMING);
        constants.put(AGORA_AUDIO_SCENARIO_SHOW_ROOM, AUDIO_SCENARIO_SHOWROOM);

        constants.put(AGORA_VIDEO_PROFILE_120P, VIDEO_PROFILE_120P);
        constants.put(AGORA_VIDEO_PROFILE_120P_3, VIDEO_PROFILE_120P_3);
        constants.put(AGORA_VIDEO_PROFILE_180P, VIDEO_PROFILE_180P);
        constants.put(AGORA_VIDEO_PROFILE_180P_3, VIDEO_PROFILE_180P_3);
        constants.put(AGORA_VIDEO_PROFILE_180P_4, VIDEO_PROFILE_180P_4);
        constants.put(AGORA_VIDEO_PROFILE_240P, VIDEO_PROFILE_240P);
        constants.put(AGORA_VIDEO_PROFILE_240P_3, VIDEO_PROFILE_240P_3);
        constants.put(AGORA_VIDEO_PROFILE_240P_4, VIDEO_PROFILE_240P_4);
        constants.put(AGORA_VIDEO_PROFILE_360P, VIDEO_PROFILE_360P);
        constants.put(AGORA_VIDEO_PROFILE_360P_3, VIDEO_PROFILE_360P_3);
        constants.put(AGORA_VIDEO_PROFILE_360P_4, VIDEO_PROFILE_360P_4);
        constants.put(AGORA_VIDEO_PROFILE_360P_6, VIDEO_PROFILE_360P_6);
        constants.put(AGORA_VIDEO_PROFILE_360P_7, VIDEO_PROFILE_360P_7);
        constants.put(AGORA_VIDEO_PROFILE_360P_8, VIDEO_PROFILE_360P_8);
        constants.put(AGORA_VIDEO_PROFILE_360P_9, VIDEO_PROFILE_360P_9);
        constants.put(AGORA_VIDEO_PROFILE_360P_10, VIDEO_PROFILE_360P_10);
        constants.put(AGORA_VIDEO_PROFILE_360P_11, VIDEO_PROFILE_360P_11);
        constants.put(AGORA_VIDEO_PROFILE_480P, VIDEO_PROFILE_480P);
        constants.put(AGORA_VIDEO_PROFILE_480P_3, VIDEO_PROFILE_480P_3);
        constants.put(AGORA_VIDEO_PROFILE_480P_4, VIDEO_PROFILE_480P_4);
        constants.put(AGORA_VIDEO_PROFILE_480P_6, VIDEO_PROFILE_480P_6);
        constants.put(AGORA_VIDEO_PROFILE_480P_8, VIDEO_PROFILE_480P_8);
        constants.put(AGORA_VIDEO_PROFILE_480P_9, VIDEO_PROFILE_480P_9);
        constants.put(AGORA_VIDEO_PROFILE_480P_10, VIDEO_PROFILE_480P_10);
        constants.put(AGORA_VIDEO_PROFILE_720P, VIDEO_PROFILE_720P);
        constants.put(AGORA_VIDEO_PROFILE_720P_3, VIDEO_PROFILE_720P_3);
        constants.put(AGORA_VIDEO_PROFILE_720P_5, VIDEO_PROFILE_720P_5);
        constants.put(AGORA_VIDEO_PROFILE_720P_6, VIDEO_PROFILE_720P_6);
        constants.put(AGORA_VIDEO_PROFILE_DEFAULT, VIDEO_PROFILE_DEFAULT);

        constants.put(AGORA_VIDEO_STREAM_TYPE_HIGH, VIDEO_STREAM_HIGH);
        constants.put(AGORA_VIDEO_STREAM_TYPE_LOW, VIDEO_STREAM_LOW);

        constants.put(AGORA_VIDEO_MIRROR_MODE_AUTO, VIDEO_MIRROR_MODE_AUTO);
        constants.put(AGORA_VIDEO_MIRROR_MODE_ENABLED, VIDEO_MIRROR_MODE_ENABLED);
        constants.put(AGORA_VIDEO_MIRROR_MODE_DISABLED, VIDEO_MIRROR_MODE_DISABLED);

        constants.put(AGORA_AUDIO_EQUALIZATION_BAND31, AUDIO_EQUALIZATION_BAND_31);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND62, AUDIO_EQUALIZATION_BAND_62);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND125, AUDIO_EQUALIZATION_BAND_125);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND250, AUDIO_EQUALIZATION_BAND_250);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND500, AUDIO_EQUALIZATION_BAND_500);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND1K, AUDIO_EQUALIZATION_BAND_1K);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND2K, AUDIO_EQUALIZATION_BAND_2K);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND4K, AUDIO_EQUALIZATION_BAND_4K);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND8K, AUDIO_EQUALIZATION_BAND_8K);
        constants.put(AGORA_AUDIO_EQUALIZATION_BAND16K, AUDIO_EQUALIZATION_BAND_16K);

        constants.put(AGORA_AUDIO_REVERB_DRY_LEVEL, AUDIO_REVERB_DRY_LEVEL);
        constants.put(AGORA_AUDIO_REVERB_WET_LEVEL, AUDIO_REVERB_WET_LEVEL);
        constants.put(AGORA_AUDIO_REVERB_ROOM_SIZE, AUDIO_REVERB_ROOM_SIZE);
        constants.put(AGORA_AUDIO_REVERB_WET_DELAY, AUDIO_REVERB_WET_DELAY);
        constants.put(AGORA_AUDIO_REVERB_STRENGTH, AUDIO_REVERB_STRENGTH);

        constants.put(AGORA_AUDIO_RECORDING_QUALITY_LOW, AUDIO_RECORDING_QUALITY_LOW);
        constants.put(AGORA_AUDIO_RECORDING_QUALITY_MEDIUM, AUDIO_RECORDING_QUALITY_MEDIUM);
        constants.put(AGORA_AUDIO_RECORDING_QUALITY_HIGH, AUDIO_RECORDING_QUALITY_HIGH);

        return constants;
    }

    @ReactMethod
    public void createEngine(String appId) {
        mHandler = new IRtcEngineEventHandler() {
            @Override
            public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putString("channel", channel);
                map.putInt("uid", uid);
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("LocalDidJoinedChannel", map);
            }

            @Override
            public void onRejoinChannelSuccess(String channel, int uid, int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putString("channel", channel);
                map.putInt("uid", uid);
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("CurrentDidRejoinChannel", map);
            }

            @Override
            public void onWarning(int warn) {
                WritableMap map = Arguments.createMap();
                map.putInt("warn", warn);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidOccurWarning", map);
            }

            @Override
            public void onError(int err) {
                WritableMap map = Arguments.createMap();
                map.putInt("err", err);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidOccurError", map);
            }

            @Override
            public void onApiCallExecuted(int error, String api, String result) {
                WritableMap map = Arguments.createMap();
                map.putInt("error", error);
                map.putString("api", api);
                map.putString("result", result);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onApiCallExecuted", map);
            }

            @Override
            public void onCameraReady() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("CameraDidReady", map);
            }

            @Override
            public void onCameraFocusAreaChanged(Rect rect) {
                WritableMap map = Arguments.createMap();
                map.putInt("left", rect.left);
                map.putInt("top", rect.top);
                map.putInt("right", rect.right);
                map.putInt("bottom", rect.bottom);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("CameraFocusDidChangedToRect", map);
            }

            @Override
            public void onVideoStopped() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("VideoDidStop", map);
            }

            @Override
            public void onAudioQuality(int uid, int quality, short delay, short lost) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("quality", quality);
                map.putInt("delay", (int) delay);
                map.putInt("lost", (int) lost);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("AudioQuality", map);
            }

            @Override
            public void onLeaveChannel(RtcStats stats) {
                WritableMap map = Arguments.createMap();
                map.putInt("totalDuration", stats.totalDuration);
                map.putInt("txBytes", stats.txBytes);
                map.putInt("rxBytes", stats.rxBytes);
                map.putInt("txKBitRate", stats.txKBitRate);
                map.putInt("rxKBitRate", stats.rxKBitRate);
                map.putInt("txAudioKBitRate", stats.txAudioKBitRate);
                map.putInt("rxAudioKBitRate", stats.rxAudioKBitRate);
                map.putInt("txVideoKBitRate", stats.txVideoKBitRate);
                map.putInt("rxVideoKBitRate", stats.rxVideoKBitRate);
                map.putInt("users", stats.users);
                map.putDouble("cpuTotalUsage", stats.cpuTotalUsage);
                map.putDouble("cpuAppUsage", stats.cpuAppUsage);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidLeaveChannelWithStats", map);
            }

            @Override
            public void onRtcStats(RtcStats stats) {
                WritableMap map = Arguments.createMap();
                map.putInt("totalDuration", stats.totalDuration);
                map.putInt("txBytes", stats.txBytes);
                map.putInt("rxBytes", stats.rxBytes);
                map.putInt("txKBitRate", stats.txKBitRate);
                map.putInt("rxKBitRate", stats.rxKBitRate);
                map.putInt("txAudioKBitRate", stats.txAudioKBitRate);
                map.putInt("rxAudioKBitRate", stats.rxAudioKBitRate);
                map.putInt("txVideoKBitRate", stats.txVideoKBitRate);
                map.putInt("rxVideoKBitRate", stats.rxVideoKBitRate);
                map.putInt("users", stats.users);
                map.putDouble("cpuTotalUsage", stats.cpuTotalUsage);
                map.putDouble("cpuAppUsage", stats.cpuAppUsage);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidLeaveChannelWithStats", map);
            }

            @Override
            public void onAudioVolumeIndication(AudioVolumeInfo[] speakers, int totalVolume) {
                WritableMap map = Arguments.createMap();
                map.putInt("count", speakers.length);
                for (int i = 0; i < speakers.length; i++) {
                    map.putInt("uid" + i, speakers[i].uid);
                    map.putInt("volume" + i, speakers[i].volume);
                }
                map.putInt("totalVolume", totalVolume);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("ReportAudioVolumeIndicationOfSpeakers", map);
            }

            @Override
            public void onNetworkQuality(int uid, int txQuality, int rxQuality) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("txQuality", txQuality);
                map.putInt("rxQuality", rxQuality);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("NetworkQuality", map);
            }

            @Override
            public void onLastmileQuality(int quality) {
                WritableMap map = Arguments.createMap();
                map.putInt("quality", quality);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("LastmileQuality", map);
            }

            @Override
            public void onUserJoined(int uid, int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("RemoteDidJoinedChannel", map);
            }

            @Override
            public void onUserOffline(int uid, int reason) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("reason", reason);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("RemoteDidOfflineOfUid", map);
            }

            @Override
            public void onUserMuteAudio(int uid, boolean muted) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putBoolean("muted", muted);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidAudioMuted", map);
            }

            @Override
            public void onUserMuteVideo(int uid, boolean muted) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putBoolean("muted", muted);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidVideoMuted", map);
            }

            @Override
            public void onUserEnableVideo(int uid, boolean enabled) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putBoolean("enabled", enabled);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidVideoEnabled", map);
            }

            @Override
            public void onUserEnableLocalVideo(int uid, boolean enabled) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putBoolean("enabled", enabled);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onUserEnableLocalVideo", map);
            }

            @Override
            public void onLocalVideoStat(int sentBitrate, int sentFrameRate) {
                WritableMap map = Arguments.createMap();
                map.putInt("sentBitrate", sentBitrate);
                map.putInt("sentFrameRate", sentFrameRate);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onLocalVideoStat", map);
            }

            @Override
            public void onRemoteVideoStat(int uid, int delay, int receivedBitrate, int receivedFrameRate) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("delay", delay);
                map.putInt("receivedBitrate", receivedBitrate);
                map.putInt("receivedFrameRate", receivedFrameRate);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onRemoteVideoStat", map);
            }

            @Override
            public void onRemoteVideoStats(RemoteVideoStats stats) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", stats.uid);
                map.putInt("delay", stats.delay);
                map.putInt("width", stats.receivedBitrate);
                map.putInt("height", stats.receivedFrameRate);
                map.putInt("receivedBitrate", stats.receivedFrameRate);
                map.putInt("receivedFrameRate", stats.receivedFrameRate);
                map.putInt("rxStreamType", stats.receivedFrameRate);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("RemoteVideoStats", map);
            }

            @Override
            public void onLocalVideoStats(LocalVideoStats stats) {
                WritableMap map = Arguments.createMap();
                map.putInt("sentBitrate", stats.sentBitrate);
                map.putInt("sentFrameRate", stats.sentFrameRate);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("LocalVideoStats", map);
            }

            @Override
            public void onFirstRemoteVideoFrame(int uid, int width, int height, int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("width", width);
                map.putInt("height", height);
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("FirstRemoteVideoFrame", map);
            }

            @Override
            public void onFirstLocalVideoFrame(int width, int height, int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putInt("width", width);
                map.putInt("height", height);
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("FirstLocalVideoFrame", map);
            }

            @Override
            public void onFirstRemoteVideoDecoded(int uid, int width, int height, int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("width", width);
                map.putInt("height", height);
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("FirstRemoteVideoDecoded", map);
            }

            @Override
            public void onVideoSizeChanged(int uid, int width, int height, int rotation) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("width", width);
                map.putInt("height", height);
                map.putInt("rotation", rotation);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("VideoSizeChanged", map);
            }

            @Override
            public void onConnectionLost() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("ConnectionDidLost", map);
            }

            @Override
            public void onConnectionInterrupted() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("ConnectionDidInterrupted", map);
            }

            @Override
            public void onConnectionBanned() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("ConnectionDidBanned", map);
            }

            @Override
            public void onStreamMessage(int uid, int streamId, byte[] data) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("streamId", streamId);
                map.putString("message", new String(data));
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("ReceiveStreamMessageFromUid", map);
            }

            @Override
            public void onStreamMessageError(int uid, int streamId, int error, int missed, int cached) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("streamId", streamId);
                map.putInt("error", error);
                map.putInt("missed", missed);
                map.putInt("cached", cached);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidOccurStreamMessageErrorFromUid", map);
            }

            @Override
            public void onMediaEngineLoadSuccess() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onMediaEngineLoadSuccess", map);
            }

            @Override
            public void onMediaEngineStartCallSuccess() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onMediaEngineStartCallSuccess", map);
            }

            @Override
            public void onAudioMixingFinished() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("LocalAudioMixingDidFinish", map);
            }

            @Override
            public void onRequestToken() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("RequestToken", map);
            }

            @Override
            public void onAudioRouteChanged(int routing) {
                WritableMap map = Arguments.createMap();
                map.putInt("routing", routing);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidAudioRouteChanged", map);
            }

            @Override
            public void onFirstLocalAudioFrame(int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("FirstLocalAudioFrame", map);
            }

            @Override
            public void onFirstRemoteAudioFrame(int uid, int elapsed) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                map.putInt("elapsed", elapsed);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("FirstRemoteAudioFrame", map);
            }

            @Override
            public void onActiveSpeaker(int uid) {
                WritableMap map = Arguments.createMap();
                map.putInt("uid", uid);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("ActiveSpeaker", map);
            }

            @Override
            public void onAudioEffectFinished(int soundId) {
                WritableMap map = Arguments.createMap();
                map.putInt("soundId", soundId);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidAudioEffectFinish", map);
            }

            @Override
            public void onClientRoleChanged(int oldRole, int newRole) {
                WritableMap map = Arguments.createMap();
                map.putInt("oldRole", oldRole);
                map.putInt("newRole", newRole);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("DidClientRoleChanged", map);
            }

            @Override
            public void onStreamPublished(String url, int error) {
                WritableMap map = Arguments.createMap();
                map.putString("url", url);
                map.putInt("error", error);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onStreamPublished", map);
            }

            @Override
            public void onStreamUnpublished(String url) {
                WritableMap map = Arguments.createMap();
                map.putString("url", url);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onStreamUnpublished", map);
            }

            @Override
            public void onTranscodingUpdated() {
                WritableMap map = Arguments.createMap();
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onTranscodingUpdated", map);
            }

            @Override
            public void onStreamInjectedStatus(String url, int uid, int status) {
                WritableMap map = Arguments.createMap();
                map.putString("url", url);
                map.putInt("uid", uid);
                map.putInt("status", status);
                mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                        .emit("onStreamInjectedStatus", map);
            }
        };

        try {
            mRtcEngine = RtcEngine.create(mReactContext, appId, mHandler);

            initPublicAPI();
            initInternalAPI();

        } catch (Exception ex) {
            Log.e("RCTNative", ex.toString());
            mRtcEngine = null;
        }
    }

    @ReactMethod
    public void setChannelProfile(int profile) {
        mRtcEngine.setChannelProfile(profile);
    }

    @ReactMethod
    public void enableAudio() {
        mRtcEngine.enableAudio();
    }

    @ReactMethod
    public void disableAudio() {
        mRtcEngine.disableAudio();
    }

    @ReactMethod
    public void joinChannel(String token, String channelName, String optionalInfo, int optionalUid) {
        mRtcEngine.joinChannel(token, channelName, optionalInfo, optionalUid);
    }

    @ReactMethod
    public void leaveChannel() {
        mRtcEngine.leaveChannel();
    }

    @ReactMethod
    public void setAudioProfile(int profile, int scenario) {
        mRtcEngine.setAudioProfile(profile, scenario);
    }

    @ReactMethod
    public void enableVideo() {
        mRtcEngine.enableVideo();
    }

    @ReactMethod
    public void disableVideo() {
        mRtcEngine.disableVideo();
    }

    @ReactMethod
    public void enableLocalVideo(boolean enabled) {
        mRtcEngine.enableLocalVideo(enabled);
    }

    @ReactMethod
    public void setVideoProfile(int profile, boolean swapWidthAndHeight) {
        mRtcEngine.setVideoProfile(profile, swapWidthAndHeight);
    }

    @ReactMethod
    public void setVideoProfileDetail(int width, int height, int frameRate, int bitrate) {
        mRtcEngine.setVideoProfile(width, height, frameRate, bitrate);
    }

    @ReactMethod
    public void enableDualStreamMode(boolean enabled) {
        mRtcEngine.enableDualStreamMode(enabled);
    }

    @ReactMethod
    public void setRemoteVideoStreamType(int uid, int streamType) {
        mRtcEngine.setRemoteVideoStreamType(uid, streamType);
    }

    @ReactMethod
    public void setVideoQualityParameters(boolean preferFrameRateOverImageQuality) {
        mRtcEngine.setVideoQualityParameters(preferFrameRateOverImageQuality);
    }

    @ReactMethod
    public void startPreview() {
        mRtcEngine.startPreview();
    }

    @ReactMethod
    public void stopPreview() {
        mRtcEngine.stopPreview();
    }

    @ReactMethod
    public void setLocalRenderMode(int mode) {
        mRtcEngine.setLocalRenderMode(mode);
    }

    @ReactMethod
    public void setLocalVideoMirrorMode(int mode) {
        mRtcEngine.setLocalVideoMirrorMode(mode);
    }

    @ReactMethod
    public void muteLocalVideoStream(boolean muted) {
        mRtcEngine.muteLocalVideoStream(muted);
    }

    @ReactMethod
    public void muteAllRemoteVideoStreams(boolean muted) {
        mRtcEngine.muteAllRemoteVideoStreams(muted);
    }

    @ReactMethod
    public void muteRemoteVideoStream(int uid, boolean muted) {
        mRtcEngine.muteRemoteVideoStream(uid, muted);
    }

    @ReactMethod
    public void switchCamera() {
        mRtcEngine.switchCamera();
    }

    @ReactMethod
    public void setCameraZoomFactor(float factor) {
        mRtcEngine.setCameraZoomFactor(factor);
    }

    @ReactMethod
    public void setCameraFocusPositionInPreview(float positionX, float positionY) {
        mRtcEngine.setCameraFocusPositionInPreview(positionX, positionY);
    }

    @ReactMethod
    public void setCameraTorchOn(boolean isOn) {
        mRtcEngine.setCameraTorchOn(isOn);
    }

    @ReactMethod
    public void setCameraAutoFocusFaceModeEnabled(boolean enabled) {
        mRtcEngine.setCameraAutoFocusFaceModeEnabled(enabled);
    }

    @ReactMethod
    public void setDefaultAudioRoutetoSpeakerphone(boolean defaultToSpeaker) {
        mRtcEngine.setDefaultAudioRoutetoSpeakerphone(defaultToSpeaker);
    }

    @ReactMethod
    public void setEnableSpeakerphone(boolean enabled) {
        mRtcEngine.setEnableSpeakerphone(enabled);
    }

    @ReactMethod
    public void enableAudioVolumeIndication(int interval, int smooth) {
        mRtcEngine.enableAudioVolumeIndication(interval, smooth);
    }

    @ReactMethod
    public void muteLocalAudioStream(boolean muted) {
        mRtcEngine.muteLocalAudioStream(muted);
    }

    @ReactMethod
    public void muteAllRemoteAudioStreams(boolean muted) {
        mRtcEngine.muteAllRemoteAudioStreams(muted);
    }

    @ReactMethod
    public void muteRemoteAudioStream(int uid, boolean muted) {
        mRtcEngine.muteRemoteAudioStream(uid, muted);
    }

    @ReactMethod
    public void startAudioMixing(String filePath, boolean loopback, boolean replace, int cycle) {
        mRtcEngine.startAudioMixing(filePath, loopback, replace, cycle);
    }

    @ReactMethod
    public void stopAudioMixing() {
        mRtcEngine.stopAudioMixing();
    }

    @ReactMethod
    public void pauseAudioMixing() {
        mRtcEngine.pauseAudioMixing();
    }

    @ReactMethod
    public void resumeAudioMixing() {
        mRtcEngine.resumeAudioMixing();
    }

    @ReactMethod
    public void adjustAudioMixingVolume(int volume) {
        mRtcEngine.adjustAudioMixingVolume(volume);
    }

    @ReactMethod
    public void setAudioMixingPosition(int pos) {
        mRtcEngine.setAudioMixingPosition(pos);
    }

    @ReactMethod
    public void startAudioRecording(String filePath, int quality) {
        mRtcEngine.startAudioRecording(filePath, quality);
    }

    @ReactMethod
    public void stopAudioRecording() {
        mRtcEngine.stopAudioRecording();
    }

    @ReactMethod
    public void adjustRecordingSignalVolume(int volume) {
        mRtcEngine.adjustRecordingSignalVolume(volume);
    }

    @ReactMethod
    public void adjustPlaybackSignalVolume(int volume) {
        mRtcEngine.adjustPlaybackSignalVolume(volume);
    }

    @ReactMethod
    public void setEncryptionSecret(String secret) {
        mRtcEngine.setEncryptionSecret(secret);
    }

    @ReactMethod
    public void setEncryptionMode(String encryptionMode) {
        mRtcEngine.setEncryptionMode(encryptionMode);
    }

    @ReactMethod
    public void createDataStream(boolean reliable, boolean ordered) {
        mRtcEngine.createDataStream(reliable, ordered);
    }

    @ReactMethod
    public void sendStreamMessage(int streamId, byte[] message) {
        mRtcEngine.sendStreamMessage(streamId, message);
    }

    @ReactMethod
    public void startEchoTest() {
        mRtcEngine.startEchoTest();
    }

    @ReactMethod
    public void stopEchoTest() {
        mRtcEngine.stopEchoTest();
    }

    @ReactMethod
    public void enableLastmileTest() {
        mRtcEngine.enableLastmileTest();
    }

    @ReactMethod
    public void disableLastmileTest() {
        mRtcEngine.disableLastmileTest();
    }

    @ReactMethod
    public void rate(String callId, int rating, String description) {
        mRtcEngine.rate(callId, rating, description);
    }

    @ReactMethod
    public void complain(String callId, String description) {
        mRtcEngine.complain(callId, description);
    }

    @ReactMethod
    public void renewToken(String token) {
        mRtcEngine.renewToken(token);
    }

    @ReactMethod
    public void setLogFilter(int filter) {
        mRtcEngine.setLogFilter(filter);
    }

    @ReactMethod
    public void destroy() {
        mMethods.clear();
        mInternalMethods.clear();

        RtcEngine.destroy();
    }

    @ReactMethod
    public void setEffectsVolume(double volume) {
        mRtcEngine.getAudioEffectManager().setEffectsVolume(volume);
    }

    @ReactMethod
    public void setVolumeOfEffect(int soundId, double volume) {
        mRtcEngine.getAudioEffectManager().setVolumeOfEffect(soundId, volume);
    }

    @ReactMethod
    public void setLocalVoicePitch(double pitch) {
        mRtcEngine.setLocalVoicePitch(pitch);
    }

    @ReactMethod
    public void setLocalVoiceEqualization(int bandFrequency, int bandGain) {
        mRtcEngine.setLocalVoiceEqualization(bandFrequency, bandGain);
    }

    @ReactMethod
    public void setLocalVoiceReverb(int reverbKey, int value) {
        mRtcEngine.setLocalVoiceReverb(reverbKey, value);
    }

    @ReactMethod
    public void playEffect(int soundId, String filePath, int loopCount, double pitch, double pan, double gain, boolean publish) {
        mRtcEngine.getAudioEffectManager().playEffect(soundId, filePath, loopCount, pitch, pan, gain, publish);
    }

    @ReactMethod
    public void stopEffect(int soundId) {
        mRtcEngine.getAudioEffectManager().stopEffect(soundId);
    }

    @ReactMethod
    public void stopAllEffects() {
        mRtcEngine.getAudioEffectManager().stopAllEffects();
    }

    @ReactMethod
    public void preloadEffect(int soundId, String pszFilePath) {
        mRtcEngine.getAudioEffectManager().preloadEffect(soundId, pszFilePath);
    }

    @ReactMethod
    public void unloadEffect(int soundId) {
        mRtcEngine.getAudioEffectManager().unloadEffect(soundId);
    }

    @ReactMethod
    public void pauseEffect(int soundId) {
        mRtcEngine.getAudioEffectManager().pauseEffect(soundId);
    }

    @ReactMethod
    public void pauseAllEffects() {
        mRtcEngine.getAudioEffectManager().pauseAllEffects();
    }

    @ReactMethod
    public void resumeEffect(int soundId) {
        mRtcEngine.getAudioEffectManager().resumeEffect(soundId);
    }

    @ReactMethod
    public void resumeAllEffects() {
        mRtcEngine.getAudioEffectManager().resumeAllEffects();
    }

    @ReactMethod
    public void isCameraZoomSupported(Callback callback) {
        callback.invoke(mRtcEngine.isCameraZoomSupported());
    }

    @ReactMethod
    public void isCameraTorchSupported(Callback callback) {
        callback.invoke(mRtcEngine.isCameraTorchSupported());
    }

    @ReactMethod
    public void isCameraFocusSupported(Callback callback) {
        callback.invoke(mRtcEngine.isCameraFocusSupported());
    }

    @ReactMethod
    public void isCameraAutoFocusFaceModeSupported(Callback callback) {
        callback.invoke(mRtcEngine.isCameraAutoFocusFaceModeSupported());
    }

    @ReactMethod
    public void isSpeakerphoneEnabled(Callback callback) {
        callback.invoke(mRtcEngine.isSpeakerphoneEnabled());
    }

    @ReactMethod
    public void getEffectsVolume(Callback callback) {
        callback.invoke(mRtcEngine.getAudioEffectManager().getEffectsVolume());
    }

    @ReactMethod
    public void getAudioMixingDuration(Callback callback) {
        callback.invoke(mRtcEngine.getAudioMixingDuration());
    }

    @ReactMethod
    public void getAudioMixingCurrentPosition(Callback callback) {
        callback.invoke(mRtcEngine.getAudioMixingCurrentPosition());
    }

    @ReactMethod
    public void getCallId(Callback callback) {
        callback.invoke(mRtcEngine.getCallId());
    }

    @ReactMethod
    public void getSdkVersion(Callback callback) {
        callback.invoke(mRtcEngine.getSdkVersion());
    }

    @ReactMethod
    public void addPublishStreamUrl(String url, boolean transcodingEnabled) {
        mRtcEngine.addPublishStreamUrl(url, transcodingEnabled);
    }

    @ReactMethod
    public void removePublishStreamUrl(String url) {
        mRtcEngine.removePublishStreamUrl(url);
    }

    @ReactMethod
    public void setLiveTranscoding(ReadableMap map) {
        try {
            Gson gson = new Gson();
            LiveTranscoding transcoding = gson.fromJson(convertMapToJson(map).toString(), LiveTranscoding.class);
            mRtcEngine.setLiveTranscoding(transcoding);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void setClientRole(int role, Callback callback) {
        callback.invoke(mRtcEngine.setClientRole(role));
    }

    @ReactMethod
    public void callAPI(String api, ReadableArray args) {
        Object[] parameters = new Object[args.size()];
        for (int i = 0; i < args.size(); ++i) {
            switch (args.getType(i)) {
                case Null:
                    parameters[i] = null;
                    continue;
                case Boolean:
                    parameters[i] = args.getBoolean(i);
                    continue;
                case Number:
                    parameters[i] = args.getDouble(i);
                    continue;
                case String:
                    parameters[i] = args.getString(i);
                    continue;
                case Map:
                    Log.e(TAG, "No support for array or map parameters at moment");
                    return;
                case Array:
                    Log.e(TAG, "No support for array or map parameters at moment");
                    return;
            }
        }

        if (mMethods.containsKey(api)) {
            callAPI(api, parameters);
        }
    }

    public void setupLocalVideo(SurfaceView view, int uid, int renderMode) {
        if (mAgoraPackage.get() == null)
            return;

        mRtcEngine.setupLocalVideo(new VideoCanvas(view, renderMode, uid));
    }

    public void setupRemoteVideo(SurfaceView view, int uid, int renderMode) {
        if (mAgoraPackage.get() == null)
            return;

        mRtcEngine.setupRemoteVideo(new VideoCanvas(view, renderMode, uid));
    }

    private void initPublicAPI() {
        Method[] methods = mRtcEngine.getClass().getDeclaredMethods();
        for (Method m : methods) {
            String name = m.getName();
            if (name.startsWith("native")) {
                continue;
            }

            mMethods.put(name, m);
        }
    }

    private void initInternalAPI() {
        mInternalMethods.put("setupLocalVideo", true);
    }

    private void callAPI(String api, Object[] args) {
        try {
            Method m = mMethods.get(api);
            int n = args.length;

            Class<?>[] cls = m.getParameterTypes();
            for (int i = 0; i < n; ++i) {
                if (cls[i].equals(Integer.TYPE)) {
                    args[i] = ((Double) args[i]).intValue();
                }
            }

            switch (n) {
                case 0:
                    callAPI0(m, args);
                    break;
                case 1:
                    callAPI1(m, args);
                    break;
                case 2:
                    callAPI2(m, args);
                    break;
                case 3:
                    callAPI3(m, args);
                    break;
                case 4:
                    callAPI4(m, args);
                    break;
                case 5:
                    callAPI5(m, args);
                    break;
                case 6:
                    callAPI6(m, args);
                    break;
                case 7:
                    callAPI7(m, args);
                    break;
                default:
                    Log.e(TAG, "Need add more callAPI methods");
                    break;
            }
        } catch (IllegalAccessException ex) {
            Log.e(TAG, ex.toString());
        } catch (InvocationTargetException ex) {
            Log.e(TAG, ex.toString());
        }
    }

    private void callAPI0(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine);
    }

    private void callAPI1(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine, args[0]);
    }

    private void callAPI2(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine, args[0], args[1]);
    }

    private void callAPI3(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine, args[0], args[1], args[2]);
    }

    private void callAPI4(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine, args[0], args[1], args[2], args[3]);
    }

    private void callAPI5(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine, args[0], args[1], args[2], args[3], args[4]);
    }

    private void callAPI6(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
    }

    private void callAPI7(Method method, Object[] args) throws InvocationTargetException,
            IllegalAccessException {
        method.invoke(mRtcEngine, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
    }

    private void sendEvent(ReactContext reactContext, String eventName, @Nullable WritableMap params) {
        synchronized (this) {
            if (mJSModule == null) {
                mJSModule = reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class);
            }
        }
        ((DeviceEventManagerModule.RCTDeviceEventEmitter) mJSModule).emit(eventName, params);
    }
}
