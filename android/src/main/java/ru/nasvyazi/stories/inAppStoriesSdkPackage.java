package ru.nasvyazi.stories;

import androidx.annotation.NonNull;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class inAppStoriesSdkPackage implements ReactPackage {
//    public MyFragment fragment = new MyFragment();
    public StoriesCustomViewManager storiesCustomViewManager;
    @NonNull
    @Override
    public List<NativeModule> createNativeModules(@NonNull ReactApplicationContext reactContext) {
        storiesCustomViewManager  = new StoriesCustomViewManager(reactContext);
        List<NativeModule> modules = new ArrayList<>();
        modules.add(new inAppStoriesSdkModule(reactContext));
        modules.add(storiesCustomViewManager);
        return modules;
    }

    @NonNull
    @Override
    public List<ViewManager> createViewManagers(@NonNull ReactApplicationContext reactContext) {
        return Arrays.<ViewManager>asList(
                storiesCustomViewManager
        );
    }
}
