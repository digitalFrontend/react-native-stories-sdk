package ru.nasvyazi.stories;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.storage.StorageManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;

import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.fragment.app.Fragment;


import com.inappstory.sdk.AppearanceManager;
import com.inappstory.sdk.exceptions.DataException;
import com.inappstory.sdk.stories.ui.list.StoriesList;
import com.inappstory.sdk.stories.ui.views.IStoriesListItem;

import java.io.File;

public class MyFragment extends Fragment {
    StoriesList view;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup parent, Bundle savedInstanceState) {
        super.onCreateView(inflater, parent, savedInstanceState);
//        LayoutInflater inflater1 = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
//        View baseList = inflater.inflate(R.layout.base_list, null);
        View child = getLayoutInflater().inflate(R.layout.base_list, null);
        this.view = child.findViewById(R.id.stories_list);
        showStories();
        return child; // this CustomView could be any view that you want to render
    }

    private AppearanceManager generateAppearanceManager() {
        AppearanceManager appearanceManager =
                new AppearanceManager()
                        .csListItemMargin(0)
                        .csStoryReaderAnimation(AppearanceManager.ANIMATION_DEPTH)
                        .csListItemInterface(new IStoriesListItem() {
                            @Override
                            public View getView() {
                                return LayoutInflater.from(MyFragment.this.getView().getContext())
                                        .inflate(R.layout.custom_story_list_item, null, false);
                            }

                            @Override
                            public View getVideoView() {
                                return LayoutInflater.from(MyFragment.this.getView().getContext())
                                        .inflate(R.layout.custom_story_list_item, null, false);
                            }

                            @Override
                            public void setId(View view, int i) {

                            }

                            @Override
                            public void setTitle(View itemView, String title, Integer color) {
                                ((AppCompatTextView) itemView.findViewById(R.id.title)).setText(title);
                                if (color != null) {
                                    ((AppCompatTextView) itemView.findViewById(R.id.title)).setTextColor(color);
                                }
                            }

                            @Override
                            public void setImage(View itemView, String url, int backgroundColor) {
                                showImage(url, backgroundColor, (ImageView) itemView.findViewById(R.id.image));
                            }

                            @Override
                            public void setHasAudio(View itemView, boolean hasAudio) {

                            }

                            @Override
                            public void setVideo(View view, String s) {

                            }

                            @Override
                            public void setOpened(View itemView, boolean isOpened) {
                                itemView.findViewById(R.id.whiteCover).setAlpha(isOpened ? (float) 0.5 : 0);

                            }
                        });
        return appearanceManager;
    }
    public void showStories() {
        StoriesList storiesList = this.view;
        storiesList.setAppearanceManager(generateAppearanceManager());
        
        storiesList.loadStories();
        

    }

    private void showImage(String path, int backgroundColor, ImageView imageView) {
        if (path != null && !path.isEmpty()) {
            Bitmap bmp = ImageLoader.decodeFile(new File(path));
            if (bmp == null) {
                imageView.setBackgroundColor(backgroundColor);
            } else {
                imageView.setImageBitmap(bmp);
            }
        } else {
            imageView.setBackgroundColor(backgroundColor);
        }
    }
    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        // do any logic that should happen in an `onCreate` method, e.g:
        // customView.onCreate(savedInstanceState);
    }

    @Override
    public void onPause() {
        super.onPause();
        // do any logic that should happen in an `onPause` method
        // e.g.: customView.onPause();
    }

    @Override
    public void onResume() {
        super.onResume();
        // do any logic that should happen in an `onResume` method
        // e.g.: customView.onResume();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        // do any logic that should happen in an `onDestroy` method
        // e.g.: customView.onDestroy();
    }
}