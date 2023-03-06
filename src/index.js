
import React from "react";
import {  NativeModules,  Platform,  UIManager,  } from "react-native";
import {IOSNativeStoriesList} from './modules'
import  AndroidNativeStoriesListWrapper from './AndroidNativeStoriesListWrapper'
const { StoriesModule: Stories, StoriesCustomViewManager: ViewManager, NativeCustomViewManager:  StoriesListManager } = NativeModules;


export const StoriesManager = {
  onCreate: async (apiKey, userId) => {
      Stories.onCreate(apiKey, userId)
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
    UIManager.dispatchViewManagerCommand(
      viewId,
      //calling the 'create' command
      UIManager.StoriesCustomViewManager.Commands.create.toString(),
      [viewId]
  )
  },
};


// Stories List Component
const  StoriesView = () => {
  if(Platform.OS == 'ios'){
    return  <IOSNativeStoriesList style={{ width: '100%', height: 134}} />
  }else if(Platform.OS == 'android') {
    return <AndroidNativeStoriesListWrapper />
  }else{
    return null
  }
}
export default StoriesView