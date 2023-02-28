"use strict";

import { NativeModules, Platform, UIManager } from "react-native";

const { StoriesModule: Stories, StoriesCustomViewManager: ViewManager, NativeCustomViewManager:  StoriesListManager } = NativeModules;


export const  StoriesManager = {
  onCreate: async (apiKey, userId) => {
   if( Platform.OS == 'android'){
      Stories.onCreate(apiKey, userId);
   }else {
      Stories.onCreate(apiKey, userId);
   }

  },
  openSingle: async (storyId) => {
    if( Platform.OS == 'android'){
      Stories.openSingleStory(storyId);
    }else {
      Stories.showSingle(storyId);
    }
    
  },
  refresh: async () => {
    if( Platform.OS == 'android'){
      ViewManager.updateStoriesList()
    }else {
      StoriesListManager.refreshStoriesList()
    }

  },
  // ANDROID ONLY! Method create new StoriesList Fragment (unmount&mount)
  // Also may using for refresh storiesList
  createAndroidView: async (viewId) => {
    console.log('viewId', viewId);

    UIManager.dispatchViewManagerCommand(
      viewId,
      //calling the 'create' command
      UIManager.StoriesCustomViewManager.Commands.create.toString(),
      [viewId]
  )
  },
 
 
};

