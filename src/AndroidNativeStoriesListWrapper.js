import React, { useEffect, useRef } from "react";
import {StoriesCustomViewManagerAndroid} from './modules'
import { Dimensions, findNodeHandle,  PixelRatio,  View } from "react-native";
import {StoriesManager} from './index'

// Android Stories List Wrapper Component
const AndroidNativeStoriesListWrapper = () => {
    const ref = useRef(null)
   
      useEffect(() => {
        const viewId = findNodeHandle(ref.current)
        StoriesManager.createAndroidView(viewId)
      }, [])
  
    return (
        <View style={{ height: 200, flexDirection: 'row' }}>
            <StoriesCustomViewManagerAndroid
                style={{
                    // converts dpi to px, provide desired height
                    height: PixelRatio.getPixelSizeForLayoutSize(200),
                    // converts dpi to px, provide desired width
                    width: PixelRatio.getPixelSizeForLayoutSize(Dimensions.get('window').width)
                }}
                ref={ref}
            />
        </View>
    )
  }
  export default AndroidNativeStoriesListWrapper