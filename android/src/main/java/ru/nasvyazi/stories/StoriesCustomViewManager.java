package ru.nasvyazi.stories;

import android.graphics.Bitmap;
import android.util.Log;
import android.view.Choreographer;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.fragment.app.FragmentActivity;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.annotations.ReactPropGroup;
import com.facebook.react.uimanager.ViewGroupManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.inappstory.sdk.AppearanceManager;
import com.inappstory.sdk.exceptions.DataException;
import com.inappstory.sdk.stories.ui.list.StoriesList;
import com.inappstory.sdk.stories.ui.views.IStoriesListItem;

import java.io.File;
import java.util.Map;

public class StoriesCustomViewManager extends ViewGroupManager<FrameLayout> {

    public static final String REACT_CLASS = "StoriesCustomViewManager";
    public final int COMMAND_CREATE = 1;
    private int propWidth;
    private int propHeight;

    MyFragment fragment;
    ReactApplicationContext reactContext;
    int viewId = -1;

    public StoriesCustomViewManager(ReactApplicationContext reactContext) {
        this.reactContext = reactContext;
        this.fragment = new MyFragment();
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    /**
     * Return a FrameLayout which will later hold the Fragment
     */
    @Override
    public FrameLayout createViewInstance(ThemedReactContext reactContext) {
        return new FrameLayout(reactContext);
    }

    /**
     * Map the "create" command to an integer
     */
    @Nullable
    @Override
    public Map<String, Integer> getCommandsMap() {
        return MapBuilder.of("create", COMMAND_CREATE);
    }


    /**
     * Handle "create" command (called from JS) and call createFragment method
     */
    @Override
    public void receiveCommand(
            @NonNull FrameLayout root,
            String commandId,
            @Nullable ReadableArray args
    ) {

        super.receiveCommand(root, commandId, args);

        int reactNativeViewId = args.getInt(0);

        int commandIdInt = Integer.parseInt(commandId);
        switch (commandIdInt) {
            case COMMAND_CREATE:
                createFragment(root, reactNativeViewId);
                break;
            default: {}
        }
    }
    @ReactMethod
    public void updateStoriesList() {
            if(fragment != null) {
                fragment.showStories();
            }
    }

    @ReactPropGroup(names = {"width", "height"}, customType = "Style")
    public void setStyle(FrameLayout view, int index, Integer value) {
        if (index == 0) {
            propWidth = value;
        }

        if (index == 1) {
            propHeight = value;
        }
    }

    /**
     * Replace React Native view with a custom fragment
     */
    public void createFragment(FrameLayout root, int reactNativeViewId) {

        ViewGroup parentView = (ViewGroup) root.findViewById(reactNativeViewId);
        setupLayout(parentView);

        final MyFragment myFragment = fragment;
            FragmentActivity activity = (FragmentActivity) reactContext.getCurrentActivity();
            if(viewId == -1){
                activity.getSupportFragmentManager()
                        .beginTransaction()
                        .add(reactNativeViewId, myFragment, String.valueOf(reactNativeViewId))
                        .commit();
                viewId = reactNativeViewId;
            }else{
                activity.getSupportFragmentManager()
                        .beginTransaction()
                        .remove(fragment)
                        .commit();
                MyFragment newFragment = new MyFragment();
                activity.getSupportFragmentManager()
                        .beginTransaction()
                        .add(reactNativeViewId, newFragment, String.valueOf(reactNativeViewId))
                        .commit();
                fragment = newFragment;
            }
    }

    public void setupLayout(final View view) {
        Choreographer.getInstance().postFrameCallback(new Choreographer.FrameCallback() {
            @Override
            public void doFrame(long frameTimeNanos) {
                manuallyLayoutChildren(view);
                view.getViewTreeObserver().dispatchOnGlobalLayout();
                Choreographer.getInstance().postFrameCallback(this);
            }
        });
    }

    /**
     * Layout all children properly
     */
    public void manuallyLayoutChildren(View view) {
        // propWidth and propHeight coming from react-native props
        int width = propWidth;
        int height = propHeight;

        view.measure(
                View.MeasureSpec.makeMeasureSpec(width, View.MeasureSpec.EXACTLY),
                View.MeasureSpec.makeMeasureSpec(height, View.MeasureSpec.EXACTLY));

        view.layout(0, 0, width, height);
    }

}


