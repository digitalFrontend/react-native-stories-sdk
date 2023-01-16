package ru.nasvyazi.stories;


import android.annotation.SuppressLint;
import android.appwidget.AppWidgetManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Handler;
import android.os.HandlerThread;
import android.preference.PreferenceManager;
import android.util.Log;
import android.util.Base64;
import android.widget.RemoteViews;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.inappstory.sdk.AppearanceManager;
import com.inappstory.sdk.InAppStoryManager;
import com.inappstory.sdk.exceptions.DataException;
import com.inappstory.sdk.stories.ui.list.StoriesList;

import java.io.IOException;
import java.security.Key;
import java.util.ArrayList;
import java.util.List;


import static android.content.Context.MODE_PRIVATE;
import static android.os.Looper.getMainLooper;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class inAppStoriesSdkModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

    MyFragment currentFragment;
    AppearanceManager appearanceManager = new AppearanceManager();

    @SuppressLint("RestrictedApi")
    public inAppStoriesSdkModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

   @Override
   public String getName() {
     return "StoriesModule";
   }


    @ReactMethod
    public void onCreate( String apiKey, String userId ) throws DataException {
        try {
            new InAppStoryManager.Builder()
              .userId(userId)
              .apiKey(apiKey)
              //.testKey(getTestKey())
              .context(reactContext)
              .create();

        } catch (DataException e) {
            e.printStackTrace();
            return;
        }
  }

    @ReactMethod
    public void openSingleStory(String storyId) throws DataException {

      if (storyId == null || storyId.isEmpty()) return;
      InAppStoryManager.getInstance().showStory(storyId, reactContext, appearanceManager);

    }
}