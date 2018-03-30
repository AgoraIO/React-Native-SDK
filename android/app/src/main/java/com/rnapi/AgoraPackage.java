package com.rnapi;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AgoraPackage implements ReactPackage {
    private AgoraModule mModule;

    @Override
    public List<NativeModule> createNativeModules(
            ReactApplicationContext reactContext) {
        List<NativeModule> modules = new ArrayList<>();

        if (mModule == null) {
            mModule = new AgoraModule(reactContext);
            mModule.setAgoraPackage(this);
        }

        modules.add(mModule);
        return modules;
    }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        if (mModule == null) {
            mModule = new AgoraModule(reactContext);
            mModule.setAgoraPackage(this);
        }
        return Arrays.<ViewManager>asList(
                new SurfaceViewManager(mModule)
        );
    }

}
