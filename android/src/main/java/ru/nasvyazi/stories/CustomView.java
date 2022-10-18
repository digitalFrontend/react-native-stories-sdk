package ru.nasvyazi.stories;

import android.content.Context;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RemoteViews;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.inappstory.sdk.AppearanceManager;
import com.inappstory.sdk.exceptions.DataException;
import com.inappstory.sdk.stories.ui.list.StoriesList;

public class CustomView extends FrameLayout {

  public CustomView(@NonNull Context context) {
    super(context);

    StoriesList storiesList = new StoriesList(context);
    storiesList.setFeed("");

    this.addView(storiesList);

    try {
      storiesList.loadStories();
    } catch (DataException e) {
      e.printStackTrace();
    }
  }
}